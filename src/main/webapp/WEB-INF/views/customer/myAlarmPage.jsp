<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트 스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/resources/css/header.css">
<title>myAlarmPage</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}
.container{
	width : 1200px;
	max-width: none !important;
}

a{
	text-decoration: none !important;
	margin: 0 !important; 
	padding: 0 !important;
}

a:hover{
	text-decoration: blink !important;
}

.card{
	border: none;
}

.swal-button {
  
  background-color: #fff58c;
  font-size: 12px;
  border: 1px solid #gold;
}

</style>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	var sessionCustomer = null;
	var containerBox = document.getElementById("maincontainer");
	var myModal = null;
	
	function getSessionCustomerNo(){
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
			if(xmlhttp.readyState==4 && xmlhttp.status == 200){
				var obj = JSON.parse(xmlhttp.responseText);
				
				sessionCustomerNo = obj.customer_no;
			}
		};
		
		xmlhttp.open("get","../customer/getSessionCustomerNo.do" , true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send();
	}
	
	function alarmConfirm(alarm_no){
		
		var alarmNO = alarm_no;

		
		myModal.show();
	}
	

	
	function init(){
		getSessionCustomerNo();
		myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
		
	}
	
	
</script>

</head>
<body onload="init()">

<div class="container">
	<div class="row">
		<jsp:include page="/WEB-INF/views/commons/header.jsp"></jsp:include>
	</div>

	<jsp:include page="/WEB-INF/views/commons/headerForCustomer.jsp"></jsp:include>
	
	<div class="row">
		<!-- 좌측네비바 -->
		<jsp:include page="/WEB-INF/views/commons/headerForCustomer+left.jsp"></jsp:include>
		
		<!-- 여기서부터는 마이페이지 내부의 여러 기능을 한페이지에서 구현 -->
		<div class="col" id="mainContainer">
		
		<!-- 내가 남긴 상품 후기 -->
		<div class="AlarmList">
			<!-- 주문내역 검색(주문상품명으로만 검색) -->
			<div class="row mt-3 mb-3">
				<div class="col-5" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
					제품 알림<br> 
					<span style="color: #fcc92f; font-size: 20px; font-weight: bold; text-align: left;">읽지 않은 ${nonReadAlarm }개의 알람이 있습니다.</span>
				</div>
				<div class="col"></div>
			</div>
			<!-- 내가 남긴 후기리스트 출력파트 table 형식-->
			<div class="row mb-5">
				<table class="table table-sm">
					<colgroup>
						<col style="width:17.6%">
						<col style="width:*">
						<col style="width:12.6%">
						<col style="width:15.3%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr style="text-align: center;">
							<th scope="col">제품명</th>
							<th scope="col">알림내용</th>
							<th scope="col">알림일자</th>
							<th scope="col">읽은일자</th>
							<th scope="col">&nbsp;</th>
						</tr>
					</thead>
					
						<tbody>
						<c:forEach items="${myAlarmData}" var="data">
						<tr>
							<td>${data.alarmVO.product_no}</td>
							<td class="left">
								${data.alarmVO.alarm_comment }</td>
							<td>
								<fmt:formatDate value="${data.alarmVO.alarm_writedate }" pattern="yy년MM월dd일"></fmt:formatDate>
							</td>
							<td>
								<fmt:formatDate value="${data.alarmVO.alarm_readdate }" pattern="yy년MM월dd일"></fmt:formatDate>
							</td>
							<td>
								<button type="button" class="btn w100 btn-sm btn-default" onclick="alarmConfirm(${data.alarmVO.alarm_no})">
									상품으로 이동
								</button>
							</td>
						</tr>
						
						</c:forEach>
					</tbody>
				</table>
		
			</div>
				
				<!-- Modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel" style="color: #5b5b5b; font-size: 25px; font-weight: bold; text-align: left;">
										알람 확인
									</h5>
									<button type="button" class="btn-close"
										onclick="myModal.hide();"></button>
								</div>
								<div class="modal-body">
									<div style="border: 1px solid #fcc92f;">
										제품명
										
										제품으로 이동
									</div>
								</div>
								<div class="modal-footer" id="modalButton">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">확인</button>
								</div>
							</div>
						</div>
					</div>
				
			</div>
		</div>
	<!-- 콘테이너 끝 -->
	
	
</div>

<div class="row" style="height: 100px;"></div>
</div>
<div class="row">
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" 
		integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
		crossorigin="anonymous">
</script>	
</body>
</html>