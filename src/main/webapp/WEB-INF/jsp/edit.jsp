<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>我的笔记</title>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
        <meta http-equiv="x-pjax-version" content="v173">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath }/ico/favico-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath }/ico/favico-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath }/ico/favico-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/ico/favico-57-precomposed.png">
        <link rel="shortcut icon" href="${pageContext.request.contextPath }/ico/favico.png">
        <link rel="shortcut icon" href="${pageContext.request.contextPath }/ico/favico.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/styles/icon.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath }/styles/main.css"/>
		<!-- Google-Code代码高亮CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath }/styles/prettify.css"/>
		<!-- Ueditor编辑器CSS -->
		<link href="${pageContext.request.contextPath }/styles/umeditor.min.css" type="text/css" rel="stylesheet">
    	<script type="text/javascript" 
    		src="${pageContext.request.contextPath }/scripts/jquery.min.js">
    	</script>
    	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    	<script type="text/javascript"
    		src="${pageContext.request.contextPath }/scripts/book.js">
    	</script>
    	<script type="text/javascript"
    		src="${pageContext.request.contextPath }/scripts/note.js">
    	</script>
    	<script type="text/javascript">
    		var ctx = "${pageContext.request.contextPath }";
		</script>
    	<script type="text/javascript">
		
    	/* var userId = getCookie("userId");
    	if(userId == null){
    		window.location.href="log_in.html";
    	} */
    	var um;
    	
        $(function(){//页面载入后执行
        	$("#pc_part_1").show();
    		$("#pc_part_2").show();
    		$("#pc_part_4").hide();
    		$("#pc_part_5").hide();
    		$("#pc_part_3").show();
    		$("#pc_part_6").hide();
    		$("#pc_part_7").hide();
        	//实例化Ueditor编辑器
			um = UM.getEditor('myEditor');
        	//发送ajax加载笔记本列表
    		//loaduserbooks();
        	//点击笔记本li显示笔记列表
        	//$("#book_list").on("click","li",loadbooknotes);
        	//点击笔记li显示笔记内容
        	//$("#note_list").on("click","li",loadnotebyid);
        	//弹出"添加笔记本"对话框
        	//$("#add_notebook").click(showAddBookWindow);
        	//关闭所有对话框
        	//$("#can").on("click",".close,.cancle",closeWindow);
        	//创建笔记本
        	//$("#can").on("click","#sure_addbook",sureAddBook);
        	//双击弹出修改笔记本名对话框
        	$("#book_list").on("dblclick","li",showRenameBookWindow);
        	//确认修改笔记本名
        	$("#can").on("click","#sure_renamebook",sureRenameBook);
        	//弹出"添加笔记"对话框
        	$("#add_note").click(showAddNoteWindow);
        	//确认添加笔记操作
        	$("#can").on("click","#sure_addnote",sureAddNote);
        	//保存笔记操作
        	$("#save_note").click(saveNote);
        	//弹出笔记菜单
        	$("#note_list").on("click",".btn_slide_down",popNoteMenu);
        	//鼠标移动控制笔记菜单显示和隐藏
        	$("#note_list").on("mouseout",".note_menu",function(){
        		$(this).hide();
        	});
        	$("#note_list").on("mouseover",".note_menu",function(){
        		$(this).show();
        	});
        	//删除笔记--放回收站
        	$("#note_list").on("click",".btn_delete",recycleNote);
        	//分享笔记
        	$("#note_list").on("click",".btn_share",shareNote);
        	//搜索分享过的笔记
        	$("#search_note").keydown(searchsharenote);
        	//显示分享过的笔记
        	$("#search_list").on("mouseover","li",preview);
        	//把笔记放到回收站
        	$("#rollback_button").click(rolltorecycle);
        	//彻底删除笔记
        	$("#recycle_list").on("click",".btn_delete",delete_note);
        	//恢复笔记
        	$("#recycle_list").on("click",".btn_replay",replay_note);
        });
        
    	</script>
    
    </head>
    <body class="animated fadeIn">
    	<div id="vuebody">
        <header class="header">
            <div class="header-brand">
                <a data-pjax=".content-body" href="edit.html">
                    <img class="brand-logo" src="${pageContext.request.contextPath }/images/dummy/8986f28e.stilearn-logo.png" alt="Stilearn Admin Sample Logo">
                </a>
            </div>
            <div class="header-profile">
                <div class="profile-nav">
                    <span class="profile-username"></span>
                    <a  class="dropdown-toggle" data-toggle="dropdown">
                        <span class="fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu animated flipInX pull-right" role="menu">
                        <li><a href="Change_password.html"><i class="fa fa-user"></i> 修改密码</a></li>
                        <li class="divider"></li>
                        <li><a id="logout" href="${pageContext.request.contextPath }/user/toRegister.do?todo=log_in"><i class="fa fa-sign-out"></i> 退出登录</a></li>
                    </ul>
                </div>
            </div>
            <form class="form-inline" onsubmit="return false;">
                <button type="button" class="btn btn-default btn-expand-search"><i class="fa fa-search"></i></button>
                <div class="toggle-search">
                    <input type="text" class="form-control" placeholder="搜索笔记" id='search_note'>
                    <button type="button" class="btn btn-default btn-collapse-search"><i class="fa fa-times"></i></button>
                </div>
            </form>
            <ul class="hidden-xs header-menu pull-right">
                <li>
                    <a href="activity.html" target='_blank' title="笔记活动">活动</a>
                </li>
            </ul>
        </header>
		<div class="row" style='padding:0;' id='center'>
			<!-- alert_background-->
			<div v-bind:class="{'opacity_bg':showOpacity}"></div>
			<!-- alert_notebook -->
			<div id="can">
				<div v-show="isShow" class="modal fade in" id="modalBasic" tabindex="-1" role="dialog" aria-labelledby="modalBasicLabel" aria-hidden="false" >
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="modalBasicLabel">新建笔记本</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
                                <label class="col-sm-3 control-label" for="input" style='margin-top:5px;'>笔记本名称</label>
                                <div class="col-sm-8">
                                    <input type="text" v-model="notebookname" class="form-control" id="input_notebook">
                                </div>
                            </div>
						</div>
						<div class="modal-footer" style='margin-top:20px;'>
							<button type="button" class="btn btn-default cancle" @click="isShow=false;showOpacity=false" >取 消</button>
							<button type="button" class="btn btn-primary sure" @click="sureAddBook" id="sure_addbook">创 建</button>
						</div>
					</div>
				</div>
			</div>
			</div>
			<div class="col-xs-2" style='padding:0;' id='pc_part_1'>
				<!-- side-right -->
				<div class="pc_top_first">
					<h3>全部笔记本</h3>
					<button type="button" class="btn btn-default btn-xs btn_plus" id='add_notebook' @click="isShow=true;showOpacity=true;notebookname=''"><i class="fa fa-plus"></i></button>
				</div>
				<aside class="side-right" id='first_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body">
								<ul id="book_list" class="contacts-list">
									<!-- 动态添加li -->
									<li v-for="book in books" class="online">
										<a @click="loadnotes(book.cn_notebook_id)">
											<i class="fa fa-book" title="online" rel="tooltip-bottom"></i>
											{{book.cn_notebook_name}}
										</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</aside>
				<div class="row clear_margin">
					<div class="col-xs-4 click" id='rollback_button' title='回收站'><i class='fa fa-trash-o' style='font-size:20px;line-height:31px;'></i></div>
					<div class="col-xs-4 click" id='like_button' title='收藏笔记本'><i class='fa fa-star' style='font-size:20px;line-height:31px;'></i></div>
					<div class="col-xs-4 click" id='action_button' title='参加活动笔记'><i class='fa fa-users' style='font-size:20px;line-height:30px;'></i></div>
				</div>
			</div>
			<!-- 全部笔记本 -->
			<!-- 全部笔记 -->
			<div class="col-xs-3" style='padding:0;' id='pc_part_2'>
				<div class="pc_top_second" id='notebookId'>
					<h3>全部笔记</h3>
					<button type="button" class="btn btn-default btn-xs btn_plus" id='add_note'><i class="fa fa-plus"></i></button>
				</div>
				<aside class="side-right" id='second_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body">
								<ul id="note_list" class="contacts-list">
									<!-- 动态加载笔记 -->
									<li v-for="note in notes" class="online">
										<a @click="showNote(note)">
											<i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i>{{note.cn_note_title}}<button type="button" class="btn btn-default btn-xs btn_position btn_slide_down"><i class="fa fa-chevron-down"></i></button>
										</a>
										<div class="note_menu" tabindex="-1">
											<dl>
												<dt><button type="button" class="btn btn-default btn-xs btn_move" title="移动至..."><i class="fa fa-random"></i></button></dt>
												<dt><button type="button" class="btn btn-default btn-xs btn_share" title="分享"><i class="fa fa-sitemap"></i></button></dt>
												<dt><button type="button" class="btn btn-default btn-xs btn_delete" title="删除"><i class="fa fa-times"></i></button></dt>
											</dl>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</aside>
			</div>
			<!-- 全部笔记 -->
			<!-- 回收站笔记 -->
			<div class="col-xs-3" style='padding:0;display:none;' id='pc_part_4'>
				<div class="pc_top_second">
					<h3>回收站笔记</h3>
				</div>
				<aside class="side-right" id='four_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body">
								<ul class="contacts-list" id="recycle_list">
									<li class="disable"><a ><i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i> 虚假回收站笔记<button type="button" class="btn btn-default btn-xs btn_position btn_delete"><i class="fa fa-times"></i></button><button type="button" class="btn btn-default btn-xs btn_position_2 btn_replay"><i class="fa fa-reply"></i></button></a></li>
								</ul>
							</div>
						</div>
					</div>
				</aside>
			</div>
			<!-- 回收站笔记 -->
			<!-- 搜索笔记列表 -->
			<div class="col-xs-3" style='padding:0;display:none;' id='pc_part_6'>
				<div class="pc_top_second">
					<h3>搜索结果</h3>
				</div>
				<aside class="side-right" id='sixth_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body">
								<ul class="contacts-list" id='search_list'>
								</ul>
							</div>
						</div>
						<div id='more_note'>更多...</div>
					</div>
				</aside>
			</div>
			<!-- 搜索笔记列表 -->
			<!-- 收藏笔记列表 -->
			<div class="col-xs-3" style='padding:0;display:none;' id='pc_part_7'>
				<div class="pc_top_second">
					<h3>已收藏笔记</h3>
				</div>
				<aside class="side-right" id='seventh_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body">
								<ul class="contacts-list">
									<!--li class="idle"><a ><i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i> switch多分支结构<button type="button" class="btn btn-default btn-xs btn_position btn_delete"><i class="fa fa-times"></i></button></a></li-->
								</ul>
							</div>
						</div>
					</div>
				</aside>
			</div>
			<!-- 收藏笔记列表 -->
			<!-- 参加活动的笔记列表 -->
			<div class="col-xs-3" style='padding:0;display:none;' id='pc_part_8'>
				<div class="pc_top_second">
					<h3>参加活动的笔记</h3>
				</div>
				<aside class="side-right" id='eighth_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body">
								<ul class="contacts-list">
									<!--li class="offline"><a ><i class="fa fa-file-text-o" title="online" rel="tooltip-bottom"></i> 样式用例（点击无效）</a></li-->
								</ul>
							</div>
						</div>
					</div>
				</aside>
			</div>
			<!-- 参加活动的笔记列表 -->
			<!-- 编辑笔记 -->
			<div class="col-sm-7" id='pc_part_3'>
				<!-- side-right -->
				<div class="pc_top_third">
					<div class="row">
						<div class="col-xs-9">
							<h3>编辑笔记</h3>
						</div>
						<div class="col-xs-3">
							<button type="button" class="btn btn-block btn-sm btn-primary" id='save_note'>保存笔记</button>
						</div>
					</div>
				</div>
				<aside class="side-right" id='third_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body clear_margin">
								<!--- 笔记标题 --->
								<div class="row" >
									<div class="col-xs-8">
										<input type="text" class="form-control" id="input_note_title" v-model="noteTitle" placeholder='笔记标题...'>
									</div>
								</div>
								<!--- 笔记标题 --->
								<div class="row">
									<div class="col-sm-12">
										<!--- 输入框 --->
										<script type="text/plain" id="myEditor" style="width:100%;height:400px;">
										</script>
										<!--- 输入框 --->
									</div>
								</div>
							</div>
						</div>
					</div>
				</aside>
			</div>
			<!-- 编辑笔记 -->
			<!-- 预览笔记 -->
			<div class="col-sm-7" id='pc_part_5' style='display:none;' >
				<div class="pc_top_third">
					<div class="row">
						<div class="col-xs-9">
							<h3>预览笔记</h3>
						</div>
					</div>
				</div>
				<aside class="side-right" id='fifth_side_right'>
					<div class="module" data-toggle="niceScroll">
						<div class="chat-contact">
							<div class="contact-body clear_margin">
								<h4 id="noput_note_title"></h4>
								<p>
								</p>
							</div>
						</div>
					</div>
				</aside>
			</div>
			<!-- 预览笔记 -->
			

			
		</div>
        <footer>
            <p>&copy; 2014 Stilearning</p>
			<div style='position:absolute;top:5PX;height:30px;right:20px;line-height:26px;border:1px solid #0E7D76;display:none;background:#fff'>
				<strong style='color:#0E7D76;margin:0 10px;'></strong>
			</div>
        </footer>
		<script type="text/javascript">
		//加载DOM之后处理页面高度
		function get_dom(e){
			return document.getElementById(e);
		}
		function set_height(){
			var pc_height=window.innerHeight;
			pc_height=pc_height-132;
			get_dom('first_side_right').style.height=(pc_height-31)+'px';
			get_dom('second_side_right').style.height=pc_height+'px';
			get_dom('four_side_right').style.height=pc_height+'px';
			get_dom('sixth_side_right').style.height=pc_height+'px';
			get_dom('seventh_side_right').style.height=pc_height+'px';
			get_dom('eighth_side_right').style.height=pc_height+'px';
			get_dom('third_side_right').style.height=(pc_height-15)+'px';
			get_dom('fifth_side_right').style.height=(pc_height-15)+'px';
		}
		function myEditorWidth(){
			var dom=get_dom('third_side_right');
			var style=dom.currentStyle||window.getComputedStyle(dom, null);
			get_dom('myEditor').style.width=style.width;
		}
		set_height();
		//改变窗口大小时调整页面尺寸
		window.onresize=function(){
			set_height();
			var width=$('#third_side_right').width()-35;
			$('.edui-container,.edui-editor-body').width(width);
			$('#myEditor').width(width-20);
		};
		</script>
 

		<!-- Bootstrap框架JS -->
        <script src="${pageContext.request.contextPath }/scripts/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath }/scripts/js-prototype.js"></script>       
        <script src="${pageContext.request.contextPath }/scripts/theme-setup.js"></script>
		<!-- Google-Code代码高亮JS -->
        <script class="re-execute" src="${pageContext.request.contextPath }/scripts/run_prettify.js"></script>
		<!-- Ueditor编辑器JS -->
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/scripts/ue/umeditor.config.js"></script>
		<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/scripts/ue/umeditor.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/scripts/ue/lang/zh-cn.js"></script>
		
		
		</div>
		<script type="text/javascript">
			//重写JS原生alert函数
				window.alert=function(e){
					$('#can').load('${pageContext.request.contextPath }/alert/alert_error.html',function(){
						$('#error_info').text(' '+e);
						$('.opacity_bg').show();
					});
				}
				$("#pc_part_1").show();
	    		$("#pc_part_2").show();
	    		$("#pc_part_4").hide();
	    		$("#pc_part_5").hide();
	    		$("#pc_part_3").show();
	    		$("#pc_part_6").hide();
	    		$("#pc_part_7").hide();
	        	//实例化Ueditor编辑器
			//var um = UM.getEditor('myEditor');
			var vuebody = new Vue({
				el: "#vuebody",
				data: {
					books : [],
					notes : [],
					noteTitle : "",
					notebookname : "",
					isShow : false,
					showOpacity : false
				},
				created:function(){
					this.loadbooks();
				},
				methods: {
					loadbooks : function(){
						var _this=this;
						$.ajax({
							url:ctx+"/notebook/loadbooks.do",
							type:"post",
							dataType:"json",
							success:function(result){
								if(result.status==0){
									//清空原有笔记本列表
									_this.books=[];
									//解析笔记本信息,生成列表
									_this.books = result.data;
									//console.log("-----");
									//console.log(_this.books);
									
								}
							},
							error:function(){
								alert("加载笔记本失败");
							}
						});
					},
					loadnotes : function(bookId){
						var _this=this;
						//发送ajax请求
						$.ajax({
							url:ctx+"/notebook/loadnotes.do?bookId="+bookId,
							type:"get",
							dataType:"json",
							success:function(result){
								if(result.status==0){
									//将原有笔记列表清除
									_this.notes = [];
									//根据笔记信息生成笔记列表
									_this.notes = result.data;
								}
							},
							error:function(){
								alert("加载笔记本的笔记失败");
							}
						});
					},
					showNote : function(note){
						this.noteTitle = note.cn_note_title;
						um.setContent(note.cn_note_body);
					},
					sureAddBook : function(){
						var _this=this;
						$.ajax({
							url:ctx+"/notebook/add.do",
							type:"post",
							data:{"bookName":_this.notebookname},
							dataType:"json",
							success:function(result){
								if(result.status==0){
									//关闭对话框
									//closeWindow();
									_this.isShow = false;
									_this.showOpacity = false;
									_this.loadbooks();
								}
							},
							error:function(){
								alert("创建笔记本失败");
							}
						});
					}
					
				}
			})
		</script>
		</body>		
</html>