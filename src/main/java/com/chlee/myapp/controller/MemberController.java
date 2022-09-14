package com.chlee.myapp.controller;

import com.chlee.myapp.service.MemberService;
import com.chlee.myapp.vo.MemberVO;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class MemberController {

    @Autowired
    MemberService memberService;

    @RequestMapping(value = "/join", method = RequestMethod.GET)
    public String joinGet(){

        return "join";
    }

    @RequestMapping(value = "/insertMember", method = RequestMethod.POST)
    @ResponseBody
    public String insertMember(HttpServletRequest request){

        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        for(String key:map.keySet()){
            System.out.println("key "+key);

            hashMap.put(key, map.get(key));
            String[] value =(String[])map.get(key);
            System.out.println("value "+ value[0]);
        }

        int result = memberService.insertMember(hashMap);
        String resultStr="";

        if (result!=0){
            resultStr = "success";
            System.out.println("성공");
        }else{
            resultStr = "fail";
            System.out.println("실패");
        }

        return resultStr;
    }
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String mainPage(HttpServletRequest request){

        return "login";
    }
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(HttpServletRequest request){

        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public MemberVO loginPOST(HttpServletRequest request, HttpSession session, Model model){

        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        for(String key:map.keySet()){
            System.out.println("key "+key);
            hashMap.put(key, map.get(key));
            String[] value =(String[])map.get(key);
            System.out.println("value "+ value[0]);
        }

        MemberVO memberVO= memberService.loginCheck(hashMap);
        session.setAttribute("loginMemInSession", memberVO.getMemId());
//        model.addAttribute("loginMemInModel", memberVO.getMemId());


        return memberVO;
    }
    @RequestMapping(value = "/logimMember", method = RequestMethod.GET)
    @ResponseBody
    public Object logimMember(HttpSession session){

        return session.getAttribute("loginMemInSession");
    }

    @RequestMapping(value = "/logoutMember", method = RequestMethod.GET)
    @ResponseBody
    public String logoutMember(HttpSession session){
        session.removeAttribute("loginMemInSession");
        return "sessionDelete";
    }
}
