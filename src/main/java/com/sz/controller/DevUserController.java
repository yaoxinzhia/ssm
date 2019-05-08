package com.sz.controller;

import com.sz.pojo.DevUser;
import com.sz.service.AppInfoService;
import com.sz.service.DevUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/dev")
public class DevUserController {

    @Autowired
    private DevUserService devUserService;

    @Autowired
    private AppInfoService appInfoService;

    @RequestMapping("/toLogin")
    public String toLogin(){

        return "dev/login";
    }

    @RequestMapping("/login")
    // 在model里面存，在会话里面存
    public String login(DevUser devUser, Model model, HttpSession session){

        devUser = devUserService.login(devUser);
        if (devUser != null){
            // 登录成功
            session.setAttribute("devUser",devUser);
            return "dev/index";
        } else {
            // 登录失败
            model.addAttribute("errMsg","登录失败");
            return "dev/login";
        }
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("devUser");
        session.invalidate();
        /*try {
            response.sendRedirect(session.getServletContext().getContextPath() + "/index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }*/
        return "redirect:/";
    }

}
