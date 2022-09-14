package com.chlee.myapp.service;

import com.chlee.myapp.dao.MemberDAO;
import com.chlee.myapp.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    MemberDAO memberDAO;

    public int insertMember(Object object){
        return memberDAO.insertMember(object);
    }

    public MemberVO loginCheck(Object object){
        return memberDAO.loginCheck(object);
    }

    public MemberVO findByNoMember(String memId){
        return memberDAO.findByNoMember(memId);
    }
}
