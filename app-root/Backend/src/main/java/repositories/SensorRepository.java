package repositories;

import org.springframework.data.repository.CrudRepository;

import models.Sensor;

public interface SensorRepository extends CrudRepository<Sensor, Long> {

	Iterable<Sensor> findByRoomIdIsNull();
}
