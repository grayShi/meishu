package com.springapp.entity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by hello on 2016/7/14.
 */
@Entity
@Table(name = "message")  //报考信息
public class message {
    private Long id;
    private String reportPlace;  //报名点
    private String subPlace;
    private String name;  //姓名
    private String sex;  //性别
    private String birth;  //出生日期
    private String country;   //国籍
    private String nation ;  //民族
    private String address;   //联系地址
    private String phoneNumber;  //电话
    private String time;        //考试时间
    private String subject;
    private String examTime;   ///持续时间
    private int level;
    private String cardNumber; //准考证号
    private int isDelete;  //是否删除   0存在1删除
    private String examPlace; //考试地点
    private String classPlace;   //考场地点
    private int realLevel;   //评定等级
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    @Column(length = 255,name = "reportPlace")
    public String getReportPlace() {
        return reportPlace;
    }

    public void setReportPlace(String reportPlace) {
        this.reportPlace = reportPlace;
    }
    @Column(length = 45,name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @Column(length = 45,name = "birth")
    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }
    @Column(length = 45,name = "sex")
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Column(length = 45,name = "country")
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    @Column(length = 45,name = "nation")
    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }
    @Column(length = 255,name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Column(length = 45,name = "phoneNumber")
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    @Column(length = 45,name = "subject")
    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
    @Column(length = 45,name = "level")
    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
    @Column(length = 45,name = "cardNumber")
    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    @Column(length = 255,name = "subPlace")
    public String getSubPlace() {
        return subPlace;
    }

    public void setSubPlace(String subPlace) {
        this.subPlace = subPlace;
    }
    @Column(length = 45,name = "time")
    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    @Column(length = 45,name = "isDelete")
    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }
    @Column(length = 255,name = "examPlace")
    public String getExamPlace() {
        return examPlace;
    }

    public void setExamPlace(String examPlace) {
        this.examPlace = examPlace;
    }

    @Column(length = 255,name = "classPlace")
    public String getClassPlace() {
        return classPlace;
    }

    public void setClassPlace(String classPlace) {
        this.classPlace = classPlace;
    }
    @Column(length = 255,name = "realLevel")
    public int getRealLevel() {
        return realLevel;
    }

    public void setRealLevel(int realLevel) {
        this.realLevel = realLevel;
    }

    @Column(length = 255,name = "examTime")
    public String getExamTime() {
        return examTime;
    }

    public void setExamTime(String examTime) {
        this.examTime = examTime;
    }
}
