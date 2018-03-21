package aspects;

import gomoku.core.Player;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

/*
 * Logs aspect
 */
public aspect Logs {

    /*
     * Pointcut on the placeStone function (core.model.Grid)
     */
    pointcut callPlaceStone(int x, int y, Player player) : call(void placeStone(int, int, Player)) && args(x, y, player);

    /*
     * After the call of placeStone, we execute this code.
     * Writing informations (the player's name and the position played) in an external .txt file.
     */
    after(int x, int y, Player player) : callPlaceStone(x, y, player) {
        //System.out.println("Joueur: "+player.getName()+", position: "+x+","+y+".");
        String fileName = "logs.txt";
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
