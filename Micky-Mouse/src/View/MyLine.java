package View;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.shape.Line;

public class MyLine extends Line {
    public MyLine(Point a, Point b){
        super(a.x,a.y,b.x,b.y);
        setStroke(Color.DARKVIOLET);
        setStrokeWidth(10);
    }
}

class Spawner extends ImageView{
    public Spawner(int x, int y) {
        super(new Image("Images/spawner.png"));
        setFitWidth(75);
        setFitHeight(75);
        setX(x);
        setY(y);
    }
}

class Heart extends ImageView{
    public Heart(int x) {
        super(new Image("Images/heartFull.png"));
        setFitWidth(45);
        setFitHeight(45);
        setX(x);
    }
}

class Point{
    int x;
    int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
}
