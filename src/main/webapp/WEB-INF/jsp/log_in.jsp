<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/styles/login.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/cookie_util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/login.js"></script>
<script type="text/javascript"src="${pageContext.request.contextPath }/scripts/regist.js"></script>
<script type="text/javascript">
    var ctx = "${pageContext.request.contextPath }";
</script>
<script type="text/javascript">
  $(function(){
	  $("#sig_in").click(function(){
		  window.location.href="${pageContext.request.contextPath }/user/toRegister.do?todo=reg_in";
	  });
  });
  function reloadImg(){
	  var time=new Date().getTime();
	  document.getElementById("yanzhengma").src="${pageContext.request.contextPath }/user/captcha.do?d="+time;
  }
  
</script>

</head>
	<body>
		<div class="global">
			<div class="log log_in" tabindex='-1' id='dl'>
				<dl>
					<dt>
						<div class='header'>
							<h3>登&nbsp;录</h3>
						</div>
					</dt>
					<dt></dt>
					<dt>
						<div class='letter'>
							用户名:&nbsp;<input type="text" name="" id="count" tabindex='1'/>
							<span id="count_msg"></span>
						</div>
					</dt>
					<dt>
						<div class='letter'>
							密&nbsp;&nbsp;&nbsp;码:&nbsp;<input type="password" name="" id="password" tabindex='2'/>
							<span id="password_msg"></span>
						</div>
					</dt>
					<dt>
						<div class='letter'>
							验证码:&nbsp;<input type="text" name="" id="captcher" tabindex='1'/>&nbsp;&nbsp;
							<span><a href="javascript:reloadImg();"><img alt="验证码" id="yanzhengma" src="${pageContext.request.contextPath }/user/captcha.do"></a></span>
							<p id="captcha_msg"></p>
						</div>
					</dt>
					<dt>
						<div>
							<input type="button" name="" id="login" value='&nbsp登&nbsp录&nbsp' tabindex='3'/>
							<input type="button" name="" id="sig_in" value='&nbsp注&nbsp册&nbsp' tabindex='4'/>
						</div>
					</dt>
				</dl>
			</div>
		</div>
	</body>
</html>