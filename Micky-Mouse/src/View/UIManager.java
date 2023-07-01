package View;
import Model.*;

public class UIManager { //controller
    public static void PlayButton(){
        GameUI game = new GameUI(new Player(MainMenu.getName()));
        Main.getScene().setRoot(game);
    }
    public static void ScoreButton(){
        Main.getScene().setRoot(new HighScore());
    }
    public static void ExitButton(){
        System.exit(0);
    }
    public static void GoToMenu(){
        Main.getScene().setRoot(new MainMenu());
        GameUI.getSpawnGems().interrupt();
    }
}
