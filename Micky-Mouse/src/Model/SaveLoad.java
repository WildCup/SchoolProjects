package Model;

import java.io.*;
import java.util.List;

public class SaveLoad implements Serializable {
    private List<String> scores;

    public SaveLoad(List<String> scores) {
        this.scores = scores;
    }

    public static void save() {
        try {
            FileOutputStream stream = new FileOutputStream("save.txt");
            ObjectOutputStream stream2 = new ObjectOutputStream(stream);
            stream2.writeObject(new SaveLoad(Player.getScores()));
            stream2.flush();
            stream2.close();
        } catch (IOException e) {
            System.out.println("saving didn't work ?");
        }
    }

    public static void load() {
        try {
            FileInputStream stream = new FileInputStream("save.txt");
            ObjectInputStream stream2 = new ObjectInputStream(stream);
            SaveLoad saveData = (SaveLoad) stream2.readObject();
            stream2.close();
            Player.getScores().clear();
            Player.setScores(saveData.scores);
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("File not found ?");
        }
    }
}
