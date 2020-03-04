using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Sale_App
{
    public partial class Personal_Profile_Klient : Form
    {
        string Card_Number = "", Card_Create = "",
            Klient_First_Name = "", Klient_Name = "",
            KLient_Middle_Name = "", Login = "", Password = "";

        private void dtpStartDate_ValueChanged(object sender, EventArgs e)
        {
            Statistic_Fill();
        }

        private void Personal_Profile_Klient_Load(object sender, EventArgs e)
        {
            Thread thread = new Thread(Klient_Data_Fill);
            thread.Start();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void Personal_Profile_Klient_FormClosing(object sender, FormClosingEventArgs e)
        {
            switch (MessageBox.Show("Вы действительно хотите выйти из профиля и \nперейти в авторизацию?", "Продажа товара", 
                MessageBoxButtons.YesNo, MessageBoxIcon.Question))
            {
                case DialogResult.Yes:
                    ((Authorization_Form)Owner).Show();
                    e.Cancel = false;
                    Program.intID = "";
                    Program.strStatus = "";
                    Program.intDropStatis = 0;
                    break;
                case DialogResult.No:
                    e.Cancel = true;
                    break;
            }
        }

        public Personal_Profile_Klient()
        {
            InitializeComponent();
        }

        private void Klient_Data_Fill()
        {
            Action action = () =>
            {
                Table_Class table_Class = new Table_Class("SELECT [ID_Klient],[First_Name_Klient],[Name_Klient],[Middle_Name_Klient],[Klient_Card],[Klient_Card_Create],[Klient_Login]," +
                    "[Klient_Password],[Klinet_Logical_Delete] FROM [Sale_Data_Base].[dbo].[Klient] WHERE [dbo].[Klient].[ID_Klient] = " + Program.intID);
                table_Class.Dependency.OnChange += Dependency_OnChange;
                Card_Number = table_Class.table.Rows[0][4].ToString();
                Card_Create = table_Class.table.Rows[0][3].ToString();
                Klient_First_Name = table_Class.table.Rows[0][0].ToString();
                Klient_Name = table_Class.table.Rows[0][1].ToString();
                KLient_Middle_Name = table_Class.table.Rows[0][2].ToString();
                Login = table_Class.table.Rows[0][5].ToString();
                Password = table_Class.table.Rows[0][6].ToString();
                lblKlinet_Surname.Text = "Фамилия: " + Klient_First_Name;
                lblKlinet_Name.Text = "Имя: " + Klient_Name;
                lblKlinet_Middlename.Text = "Отчество: " + KLient_Middle_Name;
                lblKlinet_Create.Text = "Дата создания уч. записи: " + Card_Create;
                lblKlient_Card_Number.Text = "Карта №: " + Card_Number;
                tbFirst_Name.Text = Klient_First_Name;
                tbName.Text = Klient_Name;
                tbMiddle_Name.Text = KLient_Middle_Name;
                tbLogin.Text = Login;
                dtpStartDate.Value = Convert.ToDateTime(Card_Create);
            };
            Invoke(action);
            Thread thread = new Thread(Klient_Check_History_Fill);
            Thread thread1 = new Thread(Klient_Top_5_Product_Fill);
            thread.Start();
            thread1.Start();
        }

        private void Klient_Check_History_Fill()
        {
            Action action = () =>
            {
                ArrayList list = new ArrayList();
                list.Clear();
                list.Add(string.Format("'{0}'", Card_Number));
                Funcrion_Class funcrion = new Funcrion_Class("Klient_Check_History", "table", list);
                foreach (DataRow row in funcrion.restable.Rows)
                {
                    int new_row = 0;
                    string txt = row[3].ToString();
                    Label text = new Label();
                    text.Dock = DockStyle.Top;
                    foreach(char ch in txt)
                    {
                        if (ch == ';')
                        {
                            new_row += 1;
                            text.Text += new_row + "\n--------------------\n";
                        }
                        else
                        {
                            text.Text += ch;
                        }
                    }
                    text.AutoSize = true;
                    text.AutoEllipsis = true;
                    Label label = new Label();
                    label.AutoSize = true;
                    label.Name = "lbl" + row[0];
                    label.Text = "Номер чека: " + row[0].ToString() + "\nДата продажи: " + row[1].ToString() + "\nСостав:";
                    label.Dock = DockStyle.Top;
                    Label Full_Price = new Label();
                    Full_Price.AutoSize = true;
                    Full_Price.Text = "Итог: " + row[2].ToString();
                    Full_Price.Dock = DockStyle.Bottom;
                    Panel panel = new Panel();
                    panel.Name = "pn" + row[0];
                    panel.Height = label.Height + ((text.Height + 30) * new_row) + Full_Price.Height + 100;
                    panel.Dock = DockStyle.Top;
                    panel.BorderStyle = BorderStyle.Fixed3D;
                    panel.Controls.Add(Full_Price);
                    panel.Controls.Add(text);
                    panel.Controls.Add(label);
                    tbpgKlientChekcHistory.Controls.Add(panel);
                }
            };
            Invoke(action);
        }

        private void Dependency_OnChange(object sender, System.Data.SqlClient.SqlNotificationEventArgs e)
        {
            if (e.Info != System.Data.SqlClient.SqlNotificationInfo.Invalid)
                Klient_Data_Fill();
        }

        private void Klient_Top_5_Product_Fill()
        {
            Action action = () =>
            {
                ArrayList list = new ArrayList();
                list.Clear();
                list.Add(string.Format("'{0}'", Card_Number));
                Funcrion_Class funcrion = new Funcrion_Class("Klient_Top_5_Product_Fill", "table", list);
                lstbxKlient_Top_5_Product.Items.Clear();
                for(int i = 0; i<funcrion.restable.Rows.Count; i++)
                {
                    lstbxKlient_Top_5_Product.Items.Add(string.Format("{0}.{1}, куплено {2} раз", (int)i + 1, 
                        funcrion.restable.Rows[i][0].ToString(), funcrion.restable.Rows[i][1].ToString()));
                }
            };
            Invoke(action);
        }

        private void Statistic_Fill()
        {
            Action action = () =>
            {
                ArrayList list = new ArrayList();
                list.Clear();
                list.Add(string.Format("'{0}'", Card_Number));
                list.Add(string.Format("'" + dtpStartDate.Value.ToString() + "'", "dd.MM.yyyy"));
                list.Add(string.Format("'" + dtpEndDate.Value.ToString() + "'", "dd.MM.yyyy"));
                Funcrion_Class funcrion = new Funcrion_Class("Klient_Expenses", "table", list);
                chrExpencens.Series["srExpens"].Points.Clear();
                chrExpencens.Series["srExpens"].LegendText = "Затраты за период времени";
                foreach(DataRow r in funcrion.restable.Rows)
                {
                    chrExpencens.Series["srExpens"].Points.AddXY(string.Format("{0}.{1}", r[0].ToString(), r[1].ToString()), r[2]);
                }
            };
            Invoke(action);
        }
    }
}
