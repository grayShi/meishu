package com.springapp.classes;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * Created by 11369 on 2016/6/24.
 */
public class SqlFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req=(HttpServletRequest)servletRequest;
        HttpServletResponse res=(HttpServletResponse)servletResponse;
        String url = req.getRequestURI();
        //获得所有请求参数名
        Enumeration params = req.getParameterNames();
        System.out.print(params + "params");
        String sql = "";
        while (params.hasMoreElements()) {
            //得到参数名
            String name = params.nextElement().toString();
            //System.out.println("name===========================" + name + "--");
            //得到参数对应值
            String[] value = req.getParameterValues(name);
            for (int i = 0; i < value.length; i++) {
                sql = sql + value[i];
            }
        }
        //System.out.println("============================SQL"+sql);
        //有sql关键字，跳转到error.html
        if (sqlValidate(sql)) {
            String ip = req.getRemoteAddr();
            throw new IOException("用户"+ip+"发送请求中的参数中含有非法字符");
            //String ip = req.getRemoteAddr();
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
    //效验
    protected static boolean sqlValidate(String str) {
        str = str.toLowerCase();//统一转为小写
        String badStr = "'|and|exec|execute|insert|select|delete|update|count|drop|*|%|chr|mid|master|truncate|" +
                "char|declare|sitename|xp_cmdshell|or|like'|and|exec|execute|insert|create|drop|" +
                "table|from|grant|group_concat|column_name|" +
                "information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|" +
                "chr|mid|master|truncate|char|declare|or|--|+|like|//|/|";//过滤掉的sql关键字，可以手动添加 use
        String[] badStrs = badStr.split("\\|");
        for (int i = 0; i < badStrs.length; i++) {
            if (str.contains(badStrs[i])) {
                System.out.print(badStrs[i]);
                return true;
            }
        }
        return false;
    }
    public static void main(String []args){
        String str="%E4%B8%8A%E6%B5%B7%E6%88%90%E5%9F%BA%E5%B8%82%E6%94%BF%E5%BB%BA%E8%AE%BE%E5%8F%91%E5%B1%95%E6%9C%89%E9%99%90%E5%85%AC%E5%8F%B8&date=2016-10-05&startTime=00:00&endTime=23:59\n";
        if(sqlValidate(str))
            System.out.print(str);
    }
}
