package repositories;

import org.springframework.data.repository.CrudRepository;
import models.Device;

public interface DeviceRepository extends CrudRepository<Device, Long>{

    Iterable<Device> findByRoomIdIsNull();
}