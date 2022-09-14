package com.chlee.myapp.controller;

import com.chlee.myapp.service.BoardService;
import com.chlee.myapp.vo.BoardVO;
import com.chlee.myapp.vo.ReplyVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class BoardController {

    @Autowired
    BoardService boardService;

    String prevPage="";

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home(HttpSession session, Model model) {
        System.out.println("aaaaaaa");
//        System.out.println("loginMemInSession "+ session.getAttribute("loginMemInSession"));
//        System.out.println("loginMemInModel "+ model.addAttribute("loginMemInModel"));
//        model.addAttribute("loginID", session.getAttribute("loginMemInSession"));
        return "home";
    }
    @RequestMapping(value = "/home", method = RequestMethod.POST)
    @ResponseBody
    public List<BoardVO> homePost(HttpServletRequest request) {

        System.out.println("homePostIn");

//        int startPage = 0;
//        int endPage = 0;
//        String searchKeywordText = "";
//        String memId = "";
//
//        HashMap<String, Object> hashMap = new HashMap<String, Object>();
////        hashMap.put("startPage", startPage);
////        hashMap.put("endPage", endPage);
////        hashMap.put("searchKeywordText", searchKeywordText);
//
//        if(request.getParameter("memId") != null){
//            memId = request.getParameter("memId");
//            hashMap.put("memId", memId);
//            System.out.println("memId  " + memId);
//        }
////        if(request.getParameter("startPage") != null){
//        startPage = Integer.parseInt(request.getParameter("startPage"));
//        hashMap.put("startPage", startPage);
//        System.out.println("startPage  " + startPage);
////        }
////        if(request.getParameter("endPage") != null){
//        endPage = Integer.parseInt(request.getParameter("endPage"));
//        hashMap.put("endPage", endPage);
//        System.out.println("endPage  " + endPage);
////        }
//        if(request.getParameter("searchKeywordText") != null){
//            searchKeywordText = request.getParameter("searchKeywordText");
//            hashMap.put("searchKeywordText", searchKeywordText);
//            System.out.println("searchKeywordText  " + searchKeywordText);
//        }
        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        for(String key:map.keySet()){
            hashMap.put(key, ((String[])map.get(key))[0]);
        }

        List<BoardVO> boardVO = boardService.selectBoard(hashMap);
        return boardVO;
    }

    @RequestMapping(value = "/myVideos", method = RequestMethod.POST)
    @ResponseBody
    public List<BoardVO> selectBoardOneById(HttpServletRequest request) {

        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        for(String key:map.keySet()){
            hashMap.put(key, ((String[])map.get(key))[0]);
        }

        List<BoardVO> boardVO = boardService.selectBoardOneById(hashMap);
        return boardVO;
    }



    @RequestMapping(value="/boardInsert",method = RequestMethod.GET)
    public String boardList(HttpServletRequest request, Model model//, @RequestBody BoardVO vo
    ){
        prevPage= request.getHeader("Referer");
        return "boardInsert";
    }

    @RequestMapping(value="/boardInsert",method = RequestMethod.POST)
    @ResponseBody
    public String boardListPost(HttpServletRequest request, Model model//, @RequestBody BoardVO vo
    ){

        String returnURL="";
        Map<String,Object> map = (Map<String,Object>)request.getParameterMap();
        HashMap<String,Object> hashMap = new HashMap<String, Object>();

        for (String key: map.keySet()) {
            hashMap.put(key, map.get(key));
        }
        boardService.insertBoard(hashMap);

        if (prevPage !=null){
            returnURL = prevPage;
        }
        else{
            returnURL="home";
        }

        return prevPage;
    }

    //디테일 페이지 우측(side) 동영상 정보
    @RequestMapping(value = "/detailList", method = RequestMethod.GET)
    @ResponseBody
    public List<BoardVO> detailList(HttpServletRequest request, Model model){
        int boardId=0;
        int startPage=0;
        int endPage=0;
        String searchKeyword="";
        if(request.getParameter("boardId") != null){
            boardId = Integer.parseInt(request.getParameter("boardId"));
            System.out.println("boardId  " + boardId);
        }
        if(request.getParameter("startPage") != null){
            startPage = Integer.parseInt(request.getParameter("startPage"));
            System.out.println("startPage  " + startPage);
        }
        if(request.getParameter("endPage") != null){
            endPage = Integer.parseInt(request.getParameter("endPage"));
            System.out.println("endPage  " + endPage);
        }
//        if(request.getParameter("searchKeyword") != null){
//            searchKeyword = request.getParameter("searchKeyword");
//            System.out.println("searchKeyword  " + searchKeyword);
//        }

        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("startPage", startPage);
        hashMap.put("endPage", endPage);
//        hashMap.put("searchKeyword", searchKeyword);

        List<BoardVO> boardVOList = boardService.selectBoard(hashMap);

        model.addAttribute(boardVOList);
        return boardVOList;
    }

    //board 동적 생성 필요없는 디테일 동영상 이름 더보기 조회수 용
    @RequestMapping(value = "/detailListMain", method = RequestMethod.GET)
    public String detailListMain(HttpServletRequest request, Model model){
        int boardId=0;

        if(request.getParameter("boardId") != null){
            boardId = Integer.parseInt(request.getParameter("boardId"));
            System.out.println("boardId  " + boardId);
        }
        //조회수 늘리기
        boardService.updateBoardOne(boardId);

        BoardVO boardVO = boardService.selectBoardOne(boardId);

        model.addAttribute(boardVO);
        return "detailList";
    }

    @RequestMapping(value = "/insertReply", method = RequestMethod.POST)
    @ResponseBody
    public void insertReply(HttpServletRequest request){

        Map<String,Object> map = (Map<String,Object>)request.getParameterMap();
        HashMap<String,Object> hashMap = new HashMap<String, Object>();

        for (String key: map.keySet()) {
            hashMap.put(key, map.get(key));
        }
        System.out.println("insertReply1 : " + hashMap);
        boardService.insertReply(hashMap);

        //replyVO.setReplyContent(replyContent);
//        replyVO.setReplyDepth();
//        replyVO.setReplyParent();
//        replyVO.setReplyOrder();
//        replyVO.setReplyGroup();
        //replyVO.setReplyUpdate();//수정 한 날짜
        //replyVO.setBoardId(); //현재 게시물 번호
        //replyVO.setMemId(); //현재 로그인 아이디
        //
    }

    @RequestMapping(value = "/insertReReply", method = RequestMethod.POST)
    @ResponseBody
    public void insertReReply(HttpServletRequest request){

        Map<String,Object> map = (Map<String,Object>)request.getParameterMap();
        HashMap<String,Object> hashMap = new HashMap<String, Object>();

        for (String key: map.keySet()) {
            hashMap.put(key, map.get(key));
            System.out.println("key: " +key );
            String[] value= (String[])map.get(key);
            System.out.println("valye: " +value[0] );
        }

        //대댓글 입력 시 order +1 씩 더해주기
        boardService.updateReplyOrder(hashMap);

        boardService.insertReReply(hashMap);

    }

    @RequestMapping(value = "/listReply", method = RequestMethod.GET)
    @ResponseBody
    public List<ReplyVO> listReply(HttpServletRequest request){
        int boardId=0;
        int startPage=0;
        int endPage=0;
        if(request.getParameter("boardId")!=null){
            boardId = Integer.parseInt(request.getParameter("boardId"));
        }
        if(request.getParameter("startPage") != null){
            startPage = Integer.parseInt(request.getParameter("startPage"));
            System.out.println("startPage  " + startPage);
        }
        if(request.getParameter("endPage") != null){
            endPage = Integer.parseInt(request.getParameter("endPage"));
            System.out.println("endPage  " + endPage);
        }
        List<ReplyVO> replyVO = boardService.listReply(boardId, startPage, endPage);

        return replyVO;
    }

    @RequestMapping(value = "/listReReply", method = RequestMethod.GET)
    @ResponseBody
    public List<ReplyVO> listReReply(HttpServletRequest request){

        int replyGroup=0;
        int replyId=0;
        int boardId=0;
        if(request.getParameter("boardId")!=null){
            boardId = Integer.parseInt(request.getParameter("boardId"));
        }
        if(request.getParameter("replyGroup")!=null){
            replyGroup = Integer.parseInt(request.getParameter("replyGroup"));
        }
        if(request.getParameter("replyId") != null){
            replyId = Integer.parseInt(request.getParameter("replyId"));
        }

        List<ReplyVO> replyVO = boardService.listReReply(replyGroup, replyId, boardId);

        return replyVO;
    }

    @RequestMapping(value = "/getReplyMemId", method = RequestMethod.GET)
    @ResponseBody
    public String getReplyMemId(HttpServletRequest request){

        int replyId=0;
        if(request.getParameter("replyId")!=null){
            replyId = Integer.parseInt(request.getParameter("replyId"));
        }

        String parentMemId = boardService.getReplyMemId(replyId);
        System.out.println("parentMemId "+ parentMemId);
        return parentMemId;
    }


    //댓글은 기본적으로 본인 자신만 삭제
    @RequestMapping(value = "/deleteReply", method = RequestMethod.GET)
    @ResponseBody
    public String deleteReply(@RequestParam(value = "replyId") int replyId){
        String result="";
        int a = boardService.deleteReply(replyId); //댓글삭제

        if(a!=0){
            result ="OK";
        }else{
            result ="FAIL";
        }
        return result;
    }

    //최상위 댓글의 경우 자식까지 삭제
    @RequestMapping(value = "/deleteReply", method = RequestMethod.POST)
    @ResponseBody
    public String deleteReplyPost(HttpServletRequest request){
        String result="";
        String[] replyIdArr = request.getParameterValues("replyIdArr");
        int a =0;
        int b =0;
        for(String replyId: replyIdArr){
            a = boardService.deleteReply(Integer.parseInt(replyId));
            b = boardService.deleteReReply(Integer.parseInt(replyId)); //자식까지 삭제
        }
        if(a!=0 || b!=0 ){
            result ="OK";
        }else{
            result ="FAIL";
        }
        return result;
    }

    @RequestMapping(value = "/updateReply", method=RequestMethod.POST)
    @ResponseBody
    public String updateReply(HttpServletRequest request){
        String result="";
        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();

        for (String key:map.keySet())
        {
            System.out.println("updateReply key "+key);
            String[] value= (String[])map.get(key);
            System.out.println("updateReply value "+value[0]);
            hashMap.put(key, map.get(key));
        }

        int a = boardService.updateReply(hashMap);
        if(a!=0){
            result="OK";
        }
        else{
            result = "FAIL";
        }
        return result;
    }

    @RequestMapping(value = "/replyCount", method = RequestMethod.GET)
    @ResponseBody
    public List<ReplyVO> replyCount(HttpServletRequest request){

        int boardId=0;
        if(request.getParameter("boardId")!=null){
            boardId = Integer.parseInt(request.getParameter("boardId"));
        }
        int replyGroup=0;
        int replyId=0;
        if(request.getParameter("replyGroup")!=null){
            replyGroup = Integer.parseInt(request.getParameter("replyGroup"));
        }
        if(request.getParameter("replyId") != null){
            replyId = Integer.parseInt(request.getParameter("replyId"));
        }

        List<ReplyVO> replyVO = boardService.listReReply(replyGroup, replyId,boardId);

        return replyVO;
    }
    @RequestMapping(value = "/totalReplyCount", method = RequestMethod.GET)
    @ResponseBody
    public int totalReplyCount(){
        return boardService.totalReplyCount();
    }


    @RequestMapping(value="/deleteBoardList", method= RequestMethod.POST)
    @ResponseBody
    public int deleteList(HttpServletRequest request){
        String[] chkVal = request.getParameterValues("chkVal");
        int returnValue=0;
        for (String b: chkVal) {
            boardService.deleteBoardList(Integer.parseInt(b));
        }

        return returnValue;
    }

    @RequestMapping(value="/updateBoard", method= RequestMethod.POST)
    @ResponseBody
    public String updateBoard(HttpServletRequest request){
        System.out.println("11111111111");
        Map<String, Object> map = (Map<String, Object>)request.getParameterMap();
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        System.out.println("2222222222222");
        for(String key: map.keySet()){
            System.out.println("33333333333333");

            hashMap.put(key, map.get(key));

            System.out.println("key : "+ key);
            System.out.println("value : "+ ((String[])map.get(key))[0]);
//            hashMap.put(key, ((String[])map.get(key))[0]);
        }

        String result = "";
        try{
            System.out.println("44444444444444444");
            boardService.updateBoard(hashMap);
            result ="success";
        }catch (Exception e){
            result ="fail";
        }

        return result;
    }
}
