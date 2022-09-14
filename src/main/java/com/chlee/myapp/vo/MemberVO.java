package com.chlee.myapp.vo;

import lombok.*;

import java.util.Date;

public class MemberVO {
    private String memId;
    private String memName;
    private String password;
    private String auth;
    private Date registDate;
    private Date updateDate;
    private String registId;
    private String updateId;
    private String registIp;
    private String updateIp;
    private String email;
    private String memImg;
    private String memSex;
    private String wantToSay;

    public MemberVO() {
    }

    public MemberVO(String memId, String memName, String password, String auth, Date registDate, Date updateDate, String registId, String updateId, String registIp, String updateIp, String email, String memImg, String memSex, String wantToSay) {
        this.memId = memId;
        this.memName = memName;
        this.password = password;
        this.auth = auth;
        this.registDate = registDate;
        this.updateDate = updateDate;
        this.registId = registId;
        this.updateId = updateId;
        this.registIp = registIp;
        this.updateIp = updateIp;
        this.email = email;
        this.memImg = memImg;
        this.memSex = memSex;
        this.wantToSay = wantToSay;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public String getMemName() {
        return memName;
    }

    public void setMemName(String memName) {
        this.memName = memName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAuth() {
        return auth;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }

    public Date getRegistDate() {
        return registDate;
    }

    public void setRegistDate(Date registDate) {
        this.registDate = registDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getRegistId() {
        return registId;
    }

    public void setRegistId(String registId) {
        this.registId = registId;
    }

    public String getUpdateId() {
        return updateId;
    }

    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }

    public String getRegistIp() {
        return registIp;
    }

    public void setRegistIp(String registIp) {
        this.registIp = registIp;
    }

    public String getUpdateIp() {
        return updateIp;
    }

    public void setUpdateIp(String updateIp) {
        this.updateIp = updateIp;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMemImg() {
        return memImg;
    }

    public void setMemImg(String memImg) {
        this.memImg = memImg;
    }

    public String getMemSex() {
        return memSex;
    }

    public void setMemSex(String memSex) {
        this.memSex = memSex;
    }

    public String getWantToSay() {
        return wantToSay;
    }

    public void setWantToSay(String wantToSay) {
        this.wantToSay = wantToSay;
    }
}
