function loadnotebyid(){
	//设置当前笔记为选中状态
	$("#note_list li a").removeClass("checked");
	$(this).find("a").addClass("checked");
	//获取笔记ID
	var noteId = $(this).data("noteId");
	//发送ajax请求
	$.ajax({
		url:"/cloudnote/note/load.do",
		type:"post",
		data:{"noteId":noteId},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				var noteTitle = result.data.cn_note_title;
				var noteBody = result.data.cn_note_body;
				//将标题设置到编辑区
				$("#input_note_title").val(noteTitle);
				//将内容设置到编辑区
				um.setContent(noteBody);
			}
		},
		error:function(){
			alert("加载笔记内容失败");
		}
	});
};
//弹出添加笔记对话框
function showAddNoteWindow(){
	//加载alert页面内容
	$("#can").load("alert/alert_note.html");
	//显示背景色
	$(".opacity_bg").show();
};

//确认添加笔记操作
function sureAddNote(){
	//获取请求参数
	var noteTitle = $("#input_note").val().trim();
	var $bookli = 
		$("#book_list li a.checked").parent();
	var bookId = $bookli.data("bookId");
	//TODO 检测参数格式
	//发送ajax请求
	$.ajax({
		url:"http://localhost/CloudNote/note/add.do",
		type:"post",
		data:{"userId":userId,
			"bookId":bookId,
			"noteTitle":noteTitle},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				//关闭对话框
				closeWindow();
				//添加笔记li元素
				//拼一个笔记li
				var sli = '<li class="online">';
					sli+= '<a>';
					sli+= '	<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i>'+noteTitle+'<button type="button" class="btn btn-default btn-xs btn_position btn_slide_down"><i class="fa fa-chevron-down"></i></button>';
					sli+= '</a>';
					sli+= '<div class="note_menu" tabindex="-1">';
					sli+= '	<dl>';
					sli+= '		<dt><button type="button" class="btn btn-default btn-xs btn_move" title="移动至..."><i class="fa fa-random"></i></button></dt>';
					sli+= '		<dt><button type="button" class="btn btn-default btn-xs btn_share" title="分享"><i class="fa fa-sitemap"></i></button></dt>';
					sli+= '		<dt><button type="button" class="btn btn-default btn-xs btn_delete" title="删除"><i class="fa fa-times"></i></button></dt>';
					sli+= '	</dl>';
					sli+= '</div>';
					sli+= '</li>';
				var $li = $(sli);//将sli字符串转成jQuery对象
				var noteId = result.data;//获取笔记ID
				$li.data("noteId",noteId);//绑定笔记ID
				$("#note_list").prepend($li);//添加到笔记列表第一个位置
				//将新添加笔记选中
				//$li.click();
				$("#note_list li a").removeClass("checked");
				$li.find("a").addClass("checked");
				$("#input_note_title").val(noteTitle);
				um.setContent("");
			}
		},
		error:function(){
			alert("创建笔记失败");
		}
	});
};

//保存笔记信息
function saveNote(){
	//获取请求参数
	var noteTitle = $("#input_note_title").val().trim();
	var noteBody = um.getContent();
	var $noteli = 
		$("#note_list li a.checked").parent();
	var noteId = $noteli.data("noteId");
	//TODO 检查参数格式
	//发送ajax请求
	$.ajax({
		url:"http://localhost/CloudNote/note/update.do",
		type:"post",
		data:{"noteId":noteId,
			"noteTitle":noteTitle,
			"noteBody":noteBody},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				//如果标题发生改变,修改列表中的标题
				var sli = '	<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i>'+noteTitle+'<button type="button" class="btn btn-default btn-xs btn_position btn_slide_down"><i class="fa fa-chevron-down"></i></button>';
				//替换笔记列表中的标题内容
				$noteli.find("a").html(sli);
				//弹出提示信息
				alert(result.msg);
			}
		},
		error:function(){
			alert("保存笔记失败");
		}
	});
};

//弹出笔记菜单
function popNoteMenu(){
	//将当前笔记li设置为选中
	$("#note_list li a").removeClass("checked");
	$(this).parents("li").find("a")
		.addClass("checked");
	//清空编辑区笔记信息
	um.setContent("");
	$("#input_note_title").val("");
	//将所有li菜单全部隐藏
	$("#note_list .note_menu").hide();
	//将当前点中的li菜单显示
	var $menu = 
	  $(this).parents("li").find(".note_menu");
	if($menu.is(":hidden")){
		$menu.slideDown(1000);//显示
	}else{
		$menu.slideUp(1000);//隐藏
	}
	return false;//阻止冒泡
};

