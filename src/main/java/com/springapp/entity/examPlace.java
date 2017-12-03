package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by hello on 2016/7/10.
 */
@Entity
@Table(name = "examPlace")  //考试地点
public class examPlace {
    private Long id;
    private String place;
    private String classPlace;
    private int count;
    private String remark;
    private String reportPlace;
    private String subPlace;


    @Column
    public String getReportPlace() {
        return reportPlace;
    }

    public void setReportPlace(String reportPlace) {
        this.reportPlace = reportPlace;
    }
    @Column
    public String getSubPlace() {
        return subPlace;
    }

    public void setSubPlace(String subPlace) {
        this.subPlace = subPlace;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    @Column(length = 255,name = "place")
    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
    @Column(length = 255,name = "classPlace")
    public String getClassPlace() {
        return classPlace;
    }

    public void setClassPlace(String classPlace) {
        this.classPlace = classPlace;
    }
    @Column(length = 45,name = "count")
    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    @Column(length = 255,name = "remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
