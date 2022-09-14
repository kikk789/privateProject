<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
    <%
        String contextPath = request.getContextPath();
    %>
</head>
<body>
<script>
$(function(){
    var contextPath = "<%=contextPath%>";
    let memId=0;
    let startPage=1;
    let endPage=8;
    let searchKeywordText ="";
    $.ajax({
        url:contextPath+"/logimMember",
        async:false,
        success:function(data){
            memId = data;
        }
    })
    $("#offcanvasDarkNavbarLabel").html(memId)


    $(document).on("click", "#searchKeyword, #searchKeywordBtn", function(){
        var form = document.createElement('form');
        var objs, objs2, objs3, objs4;
        objs = document.createElement('input');
        objs.setAttribute('type', 'hidden');
        objs.setAttribute('name', 'memId');      // 받을 네이밍
        objs.setAttribute('value', memId);       // 넘길 파라메터

        objs2 = document.createElement('input');
        objs2.setAttribute('type', 'hidden');
        objs2.setAttribute('name', 'searchKeywordText');      // 받을 네이밍
        objs2.setAttribute('value', $(this).prev().val());       // 넘길 파라메터

        objs3 = document.createElement('input');
        objs3.setAttribute('type', 'hidden');
        objs3.setAttribute('name', 'startPage');      // 받을 네이밍
        objs3.setAttribute('value', startPage);       // 넘길 파라메터

        objs4 = document.createElement('input');
        objs4.setAttribute('type', 'hidden');
        objs4.setAttribute('name', 'endPage');      // 받을 네이밍
        objs4.setAttribute('value', endPage);       // 넘길 파라메터

        form.appendChild(objs);
        form.appendChild(objs2);
        form.appendChild(objs3);
        form.appendChild(objs4);
        form.setAttribute('method', 'get');
        form.setAttribute('action', "/home");      // URL
        document.body.appendChild(form);
        form.submit();

    })
    //검색기능(검색 텍스트에서 엔터입력)
    $(document).on("keydown", "#searchKeywordText, #searchKeywordTextSide", function(key){
        if(key.keyCode==13){
            var form = document.createElement('form');
            var objs, objs2, objs3, objs4;
            objs = document.createElement('input');
            objs.setAttribute('type', 'hidden');
            objs.setAttribute('name', 'memId');      // 받을 네이밍
            objs.setAttribute('value', memId);       // 넘길 파라메터

            objs2 = document.createElement('input');
            objs2.setAttribute('type', 'hidden');
            objs2.setAttribute('name', 'searchKeywordText');      // 받을 네이밍
            objs2.setAttribute('value', $(this).val());       // 넘길 파라메터

            objs3 = document.createElement('input');
            objs3.setAttribute('type', 'hidden');
            objs3.setAttribute('name', 'startPage');      // 받을 네이밍
            objs3.setAttribute('value', startPage);       // 넘길 파라메터

            objs4 = document.createElement('input');
            objs4.setAttribute('type', 'hidden');
            objs4.setAttribute('name', 'endPage');      // 받을 네이밍
            objs4.setAttribute('value', endPage);       // 넘길 파라메터

            form.appendChild(objs);
            form.appendChild(objs2);
            form.appendChild(objs3);
            form.appendChild(objs4);
            form.setAttribute('method', 'get');
            form.setAttribute('action', "/home");      // URL
            document.body.appendChild(form);
            form.submit();

            // searchKeywordText = $(this).val();
            // $("#mainListArea").empty();
            // infinityPage(startPage, endPage, searchKeywordText);
        }
    })

    $(document).on("click", "#logoutBtn", function(){

        $.ajax({
            url:contextPath+"/logoutMember",
            success:function(data){
                alert("로그아웃 성공");
                window.location.href=(contextPath+"/login");
            }
        })
    })
})


</script>
<nav class="navbar bg-white fixed-top" >
    <div class="container-fluid p-1 mx-lg-3">
        <div>
            <img src="http://localhost:8050/resources/img/youtube.png" style="width: 30px">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">youtube</a>
        </div>
        <div class="input-group " style="width:50%">
            <input type="text" class="form-control" id="searchKeywordText" placeholder="searchText...." aria-label="Recipient's username" aria-describedby="searchKeyword">
            <button class="btn btn-outline-secondary" type="button" id="searchKeyword"> search </button>
        </div>

        <div>
            <%--			<button type="button" class="btn btn-info" id="boardInsertBtn" onclick="window.location.href=('/boardInsert')">등록</button>--%>

            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar">
                <span><img id="boardProfileBtn" src="http://localhost:8050/resources/img/default.jpg" style="width: 40px;border-radius:80px "></span>
            </button>
        </div>

        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasDarkNavbar" aria-labelledby="offcanvasDarkNavbarLabel" >
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/profileSetting">계정설정</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/profile">마이페이지</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/boardInsert">동영상 등록</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="logoutBtn">Logout</a>
                    </li>

                    <%--					<li class="nav-item dropdown">--%>
                    <%--						<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">--%>
                    <%--							Dropdown--%>
                    <%--						</a>--%>
                    <%--						<ul class="dropdown-menu dropdown-menu-dark">--%>
                    <%--							<li><a class="dropdown-item" href="#">Action</a></li>--%>
                    <%--							<li><a class="dropdown-item" href="#">Another action</a></li>--%>
                    <%--							<li>--%>
                    <%--								<hr class="dropdown-divider">--%>
                    <%--							</li>--%>
                    <%--							<li><a class="dropdown-item" href="#">Something else here</a></li>--%>
                    <%--						</ul>--%>
                    <%--					</li>--%>
                </ul>
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" id="searchKeywordTextSide">
                    <button class="btn btn-success" type="button" id="searchKeywordBtn">Search</button>
                </form>
            </div>
        </div>
    </div>
</nav>
</body>
</html>
