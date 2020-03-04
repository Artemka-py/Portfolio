namespace Sale_App
{
    partial class Personal_Profile_Klient
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.panel1 = new System.Windows.Forms.Panel();
            this.button1 = new System.Windows.Forms.Button();
            this.gbKlient_Personal = new System.Windows.Forms.GroupBox();
            this.tbctrlKlient = new System.Windows.Forms.TabControl();
            this.tbpgKlientExpenses = new System.Windows.Forms.TabPage();
            this.chrExpencens = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.dtpEndDate = new System.Windows.Forms.DateTimePicker();
            this.lblEnd_Date = new System.Windows.Forms.Label();
            this.dtpStartDate = new System.Windows.Forms.DateTimePicker();
            this.lblStartDate = new System.Windows.Forms.Label();
            this.tbpgKLientTopProduct = new System.Windows.Forms.TabPage();
            this.lstbxKlient_Top_5_Product = new System.Windows.Forms.ListBox();
            this.tbpgKlientChekcHistory = new System.Windows.Forms.TabPage();
            this.tbpgKlientProfile = new System.Windows.Forms.TabPage();
            this.tblltpnKLinet_Information = new System.Windows.Forms.TableLayoutPanel();
            this.tbConfermPassword = new System.Windows.Forms.TextBox();
            this.tbPassword = new System.Windows.Forms.TextBox();
            this.tbLogin = new System.Windows.Forms.TextBox();
            this.tbMiddle_Name = new System.Windows.Forms.TextBox();
            this.tbName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.tbFirst_Name = new System.Windows.Forms.TextBox();
            this.btSave = new System.Windows.Forms.Button();
            this.lblKlient_Card_Number = new System.Windows.Forms.Label();
            this.lblKlinet_Create = new System.Windows.Forms.Label();
            this.lblKlinet_Middlename = new System.Windows.Forms.Label();
            this.lblKlinet_Name = new System.Windows.Forms.Label();
            this.lblKlinet_Surname = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.gbKlient_Personal.SuspendLayout();
            this.tbctrlKlient.SuspendLayout();
            this.tbpgKlientExpenses.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.chrExpencens)).BeginInit();
            this.tbpgKLientTopProduct.SuspendLayout();
            this.tbpgKlientProfile.SuspendLayout();
            this.tblltpnKLinet_Information.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.button1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel1.Location = new System.Drawing.Point(0, 655);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(779, 44);
            this.panel1.TabIndex = 0;
            // 
            // button1
            // 
            this.button1.Dock = System.Windows.Forms.DockStyle.Right;
            this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.button1.Location = new System.Drawing.Point(653, 0);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(126, 44);
            this.button1.TabIndex = 0;
            this.button1.Text = "Закрыть";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // gbKlient_Personal
            // 
            this.gbKlient_Personal.Controls.Add(this.tbctrlKlient);
            this.gbKlient_Personal.Controls.Add(this.lblKlient_Card_Number);
            this.gbKlient_Personal.Controls.Add(this.lblKlinet_Create);
            this.gbKlient_Personal.Controls.Add(this.lblKlinet_Middlename);
            this.gbKlient_Personal.Controls.Add(this.lblKlinet_Name);
            this.gbKlient_Personal.Controls.Add(this.lblKlinet_Surname);
            this.gbKlient_Personal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gbKlient_Personal.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.gbKlient_Personal.Location = new System.Drawing.Point(0, 0);
            this.gbKlient_Personal.Name = "gbKlient_Personal";
            this.gbKlient_Personal.Size = new System.Drawing.Size(779, 655);
            this.gbKlient_Personal.TabIndex = 1;
            this.gbKlient_Personal.TabStop = false;
            this.gbKlient_Personal.Text = "Персональные данные";
            // 
            // tbctrlKlient
            // 
            this.tbctrlKlient.Controls.Add(this.tbpgKlientExpenses);
            this.tbctrlKlient.Controls.Add(this.tbpgKLientTopProduct);
            this.tbctrlKlient.Controls.Add(this.tbpgKlientChekcHistory);
            this.tbctrlKlient.Controls.Add(this.tbpgKlientProfile);
            this.tbctrlKlient.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tbctrlKlient.Location = new System.Drawing.Point(3, 158);
            this.tbctrlKlient.Name = "tbctrlKlient";
            this.tbctrlKlient.SelectedIndex = 0;
            this.tbctrlKlient.Size = new System.Drawing.Size(773, 494);
            this.tbctrlKlient.TabIndex = 5;
            // 
            // tbpgKlientExpenses
            // 
            this.tbpgKlientExpenses.Controls.Add(this.chrExpencens);
            this.tbpgKlientExpenses.Controls.Add(this.dtpEndDate);
            this.tbpgKlientExpenses.Controls.Add(this.lblEnd_Date);
            this.tbpgKlientExpenses.Controls.Add(this.dtpStartDate);
            this.tbpgKlientExpenses.Controls.Add(this.lblStartDate);
            this.tbpgKlientExpenses.Location = new System.Drawing.Point(4, 34);
            this.tbpgKlientExpenses.Name = "tbpgKlientExpenses";
            this.tbpgKlientExpenses.Padding = new System.Windows.Forms.Padding(3);
            this.tbpgKlientExpenses.Size = new System.Drawing.Size(765, 456);
            this.tbpgKlientExpenses.TabIndex = 0;
            this.tbpgKlientExpenses.Text = "Затраты";
            this.tbpgKlientExpenses.UseVisualStyleBackColor = true;
            // 
            // chrExpencens
            // 
            chartArea1.Name = "ChartArea1";
            this.chrExpencens.ChartAreas.Add(chartArea1);
            this.chrExpencens.Dock = System.Windows.Forms.DockStyle.Fill;
            legend1.Name = "Legend1";
            this.chrExpencens.Legends.Add(legend1);
            this.chrExpencens.Location = new System.Drawing.Point(3, 119);
            this.chrExpencens.Name = "chrExpencens";
            series1.BackSecondaryColor = System.Drawing.Color.Transparent;
            series1.BorderColor = System.Drawing.Color.White;
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series1.Color = System.Drawing.Color.Red;
            series1.Legend = "Legend1";
            series1.Name = "srExpens";
            this.chrExpencens.Series.Add(series1);
            this.chrExpencens.Size = new System.Drawing.Size(759, 334);
            this.chrExpencens.TabIndex = 4;
            this.chrExpencens.Text = "chart1";
            // 
            // dtpEndDate
            // 
            this.dtpEndDate.Dock = System.Windows.Forms.DockStyle.Top;
            this.dtpEndDate.Location = new System.Drawing.Point(3, 87);
            this.dtpEndDate.Name = "dtpEndDate";
            this.dtpEndDate.Size = new System.Drawing.Size(759, 32);
            this.dtpEndDate.TabIndex = 3;
            // 
            // lblEnd_Date
            // 
            this.lblEnd_Date.AutoSize = true;
            this.lblEnd_Date.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblEnd_Date.Location = new System.Drawing.Point(3, 61);
            this.lblEnd_Date.Name = "lblEnd_Date";
            this.lblEnd_Date.Size = new System.Drawing.Size(164, 26);
            this.lblEnd_Date.TabIndex = 2;
            this.lblEnd_Date.Text = "Конечная дата";
            // 
            // dtpStartDate
            // 
            this.dtpStartDate.Dock = System.Windows.Forms.DockStyle.Top;
            this.dtpStartDate.Location = new System.Drawing.Point(3, 29);
            this.dtpStartDate.Name = "dtpStartDate";
            this.dtpStartDate.Size = new System.Drawing.Size(759, 32);
            this.dtpStartDate.TabIndex = 1;
            this.dtpStartDate.ValueChanged += new System.EventHandler(this.dtpStartDate_ValueChanged);
            // 
            // lblStartDate
            // 
            this.lblStartDate.AutoSize = true;
            this.lblStartDate.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblStartDate.Location = new System.Drawing.Point(3, 3);
            this.lblStartDate.Name = "lblStartDate";
            this.lblStartDate.Size = new System.Drawing.Size(178, 26);
            this.lblStartDate.TabIndex = 0;
            this.lblStartDate.Text = "Начальная дата";
            // 
            // tbpgKLientTopProduct
            // 
            this.tbpgKLientTopProduct.Controls.Add(this.lstbxKlient_Top_5_Product);
            this.tbpgKLientTopProduct.Location = new System.Drawing.Point(4, 34);
            this.tbpgKLientTopProduct.Name = "tbpgKLientTopProduct";
            this.tbpgKLientTopProduct.Padding = new System.Windows.Forms.Padding(3);
            this.tbpgKLientTopProduct.Size = new System.Drawing.Size(765, 456);
            this.tbpgKLientTopProduct.TabIndex = 1;
            this.tbpgKLientTopProduct.Text = "Рейтинг товаров";
            this.tbpgKLientTopProduct.UseVisualStyleBackColor = true;
            // 
            // lstbxKlient_Top_5_Product
            // 
            this.lstbxKlient_Top_5_Product.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lstbxKlient_Top_5_Product.FormattingEnabled = true;
            this.lstbxKlient_Top_5_Product.ItemHeight = 25;
            this.lstbxKlient_Top_5_Product.Location = new System.Drawing.Point(3, 3);
            this.lstbxKlient_Top_5_Product.Name = "lstbxKlient_Top_5_Product";
            this.lstbxKlient_Top_5_Product.Size = new System.Drawing.Size(759, 450);
            this.lstbxKlient_Top_5_Product.TabIndex = 0;
            // 
            // tbpgKlientChekcHistory
            // 
            this.tbpgKlientChekcHistory.Location = new System.Drawing.Point(4, 34);
            this.tbpgKlientChekcHistory.Name = "tbpgKlientChekcHistory";
            this.tbpgKlientChekcHistory.Padding = new System.Windows.Forms.Padding(3);
            this.tbpgKlientChekcHistory.Size = new System.Drawing.Size(765, 456);
            this.tbpgKlientChekcHistory.TabIndex = 2;
            this.tbpgKlientChekcHistory.Text = "История продаж";
            this.tbpgKlientChekcHistory.UseVisualStyleBackColor = true;
            // 
            // tbpgKlientProfile
            // 
            this.tbpgKlientProfile.Controls.Add(this.tblltpnKLinet_Information);
            this.tbpgKlientProfile.Location = new System.Drawing.Point(4, 34);
            this.tbpgKlientProfile.Name = "tbpgKlientProfile";
            this.tbpgKlientProfile.Padding = new System.Windows.Forms.Padding(3);
            this.tbpgKlientProfile.Size = new System.Drawing.Size(765, 456);
            this.tbpgKlientProfile.TabIndex = 3;
            this.tbpgKlientProfile.Text = "Личный профиль";
            this.tbpgKlientProfile.UseVisualStyleBackColor = true;
            // 
            // tblltpnKLinet_Information
            // 
            this.tblltpnKLinet_Information.ColumnCount = 2;
            this.tblltpnKLinet_Information.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tblltpnKLinet_Information.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tblltpnKLinet_Information.Controls.Add(this.tbConfermPassword, 1, 5);
            this.tblltpnKLinet_Information.Controls.Add(this.tbPassword, 1, 4);
            this.tblltpnKLinet_Information.Controls.Add(this.tbLogin, 1, 3);
            this.tblltpnKLinet_Information.Controls.Add(this.tbMiddle_Name, 1, 2);
            this.tblltpnKLinet_Information.Controls.Add(this.tbName, 1, 1);
            this.tblltpnKLinet_Information.Controls.Add(this.label1, 0, 0);
            this.tblltpnKLinet_Information.Controls.Add(this.label2, 0, 1);
            this.tblltpnKLinet_Information.Controls.Add(this.label3, 0, 2);
            this.tblltpnKLinet_Information.Controls.Add(this.label4, 0, 3);
            this.tblltpnKLinet_Information.Controls.Add(this.label5, 0, 4);
            this.tblltpnKLinet_Information.Controls.Add(this.label6, 0, 5);
            this.tblltpnKLinet_Information.Controls.Add(this.tbFirst_Name, 1, 0);
            this.tblltpnKLinet_Information.Controls.Add(this.btSave, 0, 6);
            this.tblltpnKLinet_Information.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tblltpnKLinet_Information.Location = new System.Drawing.Point(3, 3);
            this.tblltpnKLinet_Information.Name = "tblltpnKLinet_Information";
            this.tblltpnKLinet_Information.RowCount = 7;
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 14.28571F));
            this.tblltpnKLinet_Information.Size = new System.Drawing.Size(759, 450);
            this.tblltpnKLinet_Information.TabIndex = 0;
            // 
            // tbConfermPassword
            // 
            this.tbConfermPassword.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbConfermPassword.Location = new System.Drawing.Point(382, 323);
            this.tbConfermPassword.Name = "tbConfermPassword";
            this.tbConfermPassword.PasswordChar = '*';
            this.tbConfermPassword.Size = new System.Drawing.Size(374, 32);
            this.tbConfermPassword.TabIndex = 11;
            // 
            // tbPassword
            // 
            this.tbPassword.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbPassword.Location = new System.Drawing.Point(382, 259);
            this.tbPassword.Name = "tbPassword";
            this.tbPassword.PasswordChar = '*';
            this.tbPassword.Size = new System.Drawing.Size(374, 32);
            this.tbPassword.TabIndex = 10;
            // 
            // tbLogin
            // 
            this.tbLogin.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbLogin.Location = new System.Drawing.Point(382, 195);
            this.tbLogin.Name = "tbLogin";
            this.tbLogin.Size = new System.Drawing.Size(374, 32);
            this.tbLogin.TabIndex = 9;
            // 
            // tbMiddle_Name
            // 
            this.tbMiddle_Name.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbMiddle_Name.Location = new System.Drawing.Point(382, 131);
            this.tbMiddle_Name.Name = "tbMiddle_Name";
            this.tbMiddle_Name.Size = new System.Drawing.Size(374, 32);
            this.tbMiddle_Name.TabIndex = 8;
            // 
            // tbName
            // 
            this.tbName.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbName.Location = new System.Drawing.Point(382, 67);
            this.tbName.Name = "tbName";
            this.tbName.Size = new System.Drawing.Size(374, 32);
            this.tbName.TabIndex = 7;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(3, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(114, 26);
            this.label1.TabIndex = 0;
            this.label1.Text = "Фамилия:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(3, 64);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(68, 26);
            this.label2.TabIndex = 1;
            this.label2.Text = "Имя: ";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(3, 128);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(114, 26);
            this.label3.TabIndex = 2;
            this.label3.Text = "Отчество:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(3, 192);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(84, 26);
            this.label4.TabIndex = 3;
            this.label4.Text = "Логин: ";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(3, 256);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(101, 26);
            this.label5.TabIndex = 4;
            this.label5.Text = "Пароль: ";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(3, 320);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(267, 26);
            this.label6.TabIndex = 5;
            this.label6.Text = "Подтверждение пароля: ";
            // 
            // tbFirst_Name
            // 
            this.tbFirst_Name.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbFirst_Name.Location = new System.Drawing.Point(382, 3);
            this.tbFirst_Name.Name = "tbFirst_Name";
            this.tbFirst_Name.Size = new System.Drawing.Size(374, 32);
            this.tbFirst_Name.TabIndex = 6;
            // 
            // btSave
            // 
            this.btSave.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btSave.Location = new System.Drawing.Point(3, 387);
            this.btSave.Name = "btSave";
            this.btSave.Size = new System.Drawing.Size(373, 60);
            this.btSave.TabIndex = 12;
            this.btSave.Text = "Сохранить данные";
            this.btSave.UseVisualStyleBackColor = true;
            // 
            // lblKlient_Card_Number
            // 
            this.lblKlient_Card_Number.AutoSize = true;
            this.lblKlient_Card_Number.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblKlient_Card_Number.Location = new System.Drawing.Point(3, 132);
            this.lblKlient_Card_Number.Name = "lblKlient_Card_Number";
            this.lblKlient_Card_Number.Size = new System.Drawing.Size(113, 26);
            this.lblKlient_Card_Number.TabIndex = 4;
            this.lblKlient_Card_Number.Text = "Карта №: ";
            // 
            // lblKlinet_Create
            // 
            this.lblKlinet_Create.AutoSize = true;
            this.lblKlinet_Create.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblKlinet_Create.Location = new System.Drawing.Point(3, 106);
            this.lblKlinet_Create.Name = "lblKlinet_Create";
            this.lblKlinet_Create.Size = new System.Drawing.Size(287, 26);
            this.lblKlinet_Create.TabIndex = 3;
            this.lblKlinet_Create.Text = "Дата создания уч. записи: ";
            // 
            // lblKlinet_Middlename
            // 
            this.lblKlinet_Middlename.AutoSize = true;
            this.lblKlinet_Middlename.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblKlinet_Middlename.Location = new System.Drawing.Point(3, 80);
            this.lblKlinet_Middlename.Name = "lblKlinet_Middlename";
            this.lblKlinet_Middlename.Size = new System.Drawing.Size(120, 26);
            this.lblKlinet_Middlename.TabIndex = 2;
            this.lblKlinet_Middlename.Text = "Отчество: ";
            // 
            // lblKlinet_Name
            // 
            this.lblKlinet_Name.AutoSize = true;
            this.lblKlinet_Name.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblKlinet_Name.Location = new System.Drawing.Point(3, 54);
            this.lblKlinet_Name.Name = "lblKlinet_Name";
            this.lblKlinet_Name.Size = new System.Drawing.Size(68, 26);
            this.lblKlinet_Name.TabIndex = 1;
            this.lblKlinet_Name.Text = "Имя: ";
            // 
            // lblKlinet_Surname
            // 
            this.lblKlinet_Surname.AutoSize = true;
            this.lblKlinet_Surname.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblKlinet_Surname.Location = new System.Drawing.Point(3, 28);
            this.lblKlinet_Surname.Name = "lblKlinet_Surname";
            this.lblKlinet_Surname.Size = new System.Drawing.Size(120, 26);
            this.lblKlinet_Surname.TabIndex = 0;
            this.lblKlinet_Surname.Text = "Фамилия: ";
            // 
            // Personal_Profile_Klient
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(779, 699);
            this.Controls.Add(this.gbKlient_Personal);
            this.Controls.Add(this.panel1);
            this.Name = "Personal_Profile_Klient";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Личный кабинет клиента";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Personal_Profile_Klient_FormClosing);
            this.Load += new System.EventHandler(this.Personal_Profile_Klient_Load);
            this.panel1.ResumeLayout(false);
            this.gbKlient_Personal.ResumeLayout(false);
            this.gbKlient_Personal.PerformLayout();
            this.tbctrlKlient.ResumeLayout(false);
            this.tbpgKlientExpenses.ResumeLayout(false);
            this.tbpgKlientExpenses.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.chrExpencens)).EndInit();
            this.tbpgKLientTopProduct.ResumeLayout(false);
            this.tbpgKlientProfile.ResumeLayout(false);
            this.tblltpnKLinet_Information.ResumeLayout(false);
            this.tblltpnKLinet_Information.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.GroupBox gbKlient_Personal;
        private System.Windows.Forms.TabControl tbctrlKlient;
        private System.Windows.Forms.TabPage tbpgKlientExpenses;
        private System.Windows.Forms.DataVisualization.Charting.Chart chrExpencens;
        private System.Windows.Forms.DateTimePicker dtpEndDate;
        private System.Windows.Forms.Label lblEnd_Date;
        private System.Windows.Forms.DateTimePicker dtpStartDate;
        private System.Windows.Forms.Label lblStartDate;
        private System.Windows.Forms.TabPage tbpgKLientTopProduct;
        private System.Windows.Forms.ListBox lstbxKlient_Top_5_Product;
        private System.Windows.Forms.TabPage tbpgKlientChekcHistory;
        private System.Windows.Forms.TabPage tbpgKlientProfile;
        private System.Windows.Forms.TableLayoutPanel tblltpnKLinet_Information;
        private System.Windows.Forms.TextBox tbConfermPassword;
        private System.Windows.Forms.TextBox tbPassword;
        private System.Windows.Forms.TextBox tbLogin;
        private System.Windows.Forms.TextBox tbMiddle_Name;
        private System.Windows.Forms.TextBox tbName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox tbFirst_Name;
        private System.Windows.Forms.Button btSave;
        private System.Windows.Forms.Label lblKlient_Card_Number;
        private System.Windows.Forms.Label lblKlinet_Create;
        private System.Windows.Forms.Label lblKlinet_Middlename;
        private System.Windows.Forms.Label lblKlinet_Name;
        private System.Windows.Forms.Label lblKlinet_Surname;
    }
}