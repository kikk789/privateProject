<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
    <script src="./resources/component/jquery-3.3.1.min.js"></script>
    <script src="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="./resources/component/jquery-loading-master/dist/jquery.loading.min.js"></script>
    <script src="./resources/component/jqueryPrint/jqueryPrint.js"></script>

    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-loading-master/dist/jquery.loading.min.css">

    <link rel="stylesheet" type="text/css" href="./resources/bootCSS/bootstrap.css">
    <script src="./resources/bootJS/bootstrap.js"></script>
    <title>게시글 등록 </title>
    <%
        String contextPath = request.getContextPath();
    %>
    <script>
        var contextPath = "<%=contextPath%>";
        let memId;
        $.ajax({
            url:contextPath+"/logimMember",
            success:function(data){
                memId = data;
            }
        })

        $(document).on("click", "#insertBtn", function(){
            let reqData={};
            $("#divText input[type=text], #divText textarea").each(function() {
                let data = this;
                let dataId =data['id']+"";
                let dataValue =$(data).val()+"";
                if(dataId =="boardUrl"){
                    reqData[dataId] = 'https://www.youtube.com/embed/' + dataValue.substring(dataValue.indexOf("=")+1);
                    reqData['thumbnail'] = 'https://img.youtube.com/vi/'+ (dataValue.substring(dataValue.indexOf("=")+1) + '/0.jpg');
                }
                else{
                    reqData[dataId] = dataValue;
                }
            });


            //let url = 'https://www.youtube.com/embed/ + data.substring(data.indexOf("=")+1)'

            //https://www.youtube.com/watch?v=XIxnCJ9zmLk
            //https://www.youtube.com/embed/XIxnCJ9zmLk

            //memId가 FK 이므로 실제 존재하는 값으로 해야해서 우선적으로 임의로 1값 지정함
            reqData['memId'] = memId;

            console.log(reqData);
            $.ajax({
               url:contextPath+"/boardInsert",
               data:reqData,
               type:"POST",
               success:function(data){
                   alert("등록에 성공하였습니다.")
                   location.href=(contextPath+data);
               },
               error:function(){
                   alert("등록에 실패하였습니다.")
               }
            })
        })

    </script>

</head>
<body style="padding: 200px">
<jsp:include page="navigation.jsp" />
<div id="divText">

    <div class="mb-3" style="width: 300px;margin:auto" >
        <h3 style="text-align: center"> 게시글 등록</h3>
    </div>

    <div class="mb-3" style="width: 300px;margin:auto" >
        <label for="boardTitle" class="form-label">제목</label>
        <input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="title...">
    </div>
<%--    <div class="mb-3" style="width: 300px;margin:auto">--%>
<%--        <label for="memId" class="form-label">작성자</label>--%>
<%--        <input type="text" class="form-control" id="memId" name="memId" placeholder="writer...">--%>
<%--    </div>--%>
    <div class="mb-3" style="width: 300px;margin:auto">
        <label for="boardUrl" class="form-label">url</label>
        <input type="text" class="form-control" id="boardUrl" name="boardUrl" placeholder="url...">
    </div>
    <div class="mb-3" style="width: 300px;margin:auto">
        <label for="boardContent" class="form-label">영상 설명</label>
        <textarea class="form-control" id="boardContent" name="boardContent" rows="3"></textarea>
    </div>
    <div class="mb-3" style="width: 300px;margin:auto; padding-left: 200px">
        <button type="button" class="btn btn-info" id="insertBtn">등록하기</button>
    </div>
</div>
</body>
</html>
