package aspects;

import gomoku.core.Player;

public aspect Journalisation {

    pointcut callPlaceStone(int x, int y, Player player) : call(void placeStone(int, int, Player)) && args(x, y, player);

    after(int x, int y, Player player) : callPlaceStone(x, y, player) {
        System.out.println("Joueur: "+player.getName()+", position: "+x+"-"+y+".");
    }
}
