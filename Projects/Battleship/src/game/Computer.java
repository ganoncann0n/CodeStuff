package game;

import java.util.Random;

import SpaceShips.BattleCruiser;
import SpaceShips.Carrier;
import SpaceShips.Frigate;
import SpaceShips.Inteceptor;


public class Computer extends Player {
	
	private int lastX;
	private int lastY;
	private int hitFlag;
	private int hitState;
	private boolean hitLast;
	private Random rand;
	private Carrier c1;
	private BattleCruiser bc1, bc2;
	private Frigate f1, f2, f3;
	private Inteceptor i1, i2, i3, i4;
	
	public Computer(){
	
		lastX = 0;
		lastY = 0;
		hitState = 0;
		hitLast = false;
		rand = new Random();
		c1 = new Carrier();
		bc1 = new BattleCruiser();
		bc2 = new BattleCruiser();
		f1 = new Frigate();
		f2 = new Frigate();
		f3 = new Frigate();
		i1 = new Inteceptor();
		i2 = new Inteceptor();
		i3 = new Inteceptor();
		i4 = new Inteceptor();
		
	}
	
	//shoot
	@Override
	public void shoot(Player p, int x, int y) {
		
		boolean valid = false;
		
		//if shooting without previous hit, generate a valid shooting place
		if(!hitLast){
			//generate valid x,y
			while(!valid){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
					
				if((p.getBoard()[x][y].getStatus() == State.TAKEN) || ((p.getBoard()[x][y].getStatus() == State.EMPTY)))
					valid = true;
				else
					valid = false;
			}
			
			//shoot
			if(p.getBoard()[x][y].getStatus() == State.TAKEN){
				p.getBoard()[x][y].setStatus(State.HIT);
				p.getBoard()[x][y].getVessel().setHealth(-1);
				p.getBoard()[x][y].getVessel().update();
				hitTurn = true;
				turn = false;
				hitFlag++;
				
				hitLast = true;
				lastX = x;
				lastY = y;
			}
			else{
				hitTurn = false;
				turn = false;
				p.getBoard()[x][y].setStatus(State.MISS);
			}
		}
		
		//if shooting from previous hit
		else{
			//try left
			if(hitState == 0){
				x = lastX;
				y = lastY - 1;
				
				//check to make sure valid shot
				if((x < 10) && (y < 10) && (x >= 0) && (y >= 0)){
					if((p.getBoard()[x][y].getStatus() == State.TAKEN) || (p.getBoard()[x][y].getStatus() == State.EMPTY) && (x < 10) && (y < 10)){
						if(p.getBoard()[x][y].getStatus() == State.TAKEN){
							p.getBoard()[x][y].setStatus(State.HIT);
							p.getBoard()[x][y].getVessel().setHealth(-1);
							p.getBoard()[x][y].getVessel().update();
							hitTurn = true;
							turn = false;
							hitFlag++;
							
							hitLast = true;
							hitState = 0;
							lastX = x;
							lastY = y;
						}
						else{
							hitTurn = false;
							turn = false;
							p.getBoard()[x][y].setStatus(State.MISS);
							hitState++;
						}
					}
					//if not valid try next
					else{
						hitState++;
						shoot(p, x, y);
					}
				}
				else{
					hitState++;
					shoot(p, x, y);
				}
			}
			
			//try right
			else if(hitState == 1){
				x = lastX;
				y = lastY + 1;
				
				//check to make sure valid shot
				if((x < 10) && (y < 10) && (x >= 0) && (y >= 0)){
					if((p.getBoard()[x][y].getStatus() == State.TAKEN) || (p.getBoard()[x][y].getStatus() == State.EMPTY)){
						if(p.getBoard()[x][y].getStatus() == State.TAKEN){
							p.getBoard()[x][y].setStatus(State.HIT);
							p.getBoard()[x][y].getVessel().setHealth(-1);
							p.getBoard()[x][y].getVessel().update();
							hitTurn = true;
							turn = false;
							hitFlag++;
							
							hitLast = true;
							hitState = 0;
							lastX = x;
							lastY = y;
						}
						else{
							hitTurn = false;
							turn = false;
							p.getBoard()[x][y].setStatus(State.MISS);
							hitState++;
						}
					}
					else{
						hitState++;
						shoot(p, x, y);
					}
				}
				//if not valid try next
				else{
					hitState++;
					shoot(p, x, y);
				}
			}
			
			//try top
			else if(hitState == 2){
				x = lastX + 1;
				y = lastY;
				
				if((x < 10) && (y < 10) && (x >= 0) && (y >= 0)){
				//check to make sure valid shot
					if((p.getBoard()[x][y].getStatus() == State.TAKEN) || (p.getBoard()[x][y].getStatus() == State.EMPTY) && (x < 10) && (y < 10)){
						if(p.getBoard()[x][y].getStatus() == State.TAKEN){
							p.getBoard()[x][y].setStatus(State.HIT);
							p.getBoard()[x][y].getVessel().setHealth(-1);
							p.getBoard()[x][y].getVessel().update();
							hitTurn = true;
							turn = false;
							hitFlag++;
							
							hitLast = true;
							hitState = 0;
							lastX = x;
							lastY = y;
						}
						else{
							hitTurn = false;
							turn = false;
							p.getBoard()[x][y].setStatus(State.MISS);
							hitState++;
						}
					}
					
					//if not valid try next
					else{
						hitState++;
						shoot(p, x, y);
					}
				}
				else{
					hitState++;
					shoot(p, x, y);
				}
			}
			//try bottom
			else if(hitState == 3){
				x = lastX - 1;
				y = lastY;
				
				//check to make sure valid shot
				if((x < 10) && (y < 10) && (x >= 0) && (y >= 0)){
					if((p.getBoard()[x][y].getStatus() == State.TAKEN) || (p.getBoard()[x][y].getStatus() == State.EMPTY) && (x < 10) && (y < 10)){
						if(p.getBoard()[x][y].getStatus() == State.TAKEN){
							p.getBoard()[x][y].setStatus(State.HIT);
							p.getBoard()[x][y].getVessel().setHealth(-1);
							p.getBoard()[x][y].getVessel().update();
							hitTurn = true;
							turn = false;
							hitFlag++;
							
							hitLast = true;
							hitState = 0;
							lastX = x;
							lastY = y;
						}
						else{
							hitTurn = false;
							turn = false;
							hitState = 0;
							p.getBoard()[x][y].setStatus(State.MISS);
							hitLast = false;
						}
					}
					
					//if not valid try next
					else{
						hitState = 0;
						hitLast = false;
						shoot(p, x, y);
					}
				}
				else{
					hitState = 0;
					hitLast = false;
					shoot(p, x, y);
				}
			}
		}
	}
	
