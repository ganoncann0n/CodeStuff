package proj1;

import java.io.*;

import static java.lang.Math.ceil;

public class Simulation {
    private double slot_duration;
    private double sifs_duration;
    private double difs_duration;
    private double sim_time;
    private double trans_rate;
    private int contention_window_init;
    private int contention_window_max;
    private int ACK, RTS, CTS;
    private int dataframe_size;
    private float lambdaA, lambdaC;
    private Station A;
    private Station B;
    private Station C;
    private Station D;
    private String sim_domain;
    private String sim_type;
    private float clock;
    private String scenario;
    public double timeInB;
    public double timeInD;
    public int collisions;
    public Channel channel;

    public Simulation(String domain, String sim_type, String Scenario, float lamA, float lamC) {
        timeInB = 0;
        timeInD = 0;
        collisions = 0;
        slot_duration = 20e-6; //20 us
        sifs_duration = 10e-6; //10 us
        difs_duration = 40e-6; //40 us
        lambdaA = lamA;
        lambdaC = lamC;
        sim_time = 10; //10 s
        trans_rate = 6e6; //6 Mb/s
        contention_window_init = 4; //4 slots
        contention_window_max = 1024; //1024 slots
        ACK = 240; //240 bits
        RTS = 240; //240 bits
        CTS = 240; //240 bits
        dataframe_size = 1500*8; //12000 bits
        this.sim_type = sim_type;
        sim_domain = domain;
        scenario = Scenario;
        clock = 0;
        channel = new Channel();
        create_stations();
        setup_sim();
        if (this.sim_type.equals("csma")) {
                run_sim_csma();
        }
        else {
            run_sim_vcs();
        }
        write_results();
    }

    public void write_results() {
        System.out.println("\n" + sim_type + "_" + sim_domain + "_" + lambdaC + "_" + scenario);
        System.out.println("A success: " + A.packetSuccess);
        System.out.println("C success: " + C.packetSuccess);
        System.out.println("A throughput (Kbps): " + (A.packetSuccess * (dataframe_size / sim_time) / 1000));
        System.out.println("C throughput (Kbps): " + (C.packetSuccess * (dataframe_size / sim_time) / 1000));
        System.out.println("Collisions: " + collisions);
        System.out.println("Fairness Index: " + channel.timeInB/channel.timeInD);
    }

    public void setup_sim() {
        A.setTraffic(PoisonGenerator.generateTraffic(lambdaA, sim_time, slot_duration));
        C.setTraffic(PoisonGenerator.generateTraffic(lambdaC, sim_time, slot_duration));
    }

