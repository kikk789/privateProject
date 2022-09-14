<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script src="./resources/component/jquery-3.3.1.min.js"></script>
<script src="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="./resources/component/jquery-loading-master/dist/jquery.loading.min.js"></script>
<script src="./resources/component/jqueryPrint/jqueryPrint.js"></script>

<link rel="stylesheet" type="text/css" href="./resources/component/jquery-ui-1.12.1.custom/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="./resources/component/jquery-loading-master/dist/jquery.loading.min.css">
<link rel="stylesheet" type="text/css" href="./resources/css/customCSS.css">

<%--<link rel="stylesheet" type="text/css" href="./resources/bootCSS/bootstrap.css">--%>
<%--<script src="./resources/bootJS/bootstrap.js"></script>--%>
<script src="./resources/js/topNavigationBar.js"></script>
    <%
        String contextPath = request.getContextPath();
    %>
<script>
var contextPath = "<%=contextPath%>";
$(function(){
    let pwdReturnFlag = false;
    let memId;
    $.ajax({
        url:contextPath+"/logimMember",
        success:function(data){
            memId = data;
        }
    })

    var sel_file = [];//다중선택을 위해 배열로 바뀜
    $("#memImg").on("change", addFiles);
    //미리보기
    function addFiles(e){
        //e.target : 파일객체
        //e.target.files : 파일객체 안의 파일들
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
        //파일들을 짤라서 어래이로 만들고

        //f : 파일 객체
        filesArr.forEach(function(f){//이를 포이치로 돌리기
            //미리보기는 이미지만 가능함
            if(!f.type.match("image.*")){
                alert("이미지만 가능합니다.");
                return;
            }

            //파일객체 복사
            sel_file.push(f);
            //파일을 읽어주는 객체 생성
            var reader = new FileReader();
            reader.onload = function(e){//e에 담아서
                //forEach 반복 하면서 img 객체 생성
                var img_html = "<img style='width:50px; height:50px' src=\""+e.target.result+"\"/>";
                //e.target.result 이미지 결과물 경로를 넣어준다
                $("#memImgDiv").append(img_html);
            }
            reader.readAsDataURL(f);//읽어준다면
        });
    }//----------------미리보기 끝-----------------

     //첨부파일의 확장자가 exe, sh, zip, alz 경우 업로드를 제한
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    //최대 5MB까지만 업로드 가능
    var maxSize = 5242880; //5MB
    //확장자, 크기 체크
    function checkExtension(fileName, fileSize){
        if(fileSize >= maxSize){
            alert("파일 사이즈 초과");
            return false;
        }
        if(regex.test(fileName)){
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        //체크 통과
        return true;
    }

    //Upload 버튼 클릭 시 수행
    $("#uploadBtn").on("click",function(e){

    });

    $(document).on("keyup", "#memPwdCheck, #memPwd", function(e){
        if ($("#memPwdCheck").val()=='' || $("#memPwd").val()=='' || $("#memPwd").val()=='undefined' || $("#memPwdCheck").val()=='undefined'){
            $("input[type=password]").removeClass("is-valid")
            $("input[type=password]").removeClass("is-invalid")
            $("div[class=valid-feedback]").attr("style","display:none")
            $("div[class=invalid-feedback]").attr("style","display:none")
            pwdReturnFlag = false;
        }
        else if ($("#memPwd").val() == $("#memPwdCheck").val()){
            $("input[type=password]").removeClass("is-invalid")
            $("input[type=password]").addClass("is-valid")
            $("div[class=valid-feedback]").attr("style","display:block")
            $("div[class=invalid-feedback]").attr("style","display:none")
            pwdReturnFlag = true;
        }else{
            $("input[type=password]").removeClass("is-valid")
            $("input[type=password]").addClass("is-invalid")
            $("div[class=valid-feedback]").attr("style","display:none")
            $("div[class=invalid-feedback]").attr("style","display:true")
            pwdReturnFlag = false;
        }
    })

    $(document).on("click","#profileUpdate", function(){
        //FormData : 가상의 <form> 태그
        //Ajax를 이용하는 파일 업로드는 FormData를 이용
        // var formData = new FormData();

        let reqData={};
        let email = "";
        if(pwdReturnFlag==false){
            alert("비밀번호를 다시 입력하세요")
            return 0;
        }else{
            $("#memName, #memPwd, #emailFirst, #emailSecond, textarea").each(function(){
                let dataId = this['id'];
                let dataValue =  this.value;

                if(dataId === "emailFirst"){
                    email += dataValue +"@";
                }else if(dataId === "emailSecond"){
                    email += dataValue;
                    reqData['email'] = email;
                    // formData.append('email',email);
                }else{
                    reqData[dataId] = dataValue;
                    // formData.append(dataId,dataValue);
                }
            })
            reqData['memId'] = memId;
            console.log("reqData ", reqData);
            // //<input type="file" 요소
            // var inputFile = $("input[name='uploadFile']");
            // console.log("inputFile ", inputFile[0].files);
            // //<input type="file" 요소 내의 이미지들
            // var files = inputFile[0].files;

            // console.log("files : "+ files);//f12 콘솔로 보여줌

            // for(var i=0;i<files.length;i++){
            //     console.log(files[i]);//이미지를찍고
            //     //function checkExtension(fileName, fileSize){
            //     if(!checkExtension(files[i].name, files[i].size)){//파일의 이름과 파일의 크기
            //         return false;
            //         //!ture라면 실패.. 그러면 위로 올라가서 "해당 종류의 파일은 업로드할 수 없습니다." 출력
            //     }
            //     formData.append("uploadFile",files[i]);
            //     //이미지 객체를 uploadFile이라는 이름으로 어팬드해주면 컨트롤러에 들어옴
            // }
            // formData.append("memId",memId);

            // 없어?카드가?또?(upcdt)
            // processData,contentType은 반드시 false여야 전송됨
            // $.ajax({
            //     url:contextPath+'/updateProfile',
            //     processData:false,
            //     contentType:false,
            //     data:formData,//여기에 담겨서 전송하는 것
            //     type:'POST',
            //     success:function(result){//success데이터가 들어오고
            //         console.log("result : " + result);//이를 출력하는것
            //     }
            // });

            $.ajax({
                url: contextPath+"/updateProfile",
                type:"post",
                data:reqData,
                success: function (data) {
                    if (data != null || data !='undefined') {
                        data = data.split("/")[3]
                        alert("수정 성공, 이전페이지로 돌아갑니다.");
                        location.href=(contextPath+ "/"+ data);
                    }
                    else{
                        alert("수정 실패")
                    }
                }
            })
        }
    })
})





</script>
<title>계정설정</title>
</head>
<body style="padding: 150px 150px 150px 150px;overflow-y: scroll; overflow-x: hidden">
<jsp:include page="navigation.jsp" />
<div class="row h-100">
    <div class="col-5 border p-5" style="margin: 0 auto;border-radius: 20px">

        <div class="p-4">
            <h3>'${memberVO.memName}'님, 환영합니다. </h3>
            <h3>계정을 설정해주세요.</h3>
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" >이름</span>
            <input type="text" id="memName" name="memName" class="form-control" placeholder="이름" aria-label="Username" aria-describedby="basic-addon1" value="${memberVO.memName}">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text" >비밀번호</span>
            <input type="password" name="password" class="form-control" placeholder="비밀번호" aria-label="UserPwd" id="memPwd">
            <div class="valid-feedback" display: none>비밀번호가 일치합니다.</div>
            <div class="invalid-feedback" display: none>비밀번호가 일치하지 않습니다</div>
        </div>


        <div class="input-group mb-3">
            <span class="input-group-text">비밀번호 확인</span>
            <input type="password" class="form-control" placeholder="비밀번호 확인" aria-label="UserPwdCheck" id="memPwdCheck">
            <div class="valid-feedback" display: none>비밀번호가 일치합니다.</div>
            <div class="invalid-feedback" display: none>비밀번호가 일치하지 않습니다</div>
        </div>

        <div class="input-group mb-3">
            <input type="file" class="form-control" id="memImg" name="uploadFile" multiple/>
<%--            <label class="input-group-text" for="memImg">프로필 선택</label>--%>
        </div>

        <div class="mb-3" id="memImgDiv">

        </div>


        <div class="input-group mb-3">
            <c:set var="keywordArr" value="${fn:split(memberVO.email, '@')}"/>

            <span class="input-group-text">이메일</span>
            <input type="text" id="emailFirst" name="emailFirst" class="form-control" placeholder="..." aria-label="Username" value="${keywordArr[0]}">
            <span class="input-group-text">@</span>
            <input type="text"id="emailSecond" name="emailSecond" class="form-control" placeholder="..." aria-label="Server" value="${keywordArr[1]}">
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text">하고싶은 말</span>
            <textarea class="form-control" id="wantToSay" name="wantToSay" aria-label="With textarea">${memberVO.wantToSay}</textarea>
        </div>

        <div class="input-group" style="float: right;">
            <button type="button" style="width: 50%;margin: 0 auto" class="btn btn-outline-secondary" id="profileUpdate">수정</button>
        </div>
    </div>
</div>
</body>
</html>
