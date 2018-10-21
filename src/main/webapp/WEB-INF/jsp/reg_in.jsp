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
	$("#back").click(function(){
		  window.location.href="${pageContext.request.contextPath }/user/toRegister.do?todo=log_in";
	  });
});
</script>
</head>
	<body>
		<div class="global">
			<div class="log log_in" tabindex='-1' id="zc">
				<dl>
					<dt>
						<div class='header'>
							<h3>注&nbsp;册</h3>
						</div>
					</dt>
					<dt></dt>
					<dt>
						<div class='letter'>
							用户名:&nbsp;<input type="text" name="" id="regist_username" tabindex='5'/>
							<div class='warning' id='warning_1'><span>该用户名不可用</span></div>
						</div>
					</dt>
					<dt>
						<div class='letter'>
							昵&nbsp;&nbsp;&nbsp;称:&nbsp;<input type="text" name="" id="nickname" tabindex='6'/>
						</div>
					</dt>
					<dt>
						<div class='letter'>
							密&nbsp;&nbsp;&nbsp;码:&nbsp;<input type="password" name="" id="regist_password" tabindex='7'/>
							<div class='warning' id='warning_2'><span>密码长度过短</span></div>
						</div>
					</dt>
					<dt>
						<div class='password'>
							&nbsp;&nbsp;&nbsp;确认密码:&nbsp;<input type="password" name="" id="final_password" tabindex='8'/>
							<div class='warning' id='warning_3'><span>密码输入不一致</span></div>
						</div>
					</dt>
					<dt>
						<div>
							<input type="button" name="" id="regist_button" value='&nbsp注&nbsp册&nbsp' tabindex='9'/>
							<input type="button" name="" id="back" value='&nbsp返&nbsp回&nbsp' tabindex='10'/>
						</div>
					</dt>
				</dl>
			</div>
		</div>
	</body>
</html>