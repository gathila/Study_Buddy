package com.UserInformation;

import com.DBConnector.DBConnector;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by Asus PC on 7/1/2016.
 */
public class User {

    private String username;
    private String password;
    private String email;
    private DBConnector connetDB;
    private int maxLevel;

    public User(){}

    public User(String username, DBConnector connetDB){
        this.username = username;
        this.connetDB = connetDB;
    }

    public User(String username, String password, DBConnector connetDB){
        this.username = username;
        this.password = password;
        this.connetDB = connetDB;
    }

    public User(String username, String password, String email, DBConnector connetDB){
        this.username = username;
        this.password = password;
        this.email = email;
        this.connetDB = connetDB;
    }

    public String verifyUser(){
        String column = "username";

        try {
            PreparedStatement statement = connetDB.con.prepareStatement("select password from users where username = ?");
            statement.setString(1, username);
            connetDB.rs = statement.executeQuery();
            while (connetDB.rs.next()){
                if(connetDB.rs.getString("password").equals(password)){
                    return "success";
                }else {
                    return "fail";      // wrong password
                }
            }
            // username incorrect
            return "noAccount";
        } catch (SQLException e) {
            e.printStackTrace();
            return "fail";
        }
    }

    public boolean addUserToDB(){
        try {
            PreparedStatement statement = connetDB.con.prepareStatement("insert into users VALUEs(?,?,?,?)");
            statement.setString(1, username);
            statement.setString(2, password);
            statement.setString(3, email);
            statement.setInt(4, 1);
            statement.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     *
     * @return
     */
    public int getMaxLevel() {
        try {
            PreparedStatement statement = connetDB.con.prepareStatement("select stage from users where userName = ?");
            statement.setString(1, username);
            connetDB.rs = statement.executeQuery();

            while (connetDB.rs.next()) {
                maxLevel = connetDB.rs.getInt("stage");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxLevel;
    }


    public int [] getScoreFoeEachLevel(){
        int [] scoreForEachLevel = new int[maxLevel];       // score for each level from level 1 to recent
        try{
            int levelCount = 1;
            PreparedStatement statement = connetDB.con.prepareStatement("select score from score");
            connetDB.rs = statement.executeQuery();
            while (connetDB.rs.next()) {
                scoreForEachLevel[levelCount-1] = connetDB.rs.getInt("score");
                levelCount++;
            }
            if(maxLevel < 10)   scoreForEachLevel[maxLevel-1] = 0;      //
            return scoreForEachLevel;
        }catch (SQLException e){
            e.printStackTrace();
            scoreForEachLevel[0] = -1;          //If sql exception occurs return -1 to 0th element of array
            return scoreForEachLevel;
        }
    }
    public String getUsername(){
        return username;
    }


    public void updateLevel(int stage, int levelScore){
        try {
            PreparedStatement statement = connetDB.con.prepareStatement("update users set stage = ? where userName = ? " +
                    "and stage <= ?");
            statement.setInt(1, stage+1);
            statement.setString(2, this.username);
            statement.setInt(3, stage);
            int affectedRows = statement.executeUpdate();       //affectedRows = Number of updated rows

            PreparedStatement scoreUpdate;

            //if updated rows > 0 then the user get into higher level. Otherwise user played a level already has completed
            if(affectedRows > 0){
                this.maxLevel = stage+1;

                scoreUpdate = connetDB.con.prepareStatement("insert into score VALUES ?, ?, ?");
                scoreUpdate.setString(1, this.username);
                scoreUpdate.setInt(2, stage);
                scoreUpdate.setInt(3, levelScore);
                statement.executeUpdate();
            }else {

                scoreUpdate = connetDB.con.prepareStatement("update score set score = ? where userName = ? " +
                        "and level = ?");
                scoreUpdate.setInt(1, levelScore);
                scoreUpdate.setString(2, this.username);
                scoreUpdate.setInt(3, stage);
                scoreUpdate.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
