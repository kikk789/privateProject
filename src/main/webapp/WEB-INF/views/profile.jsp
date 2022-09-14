<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

    <script src="./resources/component/jquery-3.3.1.min.js"></script>
    <script src="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="./resources/component/jquery-loading-master/dist/jquery.loading.min.js"></script>
    <script src="./resources/component/jqueryPrint/jqueryPrint.js"></script>

    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="./resources/component/jquery-loading-master/dist/jquery.loading.min.css">
    <link rel="stylesheet" type="text/css" href="./resources/css/customCSS.css">

    <link rel="stylesheet" type="text/css" href="./resources/bootCSS/bootstrap.css">
    <script src="./resources/bootJS/bootstrap.js"></script>
    <script src="./resources/js/topNavigationBar.js"></script>
    <%
        String contextPath = request.getContextPath();
    %>
    <script>
        $(function(){
            var contextPath = "<%=contextPath%>";
            let memId="";
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

            //날짜구하기 (방금전, 몇시간전, 몇일전, 몇년전)
            function timeForToday(value) {
                const today = new Date();
                const timeValue = new Date(value);

                console.log("timeValue ", timeValue)
                console.log("today ", today)
                const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
                if (betweenTime < 1) return "방금전";
                if (betweenTime < 60) {
                    return betweenTime+"분전";
                }

                const betweenTimeHour = Math.floor(betweenTime / 60);
                if (betweenTimeHour < 24) {
                    return betweenTimeHour+"시간전";
                }

                const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
                if (betweenTimeDay < 365) {
                    return +betweenTimeDay +1 +"일전";
                }

                return Math.floor(betweenTimeDay / 365)+년전;
            }

            $("thead")
                .append($('<tr>')
                    .append($('<th scope="col"><input type="checkbox" id="checkAll" class="checkAll" name="checkAll" style="zoom: 2.0"></th>'))
                    .append($('<th scope="col">게시글 번호</th>'))
                    .append($('<th scope="col">썸네일</th>'))
                    .append($('<th scope="col">게시글 제목</th>'))
                    .append($('<th scope="col">등록일</th>'))
                    .append($('<th scope="col">조회수</th>'))
                    .append($('<th scope="col">설정</th>')))
                .append($('</tr>'))
            function infinityPage(startPage, endPage, searchKeywordText){
                //alert(startPage + " || "+ endPage + " || " + searchKeywordText);
                /*if(searchKeywordText != "undefined"){
                    alert(1111111);
                    window.location.href = "/home";
                }*/
                $.ajax({
                    url:contextPath+"/myVideos",
                    data:{
                        "startPage":startPage,
                        "endPage":endPage,
                        "searchKeywordText":searchKeywordText,
                        "memId":memId
                    },
                    type:"POST",
                    success:function(data){
                        console.log("data ", data);

                        $.each(data,function(index,item){

                            // //제목 23바이트 이상일 경우 ... 붙이기
                            // if(item.boardTitle.length>=40){
                            //     item.boardTitle = item.boardTitle.substring(0, 39) + "...";
                            // }

                            let boardDate = timeForToday(item.boardRegDate);

                            $("tbody").append($('<tr style="cursor:pointer; margin: auto;">')
                                .append($("<input type=hidden class='hiddenBoardTitle'>").html(item.boardTitle))
                                .append($("<input type=hidden class='hiddenBoardContent'>").html(item.boardContent))
                                .append($('<th scope="row"><input type="checkbox" id="checkSingle" class="checkSingle" name="checkSingle" style="zoom: 2.0"></th>').attr("idx", item.boardId))
                                .append($('<td></td>').html(item.boardId))
                                .append($('<td><img src="' + item.thumbnail + '" class=""; style="width:120px"></td>'))
                                .append($('<td></td>')
                                .append($("<table class='table'></table>")
                                    .append($('<tr></tr>')
                                        .append($('<td class="tdBoardTitle"></td>').html(item.boardTitle)))
                                    .append($('<tr style="padding: -100px"></tr>')
                                        .append($('<td class="tdBoardContent"></td>').html(item.boardContent)))))

                                .append($('<td></td>').html("&#183; "+boardDate))
                                .append($('<td></td>').html("조회수 "+ item.hit+"회 "))
                                // .append($('<td><a class="bi bi-three-dots-vertical settingUpdateModal" href="#layer-popup" id="'+item.boardId+'"></a></td>')))
                                .append($('<td><a class="bi bi-three-dots-vertical settingUpdateModal" id="'+item.boardId+'"></a></td>')))
                                .append($('</tr>'))

                        })
                    }
                })
            }

            $(window).scroll(function(){
                if (window.outerHeight + $(window).scrollTop() -100 > $(document).height()) {

                    console.log("그리기!!")
                    startPage = startPage+8;
                    endPage= endPage+8;
                    infinityPage(startPage, endPage)
                }
            });

            $(document).on("click", "#myVideos", function(){

                //한번도 클릭 안된 경우
                if($(this).attr("class").indexOf('active') == -1){
                    $(this).addClass("active");
                    $("#etcVideos").removeClass("active");
                    // $("#mainListArea").empty();
                    $("tbody").empty();
                    // $("thead").empty();
                    infinityPage(startPage, endPage, "");
                }else{

                }
            });

            $(document).on("click", "#etcVideos", function(){

                //한번도 클릭 안된 경우
                if($(this).attr("class").indexOf('active') == -1){
                    startPage = 1;
                    endPage=8;
                    $(this).addClass("active");
                    $("#myVideos").removeClass("active");
                    $("tbody").empty();
                    // $("thead").empty();
                }else{

                }
            });

            $(document).on("click", "#searchMyVideosBtn", function(){
                searchKeywordText = $("#searchMyVideosText").val();
                $("tbody").empty();
                // $("thead").empty();
                infinityPage(startPage, endPage, searchKeywordText);
            })

            $(document).on("click", "tbody > tr > td:not(:first-child, :last-child)", function(){

                //왜4번째냐면, 히든으로 2개 추가로 숨겨져있음 2+2 = 4
                boardId = $(this).parent().find(":nth-child(4)").html();
                alert(boardId)
                location.href=(contextPath+"/detailListMain?boardId=" + boardId +"&startPage="+startPage+"&endPage="+endPage);
            })


            //전체 선택 클릭
            $(document).on("click", "#checkAll", function(){
                if($("#checkAll").is(":checked")){
                    $(".checkSingle").prop("checked", true);
                }else{
                    $(".checkSingle").prop("checked", false);

                }
            })

            //단일 선택 클릭
            $(document).on("click", "#checkSingle", function() {
                var total =  $(".checkSingle").length;
                var checked = $(".checkSingle:checked").length;

                //단일 체크박스를 모두 다 클릭하게 되면 전체 선택 체크 버튼이 활성화 된다는 의미
                if(total != checked){
                    $("#checkAll").prop("checked", false);
                }else{
                    $("#checkAll").prop("checked", true);

                }
            })

            $(document).on("click", "#deleteAll", function(){
                let chkVal=[];
                $(".checkSingle:checked").each(function(){
                    chkVal.push($(this).parent().attr('idx'))
                })
                $.ajax({
                    url:contextPath+"/deleteBoardList",
                    type:'post',
                    traditional: true,
                    data:{"chkVal": chkVal},
                    success:function(data){
                        //리턴 받은 data(pageNUM)에 따라 새로고침
                        //만약 6페이지에 리스트가 1개밖에 없었는데 1개를 삭제하면
                        //5페이지로 이동되게 함
                        //location.href=("/practiceList?pageNUM="+data) ;
                        alert("게시글 삭제 완료")
                        location.reload();
                    },
                    error:function(request,status,error){
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    },
                    complete:function(){

                    }
                })
            })

            //모달창에서 삭제하는 것 (굳이 배열로 전달한 필요 없지만 기존 함수 그대로 사용하기 위해서 아래와 같이 사용
            $(document).on("click", ".deleteBoardBtn", function (e) {
                alert("클릭")
                let chkVal=[];
                chkVal.push($(this).parent().parent().parent().attr("boardId"))

                console.log(chkVal)
                $.ajax({
                    url:contextPath+"/deleteBoardList",
                    type:'post',
                    traditional: true,
                    data:{"chkVal": chkVal},
                    success:function(data){
                        alert("게시글 삭제 완료")
                        location.reload();
                    },
                    error:function(request,status,error){
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    },
                    complete:function(){

                    }
                })
            });

            // 팝업 열기
            $(document).on("click", ".settingUpdateModal", function(){
                let top = $(this).offset().top;
                let left = $(this).offset().left;

                //settingUpdateModal 에 속성에 href #id가 있어서 자꾸 스크롤이 아래로 내려가서 href 속성 없애고 하드코딩 하였음
                // var target = $(this).attr("href");
                var target = "#layer-popup";

                $(target).attr("boardId", $(this).attr("id"));
                $(target).attr("title", $(this).parent().parent().find(".hiddenBoardTitle").text());
                $(target).attr("content", $(this).parent().parent().find(".hiddenBoardContent").text());
                $(target).addClass("show");

                $(".settingUpdateBtn").offset({"top":top+25,"left":left-75 });
            })

            //팝업 열기 후 수정 창
            $(document).on("click", ".updateBoardBtnModal", function(e){
                // alert("수정");
                let top = $(this).offset().top;
                let left = $(this).offset().left;
                var target = $(this).attr("href");

                $(target).attr("boardId", $(this).parent().parent().parent().attr("boardId"));
                $(target).attr("title", $(this).parent().parent().parent().attr("title"));
                $(target).attr("content", $(this).parent().parent().parent().attr("content"));
                $(target).addClass("show");

                $(".settingUpdateBtn1").offset({"top":top-40,"left":left-300});

                $("#labelTitle").val($(target).attr("title"))
                $("#labelContent").html($(target).attr("content"))
            })


            $(document).on("click", "#update", function(e){
                console.log($(this).parent().parent().find("#labelTitle").val())
                console.log($(this).parent().parent().find("#labelContent").val())
                console.log($(this).parent().parent().parent().parent().attr("boardId"))
                $.ajax({
                    url:contextPath+"/updateBoard",
                    type:"post",
                    data:{
                        boardTitle:$(this).parent().parent().find("#labelTitle").val(),
                        boardContent:$(this).parent().parent().find("#labelContent").val(),
                        boardId:$(this).parent().parent().parent().parent().attr("boardId")
                    },
                    success:function(data){
                        if(data === 'success'){
                            alert("성공");
                            location.reload();
                        }
                        else{
                            alert("실패");
                        }
                    }
                })
            })


            // 외부영역 클릭 시 팝업 닫기
            $(document).mousedown(function (e){
                var LayerPopup = $(".layer-popup");
                var LayerPopup1 = $(".layer-popup1");
                if(LayerPopup.has(e.target).length === 0 && LayerPopup1.has(e.target).length === 0){
                    LayerPopup.removeClass("show");
                    LayerPopup1.removeClass("show");
                }
            });



            infinityPage(1, 8);
        })
    </script>
    <title>MyProfile</title>
