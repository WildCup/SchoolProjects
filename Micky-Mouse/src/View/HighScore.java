package View;
import Model.Player;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.HPos;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.ListView;
import javafx.scene.layout.GridPane;



public class HighScore extends GridPane {
    //public static final ObservableList names = FXCollections.observableArrayList();
    //public static final ObservableList data = FXCollections.observableArrayList();

    public HighScore() {
        super();
        setAlignment(Pos.CENTER);
        setPadding(new Insets(16));
        setVgap(16);

        ListView<String> list = new ListView<String>();
        ObservableList<String> items = FXCollections.observableArrayList (Player.getScores());
        list.setItems(items);

        add(list,0,0);

        ExitButton b = new ExitButton();
        setHalignment(b, HPos.CENTER);
        add(b,0,1);

    }
}
