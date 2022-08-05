package repositories;

import org.springframework.data.repository.CrudRepository;

import models.Room;

public interface RoomRepository extends CrudRepository<Room, Long> {
	
}
