<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/join.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function testId() {
		//유효성 검사...
		var idBox = document.getElementById("inputId");
		var idReg = /^[a-z]+[a-z0-9]{3,19}$/g;		
		var idAlert = document.getElementById("idAlert");
		if(!idReg.test(idBox.value)){
			idAlert.setAttribute("style","color : red;");
			idAlert.innerText = "아이디는 영문자로 시작하는 4~20자 영문자 또는 숫자이어야 합니다.";
			idBox.focus();
			return;
		}else{
			idAlert.innerText = "";
			var confirmedId = false;
			var inputId = idBox.value;
			//AJAX 호출.....
			var xmlhttp = new XMLHttpRequest();
			
			//호출 후 값을 받았을때... 처리 로직....
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
					var obj = JSON.parse(xmlhttp.responseText);
					//DOM 컨트롤.... 응용 많이 해야됨...
					if(obj.existId == true){
						idAlert.style.color = "red";
						idAlert.innerText = "존재하는 ID 입니다.";
						confirmedId = false;
					}else{
						idAlert.style.color = "green";
						idAlert.innerText = "사용가능한 ID 입니다.";
						confirmedId = true;
					}	
				}
			};
			
			xmlhttp.open("post","../customer/existId.do", true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xmlhttp.send("customer_id="+inputId); //post방식을때는 send에 파라미터를 전달한다.	
		}
	}
	
	function testpw() {
		var pwBox = document.getElementById("inputPw");
		var pwAlert = document.getElementById("pwAlert");
		if(pwBox.value == ""){
			pwAlert.setAttribute("style","color : red;");
			pwAlert.innerText = "비밀번호를 입력해 주세요.";
			pwBox.focus();
		}else{
			pwAlert.innerText = "";
		}
	}
	
	function testpwc() {
		var pwBox = document.getElementById("inputPw");
		var inputConfirmPw = document.getElementById("inputConfirmPw");
		var pwcAlert = document.getElementById("pwcAlert");
		if(inputConfirmPw.value != pwBox.value){
			pwcAlert.setAttribute("style","color : red;");
			pwcAlert.innerText = "비밀번호가 일치하지 않습니다.";
			pwBox.value = "";
			inputConfirmPw.value = "";
			pwBox.focus();
			
		}else {
			pwcAlert.innerText = "";
		}
		return;
	}	
	
	function testName() { 
		var nameBox = document.getElementById("inputName");
		var nameAlert = document.getElementById("nameAlert");
		if(nameBox.value == ""){
			nameAlert.setAttribute("style","color : red;");
			nameAlert.innerText = "이름을 입력해 주세요.";
			nameBox.focus();
			return;
		}else {
			nameAlert.innerText = "";
		}
	}
	
	function testAddNum() {
		var addressNumBox = document.getElementById("inputAddressNumber");
		var addNumAlert = document.getElementById("addNumAlert");
		if(addressNumBox.value == ""){
			addNumAlert.setAttribute("style","color : red;");
			addNumAlert.innerText = "지번을 입력해 주세요.";
			addressNumBox.focus();
			return;
		}else {
			addressNumBox.innerText = "";
		}
	}
	
	function testAdd() {
		var addressBox = document.getElementById("inputAddress");
		var addAlert = document.getElementById("addAlert");
		if(addressBox.value == ""){
			addAlert.setAttribute("style","color : red;");
			addAlert.innerText = "주소를 입력해 주세요.";
			addressBox.focus();
			return;
		}else {
			addressBox.innerText = "";
		}
	}
	
	function testPhone() {
		var phoneBox = document.getElementById("inputPhone");
		var phoneAlert = document.getElementById("phoneAlert");
		if(phoneBox.value == ""){
			phoneAlert.setAttribute("style","color : red;");
			phoneAlert.innerText = "휴대폰번호를 입력해 주세요.";
			phoneBox.focus();
			return;
		}else {
			phoneAlert.innerText = "";
		}
	}
	
	function testEmail() {
		var emailBox = document.getElementById("inputEmail");
		var emailAlert = document.getElementById("emailAlert");
		if(emailBox.value == ""){
			emailAlert.setAttribute("style","color : red;");
			emailAlert.innerText = "이메일을 입력해 주세요.";
			emailBox.focus();
			return;
		}else {
			emailAlert.innerText = "";
		}
	}
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('inputAddressNumber').value = data.zonecode;
               document.getElementById('inputAddress').value = roadAddr+" "+data.jibunAddress;
            }
        }).open();
    }
		
	function formSubmit(){
		var form1 = document.getElementById("formBox");
		testId();
		testpw();
		testpwc();
		testName();
		testAdd();
		testPhone();
		testEmail();
		form1.submit();
	}
</script>
<style type="text/css">
*{
	margin: 0;
	padding: 0;
	border: none;
	clear: both;
}

