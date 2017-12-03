package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by 石高磊 on 2017/2/28.
 */
@Entity
public class User {
    private Long id;
    private String username;
    private String password;
    private String power;//权限
    private String place;
    private String subPlace;

    @Column
    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    @Column
    public String getSubPlace() {
        return subPlace;
    }

    public void setSubPlace(String subPlace) {
        this.subPlace = subPlace;
    }


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)    /////设置主键
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Column
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column
    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power;
    }
}
