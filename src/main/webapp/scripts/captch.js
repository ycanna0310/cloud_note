function send(){
$.ajax({
			  url:"http://localhost/CloudNote/user/captcha.do",
			  type:"get",
			  dataType:"json",
			  success:function(){
			     
			  },
			  error:function(){
			  	alert("ϵͳ�쳣,ע��ʧ��");
			  }
			});
}