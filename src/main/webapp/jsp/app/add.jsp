<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%-- 引入layUI的cs --%>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="/jsp/common/header.jsp" />

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">

            <form action="${ctx}/app/add" class="layui-form" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">软件名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入软件名称" class="layui-input" >
                    </div>

                    <label class="layui-form-label">软件名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="APKName" lay-verify="title" autocomplete="off" placeholder="请输入APK的名称" class="layui-input" >
                    </div>

                    <label class="layui-form-label">支持ROM</label>
                    <div class="layui-input-inline">
                        <input type="text" name="supportROM" lay-verify="title" autocomplete="off" placeholder="请输入ROM的名称" class="layui-input" >
                    </div>

                    <label class="layui-form-label">界面语言</label>
                    <div class="layui-input-inline">
                        <input type="text" name="interfaceLanguage" lay-verify="title" autocomplete="off" placeholder="请输入界面语言" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">

                        <label class="layui-form-label">APP状态</label>
                        <div class="layui-input-inline">
                            <select name="status" lay-filter="aihao">
                                <option value="">-请选择-</option>
                                <c:forEach items="${appStatus}" var="obj">
                                    <option value="${obj.id}">${obj.valueName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <label class="layui-form-label">所属平台</label>
                        <div class="layui-input-inline">
                            <select name="flatform.valueId" lay-filter="status">
                                <option value="">-请选择-</option>
                                <c:forEach items="${appFlatForms}" var="obj">
                                    <option value="${obj.valueId}">${obj.valueName}</option>
                                </c:forEach>
                            </select>
                        </div>

                    <label class="layui-form-label">一级分类</label>
                    <div class="layui-input-inline">
                        <select name="categoryLevel1.id" lay-filter="levelOne" id="levelOne">
                            <option value="">-请选择-</option>
                            <c:forEach items="${levelOne}" var="obj">
                                <option value="${obj.id}" >${obj.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <label class="layui-form-label">二级分类</label>
                    <div class="layui-input-inline">
                        <select name="categoryLevel2.id" lay-filter="levelTwo" id="levelTwo">
                            <option value="" >-请选择-</option>
                        </select>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">三级分类</label>
                    <div class="layui-input-inline">
                        <select name="categoryLevel3.id" lay-filter="levelThree" id="levelThree">
                            <option value="">-请选择-</option>
                        </select>
                    </div>

                    <label class="layui-form-label">软件大小</label>
                    <div class="layui-input-inline">
                        <input type="text" name="softwareSize" lay-verify="title" autocomplete="off" placeholder="请输入软件大小" class="layui-input">
                    </div>

                    <label class="layui-form-label">应用简介</label>
                    <div class="layui-input-inline">
                        <input type="text" name="appInfo" lay-verify="title" autocomplete="off" placeholder="请输入应用简介" class="layui-input" >
                    </div>
                </div>


                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>

        </div>
    </div>

    <jsp:include page="/jsp/common/footer.jsp" />
</div>
<%-- 引入layUI的js --%>
<script src="${ctx}/static/plugins/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use(['element','form','jquery'], function(){
        var element = layui.element;
        var form = layui.form;
        var $ = layui.jquery;
        form.render();

        // 一级分类start=============================================================
        form.on('select(levelOne)',function () {
            // 获取id
            var levelOneId = $('#levelOne').val();

            if(levelOneId == ''){
                // 清空levelTwo
                var html = '<option value="">-请选择-</option>';
                // 选择level2更新
                $('#levelTwo').html(html)
                form.render();
                return;
            } else {
                $.ajax({
                    url:'${ctx}/category/queryLevelTwoByLevelOne/' + levelOneId,
                    type:'get',
                    success:function (data) {
                        // 根据data修改数据，重新渲染
                        var html = '<option value="">-请选择-</option>';
                        var len = data.length;
                        // 取出二级分类
                        var levelTwo = '${appInfoDTO.levelTwo}';
                        /**
                         *  <c:if test="${obj.id eq appInfoDTO.appStatus}"> selected </c:if>
                         */
                        for(var i = 0; i < len; i++){
                            html += '<option value="'+data[i].id+'"';
                            if(data[i].id == levelTwo){
                                html += ' selected ';
                            }

                            html += '>' + data[i].categoryName+'</option>';
                        }

                        // 选择level2更新
                        $('#levelTwo').html(html)
                        form.render();
                    }
                });
            }
        });
        // 一级分类end=============================================================

        // 二级分类start=============================================================
        form.on('select(levelTwo)',function () {
            // 获取id
            var levelTwoId = $('#levelTwo').val();

            if(levelTwoId == ''){
                // 清空levelTwo
                var html = '<option value="">-请选择-</option>';
                // 选择level2更新
                $('#levelThree').html(html)
                form.render();
                return;
            } else {
                $.ajax({
                    url:'${ctx}/category/queryLevelThreeByLevelTwo/' + levelTwoId,
                    type:'get',
                    success:function (data) {
                        // 根据data修改数据，重新渲染
                        var html = '<option value="">-请选择-</option>';
                        var len = data.length;
                        for(var i = 0; i < len; i++){
                            html += '<option value="'+data[i].id+'">'+data[i].categoryName+'</option>';
                        }

                        // 选择level2更新
                        $('#levelThree').html(html)
                        form.render();
                    }
                });
            }
        });
        // 二级分类end=============================================================
    });
</script>
</body>
</html>
a
