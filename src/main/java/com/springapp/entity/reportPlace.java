package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by hello on 2016/7/10.
 */
@Entity
@Table(name = "reportPlace")  //报名地点
public class reportPlace {
    private Long id;
    private String place;
    private String subPlace;
    private Long placeId;
    private Integer isDelete;   //////0为未删除  1为删除
    private Long subPlaceId;
    private String remark;
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
    @Column(length = 255,name = "remark")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    @Column(length = 255,name = "subPlace")
    public String getSubPlace() {
        return subPlace;
    }

    public void setSubPlace(String subPlace) {
        this.subPlace = subPlace;
    }

    public Long getPlaceId() {
        return placeId;
    }

    public void setPlaceId(Long placeId) {
        this.placeId = placeId;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public Long getSubPlaceId() {
        return subPlaceId;
    }

    public void setSubPlaceId(Long subPlaceId) {
        this.subPlaceId = subPlaceId;
    }
}
