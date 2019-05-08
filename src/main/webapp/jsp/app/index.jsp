<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%-- 引入layUI的cs --%>
    <link rel="stylesheet" href="${ctx}/static/plugins/layui/css/layui.css">

    <style>

    </style>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="/jsp/common/header.jsp" />

    <div class="layui-body">

        <form class="layui-form" action="${ctx}/app/query" method="post" style="margin-top: 20px;">
            <div class="layui-form-item">

                <%-- 隐藏域，用于提交当前页码 --%>
                <div class="layui-input-inline">
                    <input type="hidden" name="pageNum" lay-verify="title" value="1">
                </div>

                <label class="layui-form-label">软件名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="softwareName" lay-verify="title" autocomplete="off" placeholder="请输入软件的名称" class="layui-input" value="${appInfoDTO.softwareName}">
                </div>

                <label class="layui-form-label">APP状态</label>
                <div class="layui-input-inline">
                    <select name="appStatus" lay-filter="aihao">
                        <option value="">-请选择-</option>
                        <c:forEach items="${appStatus}" var="obj">
                            <option value="${obj.id}" <c:if test="${obj.id eq appInfoDTO.appStatus}"> selected </c:if> >${obj.valueName}</option>
                        </c:forEach>
                    </select>
                </div>

                <label class="layui-form-label">所属平台</label>
                <div class="layui-input-inline">
                    <select name="appFlatForm" lay-filter="aihao">
                        <option value="">-请选择-</option>
                        <c:forEach items="${appFlatForms}" var="obj">
                            <option value="${obj.id}" <c:if test="${obj.id eq appInfoDTO.appFlatForm}"> selected </c:if> >${obj.valueName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">一级分类</label>
                <div class="layui-input-inline">
                    <select name="levelOne" lay-filter="levelOne" id="levelOne">
                        <option value="">-请选择-</option>
                        <c:forEach items="${levelOne}" var="obj">
                            <option value="${obj.id}" <c:if test="${obj.id eq appInfoDTO.levelOne}"> selected </c:if> >${obj.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <label class="layui-form-label">二级分类</label>
                <div class="layui-input-inline">
                    <select name="levelTwo" lay-filter="levelTwo" id="levelTwo">
                        <option value="" >-请选择-</option>
                    </select>
                </div>

                <label class="layui-form-label">三级分类</label>
                <div class="layui-input-inline">
                    <select name="levelThree" lay-filter="levelThree" id="levelThree">
                        <option value="">-请选择-</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    <a class="layui-btn" href="${ctx}/app/toAdd">新增APP基础信息</a>
                </div>
            </div>
        </form>

        <%--<div class="layui-input-block">

        </div>--%>

        <table class="layui-table">
            <thead>
                <tr>
                    <th>软件名称</th>
                    <th width="30px">APK名称</th>
                    <th>软件大小（单位M）</th>
                    <th>所属平台</th>
                    <th width="80px">所属分类（一级分类）、（二级分类）、（三级分类）</th>
                    <th>状态</th>
                    <th>下载次数</th>
                    <th>最新版本号</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${page.list}" var="obj">
                    <tr>
                        <td>${obj.softwareName}</td>
                        <td width="30px">${obj.APKName}</td>
                        <td>${obj.softwareSize}</td>
                        <td>${obj.flatform.valueName}</td>
                        <td>
                            ${obj.categoryLevel1.categoryName}->${obj.categoryLevel2.categoryName}->${obj.categoryLevel3.categoryName}
                        </td>
                        <td>
                           ${obj.appStatus.valueName}
                        </td>
                        <td>${obj.downloads}</td>
                        <td>${obj.newAppVersion.versionNo}</td>
                        <td>
                            <%-- 编辑 --%>
                            <a href="${ctx}/app/toEdit/${obj.id}" class="layui-btn layui-btn-normal"><i class="layui-icon">&#xe642;</i></a>
                            <%-- 删除 --%>
                            <a href="${ctx}/app/delete/${obj.id}" class="layui-btn layui-btn-danger" ><i class="layui-icon">&#xe640;</i></a>
                            <%-- 搜索 --%>
                            <a href="${ctx}/app/queryById/${obj.id}" class="layui-btn"><i class="layui-icon">&#xe615;</i></a>


                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="1">
                        共${page.total}条记录 第${page.pageNum}/${page.pages}页
                    </td>
                    <td colspan="8">
                        <%--
                        javascript:void（0） void是无返回值的操作，点击这个时候没有任何反应。
                        而且如果在a标签中，如果href="#"，点击后会回到网页顶部，javascript:void(0)
                        会没有任何反应
                        --%>
                        <a href="javascript:void(0);" page="first">首页</a>
                        <a href="javascript:void(0);" page="pre">上一页</a>
                        <a href="javascript:void(0);" page="next">下一页</a>
                        <a href="javascript:void(0);" page="last">尾页</a>
                    </td>
                </tr>
            </tbody>
        </table>

        <%--<div style="padding: 15px;">内容主体区域</div>--%>
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

        // 分页事件start=============================================================
        $('a[page]').click(function () {
            var pageNum = 1;
            // 获取当前页码
            var currPage = '${page.pageNum}';
            // 获取总页码
            var totalPages = '${page.pages}';
            // 获取标签page中的属性
            var v = $(this).attr('page');
            switch (v) {
                case 'first':
                    pageNum = 1;
                    break;
                case 'pre':
                    pageNum = currPage - 1;
                    if(pageNum < 1) {
                        pageNum = 1;
                    }
                    break;
                case 'next':
                    pageNum = parseInt(currPage) + 1;
                    if(pageNum > totalPages){
                        pageNum = totalPages;
                    }
                    break;
                case 'last':
                    pageNum = totalPages;
                    break;
            }

            // 更新隐藏域里面的值
            $('input[name = pageNum]').val(pageNum);

            // 整体提交表单
            $('form').submit();
        })
        // 分页事件end=============================================================

        // 关联选中end=============================================================
        $(function () {
            // 取出一级分类的值
            var levelOne = $('#levelOne').val();
            // 一级曾经选过
            if(levelOne != '' && levelOne != null){
                var levelTwo = '${appInfoDTO.levelTwo}';
                // 二级曾经选过
                if(levelTwo != '' && levelTwo!= undefined && levelTwo != null){
                    // 这里就需要重现渲染二级的selected

                    $.ajax({
                        url:'${ctx}/category/queryLevelTwoByLevelOne/' + levelOne,
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


                    // 如果三级条件不为空，也去更新
                    var levelThree = '${appInfoDTO.levelThree}';
                    $.ajax({
                        url:'${ctx}/category/queryLevelThreeByLevelTwo/' + levelTwo,
                        type:'get',
                        success:function (data) {
                            // 根据data修改数据，重新渲染
                            var html = '<option value="">-请选择-</option>';
                            var len = data.length;
                            for(var i = 0; i < len; i++){
                                html += '<option value="'+data[i].id+'"';
                                if(data[i].id == levelThree){
                                    html += ' selected ';
                                }

                                html += '>' + data[i].categoryName+'</option>';
                            }

                            // 选择level2更新
                            $('#levelThree').html(html)
                            form.render();
                        }
                    });
                }
            }
        });
        // 关联选中end=============================================================

    });
</script>
</body>
</html>
