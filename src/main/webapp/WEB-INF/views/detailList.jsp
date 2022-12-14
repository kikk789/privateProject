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
    <title> topia </title>

    <style type="text/css">
        #playerInfo {
            display: grid;
            grid-template-rows: repeat(2, minmax(25px, auto));
            grid-template-columns: repeat(10, 1fr);
            grid-template-areas:
            "infoHeader infoHeaderTitle . . . . . . . . "
            ". infoMain infoMain infoMain infoMain infoMain infoMain infoMain infoMain infoMain"
        }
        infoHeader { grid-area: infoHeader; }
        infoHeaderTitle {
            grid-area: infoHeaderTitle;
            margin-top: auto;
            margin-bottom: auto;
        }
        infoMain   { grid-area: infoMain;   }

        .replyArea {
            display: grid;
            max-width: 770px;
            width: 100%;
            word-break: keep-all;
            word-wrap: break-word;
            /*box-sizing: border-box;*/
            margin-bottom: 20px;
            grid-template-rows: repeat(10, auto);
            grid-template-columns: repeat(auto-fill, minmax(10%, auto));
            grid-template-areas:
            "replyHeader replyHeaderTitle . . . . . . . . "
            "replyHeader replyMain replyMain replyMain replyMain replyMain replyMain replyMain replyUpdateBtn replyCancelBtn "
            ". rereplyBtn replyUpdate replyDelete . . . . . ."
            ". insertReplyArea insertReplyArea insertReplyArea insertReplyArea insertReplyArea insertReplyArea insertReplyArea insertReplyArea insertReplyArea"
            ". countReplyArea countReplyArea countReplyArea . . . . . ."
            ". showReplyArea showReplyArea showReplyArea showReplyArea showReplyArea showReplyArea showReplyArea showReplyArea showReplyArea"
            ". . showReplyArea2 showReplyArea2 showReplyArea2 showReplyArea2 showReplyArea2 showReplyArea2 showReplyArea2 showReplyArea2"

        }
        replyHeader { grid-area: replyHeader; }
        replyHeaderTitle {
            grid-area: replyHeaderTitle;
            font-size:13px;
        }
        replyMain   {
            grid-area: replyMain;
        }

        replyUpdateBtn   {
            grid-area: replyUpdateBtn;
        }

        replyCancelBtn   {
            grid-area: replyCancelBtn;
        }

        rereplyBtn{
            grid-area: rereplyBtn;
            color: #6c757d;
            font-size: 13px;
            margin-bottom: 10px;

        }
        replyUpdate   {
            grid-area: replyUpdate;
            color: #6c757d;
            font-size: 13px;
        }
        replyDelete   {
            grid-area: replyDelete;
            color: #6c757d;
            font-size: 13px;
        }
        insertReplyArea   { grid-area: insertReplyArea;   }
        showReplyArea   { grid-area: showReplyArea;   }
        countReplyArea   {
            grid-area: countReplyArea;
            color: #003eff;
            margin-bottom: 10px;

        }
        showReplyArea2   { grid-area: showReplyArea2;   }

        .loading-image{
            width: 200px;
            height: 200px;
            background-image: url(/../resources/img/gif-loading-png-10.gif);
            position: absolute;
            top: 50%;
            left: 43%;
            transform: translateY(-50%);
        }

        #boardTitle {
            /*width:70px;*/
            /*padding:0 5px;*/
            /*overflow:hidden;*/
            /*text-overflow:ellipsis;*/
            /*white-space:nowrap;*/
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2; /* ????????? */
            -webkit-box-orient: vertical;
            word-wrap:break-word;
            line-height: 1.2em;
            /*height: 2.4em; !* line-height ??? 1.2em ?????? 3????????? ????????? ????????? height??? 1.2em * 3 = 3.6em *!*/
        }
        /*.col>* {*/
        /*    flex-shrink: 0;*/
        /*    width: 100%;*/
        /*    max-width: 100%;*/
        /*    padding-right: calc(var(--bs-gutter-x) * .5);*/
        /*    padding-left: calc(var(--bs-gutter-x) * .5);*/
        /*    margin-top: var(--bs-gutter-y);*/
        /*}*/

    </style>
    <%
        String contextPath = request.getContextPath();
    %>
    <script>
        var contextPath = "<%=contextPath%>";
        let startPage=1;
        let endPage=8;

        let startPage1=1;
        let endPage1=20;
        let boardId = window.location.href.split("&")[0].split("=")[1]
        let memId;
        let totalReplyCount=0;
        $.ajax({
            url:contextPath+"/logimMember",
            success:function(data){
                memId = data;
            }
        })

        replyIfinity(startPage, endPage);
        sideBar(startPage1, endPage1);

        // ?????? ?????? ?????? ??????
        var loading = function(onoff){

            if(onoff == "ON"){
                //$("body").prepend('<div class="custom-loading"><div class="loading-image"></div></div>');
                $('body').loading({
                    overlay: $(".custom-loading")
                });
            }else{
                $('body').loading("stop");
            }
        }

        //?????? ?????? ?????? ?????? ??????
        function replyIfinity(startPage, endPage){

            $.ajax({
                url:contextPath+"/listReply?boardId="+boardId+"&startPage="+startPage+"&endPage="+endPage,
                success:function(data){
                    console.log("?????? ??????")
                    let replyContent=$("#replyContent");
                    totalReplyCountFunc(data.length);

                    for(let i=0; i<data.length; i++) {
                        //?????? ?????? ????????? ?????? ??????
                        let replyGroup = data[i].replyGroup;
                        let eachMemId = data[i].memId;
                        let allData;
                        $.ajax({
                            url:contextPath+"/listReReply?replyGroup="+replyGroup+"&boardId="+boardId,
                            async:false,
                            success:function(data){
                                allData = data;
                                totalReplyCountFunc(allData.length-1);
                            },
                            beforeSend:function(){
                            }
                        })
                        //end

                        let arrReplyContentOld = data[i].replyContent.split("")
                        let arrReplyContentFirst ="";
                        let arrReplyContentSecond ="";
                        let arrReplyContentNew ="";
                        let arrReplyContentOldCount =arrReplyContentOld.length;

                        for(let j=0; j<arrReplyContentOld.length; j++){
                            if(j>200){ //?????? 200??? ??????
                                arrReplyContentSecond += arrReplyContentOld[j];
                            }
                            else if(j<=200){ // ?????? 200??? ??????
                                arrReplyContentFirst += arrReplyContentOld[j];

                            }
                        }

                        if(arrReplyContentOld.length<=200){
                            arrReplyContentNew = arrReplyContentFirst + arrReplyContentSecond;
                        }
                        else{
                            arrReplyContentNew = arrReplyContentFirst;
                            arrReplyContentNew = arrReplyContentNew +  "<span id='showMore' style='cursor:pointer;color:#bb2d3b' '> ... ????????? </span>";
                        }
                        if (memId != eachMemId){

                            replyContent.append(
                                $($("<div></div>").addClass("replyArea").attr({"replyId": data[i].replyId, "replyGroup": data[i].replyGroup, "replyOrder": data[i].replyOrder ,"replyParent":data[i].replyParent})
                                    .append($("<replyHeader></replyHeader>")
                                        .append('<img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="50px" style="border-radius:80px">')
                                    )
                                    .append($("<replyHeaderTitle></replyHeaderTitle>").html(data[i].memId))
                                    // .append($("<replyMain></replyMain>").append($("<div></div>").html(arrReplyContentNew))
                                    // .append($("<replyMain></replyMain>").append($("<input type='text' disabled class=form-control id='replyMainText' style='background-color: white;border:none;display=inline-block;float:left;margin-left: -12px'>").val(arrReplyContentNew))
                                    .append($("<replyMain></replyMain>")
                                        .append($("<div class=form-control id='replyMainText' style='background-color: white;border:none;display=inline-block;float:left;margin-left: -12px'>")
                                            .attr("arrReplyContentOldCount", arrReplyContentOldCount)
                                            .html(arrReplyContentNew))
                                        .append($("<input type=hidden id='arrReplyContentSecond'>").val(arrReplyContentSecond))
                                        .append($("<input type=hidden id='arrReplyContentFirst'>").val(arrReplyContentFirst))
                                    )
                                    .append($("<rereplyBtn><rereplyBtn>").css("cursor","pointer").attr({"id":"rereplyBtn", "replyInsertClickFlag":"0", "replyGroup": data[i].replyGroup, "replyParent":data[i].replyParent, "replyDepth":1}).html("??????"))
                                    .append($("<countReplyArea></countReplyArea>").css("cursor","pointer").attr({"id":"countReplyArea", "replyListClickFlag":0,"replyGroup": data[i].replyGroup, "replyParent":data[i].replyParent, "replyDepth":1}).html("?????? "+(allData.length-1)+"???"))
                                    .append($("<insertReplyArea><insertReplyArea>").attr("id", "insertReplyArea").css("display", "inline-block").html(""))
                                    .append($("<showReplyArea><showReplyArea>").attr("id", "showReplyArea").css("display", "inline-block").html(""))
                                    .append($("<showReplyArea2><showReplyArea2>").attr("id", "showReplyArea2").css("display", "inline-block").html(""))
                                )
                            )
                        }else{
                            replyContent.append(
                                $($("<div></div>").addClass("replyArea").attr({"replyId": data[i].replyId, "replyGroup": data[i].replyGroup, "replyOrder": data[i].replyOrder ,"replyParent":data[i].replyParent})
                                    .append($("<replyHeader></replyHeader>")
                                        .append('<img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="50px" style="border-radius:80px">')
                                    )
                                    .append($("<replyHeaderTitle></replyHeaderTitle>").html(data[i].memId))
                                    // .append($("<replyMain></replyMain>").append($("<div></div>").html(arrReplyContentNew))
                                    // .append($("<replyMain></replyMain>").append($("<input type='text' disabled class=form-control id='replyMainText' style='background-color: white;border:none;display=inline-block;float:left;margin-left: -12px'>").val(arrReplyContentNew))
                                    .append($("<replyMain></replyMain>")
                                        .append($("<div class=form-control id='replyMainText' style='background-color: white;border:none;display=inline-block;float:left;margin-left: -12px'>")
                                            .attr("arrReplyContentOldCount", arrReplyContentOldCount)
                                            .html(arrReplyContentNew))
                                        .append($("<input type=hidden id='arrReplyContentSecond'>").val(arrReplyContentSecond))
                                        .append($("<input type=hidden id='arrReplyContentFirst'>").val(arrReplyContentFirst))
                                    )
                                    .append($("<rereplyBtn><rereplyBtn>").css("cursor","pointer").attr({"id":"rereplyBtn", "replyInsertClickFlag":"0", "replyGroup": data[i].replyGroup, "replyParent":data[i].replyParent, "replyDepth":1}).html("??????"))

                                    .append($("<replyUpdate></replyUpdate>").css("cursor","pointer").attr("id","replyUpdate").html("??????"))
                                    .append($("<replyDelete></replyDelete>").css("cursor","pointer").attr("id","replyDelete").html("??????"))
                                    .append($("<countReplyArea></countReplyArea>").css("cursor","pointer").attr({"id":"countReplyArea", "replyListClickFlag":0,"replyGroup": data[i].replyGroup, "replyParent":data[i].replyParent, "replyDepth":1}).html("?????? "+(allData.length-1)+"???"))
                                    .append($("<insertReplyArea><insertReplyArea>").attr("id", "insertReplyArea").css("display", "inline-block").html(""))
                                    .append($("<showReplyArea><showReplyArea>").attr("id", "showReplyArea").css("display", "inline-block").html(""))
                                    .append($("<showReplyArea2><showReplyArea2>").attr("id", "showReplyArea2").css("display", "inline-block").html(""))
                                )
                            )
                        }

                    }
                    $("#totalReplyCount").html("?????? "+ totalReplyCount +"???");
                }
            })
        }


        //?????? ????????? ??? ?????? ??????
        function sideBar(startPage, endPage){
            $.ajax({
                url:contextPath+"/detailList?boardId=" + boardId +"&startPage="+startPage+"&endPage="+endPage,
                success:function(data){
                    console.log("data ", data);
                    $.each(data, function(index, item){

                        //?????? 23????????? ????????? ?????? ... ?????????
                        // if(item.boardTitle.length>=31){
                        //     item.boardTitle = item.boardTitle.substring(0, 31) + "...";
                        // } //CSS??? ?????? ?????????

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

                    //     $("#side")
                    //         .append($('<div class="card mb-2" id="boardList" style="cursor:pointer;height:94px" >')
                    //             .append($('<input type="hidden" val="'+ item.boardId+'" id="'+ item.boardId+'" name="'+ item.boardId+'">'))
                    //             .append($('<div style="display: flex">')
                    //                 .append($('<span style="width: 168px; height: 94px;">')
                    //                     .append($('<img src="'+ item.thumbnail+'" class="img-fluid rounded-start" alt="..." style="width: 168px; height: 94px;">'))
                    //                     .append($('</span>')))
                    //                 .append($('</span>'))
                    //                 .append($('<div class="card-body">')
                    //                     .append($('<div class="card-title" style="font-size: 13px"> </div>').html(item.boardTitle))
                    //                     .append($('<div class="card-text"><small class="text-muted" ">'+boardDate+'</small></div>')))
                    //                 .append($('</div>'))
                    //                 .append($('</span>')))
                    //             .append($('</div>')))
                    //         .append($('</div>'))
                    // })
                        $("#side")
                            .append($('<div class="col col-lg-12" id="boardList" >')
                                .append($('<input type="hidden" val="'+ item.boardId+'" id="'+ item.boardId+'" name="'+ item.boardId+'">'))
                                .append($('<div class="mb-2 " style="display:flex">')
                                    //.append($('<span>')
                                        .append($('<img class="card-img" style="display: inline-block; width: 40%" src="'+ item.thumbnail+'" class="rounded-start" alt="...">')
                                            .css("min-width","47%"))
                                        //.append($('</span>')))
                                    .append($('<div class="p-1" style="margin-left: 10px">')
                                        .append($('<div style="font-size:14px;" id="boardTitle"> </div>').html(item.boardTitle))
                                        .append($('<div><small class="text-muted">'+item.memId+'</small></div>'))
                                        .append($('<div><small class="text-muted">'+boardDate+'</small></div>')))
                                    .append($('</div>'))
                                    .append($('</span>')))
                                .append($('</div>')))
                            .append($('</div>'))
                    })

                }
            })
        }

        $(window).scroll(function(){
            if (window.outerHeight + $(window).scrollTop() -100 > $(document).height()) {
                console.log("?????????!!")
                startPage = startPage+8;
                endPage= endPage+8;

                startPage1 = endPage1 ;
                endPage1 = startPage1+6;

                replyIfinity(startPage, endPage)

                console.log("startPage1 " , startPage1);
                console.log("endPage1 " , endPage1);
                sideBar(startPage1+1, endPage1);

            }
        });
        // window.onscroll=function(){
        //     console.log("window.innerHeight ", window.innerHeight)
        //     console.log("window.screenY ", window.screenY)
        //     console.log("document.body.offsetHeight ", document.body.offsetHeight)
        //     if(window.innerHeight + window.screenY >= document.body.offsetHeight){
        //
        //         // var toAdd=document.createElement("div");
        //         // toAdd.classList.add("box");
        //         console.log("dqwdwqd")
        //         // document.querySelector('section').appendChild(toAdd);
        //     }
        // }


        function totalReplyCountFunc(n){
            totalReplyCount += n;
            $("#totalReplyCount").html("?????? "+ totalReplyCount +"???");
        }

        //????????? ??????
        $(document).on("click", "#showMore", function(){
            $(this).hide();
            $(this).parent().html($(this).parent().html() + $(this).parent().parent().find("#arrReplyContentSecond").val()+"<span id='disableMore' style='cursor:pointer;color:#bb2d3b' '> ????????? </span>")
        })

        //????????? ??????
        $(document).on("click", "#disableMore", function(){

            let arrReplyContentFirst = $(this).parent().parent().find("#arrReplyContentFirst").val();
            let arrReplyContentSecond = $(this).parent().parent().find("#arrReplyContentSecond").val();

            $(this).parent().html(arrReplyContentFirst+"<span id='showMore' style='cursor:pointer;color:#bb2d3b' '> ... ????????? </span>")
            $(this).parent().append($("<input type=hidden id='arrReplyContentSecond'>").val(arrReplyContentSecond))
                .append($("<input type=hidden id='arrReplyContentFirst'>").val(arrReplyContentFirst))
        })

        $(document).on("click", "#boardList", function(){
            boardId = ($(this).find("input[type=hidden]")).attr("id");
            location.href=(contextPath+"/detailListMain?boardId=" + boardId +"&startPage="+startPage+"&endPage="+endPage);
        })

        //???????????? ?????? ??????
        $(document).on("click","#replyInsert", function(){
            let replyContent = $("#replyText").val();
            let data1 = {
                "replyContent" : replyContent,
                "memId" :memId, //?????? ????????? ??? ???????????? ???????????????
                "boardId": boardId,
            };

            $.ajax({
                url:contextPath+"/insertReply",
                data:data1,
                type:"POST",
                success:function(data){
                    location.reload();
                }
            })
        })
        let replyMainTextBackup;
        $(document).on("click", "#replyUpdate", function(){

            replyMainTextBackup = $(this).parent().find("replymain").find("#replyMainText").html();

            if($(this).parent().find("replymain").find("#replyMainText").attr("arrreplycontentoldcount")>200){
                $(this).parent().find("replymain").find("#replyMainText")
                    .html($(this).parent().find("replymain").find("#arrReplyContentFirst").val()+$(this).parent().find("replymain").find("#arrReplyContentSecond").val()
                    )
            }

            $(this).parent().find("replymain").find("#replyMainText").attr("contenteditable",true);
            $(this).parent().find("replymain").find("#replyMainText").focus();
            $(this).html("?????????");
            $(this).css("color", "red");
            $(this).css("font-weight", "bold");
            $(this).parent().append($("<replyUpdateBtn id='replyUpdateBtn' class='btn btn-info' style='width:58px;margin:auto'></replyUpdateBtn>").html("??????"));
            $(this).parent().append($("<replyCancelBtn id='replyCancelBtn' class='btn btn-info' style='width:58px;margin:auto'></replyCancelBtn>").html("??????"));

        })
        $(document).on("click", "#replyCancelBtn", function(){
            if(replyMainTextBackup != '' || replyMainTextBackup !=""){
                $(this).parent().find("replymain").find("#replyMainText").html(replyMainTextBackup);
            }

            $(this).parent().find("replymain").find("#replyMainText").attr("contenteditable",false);
            $(this).parent().find("replyUpdate").html("??????");
            $(this).parent().find("replyUpdate").css("color", "black");
            $(this).parent().find("replyUpdate").css("font-weight", "normal");
            $(this).parent().find("replyUpdateBtn").remove();
            $(this).parent().find("replyCancelBtn").remove();
            replyMainTextBackup="";
        })

        $(document).on("click", "#replyUpdateBtn", function() {
            let replyId = $(this).parent().attr("replyid");
            let updateText = $(this).parent().find("replymain").find("#replyMainText").html();
            $.ajax({
                url:contextPath+"/updateReply",
                type:"POST",
                data:{
                    "replyId":replyId,
                    "memId":memId,
                    "replyContent":updateText,
                },
                success:function (data){
                    if(data==="OK"){
                        alert("????????? ?????? ?????? ??????")
                        location.reload();
                    }
                }
            })
        })

            //?????? ??????
        $(document).on("click", "#replyDelete", function(){
            let replyIdArr =[];
            let replyId = $(this).parent().attr("replyid");
            let replyGroup = $(this).parent().attr("replyGroup");

            let allData;

            $.ajax({
                url:contextPath+"/replyCount?replyGroup="+replyGroup+"&replyId="+replyId,
                async:false,
                success:function(data){
                    allData = data;
                }
            })

            replyIdArr.push(replyId);
            for(let i=0; i<allData.length; i++){
                replyIdArr.push(String(allData[i].replyId));
            }
            $.ajax({
                url:contextPath+"/deleteReply",
                type:"POST",
                traditional : true,
                data:{"replyIdArr": replyIdArr},
                success:function (data){
                    if(data==="OK"){
                        alert("????????? ?????? ??????")
                    }
                    totalReplyCountFunc(-replyIdArr.length);
                    location.reload();
                }
            })
        })

        //?????????????????????
        $(document).on("click","#rereplyListDelete", function(){
            let nextThis = $(this).parent();
            let replyIdArr =[];
            let replyId = $(this).parent().attr("replyid");
            let replyDepthThis = $(this).parent().attr("replyDepth");
            let replyDepthNext = $(this).parent().next().attr("replyDepth");

            //replyIdArr??? ?????? ????????? ????????? ???????????? ?????????
            // replyIdArr.push(replyId);
            // while(true){
            //     if(Number(replyDepthThis)+1 == replyDepthNext){
            //         // replyIdArr +=",";
            //         replyIdArr.push(nextThis.next().attr("replyid"))
            //         nextThis =  nextThis.next();
            //         replyDepthThis = nextThis.attr("replyDepth");
            //         replyDepthNext = nextThis.next().attr("replyDepth");
            //     }
            //     else{
            //         break;
            //     }
            // }//end

            // replyIdArr += (new Function("$(this).parent()"+nextStr+".attr('replyid')"))();

            $.ajax({
                // url:"/deleteReply",
                url:contextPath+"/deleteReply?replyId="+replyId,
                type:"GET",
                // type:"POST",
                // traditional : true,
                // data:{"replyIdArr": replyIdArr},
                success:function (data){
                    if(data==="OK"){
                        alert("????????? ?????? ??????")
                    }
                    totalReplyCountFunc(-replyIdArr.length);
                    location.reload();
                }
            })
        })

        $(document).on("click","#rereplyListUpdate", function(){
            let replyId = $(this).parent().attr("replyid");
            // $(this).parent().find("replymain").find("replyMainText").attr("disabled",true);
            $(this).parent().find("#rereplyListText").attr("contenteditable", true);
            $(this).parent().find("#rereplyListText").focus();
            $(this).html("?????????");
            $(this).css("color", "red");
            $(this).css("font-weight", "bold");
            $(this).parent().find("#rereplyUpdateBtn").css("visibility", "visible");
            $(this).parent().find("#rereplyCancelBtn").css("visibility", "visible");

            // $(this).prev().prev().append($("<span id='rereplyUpdateBtn' class='btn btn-info' style='width:58px;margin:auto'></span>").html("??????"));
            // $(this).prev().prev().append($("<span id='rereplyCancelBtn' class='btn btn-info' style='width:58px;margin:auto'></span>").html("??????"));
        })
        $(document).on("click","#rereplyUpdateBtn", function(){
            let replyId = $(this).parent().attr("replyid");
            let updateText = $(this).parent().find("#rereplyListText").html();
            $(this).parent().find("#rereplyListText").attr("contenteditable", false);
            // $(this).parent().find("#rereplyListText").attr("disabled", true);
            $(this).parent().find("#rereplyListUpdate").html("??????");
            $(this).parent().find("#rereplyListUpdate").css("color", "black");
            $(this).parent().find("#rereplyListUpdate").css("font-weight", "normal");
            $(this).parent().find("#rereplyUpdateBtn").css("visibility", "hidden");
            $(this).parent().find("#rereplyCancelBtn").css("visibility", "hidden");

            $.ajax({
                url:contextPath+"/updateReply",
                type:"POST",
                data:{
                    "replyId":replyId,
                    "memId":memId,
                    "replyContent":updateText,
                },
                success:function (data){
                    if(data==="OK"){
                        alert("?????? ?????? ??????")
                    }
                }
            })

            // $(this).prev().prev().append($("<span id='rereplyUpdateBtn' class='btn btn-info' style='width:58px;margin:auto'></span>").html("??????"));
            // $(this).prev().prev().append($("<span id='rereplyCancelBtn' class='btn btn-info' style='width:58px;margin:auto'></span>").html("??????"));
        })
        $(document).on("click","#rereplyCancelBtn", function(){
            // $(this).parent().find("#rereplyMainText").attr("disabled", true);
            $(this).parent().find("#rereplyListText").attr("contenteditable", false);
            $(this).parent().find("#rereplyListUpdate").html("??????");
            $(this).parent().find("#rereplyListUpdate").css("color", "black");
            $(this).parent().find("#rereplyListUpdate").css("font-weight", "normal");
            $(this).parent().find("#rereplyUpdateBtn").css("visibility", "hidden");
            $(this).parent().find("#rereplyCancelBtn").css("visibility", "hidden");
        })

        //?????? ??????
        $(document).on("click", "#rereplyBtn", function(){
            if($(this).attr("replyInsertClickFlag") =="0" || $(this).attr("replyInsertClickFlag")==0){
                $(this).parent().find("#insertReplyArea")
                        .append($('<img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="30px" style="border-radius:80px">'))
                        .append($('<input type="text" style="display: inline-block;width: 70%"  class="form-control" id="rereplyInsertText" name="rereplyInsertText" placeholder="??????...">'))
                        .append($('<button type="button" class="btn btn-info" id="rereplyInsert">?????? ??????</button>'))
                        .append($('<button type="button" class="btn btn-info" id="rereplyCancel">??????</button>'))
            }
            $(this).attr("replyInsertClickFlag", "1");
        })

        //?????? ??????
        $(document).on("click", "#rereplyInsert", function(){
            let btnThis = $(this);
            let replyContent = $(this).parent().find("#rereplyInsertText").val();
            let replyParent = $(this).parent().parent().attr("replyId");
            let replyDepth = $(this).parent().parent().find("#rereplyBtn").attr("replyDepth");
            let replyGroup = $(this).parent().parent().find("#rereplyBtn").attr("replyGroup"); //db?????? +1??? ??????
            let replyOrder = $(this).parent().parent().attr("replyOrder");
            let replyId = $(this).parent().parent().attr("replyId");//????????? order ??????


            let data1 = {
                "replyContent": replyContent,
                "memId": memId, //?????? ????????? ??? ???????????? ???????????????
                "boardId": boardId,
                "replyParent": replyParent,
                "replyDepth": replyDepth,
                "replyGroup":replyGroup,
                "replyOrder":replyOrder,
                "replyId":replyId
            };

            let replyLength;
            $.ajax({
                url:contextPath+"/replyCount?replyGroup="+replyGroup+"&replyId="+replyId+"&boardId="+boardId,
                async:false,
                success:function(data){
                    replyLength = data.length;
                }
            })
            $.ajax({
                url:contextPath+"/insertReReply",
                data:data1,
                type:"POST",
                success:function(data){
                    if(btnThis.parent().parent().find("#countreplyarea").attr("replyListClickFlag") =="1" || $(this).attr("replyListClickFlag")==1){
                        (btnThis.parent().parent().find("#rereplyBtn")).attr("replyInsertClickFlag", "0")
                        btnThis.parent().parent().find("countReplyArea").trigger("click"); //??????????????? show??? ?????? click ,???????????? ?????? Show ?????? ?????? ????????? ???????????? ????????????
                        btnThis.parent().parent().find("countReplyArea").trigger("click"); //??????????????? show??? ?????? click ,???????????? ?????? Show ?????? ?????? ????????? ???????????? ????????????
                        btnThis.parent().parent().find("countReplyArea").html("?????? "+Number(replyLength+1) +"???");//?????? 1??? ?????????
                        btnThis.parent().empty(); //?????? ?????? ??? ??????
                        totalReplyCountFunc(1);
                    }else{
                        (btnThis.parent().parent().find("#rereplyBtn")).attr("replyInsertClickFlag", "0")
                        btnThis.parent().parent().find("countReplyArea").trigger("click"); //??????????????? show??? ?????? click
                        btnThis.parent().parent().find("countReplyArea").html("?????? "+Number(replyLength+1) +"???");//?????? 1??? ?????????
                        btnThis.parent().empty(); //?????? ?????? ??? ??????
                        totalReplyCountFunc(1);
                    }


                }
            })
        })

        //?????? ??????
        $(document).on("click", "#rereplyCancel", function(){
            ($(this).parent().parent().find("#rereplyBtn")).attr("replyInsertClickFlag", "0")
            $(this).parent().empty();
        })

        //?????? ?????? ??????(?????? ????????? ?????? ????????? ??????)
        $(document).on("click", "#countReplyArea", function(){
            let replyGroup = $(this).attr("replyGroup");
            let replyId = $(this).parent().attr("replyId");
            // let parentMemId = $(this).parent().find("replyHeaderTitle").html();
            let parentMemId="";
            let allData;
            $.ajax({
                url:contextPath+"/replyCount?replyGroup="+replyGroup+"&replyId="+replyId,
                async:false,
                success:function(data){
                    allData = data;
                }
            })

            if($(this).attr("replyListClickFlag") =="0" || $(this).attr("replyListClickFlag")==0) {
                let showReplyArea = $(this).parent().find("#showReplyArea");

                for (let i = 0; i < allData.length; i++) {

                    //Ajax - ???????????? ????????? id??? ????????? (????????? ????????? '@??????id' ???????????? ?????? ??????
                    $.ajax({
                        url:contextPath+"/getReplyMemId?replyId="+allData[i].replyId,
                        async:false,
                        success:function(data){
                            if(data == null || data=='undefined' || data==""){
                                console.log("?????? ????????? ??????");
                            }else{
                                parentMemId = data;
                                console.log("??????id ", data);
                            }
                        }
                    })
                    $(this).attr("replyListClickFlag", "1");

                    let arrow="";
                    for (let j=0; j<allData[i].replyDepth;j++){
                        arrow += ">";

                    }

                    let eachMemId = allData[i].memId;
                    if (memId != eachMemId){
                        $(showReplyArea)
                            .append($("<div></div>").css("margin-bottom", "15px")
                                .attr({
                                    "replyId": allData[i].replyId,
                                    "replyGroup": allData[i].replyGroup,
                                    "replyParent":allData[i].replyParent,
                                    "replyDepth":allData[i].replyDepth,
                                    "replyOrder":allData[i].replyOrder
                                })
                                .append($('<img style="margin-right: 10px;float: left;border-radius:80px" src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="30px">'))
                                .append($('<div style="background-color: white; border:none; display: inline-block;float: left" " id="rereplyListMemId" name="rereplyListMemId">').html("?????????: " + allData[i].memId))
                                .append($('<div style="background-color: white; border:none; display: block" id="rereplyListReplyDate" name="rereplyListMemId">').html("("+allData[i].replyDate+")"))
                                .append($('<input type="text"  disabled id="rereplyMainText" class="form-control" style="background-color: white;border:none;float:left;">').val("@"+parentMemId +arrow))
                                // .append($('<input type="text" disabled class="form-control" style="background-color: white;border:none;float:left;width:60%" id="rereplyListText" name="rereplyListText">').val(allData[i].replyContent))
                                .append($('<div class="form-control" style="background-color: white;border:none;float:left;width:60%;display=inline-block" id="rereplyListText" name="rereplyListText">').html(allData[i].replyContent))
                                .append($('<button class="btn btn-info" id="rereplyUpdateBtn" style="float:left;margin-right: 20px;width:9%;visibility: hidden"> ?????? </button>'))
                                .append($('<button class="btn btn-info" id="rereplyCancelBtn" style="display: block;width:9%;visibility: hidden"> ?????? </button>'))
                                .append($('<span id="rereplyListInsert" style="cursor:pointer;margin-left: 40px; color: #6c757d;font-size:13px " rereplyListInsert="0"></span>').html(" ?????? "))
                                .append($('<div id="rereplyArea"></div>'))

                            )
                    }else{
                        $(showReplyArea)
                            .append($("<div></div>").css("margin-bottom", "15px")
                                .attr({
                                    "replyId": allData[i].replyId,
                                    "replyGroup": allData[i].replyGroup,
                                    "replyParent":allData[i].replyParent,
                                    "replyDepth":allData[i].replyDepth,
                                    "replyOrder":allData[i].replyOrder
                                })
                                .append($('<img style="margin-right: 10px;float: left;border-radius:80px" src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="30px">'))
                                .append($('<div style="background-color: white; border:none; display: inline-block;float: left" " id="rereplyListMemId" name="rereplyListMemId">').html("?????????: " + allData[i].memId))
                                .append($('<div style="background-color: white; border:none; display: block" id="rereplyListReplyDate" name="rereplyListMemId">').html("("+allData[i].replyDate+")"))
                                .append($('<input type="text"  disabled id="rereplyMainText" class="form-control" style="background-color: white;border:none;float:left;">').val("@"+parentMemId +arrow))
                                // .append($('<input type="text" disabled class="form-control" style="background-color: white;border:none;float:left;width:60%" id="rereplyListText" name="rereplyListText">').val(allData[i].replyContent))
                                .append($('<div class="form-control" style="background-color: white;border:none;float:left;width:60%;display=inline-block" id="rereplyListText" name="rereplyListText">').html(allData[i].replyContent))
                                .append($('<button class="btn btn-info" id="rereplyUpdateBtn" style="float:left;margin-right: 20px;width:9%;visibility: hidden"> ?????? </button>'))
                                .append($('<button class="btn btn-info" id="rereplyCancelBtn" style="display: block;width:9%;visibility: hidden"> ?????? </button>'))
                                .append($('<span id="rereplyListInsert" style="cursor:pointer;margin-left: 40px; color: #6c757d;font-size:13px " rereplyListInsert="0"></span>').html(" ?????? "))
                                .append($('<span id="rereplyListUpdate" style="cursor:pointer;margin-left: 10px; color: #6c757d;font-size:13px " > </span>').html(" ?????? "))
                                .append($('<span id="rereplyListDelete" style="cursor:pointer;margin-left: 10px; color: #6c757d;font-size:13px " > </span>').html(" ?????? "))
                                .append($('<div id="rereplyArea"></div>'))

                            )
                    }

                }//end for
            }
            else if($(this).attr("replyListClickFlag") =="1" || $(this).attr("replyListClickFlag")==1){
                $(this).attr("replyListClickFlag", "0");
                $(this).parent().find("#showReplyArea, rereplyArea").empty();

            }

        })

        //?????????????????? ?????? ?????? ??? ??????
        $(document).on("click", "#rereplyListInsert", function(){
            if ($(this).attr("rereplyListInsert") ==0 || $(this).attr("rereplyListInsert") =="0"){
                $(this).parent().find("#rereplyArea").css({"margin-left": "50px", "margin-bottom":"10px", "margin-top":"10px" })
                    .append($('<img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="30px" style="border-radius:80px">'))
                    .append($('<input type="text" style="display: inline-block;width: 50%"  class="form-control" id="rereplyInsertText2" name="rereplyInsertText2" placeholder="??????...">'))
                    .append($('<button type="button" class="btn btn-info" id="rereplyInsert2">????????? ??????</button>'))
                    .append($('<button type="button" class="btn btn-info" id="rereplyCancel2">??????</button>'))
                $(this).attr("rereplyListInsert",1);
            }
            else{
                $(this).parent().find("#rereplyArea").empty();
                $(this).attr("rereplyListInsert",0);
            }

        })

        //????????? ?????? ?????? ???
        $(document).on("click", "#rereplyCancel2", function(){
            // ($(this).parent().parent().find("#rereplyBtn")).attr("replyInsertClickFlag", "0")
            $(this).parent().parent().find("#rereplyListInsert").attr("rereplyListInsert",0);
            $(this).parent().empty();

        })

        //????????? insert
        $(document).on("click", "#rereplyInsert2", function(){
            let btnThis =$(this);
            let replyContent = $(this).prev().val();

            let replyParent = $(this).parent().parent().attr("replyId");//????????? id??? ?????????
            let replyDepth = Number($(this).parent().parent().attr("replyDepth"))+1;
            let replyGroup = $(this).parent().parent().attr("replyGroup");//db?????? +1??? ??????
            let replyOrder = Number($(this).parent().parent().attr("replyOrder"))+1;//????????? order ??????
            let replyId = $(this).parent().parent().attr("replyId");//????????? order ??????


            let data1 = {
                "replyContent": replyContent,
                "memId": memId, //?????? ????????? ??? ???????????? ???????????????
                "boardId": boardId,
                "replyParent": replyParent,
                "replyDepth": replyDepth,
                "replyGroup":replyGroup,
                "replyOrder":replyOrder,
                "replyId":replyId
            };

            let replyLength;
            $.ajax({
                url:contextPath+"/replyCount?replyGroup="+replyGroup+"&replyId="+replyId,
                async:false,
                success:function(data){
                    replyLength = data.length;
                }
            })

            $.ajax({
                url:contextPath+"/insertReReply",
                data:data1,
                type:"POST",
                success:function(){
                    alert("??????!");

                    // (btnThis.parent().parent().parent().parent().find("#countReplyArea")).attr("replyListClickFlag", "1")

                    btnThis.parent().parent().parent().parent().find("countReplyArea").html("?????? "+Number(replyLength+1) +"???");//?????? 1??? ?????????
                    btnThis.parent().parent().parent().parent().find("countReplyArea").trigger("click");
                    // $(btnThis.parent().parent().parent().parent().find("#showReplyArea")).load(location.href + ' #showReplyArea');

                    //btnThis.parent().empty(); //????????? ???????????????
                    totalReplyCountFunc(1);
                }
            })
        })

    </script>

