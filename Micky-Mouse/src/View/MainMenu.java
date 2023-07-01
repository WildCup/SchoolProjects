package View;

import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.scene.text.TextAlignment;

public class MainMenu extends GridPane {
    private static TextField text;

    public MainMenu() {
        super();
        setAlignment(Pos.CENTER);
        setPadding(new Insets(16));
        setHgap(16);
        setVgap(8);

        text = new TextField();
        add(text, 0, 0);

        Button playButton = new MenuButton("NEW GAME");
        add(playButton, 0, 1);
        Button ScoreButton = new MenuButton("HIGH SCORE");
        add(ScoreButton, 0, 2);
        Button ExitButton = new MenuButton("EXIT");
        add(ExitButton, 0, 3);

        playButton.setOnAction(e -> UIManager.PlayButton());
        ScoreButton.setOnAction(e -> UIManager.ScoreButton());
        ExitButton.setOnAction(e -> UIManager.ExitButton());
    }

    public static String getName() {
        return text.getText();
    }
}

class MenuButton extends Button{
    public MenuButton(String s) {
        super(s);
        setAlignment(Pos.CENTER);
        setTextAlignment(TextAlignment.CENTER);
        setPrefSize(250,50);
        setFont(Font.font("MV Boli", FontWeight.BOLD,30));
    }
}
class ExitButton extends Button{
    public ExitButton() {
        super("menu");
        setAlignment(Pos.CENTER);
        setTextAlignment(TextAlignment.CENTER);
        setPrefSize(60,20);
        setFont(Font.font("MV Boli", FontWeight.BOLD,15));
        setOnAction(e -> UIManager.GoToMenu());
    }
}