using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HtmlAgilityPack;
using System.IO;
using System.Net;

namespace Betfair_data_parse
{
    class Program
    {
        static void Main(string[] args)
        {

            List<string> list_of_markets = new List<string>();
            string a_market;

            using (StreamReader SR = new StreamReader(args[0]))
            {
                while ((a_market = SR.ReadLine()) != null)
                    list_of_markets.Add(a_market);
            }

            string output_file = args[1];

            using (StreamWriter SW = new StreamWriter(output_file, true))
            {
                for (int i = 0; i < 1; i++)
                {
                    foreach (string input_address in list_of_markets)
                    {
                        try
                        {

                            WebClient client = new WebClient();
                            string input_html = client.DownloadString(input_address);
                            DateTime now = DateTime.Now;

                            HtmlDocument html_doc = new HtmlDocument();
                            html_doc.OptionFixNestedTags = true;

                            html_doc.LoadHtml(input_html);

                            string outcome = "";
                            string price = "";
                            string size = "";

                            HtmlNode title_node = html_doc.DocumentNode.SelectSingleNode(@"//title");
                            string title = title_node.InnerText.Trim();

                            title = title.Replace(" bet | betfair.com", "");
                            title = title.Replace(" bet | UK Politics odds | betfair.com", "");
                            title = title.Replace(" bet | US Politics odds | betfair.com", "");
                            title = title.Replace(" bet | Barclays Premier League odds | betfair.com", "");
                            title = title.Replace(" bet | The Championship odds | betfair.com", "");
                            title = title.Replace(" bet | Capital One Cup odds | betfair.com", "");
                            title = title.Replace(" bet | English FA Cup odds | betfair.com", "");
                            title = title.Replace(" bet | UEFA Champions League odds | betfair.com", "");

                            Console.WriteLine(title + "\t" + i);

                            foreach (HtmlNode possible_outcome_slice in html_doc.DocumentNode.SelectNodes(@"//tr[@data-handicap='0']"))
                            {
                                HtmlDocument possible_outcome = new HtmlDocument();
                                possible_outcome.LoadHtml(possible_outcome_slice.InnerHtml);

                                foreach (HtmlNode outcome_name in possible_outcome.DocumentNode.SelectNodes(@"//span[@class='sel-name']"))
                                    outcome = outcome_name.InnerHtml.Trim();

                                foreach (HtmlNode outcome_back_slice in possible_outcome.DocumentNode.SelectNodes(@"//button[@data-bettype='B']"))
                                {
                                    try
                                    {
                                        HtmlDocument outcome_back = new HtmlDocument();
                                        outcome_back.LoadHtml(outcome_back_slice.InnerHtml);

                                        foreach (HtmlNode outcome_back_price in outcome_back.DocumentNode.SelectNodes(@"//span[@class='price']"))
                                            price = outcome_back_price.InnerHtml.Trim();

                                        foreach (HtmlNode outcome_back_size in outcome_back.DocumentNode.SelectNodes(@"//span[@class='size']"))
                                            size = outcome_back_size.InnerHtml.Trim().Replace("Â£", "");

                                        if (price != "&nbsp;")
                                            SW.WriteLine(title + "\tback\t" + outcome + "\t" + price + "\t" + size + "\t" + now);
                                    }
                                    catch
                                    {
                                    }
                                }

                                foreach (HtmlNode outcome_lay_slice in possible_outcome.DocumentNode.SelectNodes(@"//button[@data-bettype='L']"))
                                {
                                    try
                                    {
                                        HtmlDocument outcome_lay = new HtmlDocument();
                                        outcome_lay.LoadHtml(outcome_lay_slice.InnerHtml);

                                        foreach (HtmlNode outcome_lay_price in outcome_lay.DocumentNode.SelectNodes(@"//span[@class='price']"))
                                            price = outcome_lay_price.InnerHtml.Trim();

                                        foreach (HtmlNode outcome_lay_size in outcome_lay.DocumentNode.SelectNodes(@"//span[@class='size']"))
                                            size = outcome_lay_size.InnerHtml.Trim().Replace("Â£", "");

                                        if (price != "&nbsp;")
                                            SW.WriteLine(title + "\tlay\t" + outcome + "\t" + price + "\t" + size + "\t" + now);
                                    }
                                    catch
                                    {
                                    }
                                }
                            }
                        }
                        catch
                        {
                        }
                    }
                }
            }
        }
    }
}