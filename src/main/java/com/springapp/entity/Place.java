package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 石高磊 on 2017/4/5.
 */
@Entity
@Table(name = "Place")  //报名地点
public class Place {
    private Long id;
    private String place;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }
}
