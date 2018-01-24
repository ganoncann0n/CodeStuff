package SpaceShips;

import game.Orientation;
import game.VesselType;


public class Inteceptor extends Vessel{

	public Inteceptor(){
		size = 2;
		direction = Orientation.HORIZONTAL;
		startX = 0;
		startY = 0;
		alive = true;
		health = 2;
		type = VesselType.INTECEPTOR;
		
	}
}
