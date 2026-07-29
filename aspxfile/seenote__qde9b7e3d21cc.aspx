<html>
    <head>
        <title>过程 'adminBindNetmenu2' 需要参数 '@parentId'，但未提供该参数。</title>
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

            <h2> <i>过程 'adminBindNetmenu2' 需要参数 '@parentId'，但未提供该参数。</i> </h2></span>

            <font face="Arial, Helvetica, Geneva, SunSans-Regular, sans-serif ">

            <b> 说明: </b>执行当前 Web 请求期间，出现未处理的异常。请检查堆栈跟踪信息，以了解有关该错误以及代码中导致错误的出处的详细信息。

            <br><br>

            <b> 异常详细信息: </b>System.Data.SqlClient.SqlException: 过程 'adminBindNetmenu2' 需要参数 '@parentId'，但未提供该参数。<br><br>

            <b>源错误:</b> <br><br>

            <table width=100% bgcolor="#ffffcc">
               <tr>
                  <td>
                      <code><pre>

行 6:      Public Sub initleftmenu()
行 7:          CBind = New Baseclasses
<font color=red>行 8:          leftmenu1.Text = CBind.BindWebLeftMenu(Session(&quot;islanguage&quot;), Session(&quot;pid&quot;))
</font>行 9:          If Session(&quot;islanguage&quot;) &lt;&gt; &quot;EN&quot; Then
行 10:             Image1.ImageUrl = &quot;images/leftlogo.jpg&quot;</pre></code>

                  </td>
               </tr>
            </table>

            <br>

            <b> 源文件: </b> D:\www\web\jdzch18.com\www\leftmenu.ascx.vb<b> &nbsp;&nbsp; 行: </b> 8
            <br><br>

            <b>堆栈跟踪:</b> <br><br>

            <table width=100% bgcolor="#ffffcc">
               <tr>
                  <td>
                      <code><pre>

[SqlException (0x80131904): 过程 'adminBindNetmenu2' 需要参数 '@parentId'，但未提供该参数。]
   System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection) +1950906
   System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection) +4846891
   System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj) +194
   System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj) +2392
   System.Data.SqlClient.SqlDataReader.ConsumeMetaData() +33
   System.Data.SqlClient.SqlDataReader.get_MetaData() +83
   System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString) +297
   System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async) +954
   System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result) +162
   System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method) +32
   System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method) +141
   System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior) +12
   System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior) +10
   System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior) +130
   System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior) +287
   System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, String srcTable) +92
   webbasedll.SqlData.RunProcedure(String storedProcName, IDataParameter[] parameters, String tableName) +166
   webbasedll.Baseclasses.BindWebMenu2(String sys_id, String parentId) +247
   webbasedll.Baseclasses.BindWebLeftMenu(String sysid, String pid) +111
   leftmenu.initleftmenu() in D:\www\web\jdzch18.com\www\leftmenu.ascx.vb:8
   seenote.Page_Load(Object sender, EventArgs e) in D:\www\web\jdzch18.com\www\seenote.aspx.vb:26
   System.Web.UI.Control.OnLoad(EventArgs e) +99
   System.Web.UI.Control.LoadRecursive() +50
   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +627
</pre></code>

                  </td>
               </tr>
            </table>

            <br>

            <hr width=100% size=1 color=silver>

            <b>版本信息:</b>&nbsp;Microsoft .NET Framework 版本:2.0.50727.3662; ASP.NET 版本:2.0.50727.3668

            </font>

    </body>
</html>
<!-- 
[SqlException]: 过程 'adminBindNetmenu2' 需要参数 '@parentId'，但未提供该参数。
   在 System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
   在 System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
   在 System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
   在 System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
   在 System.Data.SqlClient.SqlDataReader.ConsumeMetaData()
   在 System.Data.SqlClient.SqlDataReader.get_MetaData()
   在 System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   在 System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
   在 System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
   在 System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
   在 System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method)
   在 System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
   在 System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
   在 System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   在 System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
   在 System.Data.Common.DbDataAdapter.Fill(DataSet dataSet, String srcTable)
   在 webbasedll.SqlData.RunProcedure(String storedProcName, IDataParameter[] parameters, String tableName)
   在 webbasedll.Baseclasses.BindWebMenu2(String sys_id, String parentId)
   在 webbasedll.Baseclasses.BindWebLeftMenu(String sysid, String pid)
   在 leftmenu.initleftmenu() 位置 D:\www\web\jdzch18.com\www\leftmenu.ascx.vb:行号 8
   在 seenote.Page_Load(Object sender, EventArgs e) 位置 D:\www\web\jdzch18.com\www\seenote.aspx.vb:行号 26
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
   在 ASP.seenote_aspx.ProcessRequest(HttpContext context)
   在 System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   在 System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)
--><!-- 
此错误页可能包含敏感信息，因为 ASP.NET 通过 &lt;customErrors mode="Off"/&gt; 被配置为显示详细错误消息。请考虑在生产环境中使用 &lt;customErrors mode="On"/&gt; 或 &lt;customErrors mode="RemoteOnly"/&gt;。-->