    public void run_sim_csma() {
        while (clock < ceil(sim_time/slot_duration)) {
            //sense the channel if possible
            // In single domain, can hear the line
            if (channel.getOwner() == null && sim_domain.equals("one")) {
                if (A.getTraffic().size() > 0) {
                    if (A.getTraffic().get(0) <= clock && A.getStatus().equals("wait")) {//waiting packet
                        A.setStatus("difs");
                        A.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
                if (C.getTraffic().size() > 0) {
                    if (C.getTraffic().get(0) <= clock && C.getStatus().equals("wait")) {
                        C.setStatus("difs");
                        C.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
            }
            // In hidden, cant hear the line, just starts difs if it can
            else if (sim_domain.equals("hidden")) {
                if (A.getTraffic().size() > 0) {
                    if (A.getTraffic().get(0) <= clock && A.getStatus().equals("wait")) {//waiting packet
                        A.setStatus("difs");
                        A.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
                if (C.getTraffic().size() > 0) {
                    if (C.getTraffic().get(0) <= clock && C.getStatus().equals("wait")) {
                        C.setStatus("difs");
                        C.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
            }

            //check contention
            // if collision, regen new back off value, advance time to cover the transmission and sifs, and set both back to sense
            if (A.isTransmitting() && C.isTransmitting()) {
                collisions++;
                A.setTransmitting(false);
                A.setStatus("difs");
                A.setTimer(ceil(difs_duration / slot_duration));
                A.updateBackOff(true);
                C.setTransmitting(false);
                C.setStatus("difs");
                C.setTimer(ceil(difs_duration / slot_duration));
                C.updateBackOff(true);
                clock += ceil(((dataframe_size / trans_rate) + (sifs_duration)) / slot_duration);
            }
            else if (A.isTransmitting() && !C.isTransmitting()) {
                    channel.setOwner(A);
            }
            else if (C.isTransmitting() && !A.isTransmitting()) {
                channel.setOwner(C);
            }

            // update timers and clock
            clock += 1;
            channel.updateTime();
            if (sim_domain.equals("one")) {
                A.updateTimers(channel.getOwner());
                C.updateTimers(channel.getOwner());
            }
            else { //hidden cant hear the line
                A.updateTimers(null);
                C.updateTimers(null);
            }
            // check if channel freed
            if (channel.getOwner() != null && !A.isTransmitting() && !C.isTransmitting()) {
                channel.setOwner(null);
            }
        }
    }

    public void run_sim_vcs() {
        while (clock < sim_time/slot_duration) {
            //sense the channel if possible
            // In single domain, can hear the line
            if (!channel.busy && sim_domain.equals("one")) {
                if (A.getTraffic().size() > 0) {
                    if (A.getTraffic().get(0) <= clock && A.getStatus().equals("wait") && !C.getStatus().equals("rts")) {//waiting packet
                        A.setStatus("difs");
                        A.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
                if (C.getTraffic().size() > 0) {
                    if (C.getTraffic().get(0) <= clock && C.getStatus().equals("wait") && !A.getStatus().equals("rts")) {
                        C.setStatus("difs");
                        C.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
            }
            // Cannot see other rts in hidden domain
            else if (!channel.busy && sim_domain.equals("hidden")){
                if (A.getTraffic().size() > 0) {
                    if (A.getTraffic().get(0) <= clock && A.getStatus().equals("wait")) {//waiting packet
                        A.setStatus("difs");
                        A.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
                if (C.getTraffic().size() > 0) {
                    if (C.getTraffic().get(0) <= clock && C.getStatus().equals("wait")) {
                        C.setStatus("difs");
                        C.setTimer(ceil(difs_duration / slot_duration));
                    }
                }
            }

            //check contention
            // cts
            if (sim_domain.equals("one")) {
                if (A.getStatus().equals("cts") || C.getStatus().equals("cts") || A.getStatus().equals("rts") || C.getStatus().equals("rts")) {
                    channel.busy = true;
                }
            }
            // hidden can't hear rts, only cts
            else {
                if (A.getStatus().equals("cts") || C.getStatus().equals("cts")) {
                    channel.busy = true;
                }
            }

            // if collision, regen new back off value, advance time to cover the transmission and sifs, and set both back to sense
            if (A.isTransmitting() && C.isTransmitting()) {
                collisions++;
                A.setTransmitting(false);
                A.setStatus("difs");
                A.setTimer(ceil(difs_duration / slot_duration));
                A.updateBackOff(true);
                C.setTransmitting(false);
                C.setStatus("difs");
                C.setTimer(ceil(difs_duration / slot_duration));
                C.updateBackOff(true);
                clock += ceil(((dataframe_size / trans_rate) + (sifs_duration)) / slot_duration);
                channel.busy = false;
            }
            else if (A.isTransmitting() && !C.isTransmitting()) {
                channel.setOwner(A);
                channel.busy = true;
            }
            else if (C.isTransmitting() && !A.isTransmitting()) {
                channel.setOwner(C);
                channel.busy = true;
            }

            // update timers and clock
            clock += 1;
            channel.updateTime();
            A.updateTimersVCS(channel.busy, channel.getOwner());
            C.updateTimersVCS(channel.busy, channel.getOwner());

            // check if channel freed
            if (channel.getOwner() != null && !A.isTransmitting() && !C.isTransmitting()) {
                channel.setOwner(null);
                channel.busy = false;
            }
        }
    }


    public void create_stations() {
        if(this.sim_domain.equals("one")) {
            this.A = new Station("A", contention_window_init, contention_window_max);
            this.B = new Station("B", contention_window_init, contention_window_max);
            this.C = new Station("C", contention_window_init, contention_window_max);
            this.D = new Station("D", contention_window_init, contention_window_max);
        } else if(this.sim_domain.equals("hidden")){
            this.A = new Station("A", contention_window_init, contention_window_max);
            this.B = new Station("B", contention_window_init, contention_window_max);
            this.C = new Station("C", contention_window_init, contention_window_max);
        } else {
            System.out.println("Cannot create a simulation with sim domain: " + this.sim_domain);
        }
    }

    public float getLambdaA() {
        return lambdaA;
    }

    public void setLambdaA(float lambdaA) {
        this.lambdaA = lambdaA;
    }

    public float getLambdaC() {
        return lambdaC;
    }

    public void setLambdaC(float lambdaC) {
        this.lambdaC = lambdaC;
    }

    public double getSlot_duration() {
        return slot_duration;
    }

    public double getSifs_duration() {
        return sifs_duration;
    }

    public double getDifs_duration() {
        return difs_duration;
    }

    public double getSim_time() {
        return sim_time;
    }

    public double getTrans_rate() {
        return trans_rate;
    }

    public int getContention_window_init() {
        return contention_window_init;
    }

    public int getContention_window_max() {
        return contention_window_max;
    }

    public Station getA() {
        return A;
    }

    public Station getB() {
        return B;
    }

    public Station getC() {
        return C;
    }

    public Station getD() {
        return D;
    }

    public void setSlot_duration(int slot_duration) {
        this.slot_duration = slot_duration;
    }

    public void setSifs_duration(int sifs_duration) {
        this.sifs_duration = sifs_duration;
    }

    public void setDifs_duration(int difs_duration) {
        this.difs_duration = difs_duration;
    }

    public void setSim_time(float sim_time) {
        this.sim_time = sim_time;
    }

    public void setTrans_rate(float trans_rate) {
        this.trans_rate = trans_rate;
    }

    public void setContention_window_init(int contention_window_init) {
        this.contention_window_init = contention_window_init;
    }

    public void setContention_window_max(int contention_window_max) {
        this.contention_window_max = contention_window_max;
    }

    public void setA(Station a) {
        A = a;
    }

    public void setB(Station b) {
        B = b;
    }

    public void setC(Station c) {
        C = c;
    }

    public void setD(Station d) {
        D = d;
    }
}
