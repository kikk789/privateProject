<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
    <title>로그인</title>
    <script src="./resources/component/jquery-3.3.1.min.js"></script>
    <script src="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="./resources/component/jquery-loading-master/dist/jquery.loading.min.js"></script>
    <script src="./resources/component/jqueryPrint/jqueryPrint.js"></script>

    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-loading-master/dist/jquery.loading.min.css">

    <link rel="stylesheet" type="text/css" href="./resources/bootCSS/bootstrap.css">
    <script src="./resources/bootJS/bootstrap.js"></script>
    <script type="text/css">
    </script>
    <%
        String contextPath = request.getContextPath();
    %>
    <script>
        var contextPath = "<%=contextPath%>";
        $(document).on("click", "#logigBtn", function(){
            let memId = $("#memId").val()
            let memPwd = $("#memPwd").val()
            $.ajax({
                url:contextPath+"/login",
                context: document.body,
                type:"POST",
                data:{
                    "memId": memId,
                    "password":memPwd
                },
                success:function(data){
                    console.log(data.length !==0)
                    if(data.length ==0){
                        alert("로그인 실패");
                    }else{
                        alert("로그인 성공");
                        location.href=(contextPath+"/home");
                    }
                }
            })
        })

    </script>

</head>
<body>
<section class="bg-light ">
    <div class="container py-5 form-inline w-25 " >
        <div class="row justify-content-center align-self-center d-flex justify-content-center">
            <div class="col-12 text-center" >
                <form>
                    <div class="form-group">
                        <label for="memId" class="form-label mt-4">아이디</label>
                        <input type="text" class="form-control" id="memId" aria-describedby="memId" value="zxczxc123">
                    </div>
                    <div class="form-group has-success pb-5">
                        <label class="form-label mt-4" for="memPwd">비밀번호</label>
                        <input type="password" class="form-control" id="memPwd" value="1234">
                    </div>

                    <div class="d-grid gap-2 pb-5">
                        <button class="btn btn-primary btn-lg" type="button" id="logigBtn">로그인</button>
                    </div>
                    <div class="d-grid gap-2 ">
                        <button class="btn btn-primary btn-lg" type="button" id="join" onclick="window.location.href=('${pageContext.request.contextPath}/join')">회원가입</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
</body>
</html>
