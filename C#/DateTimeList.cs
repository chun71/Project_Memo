
using PIRM.Repository.IRiskMonDW.Core.EnumType;

namespace PIRM.Business.Utility.Common
{
    public sealed class DateTimeList
    {
        private DateTimeList() { }

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

            List<DateTime> dateTimeRange = DateTimeRangeInit();

            if (dataFrequency == DataFrequency.MONTHLY)
            {
                minTime = minTime.HasValue ? minTime.Value : dateTimeRange[0];
                maxTime = maxTime.HasValue ? maxTime.Value : dateTimeRange[1];

                dateTimeList = GetDateTimeListMonthly(minTime.Value, maxTime.Value);
            }
            else if (dataFrequency == DataFrequency.QUARTERLY)
            {
                minTime = minTime.HasValue ? minTime.Value : dateTimeRange[2];
                maxTime = maxTime.HasValue ? maxTime.Value : dateTimeRange[3];

                dateTimeList = GetDateTimeListQuarterly(minTime.Value, maxTime.Value);
            }
            else if (dataFrequency == DataFrequency.SEMI_ANNUAL)
            {
                dateTimeList = GetDateTimeListSemiAnnual(minTime.Value, maxTime.Value);
            }
            else if (dataFrequency == DataFrequency.ANNUAL)
            {
                dateTimeList = GetDateTimeListAnnual(minTime.Value, maxTime.Value);
            }

            return dateTimeList;
        }

        /// <summary>
        /// 預先載入日期範圍
        /// </summary>
        /// <returns></returns>
        private static List<DateTime> DateTimeRangeInit()
        {
            DateTime? minDateMonthly = null;
            DateTime? maxDateMonthly = null;
            DateTime? minDateQuarterly = null;
            DateTime? maxDateQuarterly = null;

            DateTime today = DateTime.Now;
            DateTime march31 = DateTime.Parse($"{today.Year}-03-31");
            DateTime june30 = DateTime.Parse($"{today.Year}-06-30");
            DateTime september30 = DateTime.Parse($"{today.Year}-09-30");
            DateTime december31 = DateTime.Parse($"{today.Year}-12-31");

            // 找出當月最後一天
            int lastDayInMonth = DateTime.DaysInMonth(today.Year, today.Month);

            // 當月最後一天日期字串
            string dateTimeMsg = $"{today.Year}-{today.Month}-{lastDayInMonth}";

            maxDateMonthly = DateTime.Parse(dateTimeMsg);

            // 上個月
            DateTime lastMonth = today.AddMonths(-1);

            // 上個月的第一天
            dateTimeMsg = $"{lastMonth.Year}-{lastMonth.Month}-1";

            minDateMonthly = DateTime.Parse(dateTimeMsg);

            if (today < march31)
            {
                minDateQuarterly = DateTime.Parse($"{today.Year - 1}-7-1");
                maxDateQuarterly = DateTime.Parse($"{today.Year - 1}-12-31");
            }
            else if (today >= march31 && today < june30)
            {
                minDateQuarterly = DateTime.Parse($"{today.Year - 1}-10-1");
                maxDateQuarterly = march31;
            }
            else if (today >= june30 && today < september30)
            {
                minDateQuarterly = DateTime.Parse($"{today.Year}-1-1");
                maxDateQuarterly = june30;
            }
            else if (today >= september30 && today < december31)
            {
                minDateQuarterly = DateTime.Parse($"{today.Year}-4-1");
                maxDateQuarterly = september30;
            }
            else if (today == december31)
            {
                minDateQuarterly = DateTime.Parse($"{today.Year}-7-1");
                maxDateQuarterly = december31;
            }

            return new List<DateTime>()
            {
                minDateMonthly.Value,
                maxDateMonthly.Value,
                minDateQuarterly.Value,
                maxDateQuarterly.Value
            };
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
