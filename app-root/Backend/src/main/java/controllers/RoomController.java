package controllers;

import java.net.URI;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.fasterxml.jackson.databind.ObjectMapper;

import models.Device;
import models.Room;
import models.Sensor;
import repositories.RoomRepository;

@RestController
@Transactional
@CrossOrigin(origins = { "*" }, methods = { RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT,
		RequestMethod.DELETE }) // ,allowCredentials="true")
@RequestMapping("/room")
public class RoomController {

	@Autowired
	private RoomRepository roomRepo;

	@GetMapping
	@ResponseBody
	public ResponseEntity<Iterable<Room>> getAllRooms(RequestEntity<String> req) {
		ResponseEntity<Iterable<Room>> rep;
		try {
			Iterable<Room> allRooms = roomRepo.findAll();
			rep = ResponseEntity.ok(allRooms);

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/ROOM \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}")
	@ResponseBody
	public ResponseEntity<Room> getRoomById(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Room> rep;
		try {

			Optional<Room> roomOpt = roomRepo.findById(id);

			if (!roomOpt.isPresent())
				return ResponseEntity.notFound().build();

			Room room = roomOpt.get();

			rep = ResponseEntity.ok(room);

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/ROOM/" + id + " \n" + e);
		}
		return rep;
	}

	@PostMapping
	public ResponseEntity<Object> newRoom(RequestEntity<String> req) {
		ResponseEntity<Object> rep;
		try {
			Room body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Room.class);

			Room savedRoom = roomRepo.save(body);

			URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
					.buildAndExpand(savedRoom.getId()).toUri();

			rep = ResponseEntity.created(location).build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("POST/ROOM/ \n" + e);
		}
		return rep;
	}

	@PutMapping("/{id}")
	public ResponseEntity<Object> updateRoom(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {

			Room body = null;
			if (req.hasBody())
				body = new ObjectMapper().readValue(req.getBody(), Room.class);

			Optional<Room> optionalRoom = roomRepo.findById(id);

			if (!optionalRoom.isPresent())
				return ResponseEntity.notFound().build();

			if (id != body.getId())
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

			body.setSensors(optionalRoom.get().getSensors());
			body.setDevices(optionalRoom.get().getDevices());
			roomRepo.save(body);

			rep = ResponseEntity.ok().build();

		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("PUT/ROOM/" + id + " \n" + e);
		}
		return rep;

	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Object> deleteRoom(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<Object> rep;
		try {
			roomRepo.deleteById(id);
			rep = ResponseEntity.ok().build();
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("DELETE/ROOM/" + id + " \n" + e);
		}
		return rep;
	}

	@GetMapping("/{id}/sensor")
	@ResponseBody
	public ResponseEntity<List<Sensor>> getSensorsByRoom(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<List<Sensor>> rep;
		try {
			Optional<Room> room = roomRepo.findById(id);
			if (!room.isPresent())
				return ResponseEntity.notFound().build();

			rep = ResponseEntity.ok(room.get().getSensors());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/" + id + "/SENSOR" + " \n" + e);
		}

		return rep;
	}
	@GetMapping("/{id}/device")
	@ResponseBody
	public ResponseEntity<List<Device>> getDevicesByRoom(RequestEntity<String> req, @PathVariable long id) {
		ResponseEntity<List<Device>> rep;
		try {
			Optional<Room> room = roomRepo.findById(id);
			if (!room.isPresent())
				return ResponseEntity.notFound().build();

			rep = ResponseEntity.ok(room.get().getDevices());
		} catch (Exception e) {
			rep = ResponseEntity.status(500).build();
			System.err.println("GET/" + id + "/DEVICE" + " \n" + e);
		}

		return rep;
	}

}
