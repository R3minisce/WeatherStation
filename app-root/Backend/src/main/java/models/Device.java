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
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Devices")
public class Device {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@Column(nullable = true, name = "ROOM_ID")
	private Long roomId;

	@NotNull
	private boolean isFav = false;

	private String name;
	
	@JsonIgnore
	private String url;
	
	@OneToMany
	@JoinColumn(name = "DEVICE_ID", referencedColumnName = "id")
	@JsonIgnore
	private List<Event> deviceEvents;

	private boolean activated;

	public Device() {
	}

	public Long getRoomId() {
		return roomId;
	}

	public void setRoomId(Long roomId) {
		this.roomId = roomId;
	}

	public boolean getIsFav() {
		return isFav;
	}

	public void setIsFav(boolean isFav) {
		this.isFav = isFav;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getId() {
		return id;
	}

	public boolean isActivated() {
		return activated;
	}

	public void setActivated(boolean activated) {
		this.activated = activated;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<Event> getDeviceEvents() {
		return deviceEvents;
	}

	public void setDeviceEvents(List<Event> deviceEvents) {
		this.deviceEvents = deviceEvents;
	}
	

	

}
