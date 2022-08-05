package models;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.sql.Timestamp;

@Entity
@Table(name = "SensorValues")
public class SensorValue {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@NotNull
	private float value;
	
	@Column(name="SENSOR_ID")
	private long sensorId;

	@JsonIgnore
	private Timestamp tsValue;
	
	public SensorValue() {}

	public float getValue() {
		return value;
	}

	public void setValue(float value) {
		this.value = value;
	}

	public long getSensorId() {
		return sensorId;
	}

	public void setSensorId(long sensorId) {
		this.sensorId = sensorId;
	}

	public Timestamp getTsValue() {
		return tsValue;
	}

	public void setTsValue(Timestamp tsValue) {
		this.tsValue = tsValue;
	}

	public long getId() {
		return id;
	}

	
}
