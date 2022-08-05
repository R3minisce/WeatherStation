package controllers;

import java.net.URI;
import java.sql.Timestamp;
import java.util.Date;
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
import models.Event;
import models.Sensor;
import models.SensorValue;
import repositories.DeviceRepository;
import repositories.EventRepository;
import repositories.SensorRepository;
import repositories.SensorValueRepository;

@RestController
@Transactional
@CrossOrigin(origins = { "*" }, methods = { RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT,
		RequestMethod.DELETE }) // ,allowCredentials="true")
@RequestMapping("/sensor")
public class SensorController {

	@Autowired
	private SensorRepository sensorRepo;

	@Autowired
	private SensorValueRepository sensorValueRepo;

	@Autowired
	private EventRepository eventRepo;

	@Autowired
	private DeviceRepository deviceRepo;

	@GetMapping
	@ResponseBody
	public ResponseEntity<Iterable<Sensor>> getAllSensors(RequestEntity<String> req) {
		ResponseEntity<Iterable<Sensor>> rep;
		try {
			rep = ResponseEntity.ok(sensorRepo.findAll());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SENSOR \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Sensor> getSensorById(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Sensor> rep;
		try {

			Optional<Sensor> sensor = sensorRepo.findById(id);

			if (!sensor.isPresent())
				return ResponseEntity.notFound().build();

			rep = ResponseEntity.ok(sensor.get());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SENSOR/" + id + " \n" + e);
		}
		return rep;
	}

	@PostMapping
	public ResponseEntity<Object> newSensor(RequestEntity<String> req) {
		ResponseEntity<Object> rep;
		try {
			Sensor body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Sensor.class);

			Sensor savedSensor = sensorRepo.save(body);

			URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
					.buildAndExpand(savedSensor.getId()).toUri();

			rep = ResponseEntity.created(location).build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("POST/SENSOR/ \n" + e);
		}
		return rep;
	}

	@PutMapping("/{id}")
	public ResponseEntity<Object> updateSensor(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {

			Sensor body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Sensor.class);

			Optional<Sensor> optionalSensor = sensorRepo.findById(id);

			if (!optionalSensor.isPresent())
				return ResponseEntity.notFound().build();

			if (id != body.getId())
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

			body.setSensorValues(optionalSensor.get().getSensorValues());
			body.setSensorEvents(optionalSensor.get().getSensorEvents());
			sensorRepo.save(body);

			rep = ResponseEntity.ok().build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("PUT/SENSOR/" + id + " \n" + e);
		}
		return rep;
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteSensor(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {
			sensorRepo.deleteById(id);
			rep = ResponseEntity.ok().build();
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("DELETE/SENSOR/" + id + " \n" + e);
		}
		return rep;
	}

	@GetMapping("/unassigned")
	@ResponseBody
	public ResponseEntity<Iterable<Sensor>> getUnassignedSensor(RequestEntity<String> req) {
		ResponseEntity<Iterable<Sensor>> rep;
		try {
			rep = ResponseEntity.ok(sensorRepo.findByRoomIdIsNull());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SENSOR UNASSIGNED \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}/value")
	@ResponseBody
	public ResponseEntity<SensorValue> getSensorLastValue(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<SensorValue> rep;
		try {

			Optional<Sensor> sensor = sensorRepo.findById(id);

			if (!sensor.isPresent())
				return ResponseEntity.notFound().build();

			Optional<SensorValue> sensorValue = sensorValueRepo.findFirstBySensorIdOrderByTsValueDesc(id);

			if (!sensorValue.isPresent())
				return ResponseEntity.notFound().build();

			rep = ResponseEntity.ok(sensorValue.get());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SENSOR/" + id + "/value \n" + e);
		}
		return rep;

	}

	@PostMapping("/{id}/value")
	@ResponseBody
	public ResponseEntity<Object> newSensorValue(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {

			SensorValue body = null;

			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), SensorValue.class);

			if (id != body.getSensorId())
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

			Optional<Sensor> optionalSensor = sensorRepo.findById(id);

			if (!optionalSensor.isPresent())
				return ResponseEntity.notFound().build();

			Date date = new Date();
			body.setTsValue(new Timestamp(date.getTime()));
			sensorValueRepo.save(body);

			rep = ResponseEntity.ok().build();

			checkEvent(id, body.getValue());

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("POST/SENSOR/" + id + "/value \n" + e);
		}
		return rep;
	}

	private void checkEvent(long sensorId, float sensorValue) {

        for (Event e : eventRepo.findBySensorId(sensorId)) {
            if(e.getDeviceId() != null) {
                Optional<Device> deviceOpt = deviceRepo.findById(e.getDeviceId());

                if (!deviceOpt.isPresent())
                    return;

                Device device = deviceOpt.get();

                if (e.isTriggerWhenHigher()) {
                    if (sensorValue > e.getActivationValue()) {
                        resolveEvent(device, e.getDeviceActivation(), device.isActivated());
                    }
                } else {
                    if (sensorValue < e.getActivationValue()) {
                        resolveEvent(device, e.getDeviceActivation(), device.isActivated());
                    }
                }    
            }
        }
    }

	private void resolveEvent(Device device, boolean deviceActivation, boolean isActivated) {

			if ((deviceActivation && !isActivated) ||(!deviceActivation && isActivated)) {
				if (device.getUrl() != null && device.getUrl() != "") {
					sendRequest(device, deviceActivation);
				}else {
					device.setActivated(deviceActivation);
					deviceRepo.save(device);
				}
			} 

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
		}
	}

}
