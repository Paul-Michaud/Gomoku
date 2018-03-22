package aspects;

import gomoku.core.Player;
import javafx.scene.paint.Color;

public aspect AdversaireJ {
    private Player blue = new Player("Mr. Blue", Color.BLUE);
    private Player red = new Player("Mr. Red", Color.RED);
    private boolean player = false;

    /*
     * Pointcut on the getCurrentPlayer function (ui.App)
     */
    pointcut callGetCurrentPlayer() : call(Player getCurrentPlayer());

    /*
     * We replace getCurrentPlayer code by this this code.
     * Switching between blue player and red player.
     */
    Player around() : callGetCurrentPlayer() {
        if (!player) {
            player = true;
            return blue;
        } else {
            player = false;
            return red;
        }
    }
}
