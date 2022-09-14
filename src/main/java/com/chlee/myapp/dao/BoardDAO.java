package com.chlee.myapp.dao;

import com.chlee.myapp.vo.BoardVO;
import com.chlee.myapp.vo.ReplyVO;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDAO {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    protected Log log = LogFactory.getLog(BoardDAO.class);
    protected void printQueryId(String queryId) {
        if (log.isDebugEnabled()) {
            log.debug("\t QueryId \t: " + queryId);
        }
    }

    public int insertBoard(Object object){
        printQueryId("board.insertBoard");
        return sqlSessionTemplate.insert("board.insertBoard", object);
    }

    public List<BoardVO> selectBoard(Object object){

        printQueryId("board.selectBoard");
        return sqlSessionTemplate.selectList("board.selectBoard", object);
    }

    public List<BoardVO> selectBoardDetail(){
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        return sqlSessionTemplate.selectList("board.selectBoardDetail", hashMap);
    }

    public BoardVO selectBoardOne(int boardId){
        printQueryId("board.selectBoardOne");
        return sqlSessionTemplate.selectOne("board.selectBoardOne", boardId);
    }

    public int updateBoardOne(int boardId){
        printQueryId("board.updateBoardOne");
        return sqlSessionTemplate.update("board.updateBoardOne", boardId);
    }

    public List<ReplyVO> listReply(int boardId,int startPage,int endPage){
        HashMap<String,Object> hashmap = new HashMap<String, Object>();
        hashmap.put("boardId", boardId);
        hashmap.put("startPage", startPage);
        hashmap.put("endPage", endPage);

        printQueryId("reply.listReply");
        return sqlSessionTemplate.selectList("reply.listReply", hashmap);
    }

    public int insertReply(Object object){
        printQueryId("reply.insertReply");
        return sqlSessionTemplate.insert("reply.insertReply",object);
    }

    public int insertReReply(Object object){
        printQueryId("reply.insertReReply");
        return sqlSessionTemplate.insert("reply.insertReReply",object);
    }
    public List<ReplyVO> listReReply(int replyGroup, int replyId, int boardId){
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("replyGroup", replyGroup);
        hashMap.put("replyId", replyId);
        hashMap.put("boardId", boardId);
//        System.out.println("hashMap " + hashMap);
        printQueryId("reply.listReReply");
        return sqlSessionTemplate.selectList("reply.listReReply", hashMap);
    }
    public String getReplyMemId(int replyId){

        return sqlSessionTemplate.selectOne("reply.getReplyMemId", replyId);
    }

    public int updateReplyOrder(Object object){
        HashMap<String, Object> map = (HashMap<String, Object>)object;
        for (String key: map.keySet()) {
            System.out.println("key up: " +key );
            String[] value= (String[])map.get(key);
            System.out.println("value up: " +value[0] );
        }
        System.out.println("object " + object);
        return sqlSessionTemplate.update("reply.updateReplyOrder",object);
    }
    public int updateReply(Object object){
        return sqlSessionTemplate.update("reply.updateReply", object);
    }

    public int deleteReply(int replyId){
        return sqlSessionTemplate.delete("reply.deleteReply", replyId);
    }
    public int deleteReReply(int replyId){
        return sqlSessionTemplate.delete("reply.deleteReReply", replyId);
    }


    public int totalReplyCount(){
        return sqlSessionTemplate.selectOne("reply.totalReplyCount");
    }

    public List<ReplyVO> ListDeleteReplyId(int replyId){

        return sqlSessionTemplate.selectList("reply.ListDeleteReplyId", replyId);
    }

    public List<BoardVO> selectBoardOneById(Object object){
        return  sqlSessionTemplate.selectList("board.selectBoardOneById", object);
    }

    public int deleteBoardList(int boardId){
        return  sqlSessionTemplate.delete("board.deleteBoardList", boardId);
    }

    public int updateBoard(Object object){
        return sqlSessionTemplate.update("board.updateBoard", object);
    }

    public int updateProfile(Object object) {
        return sqlSessionTemplate.update("member.updateProfile", object);
    }
}
