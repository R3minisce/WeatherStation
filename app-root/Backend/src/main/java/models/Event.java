package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Events")
public class Event {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Column(name="SENSOR_ID")
	private long sensorId;
	
	private float activationValue;
	
	@Column(nullable=true, name="DEVICE_ID")
	private Long deviceId;
	
	// if true event triggered when higher than activationValue, if false then triggered when under
	private boolean triggerWhenHigher;
	
	//activate or stop the device
	private boolean deviceActivation;
	
	public Event() {}

	public long getSensorId() {
		return sensorId;
	}

	public void setSensorId(long sensorId) {
		this.sensorId = sensorId;
	}

	public Long getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Long deviceId) {
		this.deviceId = deviceId;
	}


	public boolean isTriggerWhenHigher() {
		return triggerWhenHigher;
	}

	public void setTriggerWhenHigher(boolean triggerWhenHigher) {
		this.triggerWhenHigher = triggerWhenHigher;
	}

	public boolean getDeviceActivation() {
		return deviceActivation;
	}

	public void setDeviceActivation(boolean deviceActivation) {
		this.deviceActivation = deviceActivation;
	}

	public long getId() {
		return id;
	}

	public float getActivationValue() {
		return activationValue;
	}

	public void setActivationValue(float activationValue) {
		this.activationValue = activationValue;
	}
	
	
	

}
