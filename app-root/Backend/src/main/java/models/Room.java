package models;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Rooms")
public class Room {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@NotEmpty
	private String name;
	
	@Column(name = "description")
	private String desc;
	
	
	private String icon;
	
	@NotNull
	private boolean isFav = false;
	
	
	@Column(name="SITE_ID")
	private long siteId;
	
	@OneToMany
	@JoinColumn(name = "ROOM_ID", referencedColumnName="id")
	@JsonIgnore
	private List<Sensor> sensors;
	
	@OneToMany
	@JoinColumn(name = "ROOM_ID", referencedColumnName="id")
	@JsonIgnore
	private List<Device> devices;
	
	@Lob
	@Column(columnDefinition = "LONGBLOB")
	private byte[] picBytes;

	private String picType;
	
	public Room() {}

	public long getSiteId() {
		return siteId;
	}
	public List<Sensor> getSensors() {
		return sensors;
	}
	
	public void setSensors(List<Sensor> sensors) {
		this.sensors = sensors;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
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

	public int getNbSensors() {
		return this.sensors.size();
	}
	
	public int getNbDevices() {
		return this.devices.size();
	}
	
	public byte[] getPicBytes() {
		return picBytes;
	}
	public void setPicBytes(byte[] picBytes) {
		this.picBytes = picBytes;
	}
	public String getPicType() {
		return picType;
	}
	public void setPicType(String picType) {
		this.picType = picType;
	}
	public List<Device> getDevices() {
		return devices;
	}
	public void setDevices(List<Device> devices) {
		this.devices = devices;
	}
	

	

}