body{
	font-family: "맑은 고딕", "돋움";
	font-size: 15px;
	color: #444444;
}
input{
	height: auto; /* 높이 초기화 */
	line-height: auto; /* line-height 초기화 */
	outline: none;
	padding-left: 10px;
}
#wrap{
	height: auto;
	width: 460px;
	margin: 0 auto;
}
.Logo_area{
	margin-top: 100px;
	margin-bottom: 100px;
	text-align: center;
}
.input_area{
	display: block;
	height: auto;
	width: 460px;	
	padding-bottom: 100px;
}
.formStyle{
	font-size: 15px;
	font-weight: bold;
	display: block;
	margin-bottom: 8px;
}
.gender{
	display: block;
	padding-left: 10px;
	padding-right: 50px;
	font-size: 15px;
	margin-bottom: 30px;
}
.btn_login{
	background-color: #fccd11;
	font-size: 16px;
	font-weight: bold;
	color: #ffffff;
	width: 100%;
	height: 45px;
	line-height: 40px; 
	text-align: center;
	width: 460px;
	border: none;
	padding: 0;
	border-radius: 5px;
	outline: none;
	cursor: pointer;
}
.btn_add{
	background-color: #fccd11;
	font-size: 16px;
	font-weight: bold;
	color: #ffffff;
	width: 100px;
	height: 37px;
	line-height: 35px; 
	text-align: center;
	border: none;
	padding: 0px;
	margin: 0px; 
	border-radius: 5px;
	outline: none;
	cursor: pointer;
}
.textBox{
	width: 448px;
	height: 35px;
	margin-bottom: 30px;
	border: 1px solid lightgray;
	border-radius: 5px;
	cursor: pointer;
}
.addressNum{
	width: 100px;
	/* float: left !important; */
	margin-right: 10px !important;
	height: 35px;
	margin-bottom: 15px;
	border: 1px solid lightgray;
	border-radius: 5px;
	cursor: pointer;
}
.address{
	/* float: left !important; */
	width: 448px;
	height: 35px;
	margin-bottom: 30px;
	border: 1px solid lightgray;
	border-radius: 5px;
	cursor: pointer;
}
.dateBox{
	padding-right:10px;
	width: 440px;
	height: 35px;
	margin-bottom: 30px;
	border: 1px solid lightgray;
	border-radius: 5px;
	cursor: pointer;
}
</style>
</head>
<body>
	
<div id="wrap">
	
	<div class="Logo_area">
		<a href="../product/productMainPage.do" style="font-size: 50px; font-weight: bold; color: #fcc92f; text-decoration: none;">BEE MARKET</a>
	</div>
	
	<div class="input_area">
		<form id="formBox" action="./joinCustomerProcess.do" method="post">
			
			<span class="formStyle">아이디</span>
			<input class="textBox" id ="inputId" type="text" name="customer_id" onblur="testId()">
			<div id="idAlert"></div>
			
			<span class="formStyle">비밀번호</span>
			<input class="textBox" id ="inputPw" type="password" name="customer_pw" onblur="testpw()">
			<div id="pwAlert"></div>
			
			<span class="formStyle">비밀번호 확인</span> 
			<input class="textBox" id="inputConfirmPw" type="password" onblur="testpwc()">
			<div id="pwcAlert"></div>
			
			<span class="formStyle">이름</span>
			<input class="textBox" id="inputName" type="text" name="customer_name" onblur="testName()">
			<div id="nameAlert"></div>
			
			<span class="formStyle">생일</span>
			<input class="dateBox" type="date" name="customer_birth">
			
			<span class="formStyle">성별</span>
			<span class="gender">
			<input type="radio" name="customer_gender" value="M" checked>&nbsp;&nbsp;남
			<input type="radio" name="customer_gender" value="F">&nbsp;&nbsp;여
			</span>
			
			<span class="formStyle">주소</span>
			<div>
				<input class="addressNum" id="inputAddressNumber" type="text" name="address_number" onblur="testAddNum()">
				<button type="button" class="btn_add" onclick="execDaumPostcode()">주소찾기</button>
				<input class="address" id="inputAddress" type="text" name="address_location" onblur="testAdd()">
			</div>
			<div id="addNumAlert"></div>
			<div id="addAlert"></div>
			
			<span class="formStyle">번호</span>
			<input class="textBox" id="inputPhone" class="textBox" type="text" name="customer_phone" onblur="testPhone()">
			<div id="phoneAlert"></div>
			
			<span class="formStyle">이메일</span>
			<input class="textBox" id="inputEmail" class="textBox" type="text" name="customer_email" onblur="testEmail()">
			<div id="emailAlert"></div>
			
			<input class="btn_login" type="button" value="회원가입" onclick="formSubmit()">
			
		</form>
	</div>
	
</div>
	
</body>
</html>