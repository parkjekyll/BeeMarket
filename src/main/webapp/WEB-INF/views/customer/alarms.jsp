<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<input type="hidden" id="customer_no" value="${ sessionCustomer.customer_no }">
<div id="alarm"></div>

<script type="text/javascript">
	
	var customer_no = document.getElementById("customer_no").value;
	var alarm = document.getElementById("alarm");
	var interval = null;
	
	function sendAlarm() {
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	
			var obj = JSON.parse(xmlhttp.responseText);
			var confirm = document.getElementById("alarmView");
			
			
				if (obj.alarmNum != 0 && confirm == null) {
				 
					var alarmInnerDiv = document.createElement("div");
					alarmInnerDiv.setAttribute("id","alarmView");
					alarm.appendChild(alarmInnerDiv);
					
					var row = document.createElement("div");
					row.setAttribute("class","row");
					alarmInnerDiv.appendChild(row);
					
					var col = document.createElement("div");
					col.setAttribute("class","col");
					row.appendChild(col);
					
					var innerrow1 = document.createElement("div");
					innerrow1.setAttribute("class","row");
					col.appendChild(innerrow1);
					
					var innercol1 = document.createElement("div");
					innercol1.setAttribute("class","col");
					innercol1.setAttribute("style","font-weight: bold;");
					innercol1.innerText = "알림";
					innerrow1.appendChild(innercol1);
					
					var innercol2 = document.createElement("div");
					innercol2.setAttribute("class","col");
					innercol2.setAttribute("style","text-align:right; cursor:pointer;");
					innercol2.setAttribute("onclick","closeAlarm()");
					innercol2.innerText = "x";
					innerrow1.appendChild(innercol2);
					
					
					var innerrow2 = document.createElement("div");
					innerrow2.setAttribute("class","row mt-2");
					col.appendChild(innerrow2);
					
					var innercol3 = document.createElement("div");
					innercol3.setAttribute("class","col");
					innercol3.setAttribute("style","font-size:14px;");
					innercol3.innerText = "확인하지 않은 "+obj.alarmNum+"개의 알림이 있습니다.";
					innerrow2.appendChild(innercol3);
					
					var innerrow3 = document.createElement("div");
					innerrow3.setAttribute("class","row mt-2");
					col.appendChild(innerrow3);
					
					var innercol4 = document.createElement("div");
					innercol4.setAttribute("style","text-align:right;");
					innercol4.setAttribute("class","col");
					innerrow3.appendChild(innercol4);
					
					var innercol5 = document.createElement("button");
					innercol5.setAttribute("style","font-size:12px; padding: 3px 7px; text-align:center; cursor:pointer; background-color:#fccc0c; border-radius:3px;");
					innercol5.setAttribute("onclick","confirmAlarm();");
					innercol5.innerText = "확인";
					innercol4.appendChild(innercol5);
					
				 
				}
			    
			}
		};
		
		xmlhttp.open("post","../customer/alertAlarm.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("customer_no="+customer_no);
			
	}
	
	function initInteval(){
		interval = setInterval(sendAlarm, 1000);
	}
	
	if (${!empty sessionCustomer} == true){
		window.addEventListener('DOMContentLoaded', initInteval);
	}
	
	function closeAlarm() {
			
		if (alarm.innerHTML != "") {
			
			alarm.innerHTML = "";
			clearInterval(interval);
			
		}
			
	}
	
	function confirmAlarm() {
		
		//AJAX 호출.....
		var xmlhttp = new XMLHttpRequest();
		
		//호출 후 값을 받았을때... 처리 로직....
		xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	
			// var obj = JSON.parse(xmlhttp.responseText);
			alert("업데이트 성공");
						
			alarm.innerHTML = "";
			clearInterval(interval);
			    
			}
		};
		
		xmlhttp.open("post","../customer/confirmAlarm.do", true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("customer_no="+customer_no);
		
	}
</script>
