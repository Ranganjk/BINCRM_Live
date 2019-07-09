using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Text;
using System.Data;
using PMS;

/// <summary>
/// Summary description for LeadCategory
/// </summary>
public class LeadCategory
{
    SQLProcs sqlobj = new SQLProcs();


    public void Save(string CategoryCode, string LeadCategory, string UserID, string procedurename)
    {
        
        sqlobj.ExecuteSQLNonQuery(procedurename,
                       new SqlParameter() { ParameterName = "@CatCode", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = CategoryCode.ToString()  },
                       new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = LeadCategory.ToString() },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = UserID.ToString() }

                       );

    }
}