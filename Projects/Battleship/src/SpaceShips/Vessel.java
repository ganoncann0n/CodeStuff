package SpaceShips;

import java.io.Serializable;

import game.Orientation;
import game.VesselType;


public class Vessel implements Serializable{

	protected int size;
	protected Orientation direction;
	protected int startX;
	protected int startY;
	protected boolean alive;
	protected boolean onGrid;
	protected int health;
	protected VesselType type;
	
	public Vessel(){
		size = 0;
		direction = Orientation.HORIZONTAL;
		startX = 0;
		startY = 0;
		alive = true;
		onGrid = false;
		health = 0;
		type = null;
	}
	
	//setters
	public void setSize(int s){
		size = s;
	}
	public void setDirection(Orientation o){
		direction = o;
	}
	public void setStartX(int newX){
		startX = newX;
	}
	public void setStartY(int newY){
		startY = newY;
	}
	public void setAlive(boolean s){
		alive = s;
	}
	public void setOnGrid(boolean b){
		onGrid = b;
	}
	public void setVesselType(VesselType vt){
		type = vt;
	}
	public void setHealth(int h){
		health = health + h;
	}
	
	//getters
	public int getSize(){
		return size;
	}
	public Orientation getDirection(){
		return direction;
	}
	public int getStartX(){
		return startX;
	}
	public int getStartY(){
		return startY;
	}
	public boolean isAlive(){
		return alive;
	}
	public boolean isOnGrid(){
		return onGrid;
	}
	public VesselType getType(){
		return type;
	}
	public int getHealth(){
		return health;
	}
	
	//other
	public void update(){
		if(health < 1)
			setAlive(false);
		else
			setAlive(true);
	}
}


