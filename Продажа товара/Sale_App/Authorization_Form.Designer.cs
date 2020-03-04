namespace Sale_App
{
    partial class Authorization_Form
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
            this.lblUser_Name = new System.Windows.Forms.Label();
            this.lbl_User_Password = new System.Windows.Forms.Label();
            this.btEnter = new System.Windows.Forms.Button();
            this.btLeave = new System.Windows.Forms.Button();
            this.tb_User_Name = new System.Windows.Forms.TextBox();
            this.tbUser_Password = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // lblUser_Name
            // 
            this.lblUser_Name.AutoSize = true;
            this.lblUser_Name.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lblUser_Name.Location = new System.Drawing.Point(110, 9);
            this.lblUser_Name.Name = "lblUser_Name";
            this.lblUser_Name.Size = new System.Drawing.Size(72, 26);
            this.lblUser_Name.TabIndex = 0;
            this.lblUser_Name.Text = "Логин";
            // 
            // lbl_User_Password
            // 
            this.lbl_User_Password.AutoSize = true;
            this.lbl_User_Password.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.lbl_User_Password.Location = new System.Drawing.Point(110, 101);
            this.lbl_User_Password.Name = "lbl_User_Password";
            this.lbl_User_Password.Size = new System.Drawing.Size(89, 26);
            this.lbl_User_Password.TabIndex = 2;
            this.lbl_User_Password.Text = "Пароль";
            // 
            // btEnter
            // 
            this.btEnter.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btEnter.Location = new System.Drawing.Point(3, 209);
            this.btEnter.Name = "btEnter";
            this.btEnter.Size = new System.Drawing.Size(108, 64);
            this.btEnter.TabIndex = 4;
            this.btEnter.Text = "Вход";
            this.btEnter.UseVisualStyleBackColor = true;
            this.btEnter.Click += new System.EventHandler(this.btEnter_Click);
            // 
            // btLeave
            // 
            this.btLeave.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.btLeave.Location = new System.Drawing.Point(212, 209);
            this.btLeave.Name = "btLeave";
            this.btLeave.Size = new System.Drawing.Size(89, 64);
            this.btLeave.TabIndex = 5;
            this.btLeave.Text = "Выход";
            this.btLeave.UseVisualStyleBackColor = true;
            this.btLeave.Click += new System.EventHandler(this.btLeave_Click);
            // 
            // tb_User_Name
            // 
            this.tb_User_Name.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tb_User_Name.Location = new System.Drawing.Point(3, 52);
            this.tb_User_Name.Name = "tb_User_Name";
            this.tb_User_Name.PasswordChar = '*';
            this.tb_User_Name.Size = new System.Drawing.Size(298, 32);
            this.tb_User_Name.TabIndex = 6;
            this.tb_User_Name.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.tb_User_Name.Enter += new System.EventHandler(this.back_Color);
            // 
            // tbUser_Password
            // 
            this.tbUser_Password.Font = new System.Drawing.Font("Microsoft Sans Serif", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.tbUser_Password.Location = new System.Drawing.Point(3, 141);
            this.tbUser_Password.Name = "tbUser_Password";
            this.tbUser_Password.PasswordChar = '*';
            this.tbUser_Password.Size = new System.Drawing.Size(298, 32);
            this.tbUser_Password.TabIndex = 7;
            this.tbUser_Password.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            this.tbUser_Password.Enter += new System.EventHandler(this.back_Color);
            // 
            // Authorization_Form
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(304, 274);
            this.Controls.Add(this.tbUser_Password);
            this.Controls.Add(this.tb_User_Name);
            this.Controls.Add(this.btLeave);
            this.Controls.Add(this.btEnter);
            this.Controls.Add(this.lbl_User_Password);
            this.Controls.Add(this.lblUser_Name);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Authorization_Form";
            this.Text = "Authorization_Form";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblUser_Name;
        private System.Windows.Forms.Label lbl_User_Password;
        private System.Windows.Forms.Button btEnter;
        private System.Windows.Forms.Button btLeave;
        private System.Windows.Forms.TextBox tb_User_Name;
        private System.Windows.Forms.TextBox tbUser_Password;
    }
}