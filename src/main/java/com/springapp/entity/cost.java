package com.springapp.entity;

import javax.persistence.*;

/**
 * Created by hello on 2016/7/10.
 */
@Entity
@Table(name = "cost")
public class cost {
    private Long id;
    private int level;
    private Double kaowufei;
    private Double baomingfei;
    private Double zhengshufei;
    private Double remark;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    @Column(length = 45,name = "level")
    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }
    @Column(length = 45,name = "kaowufei",precision=12, scale=2)
    public Double getKaowufei() {
        return kaowufei;
    }

    public void setKaowufei(Double kaowufei) {
        this.kaowufei = kaowufei;
    }
    @Column(length = 45,name = "baomingfei",precision=12, scale=2)
    public Double getBaomingfei() {
        return baomingfei;
    }

    public void setBaomingfei(Double baomingfei) {
        this.baomingfei = baomingfei;
    }
    @Column(length = 45,name = "zhengshufei",precision=12, scale=2)
    public Double getZhengshufei() {
        return zhengshufei;
    }

    public void setZhengshufei(Double zhengshufei) {
        this.zhengshufei = zhengshufei;
    }
    @Column(length = 45,name = "remark",precision=12, scale=2)
    public Double getRemark() {
        return remark;
    }

    public void setRemark(Double remark) {
        this.remark = remark;
    }
}
