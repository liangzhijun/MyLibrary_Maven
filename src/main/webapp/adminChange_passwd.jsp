<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="utf-8">
  <title>大学图书馆书目检索系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Le styles -->
<link href="css/bootstrap.css" rel="stylesheet">

<style>
body {
	padding-top: 60px;
	/* 60px to make the container go all the way to the bottom of the topbar */
	
}
</style>

<script type="text/javascript">
		
	var xmlHttpRequest = null; //声明一个空对象以接收XMLHttpRequest对象
	
	function ajaxSubmit()
	{
		if(window.ActiveXObject) // IE浏览器
		{
			xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		else if(window.XMLHttpRequest) // 除IE外的其他浏览器实现
		{
			xmlHttpRequest = new XMLHttpRequest();
		}
		
		if(null != xmlHttpRequest)//处理发送
		{
			var password = document.getElementById("passwordID").value;
			var newPassword = document.getElementById("newPasswordID").value;
			var repassword = document.getElementById("repasswordID").value;
			
			xmlHttpRequest.open("POST", "/changePasswd.htm", true);
			//关联好ajxa的回调函数
			xmlHttpRequest.onreadystatechange = ajaxCallback;
			
			//真正向服务器端发送数据
			// 使用post方式提交，必须要加上如下
			xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlHttpRequest.send("password=" + password + "&newPassword=" + newPassword + "&repassword=" + repassword);
			
		}
	}
	
	function ajaxCallback()//处理响应
	{
		if(xmlHttpRequest.readyState == 4)
		{
			if(xmlHttpRequest.status == 200)//Http响应的状态
			{
				var responseTest = xmlHttpRequest.responseText;
				var user = JSON.parse(responseTest);
				var status = user.status; 	//status 作为状态码使用
				var message = user.uri;
				
				if(status == 200)							//验证通过！返回的是登录用户角色相对应“URI”地址的字符串
				{
					window.location = user.uri;				//连接到用户角色相对应的主页面
					return;
				}
				
				if(status == 400)						//返回的是错误
				{
					document.getElementById("div1").innerHTML = user.error;
					return;
				}
			}
		}
	}
	
	</script>

</head>

<body>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand">书目检索系统</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li><a href="/adminRetrieval.jsp">书目检索</a>
						</li>
						<li><a href="#about">分类浏览</a>
						</li>
						<li><a href="/deleteBooks.htm">删除图书or修改图书</a>
						</li>
						<li><a href="/getBooks.htm" >图书目库</a>
						</li>
						<li><a href="/booksEntering.jsp">图书录入</a></li>
						<li><a href="/adminLibrary.jsp">我的资料</a></li>
					</ul>
					<div style="color:#FFF; float:right; padding:5px 20px 0 0px">
    				<a href="/exit.htm"><strong style="color:#fff;">退出</strong></a>
    				</div>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>
	
	
	<div class="container">
	
		<h3 style="color: rgb(226, 106, 39)">修改个人密码</h3>
		
		<form class="form-signin" onsubmit="ajaxSubmit(); return false;" method="post">
  	
  	  	原密码 <input type="password" name="password" id="passwordID"> <br>
  		新密码 <input type="password" name="newPassword" id="newPasswordID"> <br>
  		确认密码<input type="password" name="repassword" id="repasswordID"> <div id="div1"></div> <br>
  		
  		<input class="btn btn-primary" type="submit" value="修 改">&nbsp;&nbsp;&nbsp;&nbsp;
  		<a class="btn" href="/myLibrary.jsp">返回</a>
  		</form>

		</div>
    
    
  </body>
</html>
