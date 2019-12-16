<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html>
<html>
<head>
<title>��ǰ �����ȸ</title>

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


	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	<!--////////////////////////////////////
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetUserList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
 	  	document.detailForm.submit();		
	}
	//////////////////////////////-->
	
	function fncGetUserList(currentPage) {
		
		$("#currentPage").val(currentPage)
		//$("menu").val(${menu}) 
		//$("input:hidden[name='menu']").val(${menu}); //hidden���δ� ��� ������ �𸣰ڴ�..
		//$("form").attr("href","/product/listProduct?menu=${menu}");
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${menu}").submit();
	}
	
	$(function() {
		$("td.ct_btn01:contains('�˻�')").on("click", function() {
			fncGetUserList(1);
		});
		
	  	$(".ct_list_pop td:nth-child(3)").on("click", function() {
 	 		//alert( $(this).text().trim());
 	 		var prodNo = $(this).children('input:hidden').val();
 	 		console.log("prodNo:"+prodNo);
 	 		
			self.location = "${page }prodNo="+prodNo;
		}); 
		
/* 	       $(".ct_list_pop td:nth-child(3)").on("click", function() {
	       		//alert(  $( this ).text().trim()  );
	       		self.location = "${page}prodNo="+$(this).text().trim();
		   }); */

	});
	
	////////////////////////////////////////////////////////////////
	//	��ũ�� ����¡
var page = 1;

 $(function() {
		$(window).data('ajaxready', true).scroll(function() {
			var maxHeight = $(document).height();
			var currentScroll = $(window).scrollTop() + $(window).height();
			var searchCondition = $("select[name='searchCondition']").val();
			var searchKeyword = $("input[name='searchKeyword']").val();
			var listing = $("input[name='listing']").val();
			
			if($(window).data('ajaxready') == false) return;
			if (maxHeight <= currentScroll) {
			if (page <= ${resultPage.maxPage}) {
				$(window).data('ajaxready', false);
				page++;
				console.log('page : ' + page);
					
				$.ajax({
					url : "/product/json/listProduct",
					method : "POST",
					dataType : "json",
					data : JSON.stringify({
						searchCondition : searchCondition,
						searchKeyword : searchKeyword,
						listing : listing,
						currentPage : page
					}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success: function(data) {
						for (var i = 0; i < data.list.length; i++) {
							console.log(data.list[i].prodName);
							var addData ="<div class='col-sm-6 col-md-4'>" 
										+"<div class='thumbnail'>"
										+"<img src='../images/uploadFiles/"+data.list[i].fileNameList[0]+"' style='width:250px; height:250px'/>"
										+"<div class='caption'>"
										+"<h3>"+ data.list[i].prodName +"</h3>"
										+"<p>"+ data.list[i].price +"��</p>"
										+"<p><a href='#' class='btn btn-primary' role='button'>������</a> "
										+"<button name='ajaxButton' type='button' class='btn btn-primary' data-toggle='modal' data-target='.bs-example-modal-sm'>��ٱ��Ͽ� ���</button></p>"
										+"<div id='hiddenProdNo' class='hiddenInfo'>"+data.list[i].prodNo+"</div>"
										+"</div>"
										+"</div>"
										+"</div>";
								
							$(addData).appendTo("#loadList");
						}
						prodInfo();
						$(window).data('ajaxready', true);
					}
				});
			}
			}
		})
	})
	
	/////////////////////////////////////////////////////////////////////
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<!-- ${page} -->	
	

<div style="width:98%; margin-left:10px;">
		
<!--/////////////////////////// 
<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">
 //////////////////////////-->
 <form name="detailForm">



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
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  ȸ������ DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >ȸ������</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">����������ȸ</a></li>
	                         
	                         
	                         	<li><a href="#">ȸ��������ȸ</a></li>
	                         
	                         
	                         <li class="divider"></li>
	                         <li><a href="#">etc...</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                         <li><a href="#">�ǸŸ����ȸ</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li>
	                         
	                         
	                         
	                         <li><a href="#">�ֱٺ���ǰ</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">etc...</a></li>
	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">�α׾ƿ�</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
 	
   	<!-- ////jQuery///////////////////////////////// -->
   	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
   	<script type="text/javascript">
	
		//============= logout Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= ȸ��������ȸ Event  ó�� =============	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  ����������ȸȸ Event  ó�� =============	
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=admin");
		});
		
		//////////////////////////////////////
		
	 	$( "a:contains('�ǸŸ����ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/purchase/listSale?menu=manage");
		});
		
	 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","../product/addProductView.jsp;");
		});
	 	
	 	$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			
	 		$(self.location).attr("href","/product/listProduct?menu=manage");
		});
	 	
	 	$( "a:contains('�����̷���ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			
	 		$(self.location).attr("href","/purchase/listPurchase");
		});
	 	
	 	$( "a:contains('�� ǰ �� ��')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			
	 		$(self.location).attr("href","/product/listProduct?menu=search");
		});
		
		
	</script>  
   	<!-- ToolBar End /////////////////////////////////////-->	


