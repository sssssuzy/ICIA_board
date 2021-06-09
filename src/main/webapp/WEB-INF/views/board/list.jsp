<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>게시판 목록</title>
<style>
table {width: 100%; margin-top:10px; margin-bottom:10px; border-top: 1px solid #444444; border-collapse: collapse;}
tr, td {border-bottom: 1px solid #444444;padding: 10px;}
.btnStyle{width: 100px;
              padding: .5em .5em;
              border: 1px solid black;
              background: write;
              color: black;        
              font-weight:bold;
   	}
#pagination{text-align:center;}
a{text-decoration:none; color:#364967;font-size:25px;}
a:hover{font-weight:bold;}
.keyword{width: 200px;
  padding: .5em .5em;
  font-weight: 800;
  border: 1px solid black;
  background: white;
  color:black;        
}
#divHeader{margin-bottom:10px;}
select { width: 130px;
            padding: .5em .5em;
            border: 1px solid black;
            font-family: inherit;
            background: url('/upload/arrow.jpg') no-repeat 95% 50%;
            border-radius: 0px;
            }               
select::-ms-expand {display: none;}
</style>
</head>
<body>
	<h1>게시판 목록</h1>
	<div id="divHeader">
		<div id="divLeft" style="float:left">
			<select id=searchType>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select> 
			<input type="text" placeholder="검색어" class="keyword" id="keyword"> 
			<input type="button" id="btnSearch"  class="btnStyle" value="검색">
			<span id="total"></span>
		</div>
		<div id="divRight" style="float:right">
			<input type="button" class="btnStyle" value="글쓰기">
		</div>
		<hr/>
	</div>
	<div id="list">
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
			<tr class="title">
				<td>NO</td>
               <td>Title</td>
               <td>Writer</td>
               <td>Reg Date</td>
               <td>Update date</td>
				<td>View cnt</td>
            </tr>
			{{#each list}}
				<tr onClick="location.href='read?bno={{bno}}'">
					<td>{{bno}}</td>
					<td>{{title}}  (댓글:{{replycnt}})</td>
					<td>{{writer}}</td>
					<td>{{regdate}}</td>
					<td>{{updatedate}}</td>
					<td>{{viewcnt}}</td>
				</tr>
			{{/each}}
		</script>
	</div>
	<div id="pagination">		
	</div>
</body>
<script>
	var page=1;
	getList();	
	
	$("#keyword").on("keydown",function(e){
		if(e.keyCode==13){
			$("#btnSearch").click();			
		}
	});
	
	
	$("#btnSearch").on("click",function(){		
		page=1;
		getList();
		
	});
	
	function getList(){
		var searchType=$("#searchType").val();
		var keyword=$("#keyword").val();
		$.ajax({
			  type:"get",
		      url:"list.json",
		      data:{"page":page,"searchType":searchType,"keyword":keyword},
		      dataType:"json",
		      success:function(data){
		         var temp=Handlebars.compile($("#temp").html());
		         $("#tbl").html(temp(data));
		         $("#total").html("검색수 : " + data.pm.totalCount);
		       //페이징목록출력
		            var str="";
		            var prev=data.pm.startPage-1;
		            var next=data.pm.endPage+1;
		            
		            if(data.pm.prev) str +="<a href='" + prev + "'>◀</a>";
		            for(var i=data.pm.startPage;i<=data.pm.endPage; i++){
		               if(i==page){
		                  str += "<a class='active' href='" + i + "'>" + i + "</a> ";
		               }else{
		                  str += "<a href='" + i + "'>" + i + "</a> ";
		               }   
		            }
		            if(data.pm.next) str +="<a href='" + next + "'>▶</a>";
		            $("#pagination").html(str);
		      
		      }
		});
	}
	$("#pagination").on("click","a",function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
</script>
</html>