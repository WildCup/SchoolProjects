package Model;

import View.UIManager;

import java.util.LinkedList;
import java.util.List;

public class Player {
    private int hp;
    private int score;
    private String name;
    private int position = 3;

    private static List<String> scores = new LinkedList<>();

    public Player(String name) {
        this.hp = 3;
        this.score = 0;
        this.name = name;
    }

    public void takeDamage(){
        System.out.println("HP: " + (hp-1));
        if(--hp <= 0) die();
    }
    public void die(){
        System.out.println("DIED");
        scores.add(name + ": " + " ".repeat(Math.max(0, Math.max(0, 10 - name.length()))) + score);
        SaveLoad.save();
        UIManager.GoToMenu();
    }

    public void addScore(){
        score++;
    }

    public static List<String> getScores() {
        return scores;
    }

    public static void setScores(List<String> scores) {
        Player.scores = scores;
    }

    public int getHp() {
        return hp;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public int getScore() {
        return score;
    }
}