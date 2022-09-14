<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
    <title>회원가입</title>
    <script src="./resources/component/jquery-3.3.1.min.js"></script>
    <script src="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="./resources/component/jquery-loading-master/dist/jquery.loading.min.js"></script>
    <script src="./resources/component/jqueryPrint/jqueryPrint.js"></script>

    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-loading-master/dist/jquery.loading.min.css">

    <link rel="stylesheet" type="text/css" href="./resources/bootCSS/bootstrap.css">
    <script src="./resources/bootJS/bootstrap.js"></script>
    <script type="text/css">
        <!-- 섹션 크기 -->
        .bg-light{
            height: 1053px;
            padding-top:55px;
            padding-bottom:75px;
        }
        .flex-fill.mx-xl-5.mb-2{
            margin: 0 auto;
            width : 700px;
            padding-right: 7rem;
            padding-left: 7rem;
        }
        <!-- 입력창 -->
        .container.py-4{
            margin: 0 auto;
            width : 503px;
        }
        <!-- 가입하기 -->
        .d-grid.gap-2{
            padding-top: 30px;
        }

        <!-- 생년월일 -->
        .bir_yy,.bir_mm,.bir_dd{
            width:160px;
            display:table-cell;
        }
        .bir_mm+.bir_dd, .bir_yy+.bir_mm{
            padding-left:10px;
        }
    </script>
    <%
        String contextPath = request.getContextPath();
    %>
    <script>
        var contextPath = "<%=contextPath%>";
        $(document).on("keyup", "#memPwdCheck, #memPwd", function(){
            if ($("#memPwdCheck").val()=='' || $("#memPwd").val()=='' || $("#memPwd").val()=='undefined' || $("#memPwdCheck").val()=='undefined'){
                $("input[type=password]").removeClass("is-valid")
                $("input[type=password]").removeClass("is-invalid")
                $("div[class=valid-feedback]").attr("style","display:none")
                $("div[class=invalid-feedback]").attr("style","display:none")
            }
            else if ($("#memPwd").val() == $("#memPwdCheck").val()){
                $("input[type=password]").removeClass("is-invalid")
                $("input[type=password]").addClass("is-valid")

                $("div[class=valid-feedback]").attr("style","display:block")
                $("div[class=invalid-feedback]").attr("style","display:none")
            }else{
                $("input[type=password]").removeClass("is-valid")
                $("input[type=password]").addClass("is-invalid")
                $("div[class=valid-feedback]").attr("style","display:none")
                $("div[class=invalid-feedback]").attr("style","display:true")
            }
        })

        $(document).on("change", "input[type=text], input[type=email], select",function(){
            if($(this).val()==''||$(this).val()==""){
                $(this).removeClass("is-valid")
                $(this).removeClass("is-invalid")
            }else{
                $(this).addClass("is-valid");
            }
        })

    </script>
    <script>
        $(document).on("click","#joinBtn", function(){
            let result;
            let memId = $("#memId").val();
            let memPwd = $("#memPwd").val();
            let memPwdCheck = $("#memPwdCheck").val();
            let memSex = $("#memSex").val();
            let memEmail = $("#memEmail").val();
            let memName = $("#memName").val();

            $(".container ").find("input[type=text], input[type=password], input[type=email], select").each(function(){
                let value = $(this).val();
                if(value==''||value==""||value==null){
                    result='isNull';
                    console.log($(this).addClass("is-invalid"))
                    return;
                }
            })

            if(result=='isNull'){
                alert("비어있는 값이 존재합니다.")
            }else if(memPwd!=memPwdCheck){
                alert("비밀번호가 다릅니다.")
            }
            else{
                let data={
                    "memId": memId,
                    "password":memPwd,
                    "memSex":memSex,
                    "email":memEmail,
                    "memName":memName,
                    "auth":"user"
                }
                $.ajax({
                    url:contextPath+"/insertMember",
                    data:data,
                    type:"POST",
                    success:function(data){
                        if(data==="success"){
                            alert("성공");
                            window.location.href=(contextPath+"/login");
                        }else{
                            alert("실패");
                        }
                    }
                })
            }
        })


    </script>
</head>
<body>
<section class="bg-light">
    <div class="container py-4 form-inline w-25" >
        <div class="row align-items-center justify-content-between">
        </div>
        <form>
            <div class="form-group">
                <label for="memId" class="form-label mt-4">아이디</label>
                <input type="text" class="form-control" id="memId" aria-describedby="memId">
            </div>
            <div class="form-group has-success">
                <label class="form-label mt-4" for="memPwd">비밀번호</label>
<%--                <input type="password" class="form-control is-valid" id="memPwd">--%>
                <input type="password" class="form-control" id="memPwd">
                <div class="valid-feedback" display: none>비밀번호가 일치합니다.</div>
                <div class="invalid-feedback" display: none>비밀번호가 일치하지 않습니다</div>
            </div>

            <div class="form-group has-danger">
                <label class="form-label mt-4" for="memPwdCheck">비밀번호 재확인</label>
<%--                <input type="password" class="form-control is-invalid" id="memPwdCheck">--%>
                <input type="password" class="form-control" id="memPwdCheck">
                <div class="valid-feedback" display: none>비밀번호가 일치합니다.</div>
                <div class="invalid-feedback" display: none>비밀번호가 일치하지 않습니다</div>
            </div>
            <div class="form-group">
                <label for="memName" class="form-label mt-4">이름</label>
                <input type="text" class="form-control" id="memName" aria-describedby="memName">
            </div>
<%--            <div class ="bir_wrap">--%>
<%--                <label class="form-label mt-4">생년월일</label>--%>
<%--                <div class="bir_yy">--%>
<%--                		<span class="ps_box">--%>
<%--                			<input type="text" class="form-control" id="yy" placeholder="년(4자)" maxlength="4">--%>
<%--                		</span>--%>
<%--                </div>--%>
<%--                <div class="bir_mm">--%>
<%--                		<span class="ps_box focus">--%>
<%--			                <select class="form-select" id="mm" id="exampleMonth">--%>
<%--						        <option>월</option>--%>
<%--						        <option>1</option>--%>
<%--						        <option>2</option>--%>
<%--						        <option>3</option>--%>
<%--						        <option>4</option>--%>
<%--						        <option>5</option>--%>
<%--						        <option>6</option>--%>
<%--						        <option>7</option>--%>
<%--						        <option>8</option>--%>
<%--						        <option>9</option>--%>
<%--						        <option>10</option>--%>
<%--						        <option>11</option>--%>
<%--						        <option>12</option>--%>
<%--						     </select>--%>
<%--                		</span>--%>
<%--                </div>--%>
<%--                <div class="bir_dd">--%>
<%--                		<span class="ps_box">--%>
<%--                			<input type ="text" class="form-control" id ="dd" placeholder="일" maxlength="2">--%>
<%--                		</span>--%>
<%--                </div>--%>
<%--            </div>--%>
            <div class="form-group">
                <label for="memSex" class="form-label mt-4">성별</label>
                <select class="form-select" id="memSex">
                    <option>남자</option>
                    <option>여자</option>
                </select>
            </div>
            <div class="form-group">
                <label for="memEmail" class="form-label mt-4">이메일</label>
                <input type="email" class="form-control" id="memEmail" aria-describedby="emailHelp" placeholder="선택입력">
            </div>
            <div class="d-grid gap-2">
                <button class="btn btn-primary btn-lg" type="button" id="joinBtn">가입하기</button>
            </div>

        </form>
    </div>
</section>
</body>
</html>
