using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Text;
using System.Data;
using PMS;

/// <summary>
/// Summary description for UserMenuLog
/// </summary>
public class UserMenuLog
{
    SQLProcs sqlobj = new SQLProcs();

	public void InsertUserMenuLog(string userid,string modulename,DateTime datestamp)
	{
        sqlobj.ExecuteSQLNonQuery("SP_InsertUserMenuLog",
                      new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = userid.ToString() },
                      new SqlParameter() { ParameterName = "@ModuleName", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = modulename.ToString() },
                      new SqlParameter() { ParameterName = "@DateStamp", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = datestamp.ToString() }

                      );
	}
}