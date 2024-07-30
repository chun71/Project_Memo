
namespace PIRM.Business.Utility.Common
{
    public sealed class DateCount
    {
        public static string GetResult(DateTime startDate)
        {
            DateTime today = DateTime.Today;
            int year = today.Year - startDate.Year;
            int month = today.Month - startDate.Month;
            int day = today.Day - startDate.Day;

            if (day < 0)
            {
                month = month - 1;

                int lastDayOfLastMonth = new DateTime(today.Year, today.Month, 1).AddDays(-1).Day;

                day = day + lastDayOfLastMonth;
            }

            if (month < 0)
            {
                year = year - 1;
                month = month + 12;
            }
          
            return $"{year}年{month}月{day}天";
        }
    }
}
