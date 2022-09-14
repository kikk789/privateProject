package com.chlee.myapp.vo;

import lombok.*;

import java.util.Date;

public class BoardVO {
    private int boardId;
    private String boardTitle;
    private String boardContent;
    private String boardRegDate;
    private String boardUpdate;
    private String boardUrl;
    private String memId;
    private int hit;
    private String thumbnail;

    public BoardVO() {
    }

    public BoardVO(int boardId, String boardTitle, String boardContent, String boardRegDate, String boardUpdate, String boardUrl, String memId, int hit, String thumbnail) {
        this.boardId = boardId;
        this.boardTitle = boardTitle;
        this.boardContent = boardContent;
        this.boardRegDate = boardRegDate;
        this.boardUpdate = boardUpdate;
        this.boardUrl = boardUrl;
        this.memId = memId;
        this.hit = hit;
        this.thumbnail = thumbnail;
    }

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public String getBoardTitle() {
        return boardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    public String getBoardContent() {
        return boardContent;
    }

    public void setBoardContent(String boardContent) {
        this.boardContent = boardContent;
    }

    public String getBoardRegDate() {
        return boardRegDate;
    }

    public void setBoardRegDate(String boardRegDate) {
        this.boardRegDate = boardRegDate;
    }

    public String getBoardUpdate() {
        return boardUpdate;
    }

    public void setBoardUpdate(String boardUpdate) {
        this.boardUpdate = boardUpdate;
    }

    public String getBoardUrl() {
        return boardUrl;
    }

    public void setBoardUrl(String boardUrl) {
        this.boardUrl = boardUrl;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }
}
