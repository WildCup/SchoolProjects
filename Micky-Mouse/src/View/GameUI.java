package View;
import Model.*;

import javafx.animation.FadeTransition;
import javafx.animation.ParallelTransition;
import javafx.animation.PathTransition;
import javafx.animation.SequentialTransition;
import javafx.scene.Group;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.effect.DropShadow;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.util.Duration;

import static java.lang.Math.random;

public class GameUI extends Group {
    Path path1;
    Path path2;
    Path path3;
    Path path4;
    Heart[] hearts;
    Player player;
    int[][] ends = new int[4][2];
    ImageView[] primogems = new ImageView[10];
    int count = 0;
    Label label;
    static Thread spawnGems;
    SequentialTransition transition = new SequentialTransition();

    public GameUI(Player player) {
        this.player = player;

        //region score
        label = new Label("score: 0");
        label.setLayoutX(100);
        label.setLayoutY(5);
        getChildren().add(label);
        //endregion

        //region lines
        Point a = new Point(0,132);
        Point a1 = new Point(148,212);

        Point b = new Point(0,232);
        Point b1 = new Point(148,312);

        Point c = new Point(500,132);
        Point c1 = new Point(336,212);

        Point d = new Point(500,232);
        Point d1 = new Point(336,312);

        getChildren().add(new MyLine(a,a1));
        getChildren().add(new MyLine(b,b1));
        getChildren().add(new MyLine(c,c1));
        getChildren().add(new MyLine(d,d1));
        //endregion

        //region spawners
        getChildren().add(new Spawner(5, 75));
        getChildren().add(new Spawner(5, 175));
        getChildren().add(new Spawner(420, 75));
        getChildren().add(new Spawner(420, 175));
        //endregion

        //region paths
        int x1 = 40;
        int y1 = -22;
        int x2 = 50;
        int y2 = 10;
        int offset = -20;
        int upTo = 40;
        int goAway = 90;

        path1 = new Path();
        path1.getElements().add(new MoveTo(a.x+x1,a.y+y1));
        path1.getElements().add(new LineTo(a.x+x2,a.y+y2));
        path1.getElements().add(new LineTo(a1.x+x2+offset,a1.y+y2+offset));
        path1.getElements().add(new LineTo(a1.x+x2+offset,a1.y+y2+offset+upTo));
        ends[0][0] = a1.x+x2+offset;
        ends[0][1] = a1.y+y2+offset+upTo;

        path2 = new Path();
        path2.getElements().add(new MoveTo(b.x+x1,b.y+y1));
        path2.getElements().add(new LineTo(b.x+x2,b.y+y2));
        path2.getElements().add(new LineTo(b1.x+x2+offset,b1.y+y2+offset));
        path2.getElements().add(new LineTo(b1.x+x2+offset,b1.y+y2+offset+upTo));
        ends[1][0] = b1.x+x2+offset;
        ends[1][1] = b1.y+y2+offset+upTo;

        path3 = new Path();
        path3.getElements().add(new MoveTo(c.x-x1,c.y+y1));
        path3.getElements().add(new LineTo(c.x-x2,c.y+y2));
        path3.getElements().add(new LineTo(c1.x-x2-offset,c1.y+y2+offset));
        path3.getElements().add(new LineTo(c1.x-x2-offset,c1.y+y2+offset+upTo));
        ends[2][0] = c1.x-x2-offset;
        ends[2][1] = c1.y+y2+offset+upTo;

        path4 = new Path();
        path4.getElements().add(new MoveTo(d.x-x1,d.y+y1));
        path4.getElements().add(new LineTo(d.x-x2,d.y+y2));
        path4.getElements().add(new LineTo(d1.x-x2-offset,d1.y+y2+offset));
        path4.getElements().add(new LineTo(d1.x-x2-offset,d1.y+y2+offset+upTo));
        ends[3][0] = d1.x-x2-offset;
        ends[3][1] = d1.y+y2+offset+upTo;
        //endregion

        //region HuTao
        Image HuTaoDown = new Image("Images/HuTaoDown.png");
        Image HuTaoUp = new Image("Images/HuTaoUp.png");
        ImageView HuTao = new ImageView(HuTaoDown);
        HuTao.setX(142);
        HuTao.setY(210);
        HuTao.setFitWidth(200);
        HuTao.setFitHeight(200);

        getChildren().add(HuTao);
        //endregion

        //region buttons
        Button LeftUp = new Button("LeftUp");
        LeftUp.setLayoutX(50);
        LeftUp.setLayoutY(400);
        LeftUp.setOnAction(e -> {
            HuTao.setScaleX(-1);
            HuTao.setImage(HuTaoUp);
            player.setPosition(0);
        });

        Button RightUp = new Button("RightUp");
        RightUp.setLayoutX(400);
        RightUp.setLayoutY(400);
        RightUp.setOnAction(e -> {
            HuTao.setScaleX(1);
            HuTao.setImage(HuTaoUp);
            player.setPosition(2);
        });

        Button LeftDown = new Button("LeftDown");
        LeftDown.setLayoutX(50);
        LeftDown.setLayoutY(430);
        LeftDown.setOnAction(e -> {
            HuTao.setScaleX(-1);
            HuTao.setImage(HuTaoDown);
            player.setPosition(1);
        });

        Button RightDown = new Button("RightDown");
        RightDown.setLayoutX(400);
        RightDown.setLayoutY(430);
        RightDown.setOnAction(e -> {
            HuTao.setScaleX(1);
            HuTao.setImage(HuTaoDown);
            player.setPosition(3);
        });
        getChildren().add(LeftUp);
        getChildren().add(RightUp);
        getChildren().add(LeftDown);
        getChildren().add(RightDown);

        addEventHandler(KeyEvent.KEY_PRESSED, ev -> {
            if (ev.getCode() == KeyCode.W) {
                LeftUp.fire();
            }
            else if (ev.getCode() == KeyCode.P) {
                RightUp.fire();
            }
            else if (ev.getCode() == KeyCode.S) {
                LeftDown.fire();
            }
            else if (ev.getCode() == KeyCode.L) {
                RightDown.fire();
            }
            ev.consume();
        });
        //endregion

        //region heart
        hearts = new Heart[3];
        for (int i = 0; i < 3; i++) {
            hearts[i] = new Heart(250 + i*50);
            getChildren().add(hearts[i]);
        }
        //endregion

        //region shortcut menuButton
        Button menu = new ExitButton();
        menu.setLayoutX(430);
        menu.setLayoutY(5);

        getChildren().add(menu);

        KeyCombination k = new KeyCodeCombination(KeyCode.Q, KeyCombination.CONTROL_DOWN, KeyCombination.SHIFT_DOWN);
        Main.getScene().getAccelerators().put(k, menu::fire);
        //endregion

        //region primogems
        for (int i = 0; i < primogems.length; i++) {
            Image image = new Image("Images/primogem.png");
            ImageView primogem = new ImageView(image);
            primogem.setFitWidth(35);
            primogem.setFitHeight(35);

            DropShadow shadow = new DropShadow();
            shadow.setOffsetX(6);
            shadow.setOffsetY(6);
            shadow.setColor(Color.GRAY);
            primogem.setEffect(shadow);

            getChildren().add(primogem);

            primogems[i] = primogem;
            restartPrimogem(i);
        }

        spawnGems = new Thread(()->{
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                return;
            }
            while(!Thread.interrupted()){
                spawn();
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    return;
                }
            }
        });
        spawnGems.start();
        //endregion
    }

    public void spawn(){
        PathTransition move = new PathTransition();
        move.setDuration(Duration.seconds(1));
        move.setNode(primogems[count]);

        int i = (int)(Math.random()*4);
        switch (i){
            case 0 -> move.setPath(path1);
            case 1 -> move.setPath(path2);
            case 2 -> move.setPath(path3);
            case 3 -> move.setPath(path4);
        }
        move.setOnFinished(e->check(i, count, transition));

        //region fade out primogem
        FadeTransition fade = new FadeTransition();
        fade.setDuration(Duration.seconds(1));
        fade.setFromValue(1);
        fade.setToValue(0);
        fade.setNode(primogems[count]);
        fade.setOnFinished(e->restartPrimogem(count));
        //endregion

        //region move2
        PathTransition move2 = new PathTransition();
        move2.setDuration(Duration.seconds(0.5));
        move2.setNode(primogems[count]);
        Path path = new Path();
        path.getElements().add(new MoveTo(ends[i][0],ends[i][1]));
        path.getElements().add(new LineTo(ends[i][0],ends[i][1]+150));
        move2.setPath(path);
        //endregion

        ParallelTransition parallelTransition = new ParallelTransition(move2, fade);
        transition = new SequentialTransition(move, parallelTransition);
        transition.play();

        count++;
        if (count == primogems.length)
            count = 0;
    }
    public void check(int i, int gem, SequentialTransition transition){
       if(player.getPosition() == i) {
           //play win animation
           restartPrimogem(gem);
           player.addScore();
           label.setText("score: " + player.getScore());
           transition.stop();
        }
        else {
            if (player.getHp() > 0) {
                //fade out heart
                FadeTransition fadeHeart = new FadeTransition();
                fadeHeart.setDuration(Duration.seconds(1));
                fadeHeart.setFromValue(1);
                fadeHeart.setToValue(0);
                fadeHeart.setNode(hearts[player.getHp() - 1]);
                fadeHeart.play();
            }
            player.takeDamage();
        }
    }
    public void restartPrimogem(int gem){
        primogems[gem].setX(-100);
        primogems[gem].setY(-100);
        primogems[gem].setOpacity(1);
        //primogems[gem].setFitWidth(35);
        //primogems[gem].setFitHeight(35);
    }

    public static Thread getSpawnGems() {
        return spawnGems;
    }
}
