package com.chlee.myapp.dao;

import com.chlee.myapp.vo.MemberVO;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;
    protected Log log = LogFactory.getLog(MemberDAO.class);
    protected void printQueryId(String queryId) {
        if (log.isDebugEnabled()) {
            log.debug("\t QueryId \t: " + queryId);
        }
    }
    public int insertMember(Object object){
        printQueryId("member.insertMember");
        return sqlSessionTemplate.insert("member.insertMember", object);
    }


    public MemberVO loginCheck(Object object){
        return sqlSessionTemplate.selectOne("member.loginCheck", object);
    }
    public MemberVO findByNoMember(String memId){
        return sqlSessionTemplate.selectOne("member.findByNoMember", memId);
    }

}
