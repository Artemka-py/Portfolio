using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Sale_App
{
    public partial class Authorization_Form : Form
    {
        public Authorization_Form()
        {
            InitializeComponent();
        }

        private void back_Color (object sender, EventArgs e)
        {
            if (sender is TextBox)
                (sender as TextBox).BackColor = Color.White;
        }

        private void btEnter_Click(object sender, EventArgs e)
        {
            switch(tb_User_Name.Text == "")
            {
                case true:
                    tb_User_Name.BackColor = Color.Red;
                    break;
                case false:
                    switch(tbUser_Password.Text == "")
                    {
                        case true:
                            tbUser_Password.BackColor = Color.Red;
                            break;
                        case false:
                            Funcrion_Class funcrion = new Funcrion_Class();
                            funcrion.Authorization(tb_User_Name.Text, tbUser_Password.Text);
                            switch (Program.intID == null)
                            {
                                case true:
                                    MessageBox.Show("1", "Продажа товара", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                    tb_User_Name.Clear();
                                    tbUser_Password.Clear();
                                    tb_User_Name.Focus();
                                    break;
                                case false:
                                    switch (Program.intDropStatis)
                                    {
                                        case 1:
                                            MessageBox.Show("2", "Продажа товара", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                            break;
                                        case 0:
                                            switch (Program.strStatus)
                                            {
                                                case "Klient":
                                                    //Personal_Profile_Klient profile_Klient = new Personal_Profile_Klient();
                                                    //profile_Klient.Show(this);
                                                    //Hide();
                                                    break;
                                                case "Employee":

                                                    break;
                                            }
                                            break;
                                    }
                                    break;
                                
                            }
                            break;
                    }
                    break;
            }
        }

        private void btLeave_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
