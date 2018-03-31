package aspects;

import gomoku.core.Player;
import gomoku.core.model.Grid;
import gomoku.core.model.Spot;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;
import java.util.ArrayList;
import java.util.List;
import gomoku.ui.Borad;

public privileged aspect FinJeu {
    private Boolean gameOver = false;
    private List<Spot> winningStones = new ArrayList<>(0);
    private GraphicsContext gc = null;

    /*
     * Pointcut on the gameOver function from GridChangeListener
     */
    pointcut callGameOver(Player winner) : call(void notifyGameOver(Player)) && args(winner);

    /*
     * Pointcut on the placeStone function (core.model.Grid)
     */
    pointcut callPlaceStone(int x, int y, Player player) : call(void placeStone(int, int, Player)) && args(x, y, player);

    /*
     * Pointcut on the winningStones attribute, when it's set (modified)
     */
    pointcut setWinningStonesPointcut(List<Spot> newValue) : set(List<Spot> Grid.winningStones) && args(newValue);

    /*
     * Pointcut on the drawStone function from Borad
     */
    pointcut callDrawStone(GraphicsContext gc, Spot p) : call(void drawStone(GraphicsContext, Spot)) && args(gc, p);

    /*
     * After the call of drawStone, we save the value of gc to use it later
     */
    after(GraphicsContext gc, Spot p) : callDrawStone(gc, p) {
        this.gc = gc;
    }

    /*
     * We keep a record to the winning values
     */
    after(List<Spot> newValue) : setWinningStonesPointcut(newValue) {
        this.winningStones = newValue;
    }

    /*
     * After the call of gameOver, we execute this code.
     */
    after(Player winner) : callGameOver(winner) {
        double spotSize = 20;
        this.gameOver = true;
        for (Spot stone : this.winningStones) {
            this.gc.setFill(Color.YELLOW);
            double x = spotSize + stone.x * spotSize; // center x
            double y = spotSize + stone.y * spotSize; // center y
            double r = spotSize / 2; // radius
            this.gc.fillOval(x - r, y - r, r * 2, r * 2);
        }
    }

    /*
     * If the game is over we display a message otherwise we proceed to the normal behavior
     */
    void around(int x, int y, Player player) : callPlaceStone(x, y, player) {
        if(gameOver) {
            System.out.println("The game is over");
        } else {
            proceed(x,y,player);
        }

    }
}
