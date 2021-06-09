<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
 
 .keyword{width: 200px;
  padding: .5em .5em;
  font-weight: 800;
  border: 1px solid black;
  margin-left:10px; 
  background: white;
  color:black;        
}
.box{width:500px; padding:10px; background:white; margin:10px;border-left: 1px solid black; border-bottom: 1px solid black; overflow:hidden;}

.reHeader{width:500px;}
.replyer{float:left;}
.replydate{float:right;}
.reply{color: black;   margin-left:15px; font-weight:bold; }
a{text-decoration:none; color:#364967;font-size:20px;}
#pagination{text-align:center;}
a:hover{font-weight:bold; color:red;}
.btnStyle{width: 100px;
              padding: .5em .5em;
              border: 1px solid black;
              background: write;
              color: black;        
              font-weight:bold;
   	}
   	
</style>
<h3>댓글목록</h3>
<div>
	<div>
	<input type="text" placeholder="내용을 입력하세요" class="keyword" id="txtReply"> 
	<input type="button" id="btnInsert"  class="btnStyle" value="등록">
	<span id="total"></span>
	</div>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">		
			{{#each list}}

				<div class="box">			
					<div class="replyer">{{replyer}} <a href="{{rno}}">x</a></div>			
					<div class="replydate">{{replydate}}</div>				
					
				</div>
				<div class="reply">{{reply}}</div>	

			{{/each}}
	</script>
	<div id="pagination">		
	</div>
</div>
<script>
	var bno="${vo.bno}";
	var page=1;
	getList();
	
	$("#txtReply").on("keydown",function(e){
		if(e.keyCode==13){
			$("#btnInsert").click();
			$(this).val("");
		}
	});
	
	//댓글 입력
	$("#btnInsert").on("click",function(){
		if(!confirm("댓글을 등록하실래요?")) return;
		var reply=$("#txtReply").val();
		var replyer="user02";
		if(reply==""){
			alert("댓글 내용을 입력하세요!");
			return;
		}
		$.ajax({
			type:"post",
			url:"/reply/insert",
			data:{"bno":bno,"reply":reply,"replyer":replyer},
			success:function(){
				alert("댓글 등록완료!")
				getList();
			}
		});
	});
	
	//댓글 삭제
	$("#tbl").on("click",".replyer a",function(e){
		e.preventDefault();
		if(!confirm("댓글을 삭제하실래요?")) return;
		var rno=$(this).attr("href"); // a 안에 href에 있는 것
		$.ajax({
			type:"post",
			url:"/reply/delete",
			data:{"rno":rno},
			success:function(){
				alert("댓글 삭제완료!");
				getList();
			}
		});
	});
	function getList(){
		$.ajax({
			type:"get",
			url:"/reply/list.json",
			dataType:"json",
			data:{"page":page,"bno":bno},
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