//删除笔记-放入回收站
function recycleNote(){
	//获取请求参数
	var $noteli = $(this).parents("li");
	var noteId = $noteli.data("noteId");
	//发送ajax请求
	$.ajax({
		url:"http://localhost/CloudNote/note/recycle.do",
		type:"post",
		data:{"noteId":noteId},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				$noteli.remove();//删除
				alert(result.msg);
			}
		},
		error:function(){
			alert("删除笔记失败");
		}
	});
	return false;//阻止冒泡
};
function shareNote(){
	//获取笔记ID
	var $noteli = $(this).parents("li");
	var noteId = $noteli.data("noteId");
	//发送ajax请求
	$.ajax({
		url:"http://localhost/CloudNote/note/share.do",
		type:"post",
		data:{"noteId":noteId},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				alert(result.msg);
			}else if(result.status==1){
				alert(result.msg);
			}
		},
		error:function(){
			alert("分享笔记失败");
		}
	});
	return false;//阻止事件冒泡

};
function searchsharenote(event){
	if(event.which==13){
		//显示搜索结果和预览笔记
		$("#pc_part_1").show();
		$("#pc_part_6").show();
		$("#pc_part_5").show();
		$("#pc_part_2").hide();
		$("#pc_part_3").hide();
		$("#pc_part_4").hide();
		$("#pc_part_7").hide();
		$("#pc_part_8").hide();
		
		
		//获取文本框中的内容
		var text=$("#search_note").val().trim();
		$.ajax({
			url:"http://localhost/CloudNote/note/search.do",
			type:"post",
			data:{"text":text},
			dataType:"json",
			success:function(result){
				if(result.status==0){
					$("#search_list").empty();
					var list=result.data;
					for(var i=0;i<list.length;i++){
						var title=list[i].cn_share_title;
						
						
						var id=list[i].cn_note_id;
						var sli = '<li class="online">';
						sli+= '<a>';
						sli+= '	<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i>'+title;
						sli+= '</a>';
						sli+= '</li>';
						
					
					//追加搜索结果列表
				  
					var $li = $(sli);//将sli字符串转成jQuery对象
					$li.data("noteId",id);
					$("#search_list").append($li);
					}
				}
			},
			error:function(){
				alert("搜索笔记失败");
			}
		});
	}


}
function preview(){
	 var noteId=$(this).data("noteId");
	 $.ajax({
		 url:"http://localhost/CloudNote/note/preview.do",
	     type:"post",
	     data:{"noteId":noteId},
	     dataType:"json",
	     success:function(result){
	    	if(result.status==0){
	    		var share=result.data;
	    		
	    		var body=share.cn_share_body;
	    		$("#noput_note_title").html(body);
	    		
	    		
	    	} 
	     },
		 error:function(){
			 alert("预览笔记失败");
		 }
	 });
}
function rolltorecycle(){
	$("#pc_part_1").show();
	$("#pc_part_2").show();
	$("#pc_part_4").show();
	$("#pc_part_5").hide();
	$("#pc_part_3").hide();
	$("#pc_part_6").hide();
	$("#pc_part_7").hide();
	
    //利用获取的userId
	$.ajax({
		url:"http://localhost/CloudNote/note/recycleList.do",
		type:"post",
		data:{"userId":userId},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				$("#recycle_list").empty();
				var noteList=result.data;
				for(var i=0;i<noteList.length;i++){
					var title=noteList[i].cn_note_title;
					var noteId=noteList[i].cn_note_id;
					//拼一个li
					var sli="<li class='disable'>";
			        sli+="<a><i class='fa fa-file-text-o' title='online' rel='tooltip-bottom'>";
			        sli+="</i>"+ title+"<button type='button' class='btn btn-default btn-xs btn_position btn_delete'>";
			        sli+="<i class='fa fa-times'></i></button><button type='button' class='btn btn-default btn-xs btn_position_2 btn_replay'>";
			        sli+="<i class='fa fa-reply'></i></button></a></li>";
			        //转换为jquery对象
			       var $sli=$(sli);
			        $sli.data("noteId",noteId);
			        $("#recycle_list").append($sli);
				}
			}
		},
		error:function(){
			alert("进入回收站失败");
		}
	});
}
function delete_note(){
	//获取noteId
	var $noteli = $(this).parents("li");
	var noteId = $noteli.data("noteId");
	//发送ajax请求
	$.ajax({
		url:"http://localhost/CloudNote/note/deleteNote.do",
		type:"post",
		data:{"noteId":noteId},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				$noteli.remove();//把自己删除了;
				alert(result.msg);
			}
		},
		error:function(){
			alert("删除笔记失败");
		}
		
	});
}
function replay_note(){
	//获取noteId
	var $noteli = $(this).parents("li");
	var noteId = $noteli.data("noteId");
	//发送ajax请求
	$.ajax({
		url:"http://localhost/CloudNote/note/replay.do",
		type:"post",
		data:{"noteId":noteId},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				$noteli.remove();//把自己删除了;
				alert(result.msg);
			}
		},
		error:function(){
			alert("回复笔记失败");
		}
		
	});
}