<!--//////////////////////////////////////////////////////////////////////
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					 ${title}
					 
					 <%-- ��Ʈ�ѿ��� admin���� search���� �����ְ� ����δ� ������ ����! -%>
				<%-- <% if (  menu.equals("search")) { %>
					     ��ǰ ��� ��ȸ
					 <% }else{ %>
					     ��ǰ ����
					     <% } %>   --%>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>
///////////////////////////////////////////////////////////////////////-->

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">${title}</h3>
	       
	    </div>



<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			    <%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
			    
				<option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>��ǰ��ȣ</option>
				<option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>��ǰ��</option>
				<option value="2" <%= (searchCondition.equals("2") ? "selected" : "")%>>��ǰ����</option>
				        /////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option> 
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ?  "selected"  : "" }>��ǰ����</option>
				
				</select>
			<%--<input 	type="text" name="searchKeyword" value="<%= search.getSearchKeyword() %>"  class="ct_input_g" 
							style="width:200px; height:20px" > --%>
			     <input type="text" name="searchKeyword"
			               value="${! empty search.searchKeyword ? search.searchKeyword : "" }"
			               class="ct_input_g" style="width:200px; height:20px">
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<%--  a href="javascript:fncGetUserList('1');"  --%>
						<!--[jQuery ����]]]////////////////////// 
						<a href="javascript:fncGetUserList('1') ">�˻�</a>
						 ////////////////////////////-->
						 �˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
<c:if test="${title == '��ǰ����'}">
	<tr>
		<td colspan="11" >
		 <%-- ��ü  <%= resultPage.getTotalCount() %> �Ǽ�,	���� <%= resultPage.getCurrentPage() %> ������--%>
		  ��ü ${resultPage.totalCount }�Ǽ�, ���� ${resultPage.currentPage }������
		</td>
	</tr>
	<tr>
	    <td class="ct_list_b" width="100" height="200">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150" height="200">��ǰ��<br>
		<h7 >(id click:������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="130" height="200">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150" height="200">�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="50" height="200">�������</td>	
		<td class="ct_line02"></td> 
		<td class="ct_list_b" width="250" height="200">��ǰ����</td>
			
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	</c:if>
	<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
	<%
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>
		<td align="left">
		<% if(menu.equals("manage")) {%>
			<a href="/getProduct.do?prodNo=<%=vo.getProdNo() %>&menu=<%= request.getParameter("menu") %>">
			      <%=vo.getProdName() %></a>
	    <%}else{ %>
	         <a href="/updateProductView.do?prodNo=<%=vo.getProdNo() %>&menu=<%= request.getParameter("menu") %>">
			      <%=vo.getProdName() %></a>
	    <% } %>
	    <input type="hidden" name="menu" value="<%= request.getParameter("menu") %>"/>
	    
		</td>
		<td></td>
		<td align="left"><%= vo.getPrice() %></td>
		<td></td>
		<td align="left"><%= vo.getRegDate() %>	</td>
		<td></td>
		<td align="left"> �Ǹ��� </td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
	/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
	
	
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////// -->
	
	<c:set var="i" value="0"/>
	<c:forEach var="product" items="${list }">
	   <c:set var="i" value="${i+1 }" />

<!-- ////////////////////////////////// -->
<c:if test="${title == '��ǰ �����ȸ'}">

  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">

      		<c:forEach var="k" items="${product.fileNameList}">
				<img src = "/images/uploadFiles/${k}" width="250" height="200"/>
			</c:forEach>
      <div class="caption">
        <h3>${product.prodName}</h3>
        <p>����: ${product.price}��</p>
        <p>�����: ${product.regDate}</p>
        <h4 >�Ǹ���</h4>
        <p><a href="/purchase/addPurchaseView?prodNo=${product.prodNo }" class="btn btn-primary" role="button">����</a>
        	 <a href="/product/getProduct?prodNo=${product.prodNo }" class="btn btn-default" role="button">�󼼺���</a></p>
      </div>
    </div>
  </div>
</div>
</c:if>
<!-- ////////////////////////////////////////// -->

<c:if test="${title == '��ǰ����'}">
	   <tr class="ct_list_pop">
	      <td align="center">${ i }</td>
	      <td></td>
	      <td align="left">

	       ${product.prodName}
	       <input type="hidden" id="prodNo" value="${product.prodNo}" />
<!-- 	       <script>
	       
	       $(".ct_list_pop td:nth-child(3)").on("click", function() {
	       		//alert(  $( this ).text().trim() );
	       		self.location = "${page}prodNo=${product.prodNo}";
		   });
	       </script> -->
	      </td>
	      <td></td>
	      <td align="left">${product.price}</td>
		  <td></td>
		  <td align="left">${product.regDate} 	  </td>
		  <td></td>
		  <td align="left">�Ǹ���</td>
		   <td></td>
		  <td align="left">
		  	<c:forEach var="k" items="${product.fileNameList}">
				<img src = "/images/uploadFiles/${k}" width="250" height="200"/>
			</c:forEach>
		  </td>			
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:if>
</c:forEach>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">

		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%-- if( int i =0; i<currentPage; i++){ 
		         <a href="/listProduct.do?page=<%=i %>&menu=manage">i</a>  --%>
        <%--} --%>
		<jsp:include page="../common/pageNavigator.jsp"/>	
        
       
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>
</div>

</body>
</html>