package models;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Sensors")
public class Sensor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@NotEmpty
	private String topic;

	@Column(nullable = true, name = "ROOM_ID")
	private Long roomId;

	@NotNull
	private boolean isFav = false;

	@OneToMany
	@JoinColumn(name = "SENSOR_ID", referencedColumnName = "id")
	@JsonIgnore
	private List<SensorValue> sensorValues;

	@OneToMany
	@JoinColumn(name = "SENSOR_ID", referencedColumnName = "id")
	private List<Event> sensorEvents;

	private String type;
	
	public Sensor() {
	}

	public String getTopic() {
		return topic;
	}

	public boolean getIsFav() {
		return isFav;
	}

	public void setIsFav(boolean isFav) {
		this.isFav = isFav;
	}

	public long getId() {
		return id;
	}

	public Long getRoomId() {
		return roomId;
	}

	public void setRoomId(Long roomId) {
		this.roomId = roomId;
	}

	public List<SensorValue> getSensorValues() {
		return sensorValues;
	}

	public void setSensorValues(List<SensorValue> sensorValues) {
		this.sensorValues = sensorValues;
	}

	public List<Event> getSensorEvents() {
		return sensorEvents;
	}

	public void setSensorEvents(List<Event> sensorEvents) {
		this.sensorEvents = sensorEvents;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public void setFav(boolean isFav) {
		this.isFav = isFav;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	

}
