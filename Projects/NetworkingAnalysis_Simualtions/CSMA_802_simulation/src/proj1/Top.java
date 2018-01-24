package proj1;

public class Top {
    public static void main(String[] args) {

        Simulation csma_one_50_a = new Simulation("one", "csma", "a", 50, 50);
        Simulation csma_one_50_b = new Simulation("one", "csma", "b", 100, 50);

        Simulation csma_one_100_a = new Simulation("one", "csma", "a", 100, 100);
        Simulation csma_one_100_b = new Simulation("one", "csma", "b", 200, 100);

        Simulation csma_one_200_a = new Simulation("one", "csma", "a", 200, 200);
        Simulation csma_one_200_b = new Simulation("one", "csma", "b", 400, 200);

        Simulation csma_one_300_a = new Simulation("one", "csma", "a", 300, 300);
        Simulation csma_one_300_b = new Simulation("one", "csma", "b", 600, 300);

        // csma hidden
        Simulation csma_hidden_50_a = new Simulation("hidden", "csma", "a", 50, 50);
        Simulation csma_hidden_50_b = new Simulation("hidden", "csma", "b", 100, 50);

        Simulation csma_hidden_100_a = new Simulation("hidden", "csma", "a", 100, 100);
        Simulation csma_hidden_100_b = new Simulation("hidden", "csma", "b", 200, 100);

        Simulation csma_hidden_200_a = new Simulation("hidden", "csma", "a", 200, 200);
        Simulation csma_hidden_200_b = new Simulation("hidden", "csma", "b", 400, 200);

        Simulation csma_hidden_300_a = new Simulation("hidden", "csma", "a", 300, 300);
        Simulation csma_hidden_300_b = new Simulation("hidden", "csma", "b", 600, 300);

        // vcs one
        Simulation vcs_one_50_a = new Simulation("one", "vcs", "a", 50, 50);
        Simulation vcs_one_50_b = new Simulation("one", "vcs", "b", 100, 50);

        Simulation vcs_one_100_a = new Simulation("one", "vcs", "a", 100, 100);
        Simulation vcs_one_100_b = new Simulation("one", "vcs", "b", 200, 100);

        Simulation vcs_one_200_a = new Simulation("one", "vcs", "a", 200, 200);
        Simulation vcs_one_200_b = new Simulation("one", "vcs", "b", 400, 200);

        Simulation vcs_one_300_a = new Simulation("one", "vcs", "a", 300, 300);
        Simulation cs_one_300_b = new Simulation("one", "vcs", "b", 600, 300);

        Simulation vcs_hidden_50_a = new Simulation("hidden", "vcs", "a", 50, 50);
        Simulation vcs_hidden_50_b = new Simulation("hidden", "vcs", "b", 100, 50);

        Simulation vcs_hidden_100_a = new Simulation("hidden", "vcs", "a", 100, 100);
        Simulation vcs_hidden_100_b = new Simulation("hidden", "vcs", "b", 200, 100);

        Simulation vcs_hidden_200_a = new Simulation("hidden", "vcs", "a", 200, 200);
        Simulation vcs_hidden_200_b = new Simulation("hidden", "vcs", "b", 400, 200);

        Simulation vcs_hidden_300_a = new Simulation("hidden", "vcs", "a", 300, 300);
        Simulation vcs_hidden_300_b = new Simulation("hidden", "vcs", "b", 600, 300);
    }
}
