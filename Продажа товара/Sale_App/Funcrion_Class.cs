using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace Sale_App
{
    public class Funcrion_Class
    {
        public DataTable restable = new DataTable();
        /// <summary>
        /// Вызов функции авториации 
        /// </summary>
        /// <param> name="login"</param>
        /// <param> name="password"</param>
        /// 
        public void Authorization(string Login, string Password)
        {
            Table_Class table = new Table_Class(string.Format("Select [ID_Record], " + "[Status],[Drop_status] from [dbo].[Authorization]('{0}','{1}')",
                Login, Password));
            try
            {
                //присвоение в статитеческую переменную строковую первичного ключа
                Program.intID = table.table.Rows[0][0].ToString();
                //Проверка на пустоту первичного ключа
                if (Program.intID != null)
                {
                    Program.strStatus = table.table.Rows[0][1].ToString();
                    Program.intDropStatis = Convert.ToInt32(table.table.Rows[0][2].ToString());
                }
            }
            catch
            {

            }
        }
        /// <summary>
        /// Класс работы с функциями бд
        /// </summary>
        public Funcrion_Class()
        {

        }

        public Funcrion_Class(string Function_name, string type_function)
        {
            string query = "";
            switch(type_function)
            {
                case "scalar":
                    query = string.Format(@"select [dbo].[{0}]()", Function_name);
                    break;
                case "table":
                     query = string.Format(@"select * from [dbo].[{0}]()", Function_name);
                    break;
            }
            try
            {
                Table_Class table = new Table_Class(query);
                restable = table.table;
            }
            catch
            {

            }
        }

        public Funcrion_Class(string Function_name, string type_function, ArrayList parametrs)
        {
            string query = "";
            try
            {
                switch (type_function)
                {
                    case "scalar":
                        query = string.Format(@"select [dbo].[{0}]()", Function_name);
                        break;
                    case "table":
                        query = string.Format(@"select * from [dbo].[{0}]()", Function_name);
                        break;
                }
                string list_param = "";
                switch (parametrs.Count)
                {
                    case 1:
                        list_param += parametrs[0].ToString() + ")";
                        break;
                    default:
                        foreach(object param in parametrs)
                        {
                            list_param += param + ",";
                        }
                        list_param = list_param.Remove(list_param.Length - 1, 1);
                        list_param += ")";
                        break;
                }
                query += list_param;
                Table_Class table = new Table_Class(query);
                restable = table.table;
            }
            catch
            {

            }
        }
    }

}