</head>
<body style="padding: 150px 150px 150px 150px;overflow-y: scroll">
<jsp:include page="navigation.jsp" />
<div style="display: flex">
    <div id="player" style="float:left; width:70%;" >
        <iframe style='width:100%; height:600px' src="${boardVO.boardUrl}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        <div style="padding-top: 20px;">
            <span> <h4>${boardVO.boardTitle}</h4> </span>
            <div style="display: flex">
                <span style="width:60%"> ????????? ${boardVO.hit}??? </span>
                <span style="width:30%;text-align: right"> ${boardVO.boardRegDate} </span>
                <span style="width:10%"> <button style="float:right">??????</button>  </span>
            </div>
        </div>
        <hr>
        <div id="playerInfo">
            <infoHeader>
                <img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="50px" style="border-radius:80px">
            </infoHeader>
            <infoHeaderTitle> ${boardVO.memId}</infoHeaderTitle>
            <infoMain> ${boardVO.boardContent}</infoMain>
        </div>
        <hr>

        <div id="reply">
            <div style="display: inline" id="totalReplyCount"> </div>
            <div style="display: inline"> ????????????</div>
            <div>
                <img src="http://localhost:8050/resources/img/default.jpg" class="card-img-middle" width="50px" style="border-radius:80px">
                <input type="text" style="display: inline-block;width: 84%"  class="form-control" id="replyText" name="replyText" placeholder="??????...">
                <button type="button" class="btn btn-info" id="replyInsert">??????</button>
            </div>
            <br><br>
            <div id="replyContent">

            </div>
        </div>
    </div>

    <div id="side" style="margin-left: 20px; width:30%">

    </div>
</div>



</body>
</html>
