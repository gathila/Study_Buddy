package com.Game;

import com.UserInformation.User;
import com.loginController.LoginController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Asus PC on 7/3/2016.
 */

@Controller
public class GameHandler {


    @RequestMapping(value = "/level1", method = RequestMethod.GET)
    public String playGame(@RequestParam("username") String userName, Model model){
        model.addAttribute("username", userName);
        return "level1";
    }

    @RequestMapping(value = "/nextLevel", method = RequestMethod.GET)
    public String nextLevel(@RequestParam("level") String level, @RequestParam("username") String userName, @RequestParam("score") String score, Model model){
        int currentLevel = Integer.parseInt(level);
        int nextLevel;
        if(currentLevel < 10)                                           //10 is number of levels in the game
            nextLevel = currentLevel + 1;
        else nextLevel = currentLevel;
        User user = new User(userName, LoginController.connectDB);
        System.out.println(score);
        user.updateLevel(currentLevel, Integer.parseInt(score));        //update db with level and score
        model.addAttribute("username", userName);
        return "level"+nextLevel;
    }

    @RequestMapping(value = "/levels", method = RequestMethod.GET)
    public String getLevels(@RequestParam("username") String userName, Model model){
        User user = new User(userName, LoginController.connectDB);
        int maxLevel = user.getMaxLevel();
        int [] score = user.getScoreFoeEachLevel();
        model.addAttribute("username", userName);
        model.addAttribute("maxLevel", maxLevel);
        model.addAttribute("scoreForEachLevel", score);
        return "levels";
    }

    @RequestMapping(value = "/moveTo", method = RequestMethod.GET)
    public String moveTo(@RequestParam("level") String level, @RequestParam("username") String userName, Model model){
        model.addAttribute("username", userName);
        return "level"+level;
    }

    @RequestMapping(value = "/instruction", method = RequestMethod.GET)
    public String getInstructions(@RequestParam("level") String level, Model model){
        // model.addAttribute("maxLevel", max)
        String returnPage = "level"+level+"Instructions";
        return returnPage;
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String returnHome(@RequestParam("username") String username, Model model){
        model.addAttribute("username", username);
        return "home";
    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(){
        return "login";
    }
}
