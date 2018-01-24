package game;


public class Human extends Player {

	//constructor
	public Human(){
		turn = true;
		hitTurn = false;
	}
	
	//shoot method
	@Override
	public void shoot(Player p, int x, int y) {
		
		if(p.getBoard()[x][y].getStatus() == State.TAKEN){
			p.getBoard()[x][y].setStatus(State.HIT);
			p.getBoard()[x][y].getVessel().setHealth(-1);
			p.getBoard()[x][y].getVessel().update();
			
			if(hitTurn){
				hitTurn = false;
			}
			else{
				hitTurn = true;
				turn = false;
			}
		}
		else if(p.getBoard()[x][y].getStatus() == State.EMPTY){
			turn = false;
			hitTurn = false;
			p.getBoard()[x][y].setStatus(State.MISS);
		}
	}
}
