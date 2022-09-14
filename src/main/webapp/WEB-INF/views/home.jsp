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
	<script src="./resources/js/topNavigationBar.js"></script>
	<script src="./resources/bootJS/bootstrap.js"></script>
	<%
		String contextPath = request.getContextPath();
	%>
	<script>
		var contextPath = "<%=contextPath%>";
		let memId;
		let startPage=1;
		let endPage=8;
		let searchKeywordText="";
		let homeURL = decodeURI(window.location.href);
		$.ajax({
			url:contextPath+"/logimMember",
			success:function(data){
				memId = data;
			}
		})

		if(Number(homeURL.split("&").length) == Number(4)){
			let id = homeURL.split("&")[0].split("=")[1];
			let keyword = homeURL.split("&")[1].split("=")[1];
			let start = homeURL.split("&")[2].split("=")[1];
			let end = homeURL.split("&")[3].split("=")[1];
			memId =id;
			searchKeywordText =keyword;
			startPage =start;
			endPage =end;
		}

		function infinityPage(startPage, endPage, searchKeywordText){
			$.ajax({
				url:contextPath+"/home",
				data:{
					"startPage":startPage,
					"endPage":endPage,
					"searchKeywordText":searchKeywordText,
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
							boardDate= Math.abs(resultmonth) + "월 전"
						}else if (resultdate!=0){
							boardDate= Math.abs(resultdate) + "일 전"
						}else if (resulthours!=0){
							boardDate= Math.abs(resulthours) + "시간 전"
						}else if (resultminutes!=0){
							boardDate= Math.abs(resultminutes) + "분 전"
						}else if (resultSeconds<0){
							boardDate= Math.abs(resultSeconds) + "초 전"
						}

						$("#mainListArea")
								.append($('<div class="col" id="boardList" style="cursor:pointer;">')
										.append($('<div class="card h-100">')
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
				}
			})
		}
		$(document).on("click", "#boardList", function(){
			let boardId = ($(this).find("input[type=hidden]")).attr("id");
			location.href=(contextPath+"/detailListMain?boardId=" + boardId +"&startPage="+startPage+"&endPage="+endPage);
		})

		$(window).scroll(function(){
			if (window.outerHeight + $(window).scrollTop() -100 > $(document).height()) {
				console.log("그리기!!")
				startPage = startPage+8;
				endPage= endPage+8;

				infinityPage(startPage, endPage,searchKeywordText)
			}
		});

		//최초로 1번 리스트 띄울 때 사용
		infinityPage(startPage,endPage,searchKeywordText);

	</script>
	<title>Youtube</title>
</head>
<body style="padding: 150px 150px 150px 300px;overflow-y: scroll">
<jsp:include page="navigation.jsp" />

<div class="row row-cols-1 row-cols-md-4 g-4" id="mainListArea">

</div>

</body>
</html>
