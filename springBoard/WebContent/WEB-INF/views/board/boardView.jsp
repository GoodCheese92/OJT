<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>

<script type="text/javascript">
	$j(document).ready(function(){
		$j("#delete").on("click", function(){
			
			
			var $frm = $j('.boardDelete :input');
			var param = $frm.serialize();
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			$j.ajax({
				url : "board/boardDeleteAction.do",
				dataType : "json",
				type : "post",
				data : param,
				success : function(data, textStatus, jqXHR){
					alert("작성완료");
					
					alert("메세지 : " + data.success);
					
					location.href = "/board/boardList.do";
				},
				error : function(jqXHR, textStatus, errorThrown){
					alert("실패");
				}
				
			});
		});
	});

</script>
<body>
<form class="boardDelete">
	<input type="hidden" name="boardType" value="${board.boardType}">
	<input type="hidden" name="boardNum" value="${board.boardNum}">
</form>
<table align="center">
	<tr>
		<td align="right">
			<input id="update" type="button" value="수정" onclick="location.href='/board/boardUpdate.do?boardType=${board.boardType}&boardNum=${board.boardNum}'">
			<input id="delete" type="button" value="삭제">
		</td>
	</tr>
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>	
	
</body>
</html>