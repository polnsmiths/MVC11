<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<title>판매목록</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>



<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

<!--//////////////////////////////////////////
	function fncGetUserList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		//currentPage의 value값을 가져와서(맨밑에! ""로 설정되어 있음) 클릭한 page를  value값으로 설정해줌 
		document.detailForm.submit();
	}
	////////////////////////////////-->
	
	$("form").attr("method", "POST").attr("action", "/purchase/listSale").submit();

	$(function() {
		$(".ct_list_pop td:nth-child(1)").on("click", function() {
			var prodNo = $(this).children('#prodNo').val();
			var tranNo = $(this).children("#tranNo").val();
			console.log(prodNo);
			console.log(tranNo);
			
			self.location = "/purchase/getPurchase?tranNo="+tranNo+"&prodNo="+prodNo;
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function() {
			var userId = $(this).children('input:hidden').val();
			console.log(userId);
			////////////////////
			//self.location = "/user/getUser?userId="+userId;
			
			$.ajax( 
					{
						url : "/user/json/getUser/"+userId ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);
							
							var displayValue = "<h3>"
														+"아이디 : "+JSONData.userId+"<br/>"
														+"이  름 : "+JSONData.userName+"<br/>"
														+"이메일 : "+JSONData.email+"<br/>"
														+"ROLE : "+JSONData.role+"<br/>"
														+"등록일 : "+JSONData.regDate+"<br/>"
														+"</h3>";
							//Debug...									
							//alert("JSONData들 : "+displayValue);
							//alert(JSON.stringify(JSONData));
							$("h3").remove();
							$( "#"+userId+"" ).html(displayValue);
							//$("#user09" ).html(displayValue);
							
						}
				});
			
			
		});
		
		$(".ct_list_pop td:nth-child(15)").on("click", function() {
			//console.log("안ㄴ녕");
			var tranNo = $(this).children("#tranNo").val(); 
			var tranCode = $(this).children('#tranCode').val(); 
			
			console.log(tranCode);
			console.log(tranNo);
		
			self.location = "/purchase/updateTranCodeByAdmin?currentPage=${resultPage.currentPage}&"
				+"tranNo="+tranNo+"&tranCode="+tranCode;
		}); 
		
		/////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////
		$(".ct_list_pop td:nth-child(1)").css("color", "blue");
		
		$(".ct_list_pop td:nth-child(3)").css("color", "blue");
		$("h7").css("color", "blue");
	
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		//배송하기 색 지정
		$(".ct_list_pop td:nth-child(15)").css("color", "purple");
		
		
	});
	
	
	
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">
<form name="detailForm" action="/purchase/listSale?" method="post">

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         
	                         
	                         	<li><a href="#">회원정보조회</a></li>
	                         
	                         
	                         <li class="divider"></li>
	                         <li><a href="#">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li><a href="#">판매목록조회</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         
	                         
	                         <li><a href="#">최근본상품</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">etc...</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
 	
   	<!-- ////jQuery///////////////////////////////// -->
   	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
   	<script type="text/javascript">
	
		//============= logout Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=admin");
		});
		
		//////////////////////////////////////
		
	 	$( "a:contains('판매목록조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/purchase/listSale?menu=manage");
		});
		
	 	$( "a:contains('판매상품등록')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","../product/addProductView.jsp;");
		});
	 	
	 	$( "a:contains('판매상품관리')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			
	 		$(self.location).attr("href","/product/listProduct?menu=manage");
		});
	 	
	 	$( "a:contains('구매이력조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			
	 		$(self.location).attr("href","/purchase/listPurchase");
		});
	 	
	 	$( "a:contains('상 품 검 색')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			
	 		$(self.location).attr("href","/product/listProduct?menu=search");
		});
		
		
	</script>  
   	<!-- ToolBar End /////////////////////////////////////-->

<!-- ///////////////////////////////////////////////////////////////////// 

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">판매 목록</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>
 ///////////////////////////////////////////////////////////////////// -->
 
 	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">판매 목록</h3>
	       
	    </div>
 
 

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">받는분성함</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="50">상품번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">배송희망일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">배송요구</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송상황</td>
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
<c:set var="i" value="0"/>
<c:forEach var="purchase" items="${purchase}" varStatus="status">
	<c:set var="i" value="${i+1}"/> 
	<tr class="ct_list_pop">
		<td align="center">
		<!-- /////////////////////////////////////
			<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}&prodNo=${purchase.purchaseProd.prodNo}">${i}</a>
		 //////////////////////////////////////////-->
		 ${i}
		 <input type="hidden" id="tranNo" value="${purchase.tranNo}">
		 <input type="hidden" id="prodNo" value="${purchase.purchaseProd.prodNo}">
		</td>
		<td></td>
		<td align="left">	
		<!-- //////////////////////////////////////////
			<a href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a>
		 ////////////////////////////////////////////////////-->
		 	${purchase.buyer.userId}
		 	<input type="hidden" id="userId" value="${purchase.buyer.userId}">
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.purchaseProd.prodNo}</td>
		<td></td>
		<td align="left">${purchase.purchaseProd.prodName}</td>
		<td></td>
		<td align="left">${purchase.dlvyDate}</td>
		<td></td>
		<td align="left">${purchase.dlvyRequest}</td>
		<td></td>
		<td align="left">${state[i-1]}
		<!-- /////////////////////////////////////////////// 
		<a href="/purchase/updateTranCodeByAdmin?currentPage=${resultPage.currentPage}
		&tranCode=${purchase.tranCode}&tranNo=${purchase.tranNo}"> ${delivery[i-1]}</a>
		///////////////////////////////////////////////////-->
		 ${delivery[i-1]}
		 <input type="hidden" id="tranCode" value="${purchase.tranCode}">
		 <input type="hidden" id="tranNo" value="${purchase.tranNo}">
		</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<tr>
		<td id="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	
	</tr>
	
</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <jsp:include page="../common/pageNavigator.jsp"/>	
		
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>