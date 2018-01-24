package proj1;

public class Channel {
    private Station owner;
    public double timeInB;
    public double timeInD;
    public boolean busy;

    public Channel() {
        owner = null;
        timeInB = 0;
        timeInD = 0;
    }

    public void updateTime() {
        if (owner != null) {
            if (owner.getName().equals("A")) {
                timeInB += 1;
            } else if (owner.getName().equals("C")) {
                timeInD += 1;
            }
        }
    }



    public Station getOwner() {
        return owner;
    }

    public void setOwner(Station owner) {
        this.owner = owner;
    }

    public double getTimeInB() {
        return timeInB;
    }

    public void setTimeInB(double timeInB) {
        this.timeInB = timeInB;
    }

    public double getTimeInD() {
        return timeInD;
    }

    public void setTimeInD(double timeInD) {
        this.timeInD = timeInD;
    }
}
