<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="sellListR.jsp">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>HS STATIONERY</title>

	<link href="${context}/css/sass/jumbotronimg.css" rel="stylesheet">
	<link href="${context}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${context}/css/bootstrap-theme.css" rel="stylesheet">
	<link href="${context}/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="${context}/css/plugins/dataTables.bootstrap.css" rel="stylesheet">

    <link href="${context}/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${context}/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<script src="${context}/js/jquery-1.9.1.js"></script>
	<script src="${context}/js/bootstrap.min.js"></script>

    <script src="${context}/js/plugins/metisMenu/metisMenu.min.js"></script>

    <script src="${context}/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="${context}/js/plugins/dataTables/dataTables.bootstrap.js"></script>

    <script src="${context}/js/sb-admin-2.js"></script>

    <script>
	var existFolder = '';
	var imageFolder = '';
	var path = '';

    $(document).ready(function() {
//         $('#dataTables-example').dataTable();

    });

    function fn_eval(self, resumePassYn, examNo){
   		$.ajax({
   			url:"${context}/work/applicant/updateEvalForResume.do?resumePassYn=" + resumePassYn + "&examNo=" + examNo,
   			success:function(result){
   				result = result.replace(/"/gi, "");
   				self.parent().next().children().html(result);
   			}
   		});
    }

    function fn_selEval(resumePassYn){
		var checked = $("input[name='chkBox']:checked");
		var checkedCnt = $("input[name='chkBox']:checked").length;

		var examNo = "";

		for(var i = 0; i < checkedCnt; i++){
			examNo = checked.eq(i).parent().parent().children("td").eq(3).html();
			$.ajax({
	   			url:"${context}/work/applicant/updateEvalForResume.do?resumePassYn=" + resumePassYn + "&examNo=" + examNo,
	   			async: false,
	   			success:function(result){
	   				result = result.replace(/"/gi, "");
	   				checked.eq(i).parent().parent().children("td").eq(10).html(result);
	   			}
	   		});
		}
    }

    function fn_resumeDetail(self){
    	var examNo = self.parent().parent().children("td").eq(3).html();

    	location.href = "${context}/work/applicant/retrieveResumeDetail.do?examNo=" + examNo;
    }

    function fn_save(){
    	var examNo = '${dsSellList[0].examNo}';

		if(confirm("??????????????? ?????????????????????????")){
			location.href = "${context}/work/incruit/updateIStatusForResume.do?examNo=" + examNo;
		}
    }

    function fn_finalBuy(paramSellCode, paramSellCount, paramProductCode){
		if(confirm("?????????????????????????")){
			location.href = "${context}/work/sell/updateFinalBuy.do?sellCode=" + paramSellCode + "&sellCount=" + paramSellCount + "&productCode=" + paramProductCode;
		}
    }
    </script>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>
	<div id="jumbotron" class="container">
		<div class="jumbotron jumbotron-info">
			<h1><strong>????????????</strong>&nbsp;<i class="fa fa-credit-card fa-1x"></i></h1>
			<p>?????? ????????? ??????????????????</p>
		</div>

		<div class="row">
			<div class="col-md-12">
			    <div class="panel panel-default">
			        <!-- /.panel-heading -->
			        <div class="panel-body">
			            <div class="table-responsive">
			                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
			                    <thead>
			                        <tr>
			                        	<th style="text-align: center; vertical-align: middle; width: 30px;">??????????????????</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;">???????????????</th>
			                            <th style="text-align: center; vertical-align: middle; width: 80px;">????????????</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;">????????????</th>
			                            <th style="text-align: center; vertical-align: middle; width: 50px;">????????????</th>
			                            <th style="text-align: center; vertical-align: middle; width: 30px;">????????????</th>
			                            <th style="text-align: center; vertical-align: middle; width: 20px;">??????</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                    	<c:forEach items="${dsSellList}" var="dsSellList" varStatus="sellIdx">
			                         <tr>
			                         	<td style="text-align: center; vertical-align: middle;">${dsSellList.SELL_CODE}</td>
			                            <td style="text-align: center; vertical-align: middle;">
										<img name="image" width="110px" height="110px" src="${context}/binderImg/${dsSellList.PRODUCT_IMAGE}" class="img-thumbnail">
											<script type="text/javascript">
											 	var productCategoryCd = '${dsSellList.PRODUCT_CATEGORY_CD}';

											 	if(productCategoryCd == 'O'){
													imageFolder = "officeImg";
												}else if(productCategoryCd == 'P'){
													imageFolder = "penImg";
												}else if(productCategoryCd == 'S'){
													imageFolder = "storageImg";
												}else if(productCategoryCd == 'D'){
													imageFolder = "designImg";
												}else if(productCategoryCd == 'B'){
													imageFolder = "binderImg";
												}
												path = $("img[name='image']").eq('${dsProductIdx.index}').attr("src");

												existFolder = path.split("/")[2];
												$("img[name='image']").eq('${sellIdx.index}').attr("src", path.replace(existFolder, imageFolder));
											</script>
			                            </td>
			                            <td style="text-align: center; vertical-align: middle;">${dsSellList.PRODUCT_NAME}</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsSellList.PRODUCT_UNIT_PRICE}???</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsSellList.SELL_COUNT}</td>
			                            <td style="text-align: center; vertical-align: middle;">${dsSellList.SELL_PRICE}???</td>
			                            <td style="text-align: center; vertical-align: middle;">
			                            	<button type="button" class="btn btn-primary" onclick="fn_finalBuy('${dsSellList.SELL_CODE}', '${dsSellList.SELL_COUNT}', '${dsSellList.PRODUCT_CODE}')">????????????</button>
			                            </td>
			                         </tr>
			                        </c:forEach>
			                    </tbody>
			                </table>
			            </div>
			            <!-- /.table-responsive -->
			        </div>
			        <!-- /.panel-body -->
			    </div>
			    <!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
			<div class="col-md-1 col-md-offset-11">
				<button type="button" class="btn btn-success btn-lg"  style="float:right;" onclick="fn_back()">????????????</button>
			</div>
		</div>
	</div>
<jsp:include page="/common/foot.jsp"></jsp:include>
</body>
</html>