package com.loginController;

import com.DBConnector.DBConnector;
import com.UserInformation.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.jws.soap.SOAPBinding;

/**
 * Created by Asus PC on 7/1/2016.
 */

@Controller
public class LoginController {

    boolean isdbInitialized = false;
    public static DBConnector connectDB;

    @RequestMapping("/login")
    public ModelAndView login(){

        if(!isdbInitialized){
          //  connectDB = new DBConnector();
            isdbInitialized = true;
        }
        connectDB = new DBConnector();
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("msg", "hello machn");
        return modelAndView;
    }

    @RequestMapping(value = "/verify", method = RequestMethod.POST)
    public String varifyLogin(@RequestParam String username, @RequestParam String password, Model model){
        //System.out.println(DBConnector.con);
        User user = new User(username, password, connectDB);

        if(user.verifyUser().equals("success")){
            model.addAttribute("username", username);
           // System.out.println(user.getMaxLevel());
            return "home";
        }
        else if(user.verifyUser().equals("fail")){
            return "login";
        }
        else{
            return "signUp";
        }
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String signUp(@RequestParam String username, @RequestParam String password, @RequestParam String email,  Model model){
        User user = new User(username, password, email, connectDB);
        if(user.addUserToDB()) {
            model.addAttribute("user", user);
            return "home";
        }
        return "signUp";
    }

    @RequestMapping(value = "/signupforlog", method = RequestMethod.GET)
    public String signUpFromLogin(){
        return "signUp";
    }

}
