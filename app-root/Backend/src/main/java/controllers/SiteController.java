package controllers;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.RequestMethod;

import models.Device;
import models.Room;
import models.Site;
import repositories.SiteRepository;

@RestController
@Transactional
@CrossOrigin(origins = { "*" }, methods = {RequestMethod.GET,RequestMethod.POST,RequestMethod.PUT,RequestMethod.DELETE})//,allowCredentials="true")
@RequestMapping("/site")
public class SiteController {

	@Autowired
	SiteRepository siteRepo;

	@GetMapping
	@ResponseBody
	public ResponseEntity<Iterable<Site>> getAllSites(RequestEntity<String> req) {

		ResponseEntity<Iterable<Site>> rep;
		try {
			Iterable<Site> allSites = siteRepo.findAll();		
			rep = ResponseEntity.ok(allSites);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SITE \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Site> getSiteById(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Site> rep;
		try {

			Optional<Site> siteOpt = siteRepo.findById(id);

			if (!siteOpt.isPresent())
				return ResponseEntity.notFound().build();

			Site site = siteOpt.get();
			
			rep = ResponseEntity.ok(site);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SITE/" + id + " \n" + e);
		}
		return rep;
	}

	@PostMapping
	public ResponseEntity<Object> newSite(RequestEntity<String> req) {
		ResponseEntity<Object> rep;
		try {
			Site body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Site.class);

			Site savedSite = siteRepo.save(body);

			URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
					.buildAndExpand(savedSite.getId()).toUri();

			rep = ResponseEntity.created(location).build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("POST/SITE/ \n" + e);
		}
		return rep;
	}

	@PutMapping("/{id}")
	public ResponseEntity<Object> updateSite(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {

			Site body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Site.class);

			Optional<Site> optionalSite = siteRepo.findById(id);

			if (!optionalSite.isPresent())
				return ResponseEntity.notFound().build();

			if (id != body.getId())
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

			body.setRooms(optionalSite.get().getRooms());
			siteRepo.save(body);

			rep = ResponseEntity.ok().build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("PUT/SITE/" + id + " \n" + e);
		}
		return rep;
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteSite(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {
			siteRepo.deleteById(id);
			rep = ResponseEntity.ok().build();
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("DELETE/SITE/" + id + " \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}/room")
	@ResponseBody
	public ResponseEntity<Iterable<Room>> getRoomsBySite(RequestEntity<String> req, @PathVariable long id) {

		ResponseEntity<Iterable<Room>> rep;
		try {
			Optional<Site> site = siteRepo.findById(id);
			if (!site.isPresent())
				return ResponseEntity.notFound().build();

			Iterable<Room> roomsBySite = site.get().getRooms();
			rep = ResponseEntity.ok(roomsBySite);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SITE/" + id + "/ROOM" + " \n" + e);
		}

		return rep;
	}
	@GetMapping("/{id}/device")
	@ResponseBody
	public ResponseEntity<Iterable<Device>> getDevicesBySite(RequestEntity<String> req, @PathVariable long id) {

		ResponseEntity<Iterable<Device>> rep;
		try {
			Optional<Site> site = siteRepo.findById(id);
			if (!site.isPresent())
				return ResponseEntity.notFound().build();

			Iterable<Room> roomsBySite = site.get().getRooms();
			List<Device> devicesBySite = new ArrayList<Device>(); 
			for(Room room : roomsBySite) {
				devicesBySite.addAll(room.getDevices());
			}
			rep = ResponseEntity.ok((Iterable<Device>)devicesBySite);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/SITE/" + id + "/DEVICE" + " \n" + e);
		}

		return rep;
	}
}
