package SpaceShips;

import game.Orientation;
import game.VesselType;


public class BattleCruiser extends Vessel{

	public BattleCruiser(){
		size = 4;
		direction = Orientation.HORIZONTAL;
		startX = 0;
		startY = 0;
		alive = true;
		health = 4;
		type = VesselType.BATTLECRUISER;
	}
}
