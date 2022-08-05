package repositories;

import org.springframework.data.repository.CrudRepository;
import models.Event;

public interface EventRepository extends CrudRepository<Event, Long> {

	Iterable<Event> findBySensorId(long sensorId);
}
