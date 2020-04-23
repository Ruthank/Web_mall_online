<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改密码</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/>
<link rel="stylesheet" type="text/css" href="css/verifyCode.css"/>
	<script src="js/verifyCode.js"></script>
	<script>
		function check(){
			var passwd = document.getElementById("password").value;
			var repeat_pass = document.getElementById("password2").value;

			if (passwd.length <= 0 || repeat_pass.length <= 0) {
				alert("密码不能为空！"); createCode(4); return false;
			}
			if (passwd != repeat_pass) {
				alert("两次输入的密码不一致！"); createCode(4); return false;
			}
			
			if (!validateCode()) {
				createCode(4);
				return false;
			}
			
			var forbiddenArray =['\'','<','>','#','\'','\''];
			var re = '';
			for(var i=0;i<forbiddenArray.length;i++){
				if(i==forbiddenArray.length-1) re+=forbiddenArray[i];
				else re += forbiddenArray[i]+"|";
			}
			var pattern = new RegExp(re,"g");

			if (pattern.text(passwd)) {
				alert("密码包含非法字符！");
				createCode(4);
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<%

		HttpSession HS = request.getSession();
		String name = (String)request.getSession().getAttribute("name");
		if (name == null) {
			out.println("<script> alert(\"请先登录！\"); window.location.replace(\"login.html\"); </script>");
		}
		request.setCharacterEncoding("utf-8"); 	 
	%>
	
	<h2>您好，用户<%=name %>。</h2>
	
	<form method="post" action="update.jsp" name="myform" onsubmit="return check();" >	
        <div>
			<label for="password">新密码：</label>
			<input type="password" id="password" name="password" placeholder="请输入密码" value="" />
		</div>
		<div>
			<label for="password2">重复密码：</label>
			<input type="password" id="password2" name="password2" placeholder="请输入密码" value="" />
		</div>
		<div>
			<div id="checkCode" class="code"  onclick="createCode(4)"  ></div>
			<div> <br> <br> <h4> <span onclick="createCode(4)"> 看不清换一张 </span> </h4> </div>
		</div>
		
		<div>
			<label> 验证码：</label>
			<input type="text" id="inputCode" value="" />
		</div>
		<div >
			<input type="submit" value="确认修改">        
		</div>
	</form>

</body>
</html>