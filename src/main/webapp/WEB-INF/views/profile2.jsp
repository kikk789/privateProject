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

                            //?????? 23????????? ????????? ?????? ... ?????????
                            if(item.boardTitle.length>=31){
                                item.boardTitle = item.boardTitle.substring(0, 30) + "...";
                            }

                            //????????????
                            let today = new Date();
                            let year = today.getFullYear(); // ??????
                            let month = today.getMonth() + 1;  // ???
                            let date = today.getDate();  // ??????
                            let day = today.getDay();  // ??????
                            let hours = today.getHours(); // ???
                            let minutes = today.getMinutes();  // ???
                            let seconds = today.getSeconds();  // ???
                            let milliseconds = today.getMilliseconds(); // ??????

                            //????????? ????????? ??????
                            let timeSplitSpace = item.boardRegDate.split(" ");
                            let timeSplitDashDate = timeSplitSpace[0].split("-") //0????????????(???) 2022, 1?????? ??????(???) 08, 2?????? ??????(???) 30
                            let timeSplitColonTime = timeSplitSpace[1].split(":");//0????????????(???) 15, 1?????? ??????(???) 45, 2?????? ??????(???) 40.0

                            //?????? ?????????
                            let resultYear = year - timeSplitDashDate[0];
                            let resultmonth = month - timeSplitDashDate[1];
                            let resultdate = date - timeSplitDashDate[2];
                            let resultSeconds = seconds - timeSplitColonTime[2];
                            let resultminutes = minutes - timeSplitColonTime[1];
                            let resulthours = hours - timeSplitColonTime[0];

                            let boardDate="";

                            if(resultYear !=0){
                                boardDate= Math.abs(resultYear) + "??? ???"
                            }else if (resultmonth!=0){
                                boardDate= Math.abs(resultmonth) + "?????? ???"
                            }else if (resultdate!=0){
                                boardDate= Math.abs(resultdate) + "??? ???"
                            }else if (resulthours!=0){
                                boardDate= Math.abs(resulthours) + "?????? ???"
                            }else if (resultminutes!=0){
                                boardDate= Math.abs(resultminutes) + "??? ???"
                            }else if (resultSeconds<0){
                                boardDate= Math.abs(resultSeconds) + "??? ???"
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
                                                .append($('<div class="card-title" style="font-size: 14px"></div>').html("?????????: "+item.memId))
                                                .append($('<span class="card-text text-muted" style="font-size: 12px"></span>').html("????????? "+ item.hit+"??? "))
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
                    console.log("?????????!!")
                    startPage = startPage+8;
                    endPage= endPage+8;
                    infinityPage(startPage, endPage)
                }
            });

            $(document).on("click", "#myVideos", function(){

                //????????? ?????? ?????? ??????
                if($(this).attr("class").indexOf('active') == -1){
                    $(this).addClass("active");
                    $("#etcVideos").removeClass("active");
                    $("#mainListArea").empty();
                    infinityPage(startPage, endPage, "");
                }else{

                }
            });

            $(document).on("click", "#etcVideos", function(){

                //????????? ?????? ?????? ??????
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


            //?????? ?????? ??????
            $(document).on("click", "#checkAll", function(){
                if($("#checkAll").is(":checked")){
                    $(".checkSingle").prop("checked", true);
                }else{
                    $(".checkSingle").prop("checked", false);

                }
            })

            //?????? ?????? ??????
            $(document).on("click", "#checkSingle", function() {
                var total =  $(".checkSingle").length;
                var checked = $(".checkSingle:checked").length;

                //?????? ??????????????? ?????? ??? ???????????? ?????? ?????? ?????? ?????? ????????? ????????? ????????? ??????
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
                        //?????? ?????? data(pageNUM)??? ?????? ????????????
                        //?????? 6???????????? ???????????? 1????????? ???????????? 1?????? ????????????
                        //5???????????? ???????????? ???
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
            <a class="nav-link active" aria-current="page" href="#" id="myVideos">??? ?????????</a>
        </span>
        <span class="nav-item" >
            <a class="nav-link" href="#" id="etcVideos">?????? ??????</a>
        </span>
    </div>
    <span class="d-flex nav-item col-md-3" style="float: right">
        <input class="form-control me-1" type="search" placeholder="Search" aria-label="Search" id="searchMyVideosText">
        <button class="btn btn-outline-success" type="submit" id="searchMyVideosBtn">Search</button>
    </span>
</div>
<input type="checkbox" class="mb-3" id="checkAll" style="zoom:3.0"> ???????????? </input>

<div class="row g-4" id="mainListArea">
    <%--    ????????? ?????? ?????? --%>
</div>
</body>
</html>
