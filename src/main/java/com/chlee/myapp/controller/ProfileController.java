package com.chlee.myapp.controller;

import com.chlee.myapp.service.BoardService;
import com.chlee.myapp.service.MemberService;
import com.chlee.myapp.vo.BoardVO;
import com.chlee.myapp.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProfileController {

    @Autowired
    BoardService boardService;
    @Autowired
    MemberService memberService;
    String prevPage="";
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile(HttpServletRequest request){

        return "profile";
    }
    @RequestMapping(value = "/profileSetting", method = RequestMethod.GET)
    public String profileSetting(HttpServletRequest request, HttpSession session, Model model){
        prevPage= request.getHeader("Referer");
        System.out.println("prevPage  "+ prevPage);
        String memId = (String)session.getAttribute("loginMemInSession");
        MemberVO memberVO =  memberService.findByNoMember(memId);
        System.out.println("memberVO "+ memberVO.getMemId());
        model.addAttribute("memberVO", memberVO);

        return "profileSetting";
    }


    //계정설정
    @RequestMapping(value = "/updateProfile", method = RequestMethod.POST)
    @ResponseBody
    public String profileUpdate(HttpServletRequest request) {

        String returnURL="";
        int result = 0;
        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        for(String key:map.keySet()){
            System.out.println("key "+key);
            hashMap.put(key, map.get(key));
            String[] value =(String[])map.get(key);
            System.out.println("value "+ value[0]);
            System.out.println("value1 "+ value);
        }

        result = boardService.updateProfile(hashMap);
        System.out.println("111111111111111");
        System.out.println("result  "+ result);
        if(result != 0){
            //성공
            returnURL = prevPage;
        }else{
            result=0;
        }
        return returnURL;

    }
}
