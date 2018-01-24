package SpaceShips;

import game.Orientation;
import game.VesselType;


public class Carrier extends Vessel{

	public Carrier(){
		size = 6;
		direction = Orientation.HORIZONTAL;
		startX = 0;
		startY = 0;
		alive = true;
		health = 6;
		type = VesselType.CARRIER;
	}
}
