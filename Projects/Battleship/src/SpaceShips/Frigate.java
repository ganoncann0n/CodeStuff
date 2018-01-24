package SpaceShips;

import game.Orientation;
import game.VesselType;


public class Frigate extends Vessel{

	public Frigate(){
		size = 3;
		direction = Orientation.HORIZONTAL;
		startX = 0;
		startY = 0;
		alive = true;
		health = 3;
		type = VesselType.FRIGATE;
		
	}
}
