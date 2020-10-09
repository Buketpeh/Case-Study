using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;

namespace selenium
{
    class Program
    {
        static void Main(string[] args)
        {
            IWebDriver driver = new FirefoxDriver();
            string link = @"http://n11.com/";
            driver.Navigate().GoToUrl(link);
            driver.FindElement(By.ClassName("btnHolder")).Click();
            Thread.Sleep(2000);
            String actualtitle = driver.Title;
            Assert.AreEqual("n11.com - Hayat Sana Gelir", actualtitle);
            Console.WriteLine("Anasayfa Doğru Bir Şekilde Yüklendi");

            driver.FindElement(By.ClassName("btnSignIn")).Click();

            IWebElement email_adresi = driver.FindElement(By.Id("email"));
            email_adresi.SendKeys("asda");

            IWebElement Input_password = driver.FindElement(By.Id("password"));
            Input_password.SendKeys("asdasd");

            IWebElement Btn_UserLogin = driver.FindElement(By.Id("loginButton"));
            Btn_UserLogin.Click();


            IWebElement Input_Search = driver.FindElement(By.Id("searchData"));
            Input_Search.SendKeys("samsung");
            Thread.Sleep(2000);

            IWebElement Btn_Search = driver.FindElement(By.ClassName("searchBtn"));
            Btn_Search.Click();
            Thread.Sleep(2000);

        }
    }
}
