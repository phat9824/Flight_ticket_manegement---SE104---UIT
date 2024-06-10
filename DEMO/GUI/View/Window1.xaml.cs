﻿using MaterialDesignThemes.Wpf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using Microsoft.Win32;
using BLL;
using DTO;
using System.Windows.Media;
using static System.Net.Mime.MediaTypeNames;

namespace GUI.View
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : UserControl
    {   
        private ACCOUNT account;
        public Window1()
        {
            InitializeComponent();

            // test session
            this.Dispatcher.BeginInvoke(new Action(() =>
            {
                MessageBox.Show("Mail: " + ClientSession.Instance.mail + "\nPermissions: " + ClientSession.Instance.permissions[0], "Test Session");
            }));

            BLL.ACCOUNT_BLL prc = new BLL.ACCOUNT_BLL();
            var result = prc.List_acc(new ACCOUNT() { Email = ClientSession.Instance.mail });

            Load(result[0]);
        }

        private void Load(ACCOUNT acc)
        {
            account = acc;
            Dictionary<int, string> dr = new Dictionary<int, string>()
            {
                {1, "Admin"},
                {2, "Staff"}
            };
            UserName.Text = acc.UserName;

            Birth.Text = acc.Birth.ToString("dd-MM-yyyy");
            Email.Text = acc.Email;
            Phone.Text = acc.Phone;
            if (acc.PermissonID != 0)
            {
                Role.Text = dr[acc.PermissonID].ToString();
            }
            else
            {
                Role.Text = "Unknown";
            }
        }

        private void Phone_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            e.Handled = !IsTextAllowed(e.Text);
        }

        private static bool IsTextAllowed(string text)
        {
            return Array.TrueForAll(text.ToCharArray(), Char.IsDigit);
        }

        private void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(UserName.Text) || string.IsNullOrWhiteSpace(Email.Text) || string.IsNullOrWhiteSpace(Phone.Text) || string.IsNullOrWhiteSpace(Birth.Text))
            {
                MessageBox.Show("Vui lòng nhập đầy đủ thông tin");
                return;
            }

            if (!Phone.Text.StartsWith("0"))
            {
                MessageBox.Show("Số điện thoại không hợp lệ");
                return;
            }
            
            if(Phone.Text.Length != 10)
            {
                MessageBox.Show("Số điện thoại không hợp lệ", "Error");
                return;
            }

            foreach (char c in Phone.Text)
            {
                if (char.IsLetter(c))
                {
                    MessageBox.Show("Số điện thoại không hợp lệ", "Error");
                    return;
                }
            }

            // Code cập nhật thông tin người dùng ở đây
        }

        private void ChangeAvatarButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Image files (*.jpg, *.jpeg, *.png)|*.jpg;*.jpeg;*.png|All files (*.*)|*.*";
            if (openFileDialog.ShowDialog() == true)
            {
                string selectedFileName = openFileDialog.FileName; // Lấy đường dẫn tệp được chọn
                BitmapImage bitmap = new BitmapImage();
                bitmap.BeginInit();
                bitmap.UriSource = new Uri(selectedFileName); // Trỏ đến file ảnh.
                bitmap.CacheOption = BitmapCacheOption.OnLoad;  // Tải ảnh vào bitmap
                bitmap.EndInit();

                ImageBrush imageBrush = new ImageBrush();
                imageBrush.ImageSource = bitmap;
                imageBrush.Stretch = Stretch.UniformToFill;
                AvatarBrush.ImageSource = bitmap;
            }
        }

        private void ChangePass_Click(object sender, RoutedEventArgs e)
        {
            ChangePass_popupWin.IsOpen = true;
        }

        private void ConfirmPass_Click(object sender, RoutedEventArgs e)
        {
            ChangePass_popupWin.IsOpen = false;
            if (newPassword.Password == confirmPassword.Password)
            {
                BLL.ACCOUNT_BLL prc = new BLL.ACCOUNT_BLL();
                prc.UpdateAccountPassword(account.UserID, confirmPassword.Password);
            }
        }

        private void Popup_Loaded(object sender, RoutedEventArgs e)
        {
            ChangePass_popupWin.IsOpen = true;
        }

        private void Popup_Deactivated(object sender, EventArgs e)
        {
            ChangePass_popupWin.IsOpen = false;
        }

        private void CancelPass_Click(object sender, RoutedEventArgs e)
        {
            oldPassword.Password = string.Empty;
            newPassword.Password = string.Empty;
            confirmPassword.Password = string.Empty;
            ChangePass_popupWin.IsOpen = false;
        }

        /*private void Phone_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox textBox = sender as TextBox;
            string text = textBox.Text;

            // Kiểm tra xem văn bản có chứa chữ cái không
            if (HasLetters(text))
            {
                MessageBox.Show("Số điện thoại có chứ chữ cái");
            }
        }
        private bool HasLetters(string text)
        {
            foreach (char c in text)
            {
                if (char.IsLetter(c))
                {
                    return true;
                }
            }
            return false;
        }*/
    }
}
