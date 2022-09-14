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
    <script src="./resources/js/topNavigationBar.js"></script>
    <script>
        $(function(){

            let memId="";
            let startPage=1;
            let endPage=8;
            let searchKeywordText ="";
            $.ajax({
                url:"/logimMember",
                async:false,
                success:function(data){
                    memId = data;
                }
            })

            function infinityPage(startPage, endPage, searchKeywordText){
                //alert(startPage + " || "+ endPage + " || " + searchKeywordText);
                /*if(searchKeywordText != "undefined"){
                    alert(1111111);
                    window.location.href = "/home";
                }*/
                $.ajax({
                    url:"/myVideos",
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

                            //제목 23바이트 이상일 경우 ... 붙이기
                            if(item.boardTitle.length>=31){
                                item.boardTitle = item.boardTitle.substring(0, 30) + "...";
                            }

                            //현재시각
                            let today = new Date();
                            let year = today.getFullYear(); // 년도
                            let month = today.getMonth() + 1;  // 월
                            let date = today.getDate();  // 날짜
                            let day = today.getDay();  // 요일
                            let hours = today.getHours(); // 시
                            let minutes = today.getMinutes();  // 분
                            let seconds = today.getSeconds();  // 초
                            let milliseconds = today.getMilliseconds(); // 밀리

                            //동영상 업로드 시간
                            let timeSplitSpace = item.boardRegDate.split(" ");
                            let timeSplitDashDate = timeSplitSpace[0].split("-") //0번째배열(년) 2022, 1번째 배열(월) 08, 2번째 배열(일) 30
                            let timeSplitColonTime = timeSplitSpace[1].split(":");//0번째배열(시) 15, 1번째 배열(분) 45, 2번째 배열(초) 40.0

                            //차이 구하기
                            let resultYear = year - timeSplitDashDate[0];
                            let resultmonth = month - timeSplitDashDate[1];
                            let resultdate = date - timeSplitDashDate[2];
                            let resultSeconds = seconds - timeSplitColonTime[2];
                            let resultminutes = minutes - timeSplitColonTime[1];
                            let resulthours = hours - timeSplitColonTime[0];

                            let boardDate="";

                            if(resultYear !=0){
                                boardDate= Math.abs(resultYear) + "년 전"
                            }else if (resultmonth!=0){
                                boardDate= Math.abs(resultmonth) + "개월 전"
                            }else if (resultdate!=0){
                                boardDate= Math.abs(resultdate) + "일 전"
                            }else if (resulthours!=0){
                                boardDate= Math.abs(resulthours) + "시간 전"
                            }else if (resultminutes!=0){
                                boardDate= Math.abs(resultminutes) + "분 전"
                            }else if (resultSeconds<0){
                                boardDate= Math.abs(resultSeconds) + "초 전"
                            }

                            //window.location.href = "/home";

                            $("#mainListArea")
                                .append($('<div class="col-md-3"  style="cursor:pointer;">')
                                    .append($('<input type="checkbox" id="checkSingle" class="checkSingle" name="checkSingle"  style="zoom: 3.0">'))
                                    .append($('<div class="card" id="boardList">')
                                        .append($('<input type="hidden" val="' + item.boardId + '"id='+item.boardId +' name="'+item.boardId + '">'))
                                        .append($('<img src="' + item.thumbnail + '" class="card-img-top">'))
                                        .append($('<div class="card-body" >')
                                            .append($('<span style="float:left;width: 20%" >')
                                                .append($('<img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" style="width: 100%;border-radius:80px ">')))
                                            .append($('</span>'))
                                            .append($('<span style="float:right;width: 80%; padding-left: 10px">')
                                                .append($('<div class="card-title" style="font-size: 14px"></div>').html(item.boardTitle))
                                                .append($('<div class="card-title" style="font-size: 14px"></div>').html("등록자: "+item.memId))
                                                .append($('<span class="card-text text-muted" style="font-size: 12px"></span>').html("조회수 "+ item.hit+"회 "))
                                                .append($('<small class="text-muted" style="font-size: 12px"></small>').html("&#183; "+boardDate)))
                                            .append($('</span>')))
                                        .append($('</div>'))
                                    ))
                                .append($('</div>'))
                                .append($('</div>'))
                        })
                        //window.location.href = "/home";
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
                    $("#mainListArea").empty();
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
                    $("#mainListArea").empty();
                }else{

                }
            });

            $(document).on("click", "#searchMyVideosBtn", function(){
                searchKeywordText = $("#searchMyVideosText").val();
                $("#mainListArea").empty();
                infinityPage(startPage, endPage, searchKeywordText);
            })

            $(document).on("click", "#boardList", function(){
                boardId = ($(this).find("input[type=hidden]")).attr("id");
                location.href=("/detailListMain?boardId=" + boardId +"&startPage="+startPage+"&endPage="+endPage);
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

            $(document).on("click", "#deleteListBtnNew", function(){
                let chkVal=[];
                $(".checkSingle:checked").each(function(){
                    chkVal.push($(this).attr('idx'))
                })
                $.ajax({
                    url:"/deleteList",
                    type:'post',
                    traditional: true,
                    data:{"chkVal": chkVal},
                    success:function(data){
                        //리턴 받은 data(pageNUM)에 따라 새로고침
                        //만약 6페이지에 리스트가 1개밖에 없었는데 1개를 삭제하면
                        //5페이지로 이동되게 함
                        location.href=("/practiceList?pageNUM="+data) ;
                    },
                    error:function(request,status,error){
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    },
                    complete:function(){

                    }
                })
            })


            infinityPage(1, 8);
        })
    </script>
    <title>MyProfile</title>
</head>
<body style="padding: 150px 150px 150px 150px;overflow-y: scroll">

<jsp:include page="navigation.jsp" />

<div class="nav nav-tabs justify-content-between mb-2">
    <div class="d-flex">
        <span class="nav-item">
            <a class="nav-link active" aria-current="page" href="#" id="myVideos">내 동영상</a>
        </span>
        <span class="nav-item" >
            <a class="nav-link" href="#" id="etcVideos">재생 목록</a>
        </span>
    </div>
    <span class="d-flex nav-item col-md-3" style="float: right">
        <input class="form-control me-1" type="search" placeholder="Search" aria-label="Search" id="searchMyVideosText">
        <button class="btn btn-outline-success" type="submit" id="searchMyVideosBtn">Search</button>
    </span>
</div>
<input type="checkbox" class="mb-3" id="checkAll" style="zoom:3.0"> 전체선택 </input>

<div class="row g-4" id="mainListArea">
    <%--    리스트 목록 출력 --%>
</div>
</body>
</html>
