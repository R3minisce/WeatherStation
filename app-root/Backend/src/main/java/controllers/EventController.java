package controllers;

import java.net.URI;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;

import models.Event;
import repositories.EventRepository;

@RestController
@Transactional
@CrossOrigin(origins = { "*" }, methods = {RequestMethod.GET,RequestMethod.POST,RequestMethod.PUT,RequestMethod.DELETE})//,allowCredentials="true")
@RequestMapping("/event")
public class EventController {

	@Autowired
	private EventRepository eventRepo;
	
	@GetMapping
	@ResponseBody
	public ResponseEntity<Iterable<Event>> getAllEvents(RequestEntity<String> req) {
		ResponseEntity<Iterable<Event>> rep;
		try {
			Iterable<Event> allEvents = eventRepo.findAll();
			rep = ResponseEntity.ok(allEvents);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/EVENT \n" + e);
		}
		return rep;
	}
	
	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Event> getEventById(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Event> rep;
		try {

			Optional<Event> eventOpt = eventRepo.findById(id);

			if (!eventOpt.isPresent())
				return ResponseEntity.notFound().build();

			Event event = eventOpt.get();
			rep = ResponseEntity.ok(event);
			
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/EVENT/" + id + " \n" + e);
		}
		return rep;
	}
	
	@PostMapping
	public ResponseEntity<Object> newEvent(RequestEntity<String> req) {
		ResponseEntity<Object> rep;
		try {
			Event body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Event.class);
			

			Event savedEvent= eventRepo.save(body);

			URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
					.buildAndExpand(savedEvent.getId()).toUri();

			rep = ResponseEntity.created(location).build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("POST/EVENT/ \n" + e);
		}
		return rep;
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Object> updateEvent(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {

			Event body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Event.class);

			Optional<Event> optionalEvent = eventRepo.findById(id);

			if (!optionalEvent.isPresent())
				return ResponseEntity.notFound().build();

			if (id != body.getId())
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
			
			eventRepo.save(body);

			rep = ResponseEntity.ok().build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("PUT/EVENT/" + id + " \n" + e);
		}
		return rep;

	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteEvent(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {
			eventRepo.deleteById(id);
			rep = ResponseEntity.ok().build();
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("DELETE/EVENT/" + id + " \n" + e);
		}
		return rep;
	}
}
