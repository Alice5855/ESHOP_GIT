<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var ="context"><%=request.getContextPath()%></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="description" content="statisticsForStock.jsp">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>HS STATIONERY</title>

	<link href="${context}/css/sass/jumbotronimg.css" rel="stylesheet">
	<link href="${context}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${context}/css/bootstrap-theme.css" rel="stylesheet">
	<link href="${context}/css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	<link href="${context}/css/plugins/dataTables.bootstrap.css" rel="stylesheet">

    <link href="${context}/css/sb-admin-2.css" rel="stylesheet">
    <link href="${context}/css/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${context}/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<script src="${context}/js/jquery-1.9.1.js"></script>
	<script src="${context}/js/bootstrap.min.js"></script>

    <script src="${context}/js/plugins/metisMenu/metisMenu.min.js"></script>

    <script src="${context}/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="${context}/js/plugins/dataTables/dataTables.bootstrap.js"></script>

    <script src="${context}/js/sb-admin-2.js"></script>
    <script src="${context}/js/morris.min.js"></script>
    <script src="${context}/js/raphael.js"></script>

    <script>

	var sort;
	var url;

    $(document).ready(function(){
    	var objDonut = JSON.parse('${objDonut}');
    	var objBar = JSON.parse('${objBar}');
    	sort = '${sort}';

    	if('${sort}' != null) $("#sort").val(sort);

    	$("#sort").change(function(){
    		sort = $("#sort").val();

    		if(sort == 'stockP'){
				url = "${context}/work/product/retrieveStatisticsForStock.do?productCategoryCd=P";
    		}else if(sort == 'stockO'){
				url = "${context}/work/product/retrieveStatisticsForStock.do?productCategoryCd=O";
    		}else if(sort == 'stockS'){
				url = "${context}/work/product/retrieveStatisticsForStock.do?productCategoryCd=S";
    		}else if(sort == 'stockB'){
				url = "${context}/work/product/retrieveStatisticsForStock.do?productCategoryCd=B";
    		}else if(sort == 'stockD'){
				url = "${context}/work/product/retrieveStatisticsForStock.do?productCategoryCd=D";
    		}else if(sort == 'sell'){
    			url = "${context}/work/product/retrieveStatisticsForSell.do";
    		}

    		if(sort != 'sell'){
    			location.href = url + "&sort=" + sort;
    		}else if(sort == 'sell'){
    			location.href = url + "?sort=" + sort;
    		}
    	});

        Morris.Donut({
            element: 'donutChart',
            data: objDonut,
            resize: true
        });

        Morris.Bar({
            element: 'barChart',
            data: objBar,
            xkey: 'y',
            ykeys: ['a'],
            labels: ['??????'],
            hideHover: 'auto',
            resize: true
        });


    });

    </script>
</head>
<body>
<jsp:include page="/common/top.jsp"></jsp:include>
	<div class="container">
		<div class="jumbotron jumbotron-info">
			<h1><strong>????????????</strong>&nbsp;<span class="glyphicon glyphicon-signal"></span></h1>
			<p>???????????? ??????????????????.</p>
		</div>

		<div class="row">
			<div class="col-md-3">
				<select class="form-control" id="sort" name="sort">
					<option value="stockP">????????????[?????????]</option>
					<option value="stockO">????????????[????????????]</option>
					<option value="stockS">????????????[??????/????????????]</option>
					<option value="stockB">????????????[??????/?????????]</option>
					<option value="stockD">????????????[???????????????]</option>
					<option value="sell">????????????</option>
				</select>
			</div>
		</div>
	    <div class="row">
			<div id="donutChart"></div>
	    </div>

		<div class="row">
			<div id="barChart"></div>
	    </div>

		<div class="row">
			<div class="col-md-1 col-md-offset-11">
				<button type="button" class="btn btn-success btn-lg"  style="float:right;" onclick="fn_back()">????????????</button>
			</div>
		</div>
		<div id="printArea" style="display: none;">
		</div>
	</div>
<jsp:include page="/common/foot.jsp"></jsp:include>
</body>
</html>