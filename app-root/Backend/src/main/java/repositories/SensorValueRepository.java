package repositories;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import models.SensorValue;

public interface SensorValueRepository extends CrudRepository<SensorValue, Long>{
	
	Optional<SensorValue> findFirstBySensorIdOrderByTsValueDesc(long sensorId);
}