</head>
<body style="padding: 150px 150px 150px 150px;overflow-y: scroll; overflow-x: hidden">

<jsp:include page="navigation.jsp" />
<div class="container settingUpdateBtn">
    <div class="layer-popup" id="layer-popup">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="updateBoardBtnModal bi bi-pen-fill" style="cursor: pointer" href="#layer-popup1"> 수정 </div>
                <div class="deleteBoardBtn bi bi-trash2-fill" style="cursor: pointer"> 삭제 </div>
            </div>
        </div>
    </div>
</div>

<div class="container1 settingUpdateBtn1">
    <div class="layer-popup1" id="layer-popup1">
        <div class="modal-dialog1">
            <div class="modal-content1">
                <div class="mb-3" style="width: 300px;margin:auto" >
                    <label for="labelTitle" class="form-label">제목(필수 항목)</label>
                    <input type="text" class="form-control" id="labelTitle" name="labelTitle" placeholder="title...">
                </div>

                <div class="mb-3" style="width: 300px;margin:auto" >
                    <label for="labelContent" class="form-label">내용</label>
                    <textarea class="form-control" id="labelContent" name="labelContent" placeholder="title..."> </textarea>
                </div>

                <span class="mb-3">
                    <button type="button" class="btn btn-info" id="update">수정</button>
                </span>

                <span class="mb-3">
                    <button type="button" class="btn btn-danger" id="cancel">취소</button>
                </span>

            </div>
        </div>
    </div>
</div>

<div class="nav nav-tabs justify-content-between mb-2">
    <div class="d-flex">
        <span class="nav-item">
            <a class="nav-link active" aria-current="page" href="#" id="myVideos">내 동영상</a>
        </span>
        <span class="nav-item" >
            <a class="nav-link" href="#" id="etcVideos">재생 목록</a>
        </span>
        <button class="btn btn-outline-danger" type="submit" id="deleteAll">삭제</button>
    </div>

    <span class="d-flex col-md-4" style="float: right">
        <input class="form-control me-1" type="search" placeholder="Search" aria-label="Search" id="searchMyVideosText">
        <button class="btn btn-outline-success" type="submit" id="searchMyVideosBtn">Search</button>
    </span>
</div>

<table class="table" id="mainListAreaTable" style="vertical-align:middle">
    <thead style="text-align: center;vertical-align: center" >

    </thead>
    <tbody style="text-align: center">

    </tbody>
</table>

</body>
</html>
