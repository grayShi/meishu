package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by hello on 2016/7/10.
 */
@Entity
@Table(name = "subject")
public class subject {
    private Long id;
    private String subject;
    private int level;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
}
