using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace calculator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        long number1 = 0;
        long number2 = 0;
        string operation = "";
        public MainWindow()
        {
            InitializeComponent();
        }

        public void numberwrite(int x)
        {
            if (operation == "")
            {
                number1 = (number1 * 10) + x;
                txtDisplay.Text = number1.ToString();
            }
            else
            {
                number2 = (number2 * 10) + x;
                txtDisplay.Text = number1.ToString();
            }
        }
        private void btn1_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(1);
        }

        private void btn2_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(2);
        }

        private void btn3_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(3);
        }

        private void btn4_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(4);
        }

        private void btn5_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(5);
        }

        private void btn6_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(6);
        }

        private void btn7_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(7);
        }

        private void btn8_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(8);
        }

        private void btn9_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(9);
        }

        private void btn0_Click(object sender, RoutedEventArgs e)
        {
            numberwrite(0);
        }

        private void btnPlus_Click(object sender, RoutedEventArgs e)
        {
            operation = "+";
            txtDisplay.Text = "+";
        }

      
        private void btnMinus_Click(object sender, RoutedEventArgs e)
        {
            operation = "-";
            txtDisplay.Text = "-";
        }  
        private void btnTimes_Click(object sender, RoutedEventArgs e)
        {
            operation = "*";
            txtDisplay.Text = "*";
        }

        private void btnDivide_Click(object sender, RoutedEventArgs e)
        {
            operation = "/";
            txtDisplay.Text = "/";
        }
        private void btnEquals_Click(object sender, RoutedEventArgs e)
        {
            switch(operation)
            {
                case "+":
                    txtDisplay.Text = (number1 + number2).ToString();
                    break;
                case "-":
                    txtDisplay.Text = (number1 - number2).ToString();
                    break;
                case "*":
                    txtDisplay.Text = (number1 * number2).ToString();
                    break;
                case "/":
                    txtDisplay.Text = (number1 / number2).ToString();
                    break;
            }
        }

        private void btnClearEntry_Click(object sender, RoutedEventArgs e)
        {
            if(operation=="")
            {
                number1 = 0;
            }
            else
            {
                number2 = 0;
            }
            txtDisplay.Text = "0";
        }

        private void btnClear_Click(object sender, RoutedEventArgs e)
        {
            number1 = 0;
            number2 = 0;
            operation = "";
            txtDisplay.Text = "0";

        }

        private void btnBackSpace_Click(object sender, RoutedEventArgs e)
        {
            if (operation == "")
            {
                number1 = (number1 / 10) ;
                txtDisplay.Text = number1.ToString();
            }
            else
            {
                number2 = (number2 / 10) ;
                txtDisplay.Text = number1.ToString();
            }
        }

        private void btnPositiveNegative_Click(object sender, RoutedEventArgs e)
        {
            if (operation == "")
            {
                number1 *= -1;
                txtDisplay.Text = number1.ToString();
            }
            else
            {
                number2 *= -1;
                txtDisplay.Text = number1.ToString();
            }
        }
    }
}