	//generate board
	public void generateBoard(){
		int x, y, direction = 0;
		int battlecruisers = 0, frigates = 0, inteceptors = 0;
		boolean done = false;
		boolean valid = false;
		
		//build carrier
		while(!done){

			x = rand.nextInt(10);
			y = rand.nextInt(10);
			direction = rand.nextInt(2);
			
			c1.setStartX(x);
			c1.setStartY(y);
			if(direction == 0)
				c1.setDirection(Orientation.HORIZONTAL);
			else
				c1.setDirection(Orientation.VERTICAL);
			
			valid = isEmpty(c1);
			
			if(valid){
				addVessel(c1);
				done = true;
			}
			else
				done = false;
		}
		done = false;
		//build battlecruisers
		while(!done){
			
			if(battlecruisers < 1){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				bc1.setStartX(x);
				bc1.setStartY(y);
				
				if(direction == 0)
					bc1.setDirection(Orientation.HORIZONTAL);
				else
					bc1.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(bc1);
				
				if(valid){
					addVessel(bc1);
					battlecruisers++;
				}
			}
			else{
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				bc2.setStartX(x);
				bc2.setStartY(y);
				
				if(direction == 0)
					bc2.setDirection(Orientation.HORIZONTAL);
				else
					bc2.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(bc2);
				
				if(valid){
					addVessel(bc2);
					battlecruisers++;
					done = true;
				}
			}
		}
		done = false;
		//build frigates
		while(!done){
			
			if(frigates < 1){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				f1.setStartX(x);
				f1.setStartY(y);
				
				if(direction == 0)
					f1.setDirection(Orientation.HORIZONTAL);
				else
					f1.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(f1);
				
				if(valid){
					addVessel(f1);
					frigates++;
				}
			}
			else if(frigates < 2){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				f2.setStartX(x);
				f2.setStartY(y);
				
				if(direction == 0)
					f2.setDirection(Orientation.HORIZONTAL);
				else
					f2.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(f2);
				
				if(valid){
					addVessel(f2);
					frigates++;
				}
			}
			else if(frigates < 3){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				f3.setStartX(x);
				f3.setStartY(y);
				
				if(direction == 0)
					f3.setDirection(Orientation.HORIZONTAL);
				else
					f3.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(f3);
				
				if(valid){
					addVessel(f3);
					frigates++;
					done = true;
				}
			}
		}
		done = false;
		//build inteceptors
		while(!done){
			
			if(inteceptors < 1){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				i1.setStartX(x);
				i1.setStartY(y);
				
				if(direction == 0)
					i1.setDirection(Orientation.HORIZONTAL);
				else
					i1.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(i1);
				
				if(valid){
					addVessel(i1);
					inteceptors++;
				}
			}
			else if(inteceptors < 2){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				i2.setStartX(x);
				i2.setStartY(y);
				
				if(direction == 0)
					i2.setDirection(Orientation.HORIZONTAL);
				else
					i2.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(i2);
				
				if(valid){
					addVessel(i2);
					inteceptors++;
				}
			}
			else if(inteceptors < 3){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				i3.setStartX(x);
				i3.setStartY(y);
				
				if(direction == 0)
					i3.setDirection(Orientation.HORIZONTAL);
				else
					i3.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(i3);
				
				if(valid){
					addVessel(i3);
					inteceptors++;
				}
			}
			else if(inteceptors < 4){
				x = rand.nextInt(10);
				y = rand.nextInt(10);
				direction = rand.nextInt(2);
				
				i4.setStartX(x);
				i4.setStartY(y);
				
				if(direction == 1)
					i4.setDirection(Orientation.HORIZONTAL);
				else
					i4.setDirection(Orientation.VERTICAL);
			
				valid = isEmpty(i4);
				
				if(valid){
					addVessel(i4);
					inteceptors++;
					done = true;
				}
			}
		}
	}
	
	public int getHit(){
		return hitFlag;
	}
	
	public void setHitFlag(int h){
		hitFlag = h;
	}
}
