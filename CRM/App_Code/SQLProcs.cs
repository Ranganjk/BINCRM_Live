using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.IO;


namespace PMS
{
    public class SQLProcs
    {

        private string conn = ConfigurationManager.ConnectionStrings["PMS"].ToString();
        public DataSet SQLExecuteDataset(string query)
        {
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand();
            try
            {
                cmd.Connection = con;
                cmd.CommandText = query;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }          
            finally            
            {
                con.Dispose();

                cmd.Dispose();
            }
        }



        //public int ExecuteNonQuery(string spName, params DbParameter[] arguments)
        //{
        //    clcommon objclcommon = new clcommon();
        //    Database db = DatabaseFactory.CreateDatabase();
        //    DbCommand dbCommand = null;
        //    InOutParameters = new Dictionary<string, DbParameter>();

        //    try
        //    {
        //        int returnValue = 0;
        //        dbCommand = db.GetStoredProcCommand(spName);
        //        for (int i = 0; i < arguments.Length; i++)
        //        {
        //            dbCommand.Parameters.Add(arguments[i]);
        //        }
        //        returnValue = db.ExecuteNonQuery(dbCommand);

        //        foreach (DbParameter para in dbCommand.Parameters)
        //        {
        //            if ((para.Direction == ParameterDirection.Output) || (para.Direction == ParameterDirection.InputOutput))
        //            {
        //                InOutParameters.Add(para.ParameterName, para);
        //            }
        //        }
        //        dbCommand.Parameters.Clear();
        //        return returnValue;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    finally
        //    {
        //        objclcommon = null;
        //        db = null;
        //        dbCommand.Dispose();

        //    }
        //}

        public int ExecuteSQLNonQuery(string query, params SqlParameter[] sqlParams)
        {
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand();
            try
            {
                con.Open();
                cmd.Connection = con;
                foreach (SqlParameter param in sqlParams)
                {
                    cmd.Parameters.Add(param);
                }
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = query;
                return cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }
        }

        public DataSet SQLExecuteDataset(string spName,params SqlParameter[] sqlParams)
        {
            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand();
            DataSet ds = new DataSet();
            try
            {
                cmd.Connection = con;
                foreach (SqlParameter param in sqlParams)
                {
                    cmd.Parameters.Add(param);
                }
                cmd.CommandText = spName;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                return ds;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

       


        


      


       



    }
}
