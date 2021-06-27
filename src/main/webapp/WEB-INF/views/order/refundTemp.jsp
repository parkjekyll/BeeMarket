<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<meta charset="UTF-8">
<title>My Bee</title>
</head>
<style type="text/css">
*{margin:0; padding:0;}
body, html{width:100%; height:100%;}
#container{
	width : 1200px !important ;
	max-width: none !important;
	margin: 0 auto !important;
}
#main{float:left; width:80%; height:100%; min-height:100%; background-color: #dcdcdc; display: block;}
#wrapper{
	margin-left:0;
	width: 960px;
 	background-color: #ffffff; 
 	-webkit-border-radius: 5px; 
 	-moz-border-radius: 5px; 
 	border-radius: 5px;    
 	border: 1px solid #e5e5e5;
    padding-left: 70px;
    padding-right: 70px;
    box-sizing: border-box;
    padding-top: 50px;
    padding-bottom: 60px;
    height:95%;
    overflow:scroll;
 }
#alreadyWarning{color:red;}
#key-value_section{height:50px; display: inline-block;}
#key_section{width:100px; height:100%; float:left; padding-top:5px; padding-right:20px;}
#value_section{width:600px; height:100%; float:left;}
#buttonBox{width:100%; text-align: center;}
</style>
<script type="text/javascript">
function updateDate(order_no){
	var order_no=order_no;
	var refund_addCost=document.getElementById("refund_addCost").value;
	
	//AJAX 호출.....
	var xmlhttp = new XMLHttpRequest();
	
	//호출 후 값을 받았을때... 처리 로직....
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
		   // var obj = JSON.parse(xmlhttp.responseText);
			setTimeout(retrieving, 10000, orderNo);
		}
	};
	var con = confirm("환불을 승인하시겠습니까?");
	if(con==true){
	xmlhttp.open("get","./updateRefundAuthDate.do?order_no="+order_no+"&refund_addCost="+refund_addCost , true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send();		
		
	}else{
		return;
	}
}
//상품회수중
function retrieving(order_no){
   var orderNo=order_no;
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
         setTimeout(retrieved, 10000, orderNo);
      }
   };
   xmlhttp.open("get","./refundRetrieveing.do?order_no="+orderNo , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

//상품회수완료
function retrieved(order_no){
   var orderNo=order_no;
   
   //AJAX 호출.....
   var xmlhttp = new XMLHttpRequest();
   
   //호출 후 값을 받았을때... 처리 로직....
   xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
         // var obj = JSON.parse(xmlhttp.responseText);
    	  setTimeout(preparingProduct, 20000, orderNo);
      }
   };
   xmlhttp.open("get","./completeRetrieved.do?order_no="+orderNo , true);
   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   xmlhttp.send();   
}

//환불완료
function successRefund(order_no){
	var orderNo=order_no;
	//AJAX 호출.....
	   var xmlhttp = new XMLHttpRequest();
	   
	   //호출 후 값을 받았을때... 처리 로직....
	   xmlhttp.onreadystatechange = function(){
	      if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	         // var obj = JSON.parse(xmlhttp.responseText);
	 
	      }
	   };
	   xmlhttp.open("get","./successRefund.do?order_no="+orderNo , true);
	   xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	   xmlhttp.send();   
	
}
</script>
<body>
<div id="container">
<jsp:include page="../commons/headerForSeller+head.jsp" flush="true"/>
	<jsp:include page="../commons/sidebar.jsp" flush="true"/>
	<div id="main">
		<input type="hidden" id="seller_no" name="seller_no" value="${sessionSeller.seller_no}">
		<div id="wrapper">
			<h2>환불신청내역</h2>
			<hr>
			<div id="key-value_section">
				<div id="key_section">주문번호</div><!-- 주문번호에 a링크 달아서 해당 오더 조회 가지게 -->
				<div id=value_section><input class="form-control" id="order_no" name="order_no" value="${refundOrder.refundVO.order_no}" readOnly></div>
			</div><br>
			<div id="key-value_section">
				<div id="key_section">구매자ID</div>
				<div id=value_section><input class="form-control" id="customer_id" name="customer_id" value="${refundOrder.customerVO.customer_id}" readOnly></div>
			</div><br>
			<div id="key-value_section">
				<div id="key_section">상품명</div><!-- 주문번호에 a링크 달아서 해당 상품 디테일 가지게 -->
				<div id=value_section><input class="form-control" id="product_name" name="product_name" value="${refundOrder.productVO.product_name}" readOnly></div>
			</div><br>
			<div id="key-value_section">
				<div id="key_section">상품옵션</div>
				<div id=value_section><input class="form-control" id="productdetail_option" name="productdetail_option" value="${refundOrder.productDetailVO.productdetail_option}" readOnly></div>
			</div><br>
			반품사유<br>
			<textarea class="form-control" id="cancel_description" name="cancel_description" style="width:100%; height:300px;" disabled>${refundOrder.refundVO.refund_description}</textarea><br>
			추가 배송비부담비용<br><!-- 고민해보기 -->
			<c:if test="${refundOrder.refundVO.refund_addCost eq 999}" >
			<select class="form-control" id="refund_addCost" name="refund_addCost">
				<option value="0">0</option>
				<option value="5000">5000</option>
			</select><br>
			</c:if>
			<c:if test="${refundOrder.refundVO.refund_addCost eq 0 || refundOrder.refundVO.refund_addCost eq 5000}" >
				<input class="form-control" id="refund_addCost" name="refund_addCost" value="${refundOrder.refundVO.refund_addCost}" readOnly><br>
			</c:if>
			신청일<br>
			<input class="form-control" id="refund_applyDate" name="refund_applyDate" value="<fmt:formatDate value="${refundOrder.refundVO.refund_applyDate}" pattern="yyyy/MM/dd HH:mm:ss"/>" readOnly><br>
			승인날짜<br>
			<input class="form-control" id="refund_authDate" name="refund_authDate" value="<fmt:formatDate value="${refundOrder.refundVO.refund_authDate}" pattern="yyyy/MM/dd HH:mm:ss"/>" readOnly><br><br>
			<div id="buttonBox">
			<c:choose>
			<c:when test="${empty refundOrder.refundVO.refund_authDate}">
			<button class="btn btn-danger" onclick="updateDate(${refundOrder.refundVO.order_no})">승인하기</button>
			<button class="btn btn-primary" onclick="location.href='refundList.do?seller_no=${sessionSeller.seller_no}'">뒤로가기</button>
			</c:when>
			<c:otherwise>
			<button class="btn btn-danger" onclick="updateDate(${refundOrder.refundVO.order_no})" disabled>승인하기</button>
			<button class="btn btn-primary" onclick="location.href='refundList.do?seller_no=${sessionSeller.seller_no}'">뒤로가기</button>
			<br><p id="alreadyWarning">이미 승인하였습니다.</p>
			</c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>
</div>
</body>
</html>