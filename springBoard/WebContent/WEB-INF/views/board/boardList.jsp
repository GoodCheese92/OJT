<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <!-- charset=EUC-KR -->
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
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data, textStatus, jqXHR){
					var boardList = data.boardVoList;
					
					// alert("조회결과");
					
					// alert("메세지:"+data.success);
					/* for(var i=0; i<boardList.length; i++){
						console.log("boardVo : " + boardList[i].boardNum);
					} */
					// console.log("boardTypeSet : " + data.boardTypeSet);
					
					tableAlter(boardList);
					totalCntAlter(boardList);
					
					// location.href = "/board/boardList.do?boardTypeSet=" + data.boardTypeSet;
					
					// alert("확인");
				},
				error : function(jqXHR, textStatus, errorThrown){
					alert("실패");
				}
			});
		});
		
		function tableAlter(boardVoList){
			var div = document.querySelector('#table1');
			
			var html = '<table id="boardTable" border = "1">';
			html += '<tr>'
			+ '<td width="80" align="center">'
			+	'Type'
			+ '</td>'
			+ '<td width="40" align="center">'
			+	'No'
			+ '</td>'
			+ '<td width="300" align="center">'
			+	'Title'
			+ '</td>'
		    + '</tr>';
		    for(var i = 0; i<boardVoList.length; i++){
		    	html += '<tr>' + '<td align ="center">' + boardVoList[i].boardTypeName + '</td>';
		    	html += '<td align="center">' + boardVoList[i].boardNum + '</td>';
		    	html += '<td>' + '<a href = "/board/' + boardVoList[i].boardType + '/' + boardVoList[i].boardNum
		    		+ '/boardView.do?pageNo=${pageNo}">' + boardVoList[i].boardTitle + '</a>';
		    	html += '</td>' + '</tr>';
		    }
		    html += '</table>';
		    div.innerHTML = html;
		    console.log("html : " + html);
		} // end of tableAlter()
		
		function totalCntAlter(boardVoList){
			var tr = document.querySelector("#totalCnt");
			
			var html = '<td align="right">';
			html += 'total : ' + boardVoList.length;
			html += '</td>';
			
			tr.innerHTML = html;
			console.log("Cnt html : " + html);
		} // end of totalCntAlter()

	}); // end of ready function

</script>
<body>
<table  align="center">
	<tr id="totalCnt">
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	
	<tr>
		<td>
			<div id="table1">
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
							${list.boardTypeName}
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
			</div>
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