package proj1;
import java.util.ArrayList;
import java.util.concurrent.ThreadLocalRandom;

import static java.lang.Math.ceil;

public class Station {
    private String name;
    private ArrayList<Double> traffic;
    private int backoff;
    private int cw;
    private int cw_max;
    private boolean transmitting;
    private String status;
    int packetSuccess;
    double timer;
    double slot_duration;
    double sifs_duration;
    double difs_duration;
    double sim_time;
    double trans_rate;
    private int dataframe_size;
    private int ACK, RTS, CTS;
    public boolean freeze;

    public Station() {

    }

    public Station(String name, int cw, int cw_max) {
        this.name = name;
        this.cw = cw;
        this.cw_max = cw_max;
        backoff = 0;
        transmitting = false;
        status = "wait";
        timer = 0;
        traffic = null;
        slot_duration = 20e-6; //20 us
        sifs_duration = 10e-6; //10 us
        difs_duration = 40e-6; //40 us
        trans_rate = 6e6; //6 Mb/s
        dataframe_size = 1500*8; //12000 bits
        ACK = 240; //240 bits
        RTS = 240; //240 bits
        CTS = 240; //240 bits
        freeze = false;
    }

    public void updateTimers(Station owner) {
        // Backoff logic
        if (status.equals("backoff") && owner == null)
            backoff--;
        // Dont reduce backoff if line is busy, just freeze
        else if (status.equals("backoff") && owner != null) {
            freeze = true;
            setStatus("wait");
        }

        // Timer Logic
        if (status.equals("difs") || status.equals("transmission") || status.equals("sifs") || status.equals("ack"))
            timer--;

        //sensing logic
        if (timer == 0 && status.equals("difs") && owner == null) {
            setStatus("backoff");
            // only update the backoff if not coming from freeze or collision
            if (!freeze)
                updateBackOff(false);
            else {
                freeze = false;
            }
        }
        else if (timer == 0 && status.equals("difs") && owner != null) {
            // just wait if channel busy after sensing line
            setStatus("wait");
        }
        // transmission steps
        else if (timer == 0 && status.equals("transmission")) {
            setStatus("sifs");
            setTimer(ceil(sifs_duration / slot_duration));
        }
        else if (timer == 0 && status.equals("sifs")) {
            setStatus("ack");
            setTimer(ceil((ACK / trans_rate) / slot_duration));
        }
        else if (timer == 0 && status.equals("ack")) {
            setStatus("wait");
            traffic.remove(0);
            packetSuccess += 1;
            setTransmitting(false);
        }

        // Ready to transmit
        if (backoff == 0 && status.equals("backoff")) {
            setStatus("transmission");
            setTransmitting(true);
            setTimer(ceil((dataframe_size / trans_rate) / slot_duration));
        }
    }

    public void updateTimersVCS(boolean busy, Station s) {
        // Backoff logic
        if (status.equals("backoff") && !busy)
            backoff--;
            // Dont reduce backoff if line is busy, just freeze
        else if (status.equals("backoff") && busy) {
            freeze = true;
            setStatus("wait");
        }

        // Timer Logic
        if (status.equals("difs") && !busy)
            timer--;
        else if (status.equals("rts") || status.equals("sifs1") || status.equals("cts"))
            timer--;
        else if (status.equals("sifs2") || status.equals("transmission") || status.equals("sifs3") || status.equals("ack")) {
            if (s == null || s.getName().equals(name)) {
                timer--;
            }
            else if (busy && (s == null || !s.getName().equals(name)))
                setStatus("wait");
        }

        //sensing logic
        if (timer == 0 && status.equals("difs") && !busy) {
            setStatus("backoff");
            // only update the backoff if not coming from freeze or collision
            if (!freeze)
                updateBackOff(false);
            else {
                freeze = false;
            }
        }
        else if (timer == 0 && status.equals("difs") && busy) {
            // just wait if channel busy after sensing line
            setStatus("wait");
        }
        // transmission steps
        else if (timer == 0 && status.equals("rts")) {
            setStatus("sifs1");
            setTimer(ceil(sifs_duration / slot_duration));
        }
        else if (timer == 0 && status.equals("sifs1")) {
            setStatus("cts");
            setTimer(ceil((CTS / trans_rate) / slot_duration));
        }
        else if (timer == 0 && status.equals("cts")) {
            setStatus("sifs2");
            setTimer(ceil(sifs_duration / slot_duration));
        }
        else if (timer == 0 && status.equals("sifs2")) {
            setStatus("transmission");
            setTimer(ceil((dataframe_size / trans_rate) / slot_duration));
            setTransmitting(true);
        }
        else if (timer == 0 && status.equals("transmission")) {
            setStatus("sifs3");
            setTimer(ceil(sifs_duration / slot_duration));
        }
        else if (timer == 0 && status.equals("sifs3")) {
            setStatus("ack");
            setTimer(ceil((ACK / trans_rate) / slot_duration));
        }
        else if (timer == 0 && status.equals("ack")) {
            setStatus("wait");
            traffic.remove(0);
            packetSuccess += 1;
            setTransmitting(false);
        }

        // Ready to RTS
        if (backoff == 0 && status.equals("backoff")) {
            setStatus("rts");
            setTimer(ceil((RTS / trans_rate) / slot_duration));
        }
    }

    public boolean isTransmitting() {
        return transmitting;
    }

    public void setTransmitting(boolean transmitting) {
        this.transmitting = transmitting;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String s) {
        status = s;
    }

    public double getTimer() {
        return timer;
    }

    public void setTimer(double timer) {
        this.timer = timer;
    }

    public void updateBackOff(boolean collision) {
        if(collision) {
            if (cw*2 <= cw_max)
                cw = cw*2;
        }
        randomBackOff();
    }

    private void randomBackOff() {
        backoff = ThreadLocalRandom.current().nextInt(0, cw + 1);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Double> getTraffic() {
        return traffic;
    }

    public void setTraffic(ArrayList<Double> traffic) {
        this.traffic = traffic;
    }

    public int getBackoff() {
        return backoff;
    }

    public void setBackoff(int backoff) {
        this.backoff = backoff;
    }

    public int getCw() {
        return cw;
    }

    public void setCw(int cw) {
        this.cw = cw;
    }

    public int getCw_max() {
        return cw_max;
    }

    public void setCw_max(int cw_max) {
        this.cw_max = cw_max;
    }
}
