package game;

import java.io.Serializable;

import SpaceShips.*;



public class Coordinate implements Serializable{

	//fields
	private Vessel vessel;
	private State status;
	
	//constructor
	public Coordinate(){
		vessel = null;
		status = State.EMPTY;
	}
	
	//getters
	public Vessel getVessel(){
		return vessel;
	}
	
	public State getStatus(){
		return status;
	}
	
	//setters
	public void setVessel(Vessel newVessel){
		vessel = newVessel;
	}
	public void setStatus(State newState){
		status = newState;
	}
}
