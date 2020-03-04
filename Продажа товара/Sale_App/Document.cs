using System;
using System.Data;
using word = Microsoft.Office.Interop.Word;
using excel = Microsoft.Office.Interop.Excel;

namespace Sale_App
{
    internal class Document
    {
        /// <summary>
        /// Список доступных видов отчётов
        /// </summary>
        internal enum Document_Type
        {
            Report, Statistic
        }

        /// <summary>
        /// Итоговоый выходной формат отчёт
        /// </summary>
        internal enum Document_Format
        {
            Word, Excel, PDF
        }

        public void Document_Create(Document_Type type, Document_Format format, string name, DataTable table)
        {
            Configuration_class configuration_Class = new Configuration_class();
            configuration_Class.Document_Configuration_Get();
            switch (name != "" || name != null)
            {
                case true:
                    switch (format)
                    {
                        case Document_Format.Word:
                            word.Application application = new word.Application();
                            word.Document document = application.Documents.Add(Visible: true);
                            try
                            {
                                word.Range range = document.Range(0, 0);
                                document.Sections.PageSetup.LeftMargin = application.CentimetersToPoints((float)Configuration_class.doc_Left_Merge);
                                document.Sections.PageSetup.RightMargin = application.CentimetersToPoints((float)Configuration_class.doc_Right_Merge);
                                document.Sections.PageSetup.TopMargin = application.CentimetersToPoints((float)Configuration_class.doc_Top_Merge);
                                document.Sections.PageSetup.BottomMargin = application.CentimetersToPoints((float)Configuration_class.doc_Bottom_Merge);
                                range.Text = Configuration_class.Organiztion_Name;
                                range.ParagraphFormat.Alignment = word.WdParagraphAlignment.wdAlignParagraphCenter;
                                range.ParagraphFormat.SpaceAfter = 1;
                                range.ParagraphFormat.SpaceBefore = 1;
                                range.ParagraphFormat.LineSpacingRule = word.WdLineSpacing.wdLineSpaceSingle;
                                range.Font.Name = "Times New Roman";
                                range.Font.Size = 12;
                                document.Paragraphs.Add();
                                document.Paragraphs.Add();
                                document.Paragraphs.Add();
                                word.Paragraph Document_Name = document.Paragraphs.Add();
                                Document_Name.Format.Alignment = word.WdParagraphAlignment.wdAlignParagraphCenter;
                                Document_Name.Range.Font.Name = "Times New Roman";
                                Document_Name.Range.Font.Size = 16;
                                switch (type)
                                {
                                    case Document_Type.Report:
                                        Document_Name.Range.Text = "ОТЧЁТ";
                                        break;

                                    case Document_Type Statistic:
                                        Document_Name.Range.Text = "СТАТИСТИЧЕСКИЙ ОТЧЁТ";
                                        break;
                                }
                                document.Paragraphs.Add();
                                document.Paragraphs.Add();
                                document.Paragraphs.Add();
                                word.Paragraph statparg = document.Paragraphs.Add();
                                word.Table stat_table = document.Tables.Add(statparg.Range, table.Rows.Count, table.Columns.Count);
                                stat_table.Borders.InsideLineStyle = word.WdLineStyle.wdLineStyleSingle;
                                stat_table.Borders.OutsideLineStyle = word.WdLineStyle.wdLineStyleSingle;
                                stat_table.Rows.Alignment = word.WdRowAlignment.wdAlignRowCenter;
                                stat_table.Range.Cells.VerticalAlignment = word.WdCellVerticalAlignment.wdCellAlignVerticalCenter;
                                stat_table.Range.Font.Size = 12;
                                stat_table.Range.Font.Name = "Times New Roman";
                                for (int row = 1; row <= table.Rows.Count; row++)
                                    for (int col = 1; col <= table.Columns.Count; col++)
                                    {
                                        stat_table.Cell(row, col).Range.Text = table.Rows[row - 1][col - 1].ToString();
                                    }
                                document.Paragraphs.Add();
                                document.Paragraphs.Add();
                                word.Paragraph Footparg = document.Paragraphs.Add();
                                Footparg.Range.Text = string.Format("Дата создания \t\t\t{0}", DateTime.Now.ToString("dd.MM.yyyy"));
                            }
                            catch
                            {
                            }
                            finally
                            {
                                switch (format)
                                {
                                    case Document_Format.Word:
                                        document.SaveAs2(name, word.WdSaveFormat.wdFormatDocument);
                                        break;

                                    case Document_Format.PDF:
                                        document.SaveAs2(name, word.WdSaveFormat.wdFormatPDF);
                                        break;
                                }
                                document.Close();
                                application.Quit();
                            }
                            break;
                        case Document_Format.Excel:
                            excel.Application application_ex = new excel.Application();
                            excel.Workbook workbook = application_ex.Workbooks.Add();
                            excel.Worksheet worksheet = (excel.Worksheet)workbook.ActiveSheet();
                            try
                            {
                                switch(type)
                                {
                                    case Document_Type.Report:
                                        worksheet.Name = "Отчет";
                                        for(int row = 0; row<table.Rows.Count; row++)
                                            for (int col = 0; col<table.Columns.Count; col++)
                                            {
                                                worksheet.Cells[row + 1][col + 1] = table.Rows[row][col].ToString();
                                            }
                                        excel.Range border = worksheet.Range[worksheet.Cells[1, 1], worksheet.Cells[worksheet.Rows.Count + 1][table.Columns.Count + 1]];
                                        border.Borders.LineStyle = excel.XlLineStyle.xlContinuous;
                                        border.VerticalAlignment = excel.XlHAlign.xlHAlignCenter;
                                        border.HorizontalAlignment = excel.XlHAlign.xlHAlignCenter;
                                        worksheet.Cells[table.Rows.Count + 3][2] = string.Format("Дата создания {0}", DateTime.Now.ToString());
                                        worksheet.Range[worksheet.Cells[table.Rows.Count + 3, 2], worksheet.Cells[table.Rows.Count + 2, table.Columns.Count + 2]].Merge();
                                        break;
                                    case Document_Type.Statistic:
                                        worksheet.Name = "Статистический отчет";
                                        for (int row = 0; row < table.Rows.Count; row++)
                                            for (int col = 0; col < table.Columns.Count; col++)
                                            {
                                                worksheet.Cells[row + 1][col + 1] = table.Rows[row][col].ToString();
                                            }
                                        excel.Range border1 = worksheet.Range[worksheet.Cells[1, 1], worksheet.Cells[worksheet.Rows.Count + 1][table.Columns.Count + 1]];
                                        border1.Borders.LineStyle = excel.XlLineStyle.xlContinuous;
                                        border1.VerticalAlignment = excel.XlHAlign.xlHAlignCenter;
                                        border1.HorizontalAlignment = excel.XlHAlign.xlHAlignCenter;
                                        worksheet.Cells[table.Rows.Count + 3][2] = string.Format("Дата создания {0}", DateTime.Now.ToString());
                                        excel.ChartObjects chartObjects = (excel.ChartObjects)worksheet.ChartObjects(Type.Missing);
                                        excel.ChartObject chartObject = chartObjects.Add(300, 50, 250, 250);
                                        excel.Chart chart = chartObject.Chart;
                                        excel.SeriesCollection seriesCollection = (excel.SeriesCollection)chart.SeriesCollection(Type.Missing);
                                        excel.Series series = seriesCollection.NewSeries();
                                        chart.ChartType = excel.XlChartType.xl3DColumn;
                                        series.XValues = worksheet.get_Range("B2", "B" + table.Rows.Count+1);
                                        series.Values = worksheet.get_Range("C2", "C" + table.Rows.Count + 1);
                                        break;
                                }
                            }
                            catch
                            {

                            }
                            finally
                            {
                                workbook.SaveAs(name, application_ex.DefaultSaveFormat);
                                workbook.Close();
                                application_ex.Quit();
                            }
                            break;
                    }
                    break;
                case false:
                    System.Windows.Forms.MessageBox.Show("Введите название документа");
                    break;
            }
        }
    }
}