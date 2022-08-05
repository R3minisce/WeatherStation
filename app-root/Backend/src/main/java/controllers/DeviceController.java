package controllers;

import java.net.URI;
import java.util.Optional;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;

import models.Device;
import repositories.DeviceRepository;

@RestController
@Transactional
@CrossOrigin(origins = { "*" }, methods = {RequestMethod.GET,RequestMethod.POST,RequestMethod.PUT,RequestMethod.DELETE})//,allowCredentials="true")
@RequestMapping("/device")
public class DeviceController {


	@Autowired
	private DeviceRepository deviceRepo;
	
	@GetMapping
	@ResponseBody
	public ResponseEntity<Iterable<Device>> getAllDevices(RequestEntity<String> req) {
		ResponseEntity<Iterable<Device>> rep;
		try {
			Iterable<Device> allDevices = deviceRepo.findAll();
			rep = ResponseEntity.ok(allDevices);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/DEVICES \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Device> getDeviceById(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Device> rep;
		try {

			Optional<Device> deviceOpt = deviceRepo.findById(id);

			if (!deviceOpt.isPresent())
				return ResponseEntity.notFound().build();

			Device device = deviceOpt.get();
			rep = ResponseEntity.ok(device);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/DEVICE/" + id + " \n" + e);
		}
		return rep;
	}
	@PostMapping
	public ResponseEntity<Object> newDevice(RequestEntity<String> req) {
		ResponseEntity<Object> rep;
		try {
			Device body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Device.class);
			

			Device savedDevice = deviceRepo.save(body);

			URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
					.buildAndExpand(savedDevice.getId()).toUri();

			rep = ResponseEntity.created(location).build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("POST/DEVICE/ \n" + e);
		}
		return rep;
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Object> updateDevice(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {

			Device body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Device.class);

			Optional<Device> optionalDevice = deviceRepo.findById(id);

			if (!optionalDevice.isPresent())
				return ResponseEntity.notFound().build();

			if (id != body.getId())
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
			
			String url = optionalDevice.get().getUrl();
			body.setUrl(url);
			body.setDeviceEvents(optionalDevice.get().getDeviceEvents());
			
			if(body.isActivated() != optionalDevice.get().isActivated()) {
				if(url!= null && url != "") {
					sendRequest(body, body.isActivated());
				}else {
					deviceRepo.save(body);	
				}
			}else {
				deviceRepo.save(body);
			}

			rep = ResponseEntity.ok().build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("PUT/DEVICE/" + id + " \n" + e);
		}
		return rep;

	}
	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteDevice(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {
			deviceRepo.deleteById(id);
			rep = ResponseEntity.ok().build();
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("DELETE/DEVICE/" + id + " \n" + e);
		}
		return rep;
	}
	private void sendRequest(Device device, boolean deviceActivation) {
		try {
		    HttpClient httpClient = HttpClientBuilder.create().build();
			HttpPut httpPut = new HttpPut(device.getUrl());
			httpPut.setHeader("Accept", "application/json");
			httpPut.setHeader("Content-type", "application/json");

			String inputJson = "{\"activate\": " + deviceActivation + "}";
			StringEntity stringEntity = new StringEntity(inputJson);
			httpPut.setEntity(stringEntity);
			HttpResponse response = httpClient.execute(httpPut);

			if (response.getStatusLine().getStatusCode() == 200) {
				device.setActivated(deviceActivation);
				deviceRepo.save(device);
			} else {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatusLine().getStatusCode());
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Failed : Cannot contact device.");
		}
	}

	@GetMapping("/unassigned")
	@ResponseBody
	public ResponseEntity<Iterable<Device>> getUnassignedDevice(RequestEntity<String> req) {
		ResponseEntity<Iterable<Device>> rep;
		try {
			rep = ResponseEntity.ok(deviceRepo.findByRoomIdIsNull());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/DEVICE UNASSIGNED \n" + e);
		}
		return rep;
	}
}
