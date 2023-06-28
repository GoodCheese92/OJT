<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <!-- charset=EUC-KR -->
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>MBTI</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
	<script type="text/javascript">
		$j(document).ready(function(){
			$j("button[name='pageNo']").click(function(){
				// console.log(this.value);
				
				var pageNo = this.value;
				
				console.log(pageNo);
				
				$j.ajax({
					
					url : "/mbti/mbtiPageAction.do",
					data : {pageNo : pageNo},
					dataType : "json",
					type : "GET",
					success : function(data, textStatus, jqXHR){
						var mbtiList = data.mbtiList;
						for(var i=0; i<mbtiList.length; i++){
							console.log(mbtiList[i].mbtiComment);
						} // end of for
						
						tableAlter(mbtiList)
							
						
						
					},
					error : function(textStatus, jqXHR, errorThrown){
						alert("실패");
					}
				});
				
				function tableAlter(mbtiList){
					var div = document.querySeletor("#tableAlter");
					for(var i=0; i<mbtiList.length; i++){
						
					}
				}
				
				
			});
			
		});
	</script>

<body>
	<div class="col-3"></div>
	<div class="row justify-content-center">
		<div class="col-6">
		<table class="table table-borderless caption-top">
			<caption class="fw-bold text-center fs-3">MBTI 성격 검사</caption>
			<div id="tableAlter">
			<c:forEach items="${mbtiList}" var="list">
			<tr class="border-top border-dark">
				<th colspan="9" class="text-center fs-4">${list.mbtiComment}</th>
			</tr>
			<tr class="border-bottom border-dark">
				<td class="text-end fw-bold fs-5 text-success">
					<label class="form-check-label">동의</label>
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:24px; height:24px;" value="${list.mbtiType}_3">
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:21px; height:21px;" value="${list.mbtiType}_2">
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:18px; height:18px;" value="${list.mbtiType}_1">
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:15px; height:15px;" value="${list.mbtiType}_0">
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:18px; height:18px;" value="${list.mbtiType}_1">
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:21px; height:21px;" value="${list.mbtiType}_2">
				</td>
				<td class="text-center">
					<input type="radio" name="point" style="width:24px; height:24px;" value="${list.mbtiType}_3">
				</td>
				<td class="text-start fw-bold fs-5 text-danger">
					<label class="form-check-label">비동의</label>
				</td>
			</tr>
			</c:forEach>
			</div>	
			<tr>
				<td colspan="9" class="text-center">
					<button class="btn btn-secondary" name="pageNo" value="1">1</button>
					<button class="btn btn-secondary" name="pageNo" value="2">2</button>
					<button class="btn btn-secondary" name="pageNo" value="3">3</button>
					<button class="btn btn-secondary" name="pageNo" value="4">4</button>
				</td>
			</tr>
		</table>
		</div>
	</div>
	<div class="col-3"></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>