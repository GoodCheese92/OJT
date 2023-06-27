<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		// 전체 체크박스 클릭
		$j("#checkAll").click(function(){
			if($j("#checkAll").prop("checked")){
				$j(".check1").prop("checked", true);
			} else{
				$j(".check1").prop("checked", false);
			}
		});
		
		// 하나의 체크박스 해제 시 전체 체크박스 해제
		$j(".check1").click(function(){
			if($j("input[name='boardType']:checked").length == 4){
				$j("#checkAll").prop("checked", true);
			} else{
				$j("#checkAll").prop("checked", false);
			}
		});
		
		$j("#search").click(function(){
			var boardTypeArray = new Array();
			// var $fam = $j('.searchBoardType :input');
			// var param = $fam.serialize();
			
			$j("input:checkbox[name=boardType]:checked").each(function(){
				boardTypeArray.push($j(this).val());
			});
			
			$j.ajax({
				url : "/board/boardSearchAction.do",
				data : {boardType : boardTypeArray},
				dataType : "json",
				type : "get",
				success : function(data, textStatus, jqXHR){
					var boardList = data.boardVoList;
					
					alert("조회결과");
					
					alert("메세지:"+data.success);
					for(var i=0; i<boardList.length; i++){
						console.log("boardVo : " + boardList[i].boardNum);
					}
					console.log("boardTypeSet : " + data.boardTypeSet);
					
										
					
					// location.href = "/board/boardList.do?boardTypeSet=" + data.boardTypeSet;
					
					// alert("확인");
				},
				error : function(jqXHR, textStatus, errorThrown){
					alert("실패");
				}
			});
		});
		

	}); // end of ready function

</script>
<body>
<table  align="center">
	<tr>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							<%-- <c:set var="boardType1" value="${list.boardType}"/> --%>
							<c:choose>
								<c:when test="${list.boardType eq 'a01'}">일반</c:when>
								<c:when test="${list.boardType eq 'a02'}">Q&A</c:when>
								<c:when test="${list.boardType eq 'a03'}">익명</c:when>
								<c:when test="${list.boardType eq 'a04'}">자유</c:when>
							</c:choose>
						</td>
						<td align="center">
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr>
		<td align="left">
		<form class="searchBoardType">
			<input type="checkbox" class="check1" id="checkAll">전체
			<input type="checkbox" name="boardType" class="check1" value="a01">일반
			<input type="checkbox" name="boardType" class="check1" value="a02">Q&amp;A
			<input type="checkbox" name="boardType" class="check1" value="a03">익명
			<input type="checkbox" name="boardType" class="check1" value="a04">자유
			<input type="button" id="search" value="조회">
		</form>
		</td>
	</tr>
</table>	
</body>
</html>