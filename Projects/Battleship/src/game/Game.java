package game;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;




public class Game implements Serializable{

	//field
	private Field field;
	@SuppressWarnings("unused")
	private boolean gameOver, hit;
	
	//constructor
	public Game(){
		field = null;
		gameOver = false;
		hit = false;
	}
	
	//getter
	public Field getField(){
		return field;
	}
	public boolean getGameOver(){
		if((field.getHuman().isAlive() == false) || (field.getComputer().isAlive() == false)){
			return true;
		}
		else
			return false;
	}
	
	//setter
	public void setField(Field f){
		field = f;
	}
	public void setGameOver(boolean g){
		gameOver = g;
	}
	public void setHit(boolean h){
		hit = h;
	}
	
	//other
	public void gameTurn(int x, int y){
		if(field.getHuman().getTurn() == true){
			field.getHuman().shoot(field.getComputer(), x, y);
			
			if(field.getHuman().getHTurn() == false)
				field.getComputer().setTurn(true);
			
			if(getGameOver())
				setGameOver(true);
		}
		else if(field.getHuman().getHTurn() == true){
			field.getHuman().shoot(field.getComputer(), x, y);
			
			field.getComputer().setTurn(true);
			
			if(getGameOver())
				setGameOver(true);
		}
		else if(field.getComputer().getTurn() == true){
			field.getComputer().shoot(field.getHuman(), x, y);
			
			if(field.getComputer().getHTurn() == false){
				field.getHuman().setTurn(true);
			}
			
			if(getGameOver())
				setGameOver(true);
		}
		else if(field.getComputer().getHTurn() == true){
			field.getComputer().shoot(field.getHuman(), x, y);
			
			field.getComputer().setHTurn(false);
			
			field.getHuman().setTurn(true);
			
			if(getGameOver())
				setGameOver(true);
		}
	}
	
	//serialization
	public static void saveData(Game game){
		FileOutputStream fileOut = null;
		ObjectOutputStream objOut= null;
		
		try{
			fileOut = new FileOutputStream("Battleship.ser");		
			objOut = new ObjectOutputStream(fileOut);
			objOut.writeObject(game);
			objOut.close();				
			fileOut.close();
		}			
		catch(IOException i){
			i.printStackTrace();
		} 
	}
	
	public static Game loadData(){
		FileInputStream fileIn = null;
		ObjectInputStream objIn = null;
	    Game game = null;
			
	    try{
	       fileIn = new FileInputStream("Battleship.ser");
	       objIn = new ObjectInputStream(fileIn);
	       game = (Game) objIn.readObject();
	       objIn.close();
	       fileIn.close();
	    }
	    catch(IOException i){
	       //do nothing
	    } 
	    catch (ClassNotFoundException e){
	    	//do nothing
		}
	      return game;
	}
}
