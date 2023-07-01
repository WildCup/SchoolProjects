package View;

import Model.SaveLoad;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.GridPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

public class Main extends Application {

    private static Scene scene;

    public static void main(String[] args) {
        launch(args);
        SaveLoad.load();
    }

    @Override
    public void start(Stage stage) throws Exception {
        GridPane root = new MainMenu();

        stage.getIcons().setAll(new Image("Images\\primogem.png"));
        stage.setTitle("Project 3");
        scene = new Scene(root, 500, 500);
        scene.setFill(Color.DEEPSKYBLUE);
        stage.setScene(scene);
        stage.show();
    }

    @Override
    public void stop() throws Exception {
        super.stop();
        GameUI.getSpawnGems().interrupt();
    }

    public static Scene getScene() {
        return scene;
    }
}
