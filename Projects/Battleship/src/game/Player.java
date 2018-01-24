package game;
import java.io.Serializable;
import java.util.ArrayList;

import SpaceShips.Vessel;



public abstract class Player implements Serializable{

	//fields
	private static int WIDTH = 10;
	private static int LENGTH = 10;
	
	protected ArrayList<Vessel> fleet;
	protected Coordinate[][] board;
	
	protected boolean turn;
	protected boolean hitTurn;
	
	public Player(){
		fleet = new ArrayList<Vessel>();
		board = new Coordinate[WIDTH][LENGTH];
		turn = false;
		hitTurn = false;
		
		for(int i = 0; i < LENGTH; i++){
			for(int k = 0; k < WIDTH; k++){
				board[i][k] = new Coordinate();
			}
		}
	}
	
	
	//getters
	public ArrayList<Vessel> getFleet(){
		return fleet;
	}
	
	public Coordinate[][] getBoard(){
		return board;
	}
	public boolean getTurn(){
		return turn;
	}
	public boolean getHTurn(){
		return hitTurn;
	}
	public boolean getTurnFlag(){
		if((turn == false) && (hitTurn == false))
			return false;
		else
			return true;
	}
	
	//setters
	public void setFleet(ArrayList<Vessel> newFleet){
		fleet = newFleet;
	}
	public void setTurn(boolean newTurn){
		turn = newTurn;
	}
	public void setHTurn(boolean newTurn){
		hitTurn = newTurn;
	}
	
	@SuppressWarnings("unused")
	public void addVessel(Vessel newVessel){
		int x = newVessel.getStartX();
		int y = newVessel.getStartY();
		
		if(newVessel == null)
			return;
		
		else{
			fleet.add(newVessel);
			
			if(newVessel.getDirection() == Orientation.HORIZONTAL){
				for(int i = 0; i < newVessel.getSize(); i++){
					board[x][i+y].setStatus(State.TAKEN);
					board[x][i+y].setVessel(newVessel);
				}
			}
			else if(newVessel.getDirection() == Orientation.VERTICAL){
				for(int i = 0; i < newVessel.getSize(); i++){
					board[i+x][y].setStatus(State.TAKEN);
					board[i+x][y].setVessel(newVessel);
				}
			}
		}

	}
	
	//other
	public abstract void shoot(Player p, int x, int y);

	public boolean isAlive(){
		int counter = 0;
		
		for(int i = 0; i < fleet.size(); i++){
			if(fleet.get(i).isAlive() == true)
				counter++;
		}
		
		if(counter == 0)
			return false;
		else
			return true;
	}
	
	//location checker for ship placement
	public boolean isEmpty(Vessel v){
		int x, y, counter = 0;
		
		//convert from display grid to array
		x = v.getStartX();
		y = v.getStartY();
		
		//checker (horizontal)
		if(v.getDirection() == Orientation.HORIZONTAL){
			
			//check end conditions
			if(y+v.getSize()-1 > 9)
				return false;
			
			//check inner
			else{
				for(int i = y; i < y+v.getSize(); i++){
					if(board[x][i].getStatus() == State.EMPTY){
						counter++;
					}
				}
				if(counter == v.getSize())
					return true;
				else
					return false;
			}
		}
		
		//check (vertical)
		else if(v.getDirection() == Orientation.VERTICAL){
			
			//check end condition
			if(x+v.getSize()-1 > 9)
				return false;
			else{
				for(int i = x; i < x+v.getSize(); i++){
					if(board[i][y].getStatus() == State.EMPTY){
						counter++;
					}
				}
				if(counter == v.getSize())
					return true;
				else
					return false;
			}
		}	
		return false;
	}
}
