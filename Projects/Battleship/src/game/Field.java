package game;

import java.io.Serializable;


public class Field implements Serializable{

	//fields	
	private Human human;
	private Computer computer;
	
	//constructor
	public Field(){
		human = null;
		computer = null;
	}

	//getters
	public Human getHuman(){
		return human;
	}
	
	public Computer getComputer(){
		return computer;
	}
	
	//setters
	public void setHuman(Human h){
		human = h;
	}
	
	public void setComputer(Computer c){
		computer = c;
	}
}
