package com.DBConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by Asus PC on 7/1/2016.
 */
public class DBConnector {

    public Connection con;
    public Statement st;
    public ResultSet rs;

    public DBConnector(){

        try{
            //load the driver class
            Class.forName("com.mysql.jdbc.Driver");

            //get db connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Study_Buddy","root", "");
            st = con.createStatement();
        }catch(Exception e){
            System.out.println("no con"+  "  "+e);
        }
    }

}
