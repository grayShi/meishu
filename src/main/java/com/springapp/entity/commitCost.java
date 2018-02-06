package com.springapp.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "commitCost")
public class commitCost {
    private Long id;
    private String level;
    private int count;
    private String placeId;
    private Double totalCost;
    private int isDelete;
    private Date commitDate;
    private Date confirmDate;
    private String endSignUpdate;

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }

    public Double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getPlaceId() {
        return placeId;
    }

    public void setPlaceId(String placeId) {
        this.placeId = placeId;
    }

    public Date getCommitDate() {
        return commitDate;
    }

    public void setCommitDate(Date commitDate) {
        this.commitDate = commitDate;
    }

    public Date getConfirmDate() {
        return confirmDate;
    }

    public void setConfirmDate(Date confirmDate) {
        this.confirmDate = confirmDate;
    }

    public String getEndSignUpdate() {
        return endSignUpdate;
    }

    public void setEndSignUpdate(String endSignUpdate) {
        this.endSignUpdate = endSignUpdate;
    }
}