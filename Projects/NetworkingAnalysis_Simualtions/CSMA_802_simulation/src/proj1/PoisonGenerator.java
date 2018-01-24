package proj1;

import java.util.ArrayList;
import java.util.Random;

import static java.lang.Math.ceil;
import static java.lang.Math.log;

public class PoisonGenerator {
    public static ArrayList<Double> generateTraffic(double lambda, double sim_time, double slot_duration) {
        ArrayList<Double> U = new ArrayList<Double>();
        ArrayList<Double> X = new ArrayList<Double>();
        Random r = new Random();
        int i = 0;
        // Generate the inter slot times
        while (i < lambda*sim_time) {
            U.add((double)r.nextFloat());
            X.add(ceil(((-1/lambda) * log(1 - U.get(i))) / slot_duration));
            i++;
        }

        // Sum the inter slot times to achieve absolute slot times
        for(i = 1; i < X.size(); i++) {
            X.set(i, X.get(i) + X.get(i-1));
        }
        return X;
    }
}
