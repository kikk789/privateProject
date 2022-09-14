package com.chlee.myapp.service;

import com.chlee.myapp.controller.HomeController;
import com.chlee.myapp.dao.BoardDAO;
import com.chlee.myapp.vo.BoardVO;
import com.chlee.myapp.vo.ReplyVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class BoardService {

    @Autowired
    BoardDAO boardDAO;

    public int insertBoard(Object object) {
        HashMap<String, Object> map = (HashMap<String, Object>) object;
        return boardDAO.insertBoard(map);
    }

    public List<BoardVO> selectBoard(Object object) {
        return boardDAO.selectBoard(object);
    }
    public List<BoardVO> selectBoardDetail() {
        return boardDAO.selectBoardDetail();
    }
    public BoardVO selectBoardOne(int boardId ) {
        return boardDAO.selectBoardOne(boardId);
    }

    public int updateBoardOne(int boardId ) {
        return boardDAO.updateBoardOne(boardId);
    }

    public List<ReplyVO> listReply(int boardId,int startPage,int endPage){
        return boardDAO.listReply(boardId, startPage, endPage);
    }

    public int insertReply(Object object){
        HashMap<String, Object> map = (HashMap<String, Object>) object;
        return boardDAO.insertReply(map);
    }

    public int insertReReply(Object object){
        HashMap<String, Object> map = (HashMap<String, Object>) object;
        return boardDAO.insertReReply(map);
    }
    public List<ReplyVO> listReReply(int replyGroup, int replyId, int boardId){
        return boardDAO.listReReply(replyGroup, replyId, boardId);
    }
    public String getReplyMemId(int replyId){

        return boardDAO.getReplyMemId(replyId);
    }
    public int updateReplyOrder(Object object){
        return boardDAO.updateReplyOrder(object);
    }

    public int updateReply(Object object){
        return boardDAO.updateReply(object);
    }

    public int deleteReply(int replyId){
        return boardDAO.deleteReply(replyId);
    }
    public int deleteReReply(int replyId){
        return boardDAO.deleteReReply(replyId);
    }
    public int totalReplyCount(){ return boardDAO.totalReplyCount();}

    public List<ReplyVO> ListDeleteReplyId(int replyId){
        return boardDAO.ListDeleteReplyId(replyId);
    }

    public List<BoardVO> selectBoardOneById(Object object){
        return boardDAO.selectBoardOneById(object);
    }


    public int deleteBoardList(int boardId){
        return  boardDAO.deleteBoardList(boardId);
    }

    public int updateBoard(Object object) {
        return boardDAO.updateBoard(object);
    }

    public int updateProfile(Object object) {
        HashMap<String, Object> map = (HashMap<String, Object>) object;
        return boardDAO.updateProfile(map);
    }
}
