package com.chlee.myapp.vo;

import lombok.*;


public class ReplyVO {
    private int replyId;
    private String replyContent;
    private int replyGroup;
    private int replyDepth;
    private int replyParent;
    private int replyOrder;
    private String replyDate;
    private String replyUpdate;
    private String memId;
    private int boardId;

    public ReplyVO() {
    }

    public ReplyVO(int replyId, String replyContent, int replyGroup, int replyDepth, int replyParent, int replyOrder, String replyDate, String replyUpdate, String memId, int boardId) {
        this.replyId = replyId;
        this.replyContent = replyContent;
        this.replyGroup = replyGroup;
        this.replyDepth = replyDepth;
        this.replyParent = replyParent;
        this.replyOrder = replyOrder;
        this.replyDate = replyDate;
        this.replyUpdate = replyUpdate;
        this.memId = memId;
        this.boardId = boardId;
    }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public int getReplyGroup() {
        return replyGroup;
    }

    public void setReplyGroup(int replyGroup) {
        this.replyGroup = replyGroup;
    }

    public int getReplyDepth() {
        return replyDepth;
    }

    public void setReplyDepth(int replyDepth) {
        this.replyDepth = replyDepth;
    }

    public int getReplyParent() {
        return replyParent;
    }

    public void setReplyParent(int replyParent) {
        this.replyParent = replyParent;
    }

    public int getReplyOrder() {
        return replyOrder;
    }

    public void setReplyOrder(int replyOrder) {
        this.replyOrder = replyOrder;
    }

    public String getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(String replyDate) {
        this.replyDate = replyDate;
    }

    public String getReplyUpdate() {
        return replyUpdate;
    }

    public void setReplyUpdate(String replyUpdate) {
        this.replyUpdate = replyUpdate;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }
}
