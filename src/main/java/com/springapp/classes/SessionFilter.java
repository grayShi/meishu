package com.springapp.classes;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by sgl on 2017/12/2.
 */
//public class SessionFilter implements Filter {
//    /**
//     * 销毁
//     */
//    @Override
//    public void destroy() {
//    }
//
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
//            throws IOException, ServletException {
//        HttpServletRequest request = (HttpServletRequest) servletRequest;
//        HttpServletResponse response = (HttpServletResponse) servletResponse;
//        //获取根目录所对应的绝对路径
//        String currentURL = request.getRequestURI();
//        //截取到当前文件名用于比较
//        String targetURL = currentURL.substring(currentURL.indexOf("/",1),currentURL.length());
//        //System.out.println(targetURL);
//        //如果session不为空就返回该session，如果为空就返回null
//        HttpSession session = request.getSession(false);
//        if(!"/login".equals(targetURL)){
//            //判断当前页面是否是重顶次昂后的登陆页面页面，如果是就不做session的判断，防止死循环
//            if((session == null || session.getAttribute("userId")==null) &&
//                    !currentURL.contains(".css") && !currentURL.contains(".js")
//                    && !currentURL.contains(".png")&& !currentURL.contains(".do")){
//                //如果session为空表示用户没有登陆就重定向到login.jsp页面
//                //System.out.println("request.getContextPath()=" + request.getContextPath());
//                response.sendRedirect(request.getContextPath()+"/login");
//                return;
//            }
//        }
//        //继续向下执行
//        chain.doFilter(request, response);
//    }
//
//    /**
//     * 初始化
//     */
//    @Override
//    public void init(FilterConfig arg0) throws ServletException {
//    }
//
//}

public class SessionFilter implements Filter {
    private String[] adminPages = {"/subject","/place","/examTime","/data",
            "/cost","/user","/costCommit"};
    private log4j newLig4j = new log4j();
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // TODO Auto-generated method stub

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        // 获得在下面代码中要用的request,response,session对象
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        HttpServletResponse servletResponse = (HttpServletResponse) response;
        HttpSession session = servletRequest.getSession();

        // 获得用户请求的URI
        String path = servletRequest.getRequestURI();
        //System.out.println(path);
        //获得所有请求参数名
        Enumeration params = servletRequest.getParameterNames();

        // 从session里获取信息
        String userId = (String) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");
        String power = (String) session.getAttribute("power");


        /*创建类Constants.java，里面写的是无需过滤的页面
        for (int i = 0; i < Constants.NoFilter_Pages.length; i++) {

            if (path.indexOf(Constants.NoFilter_Pages[i]) > -1) {
                chain.doFilter(servletRequest, servletResponse);
                return;
            }
        }*/
        if(path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") || path.endsWith(".woff2") || path.endsWith(".map")){
            chain.doFilter(servletRequest, servletResponse);
            return;
        }

        // 登陆页面无需过滤
        if(path.contains("/login")||path.contains("/reLogin")) {
            this.newLig4j.printLog(path, servletRequest);
            chain.doFilter(servletRequest, servletResponse);
            return;
        }
        // 判断如果没有取到信息,就跳转到登陆页面
        if (userId == null || "".equals(userId)) {
            // 跳转到登陆页面
            servletResponse.sendRedirect(servletRequest.getContextPath() + "/login");
        } else {
            this.newLig4j.printLog(path, servletRequest);
            String elements = "";
            while (params.hasMoreElements()) {
                //得到参数名
                String name = params.nextElement().toString();
                //System.out.println("name===========================" + name + "--");
                //得到参数对应值
                String[] value = servletRequest.getParameterValues(name);
                String val = "";
                for (int i = 0; i < value.length; i++) {
                    val = val + value[i];
                }
                elements += name + ": " + val + ", ";
            }
            if(elements != ""){
                this.newLig4j.printLog(elements, servletRequest);
            } else {
                this.newLig4j.printLog("no_element", servletRequest);
            }
            // 已经登陆,继续此次请求
            if(power.equals("admin")){
                chain.doFilter(request, response);
            } else {
                String[] newAdminPages = new String[adminPages.length + 1] ;
                for(int i = 0; i< adminPages.length; i++) {
                    newAdminPages[i] = adminPages[i];
                }
                if(power.equals("schoolNoPrint")) {
                    newAdminPages[newAdminPages.length -1 ] = "/print";
                }
                if(!findIndex(newAdminPages, path.split("-")[0])){
                    chain.doFilter(request, response);
                } else {
                    servletResponse.sendRedirect(servletRequest.getContextPath() + "/reLogin");
                }
            }
        }

    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub

    }
    public static boolean findIndex(String[] arr,String targetValue){
        for(String s:arr){
          if(s!=null) {
            if(s.equals(targetValue))
                return true;
            }
        }
        return false;
    }
}
