<html>
    <head>
        <title>超时时间已到。在操作完成之前超时时间已过或服务器未响应。</title>
        <style>
         body {font-family:"Verdana";font-weight:normal;font-size: .7em;color:black;} 
         p {font-family:"Verdana";font-weight:normal;color:black;margin-top: -5px}
         b {font-family:"Verdana";font-weight:bold;color:black;margin-top: -5px}
         H1 { font-family:"Verdana";font-weight:normal;font-size:18pt;color:red }
         H2 { font-family:"Verdana";font-weight:normal;font-size:14pt;color:maroon }
         pre {font-family:"Lucida Console";font-size: .9em}
         .marker {font-weight: bold; color: black;text-decoration: none;}
         .version {color: gray;}
         .error {margin-bottom: 10px;}
         .expandable { text-decoration:underline; font-weight:bold; color:navy; cursor:hand; }
        </style>
    </head>

    <body bgcolor="white">

            <span><H1>“/”应用程序中的服务器错误。<hr width=100% size=1 color=silver></H1>

            <h2> <i>超时时间已到。在操作完成之前超时时间已过或服务器未响应。</i> </h2></span>

            <font face="Arial, Helvetica, Geneva, SunSans-Regular, sans-serif ">

            <b> 说明: </b>执行当前 Web 请求期间，出现未处理的异常。请检查堆栈跟踪信息，以了解有关该错误以及代码中导致错误的出处的详细信息。

            <br><br>

            <b> 异常详细信息: </b>System.Data.SqlClient.SqlException: 超时时间已到。在操作完成之前超时时间已过或服务器未响应。<br><br>

            <b>源错误:</b> <br><br>

            <table width=100% bgcolor="#ffffcc">
               <tr>
                  <td>
                      <code><pre>

行 38:         'End If
行 39:         '   tbmenu.Text = CBind.BindTopMenu1(sysid.Text)
<font color=red>行 40:         tbmenu.Text = CBind.BindTopMenuNew(sysid.Text)
</font>行 41:         '   CBind.BindWebTopMenu(Menu1, sysid.Text)
行 42:     End Sub</pre></code>

                  </td>
               </tr>
            </table>

            <br>

            <b> 源文件: </b> D:\www\web\jdzch18.com\www\topmenu.ascx.vb<b> &nbsp;&nbsp; 行: </b> 40
            <br><br>

            <b>堆栈跟踪:</b> <br><br>

            <table width=100% bgcolor="#ffffcc">
               <tr>
                  <td>
                      <code><pre>

[SqlException (0x80131904): 超时时间已到。在操作完成之前超时时间已过或服务器未响应。]
   System.Data.ProviderBase.DbConnectionPool.GetConnection(DbConnection owningObject) +428
   System.Data.ProviderBase.DbConnectionFactory.GetConnection(DbConnection owningConnection) +65
   System.Data.ProviderBase.DbConnectionClosed.OpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory) +117
   System.Data.SqlClient.SqlConnection.Open() +122
   webbasedll.SqlData.RunProcedure(String storedProcName, IDataParameter[] parameters, String tableName) +82
   webbasedll.Baseclasses.BindWebMenu1(String sys_id) +171
   webbasedll.Baseclasses.BindTopMenuNew(String sysid) +283
   topmenu.initusercontrol() in D:\www\web\jdzch18.com\www\topmenu.ascx.vb:40
   top.inittop() in D:\www\web\jdzch18.com\www\top.ascx.vb:19
   showimginf.Page_Load(Object sender, EventArgs e) in D:\www\web\jdzch18.com\www\showimginf.aspx.vb:25
   System.Web.UI.Control.OnLoad(EventArgs e) +99
   System.Web.UI.Control.LoadRecursive() +50
   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +627
</pre></code>

                  </td>
               </tr>
            </table>

            <br>

            <hr width=100% size=1 color=silver>

            <b>版本信息:</b>&nbsp;Microsoft .NET Framework 版本:2.0.50727.8669; ASP.NET 版本:2.0.50727.5491

            </font>

    </body>
</html>
<!-- 
[SqlException]: 超时时间已到。在操作完成之前超时时间已过或服务器未响应。
   在 System.Data.ProviderBase.DbConnectionPool.GetConnection(DbConnection owningObject)
   在 System.Data.ProviderBase.DbConnectionFactory.GetConnection(DbConnection owningConnection)
   在 System.Data.ProviderBase.DbConnectionClosed.OpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory)
   在 System.Data.SqlClient.SqlConnection.Open()
   在 webbasedll.SqlData.RunProcedure(String storedProcName, IDataParameter[] parameters, String tableName)
   在 webbasedll.Baseclasses.BindWebMenu1(String sys_id)
   在 webbasedll.Baseclasses.BindTopMenuNew(String sysid)
   在 topmenu.initusercontrol() 位置 D:\www\web\jdzch18.com\www\topmenu.ascx.vb:行号 40
   在 top.inittop() 位置 D:\www\web\jdzch18.com\www\top.ascx.vb:行号 19
   在 showimginf.Page_Load(Object sender, EventArgs e) 位置 D:\www\web\jdzch18.com\www\showimginf.aspx.vb:行号 25
   在 System.Web.UI.Control.OnLoad(EventArgs e)
   在 System.Web.UI.Control.LoadRecursive()
   在 System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
[HttpUnhandledException]: 引发类型为“System.Web.HttpUnhandledException”的异常。
   在 System.Web.UI.Page.HandleError(Exception e)
   在 System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
   在 System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
   在 System.Web.UI.Page.ProcessRequest()
   在 System.Web.UI.Page.ProcessRequestWithNoAssert(HttpContext context)
   在 System.Web.UI.Page.ProcessRequest(HttpContext context)
   在 ASP.showimginf_aspx.ProcessRequest(HttpContext context)
   在 System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   在 System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)
--><!-- 
此错误页可能包含敏感信息，因为 ASP.NET 通过 &lt;customErrors mode="Off"/&gt; 被配置为显示详细错误消息。请考虑在生产环境中使用 &lt;customErrors mode="On"/&gt; 或 &lt;customErrors mode="RemoteOnly"/&gt;。-->