
namespace PIRM.Business.Utility.Common
{
    /// <summary>
    /// DateTimeList
    /// </summary>
    public sealed class DateTimeList
    {
        /// <summary>
        /// 判斷頻率取得 DateTime 清單
        /// </summary>
        /// <param name="dataFrequency"></param>
        /// <param name="minTime"></param>
        /// <param name="maxTime"></param>
        /// <returns></returns>
        public static List<DateTime> GetDateTimeList(string dataFrequency, DateTime? minTime, DateTime? maxTime)
        {
            List<DateTime> dateTimeList = new List<DateTime>();

            if (dataFrequency == Repository.Utility.EnumType.DataFrequency.MONTHLY)
            {
                dateTimeList = GetDateTimeListMonthly(minTime.Value, maxTime.Value);
            }
            else if (dataFrequency == Repository.Utility.EnumType.DataFrequency.QUARTERLY)
            {
                dateTimeList = GetDateTimeListQuarterly(minTime.Value, maxTime.Value);
            }
            else if (dataFrequency == Repository.Utility.EnumType.DataFrequency.SEMI_ANNUAL)
            {
                dateTimeList = GetDateTimeListSemiAnnual(minTime.Value, maxTime.Value);
            }
            else if (dataFrequency == Repository.Utility.EnumType.DataFrequency.ANNUAL)
            {
                dateTimeList = GetDateTimeListAnnual(minTime.Value, maxTime.Value);
            }

            return dateTimeList;
        }

        /// <summary>
        /// 範圍時間內每月最後一天
        /// </summary>
        /// <param name="minTime"></param>
        /// <param name="maxTime"></param>
        /// <returns></returns>
        private static List<DateTime> GetDateTimeListMonthly(DateTime minTime, DateTime maxTime)
        {
            var dateTimeListMonthly = new List<DateTime>();
            DateTime tempDateTime = minTime;

            while (true)
            {
                if (tempDateTime > maxTime)
                {
                    break;
                }

                // 找出當月最後一天
                int lastDayInMonth = DateTime.DaysInMonth(tempDateTime.Year, tempDateTime.Month);
                // 當月最後一天日期字串
                string dateTimeMsg = $"{tempDateTime.Year}-{tempDateTime.Month}-{lastDayInMonth}";
                // 設定最後一天DateTime物件
                tempDateTime = DateTime.Parse(dateTimeMsg);

                dateTimeListMonthly.Add(tempDateTime);

                tempDateTime = tempDateTime.AddMonths(1);
            }

            return dateTimeListMonthly;
        }

        /// <summary>
        /// 範圍時間內每季最後一天
        /// </summary>
        /// <param name="minTime"></param>
        /// <param name="maxTime"></param>
        /// <returns></returns>
        private static List<DateTime> GetDateTimeListQuarterly(DateTime minTime, DateTime maxTime)
        {
            var dateTimeListQuarterly = new List<DateTime>();
            DateTime tempDateTime = minTime;

            DateTime march31 = DateTime.Parse($"{minTime.Year}-03-31");
            DateTime june30 = DateTime.Parse($"{minTime.Year}-06-30");
            DateTime september30 = DateTime.Parse($"{minTime.Year}-09-30");
            DateTime december31 = DateTime.Parse($"{minTime.Year}-12-31");

            if (minTime <= march31)
            {
                tempDateTime = march31;
            }
            else if (minTime > march31 && minTime <= june30)
            {
                tempDateTime = june30;
            }
            else if (minTime > june30 && minTime <= september30)
            {
                tempDateTime = september30;
            }
            else if (minTime > september30 && minTime <= december31)
            {
                tempDateTime = december31;
            }

            while (true)
            {
                if (tempDateTime > maxTime)
                {
                    break;
                }

                // 找出當月最後一天
                int lastDayInMonth = DateTime.DaysInMonth(tempDateTime.Year, tempDateTime.Month);
                // 當月最後一天日期字串
                string dateTimeMsg = $"{tempDateTime.Year}-{tempDateTime.Month}-{lastDayInMonth}";
                // 設定最後一天DateTime物件
                tempDateTime = DateTime.Parse(dateTimeMsg);

                dateTimeListQuarterly.Add(tempDateTime);

                tempDateTime = tempDateTime.AddMonths(3);
            }

            return dateTimeListQuarterly;
        }

        /// <summary>
        /// 範圍時間內每半年最後一天
        /// </summary>
        /// <param name="minTime"></param>
        /// <param name="maxTime"></param>
        /// <returns></returns>
        private static List<DateTime> GetDateTimeListSemiAnnual(DateTime minTime, DateTime maxTime)
        {
            var dateTimeListSemiAnnual = new List<DateTime>();
            DateTime tempDateTime = minTime;

            DateTime june30 = DateTime.Parse($"{minTime.Year}-06-30");
            DateTime december31 = DateTime.Parse($"{minTime.Year}-12-31");

            if (minTime <= june30)
            {
                tempDateTime = june30;
            }
            else if (minTime > june30 && minTime <= december31)
            {
                tempDateTime = december31;
            }

            while (true)
            {
                if (tempDateTime > maxTime)
                {
                    break;
                }

                // 找出當月最後一天
                int lastDayInMonth = DateTime.DaysInMonth(tempDateTime.Year, tempDateTime.Month);
                // 當月最後一天日期字串
                string dateTimeMsg = $"{tempDateTime.Year}-{tempDateTime.Month}-{lastDayInMonth}";
                // 設定最後一天DateTime物件
                tempDateTime = DateTime.Parse(dateTimeMsg);

                dateTimeListSemiAnnual.Add(tempDateTime);

                tempDateTime = tempDateTime.AddMonths(6);
            }

            return dateTimeListSemiAnnual;
        }

        /// <summary>
        /// 範圍時間內每年最後一天
        /// </summary>
        /// <param name="minTime"></param>
        /// <param name="maxTime"></param>
        /// <returns></returns>
        private static List<DateTime> GetDateTimeListAnnual(DateTime minTime, DateTime maxTime)
        {
            var dateTimeListAnnual = new List<DateTime>();
            DateTime tempDateTime = DateTime.Parse($"{minTime.Year}-12-31");

            while (true)
            {
                if (tempDateTime > maxTime)
                {
                    break;
                }

                dateTimeListAnnual.Add(tempDateTime);

                tempDateTime = tempDateTime.AddYears(1);
            }

            return dateTimeListAnnual;
        }
    }
}
