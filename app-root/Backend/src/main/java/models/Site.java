package models;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Table(name = "Sites")
public class Site {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@NotEmpty
	private String name;
	
	@NotNull
	private boolean isFav = false;
	
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.LAZY)
	@JoinColumn(name = "SITE_ID", referencedColumnName="id")
	@JsonIgnore
	private List<Room> rooms;
	
	@Lob
	@Column(columnDefinition = "LONGBLOB")
	private byte[] picBytes;

	private String picType;
	

	public Site() {}

	public void addRoom(Room r) {
		this.rooms.add(r);
	}
	public void removeRoom(Room r) {
		this.rooms.remove(r);
	}
	public Iterable<Room> getRooms() {
		return rooms;
	}	
	
	public void setRooms(Iterable<Room> rooms) {
		this.rooms = (List<Room>) rooms;
	}
	public long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean getIsFav() {
		return isFav;
	}

	public void setIsFav(boolean isFav) {
		this.isFav = isFav;
	}

	public int getNbRooms() {
		return this.rooms.size();
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
	
	
	


}
