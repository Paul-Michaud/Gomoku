package aspects;

import gomoku.core.Player;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public aspect Journalisation {

    pointcut callPlaceStone(int x, int y, Player player) : call(void placeStone(int, int, Player)) && args(x, y, player);

    after(int x, int y, Player player) : callPlaceStone(x, y, player) {
        //System.out.println("Joueur: "+player.getName()+", position: "+x+","+y+".");
        String fileName = "journalisation.txt";
        BufferedWriter bufferedWriter = null;
        try {
            bufferedWriter = new BufferedWriter( new FileWriter(fileName, true));
            bufferedWriter.write("Joueur: "+player.getName()+", position: "+x+","+y+".");
            bufferedWriter.newLine();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
