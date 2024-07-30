
/**
 * 初始化時間範圍設定
 * @returns
 */
function initDateRange() {
    let minDateMonthly;
    let maxDateMonthly;
    let minDateQuarterly;
    let maxDateQuarterly;

    let today = new Date();
    let year = today.getFullYear();
    let month = today.getMonth();
    let day = today.getDate();

    // 下個月1號
    let nextMonthFristDay = new Date(year, month + 1, 1);
    // 當月最後一天日期
    let lastDayOfMonth = new Date(nextMonthFristDay - 1).getDate();

    if (day === lastDayOfMonth) {
        let startMonth = month - 1;
        let startYear = year;

        if (startMonth < 0) {
            startMonth = 11;
            startYear = year - 1
        }

        minDateMonthly = new Date(startYear, startMonth, 1);
        maxDateMonthly = today;
    } else {
        let startMonth = month - 2;
        let startYear = year;
        let endMonth = month - 1;
        let endYear = year;

        if (startMonth < 0) {
            startMonth = 12 + startMonth;
            startYear = year - 1
        }

        if (endMonth < 0) {
            endMonth = 12 + endMonth;
            endYear = year - 1
        }

        minDateMonthly = new Date(startYear, startMonth, 1);

        // 結束月下個月1號
        let endMonthNextMonthFristDay = new Date(endYear, endMonth + 1, 1);
        // 結束月最後一天日期
        let lastDayOfEndMonth = new Date(endMonthNextMonthFristDay - 1).getDate();

        maxDateMonthly = new Date(endYear, endMonth, lastDayOfEndMonth);
    }

    let march31 = new Date(year, 2, 31);
    let june30 = new Date(year, 5, 30);
    let september30 = new Date(year, 8, 30);
    let december31 = new Date(year, 11, 31);

    if (today < march31) {
        minDateQuarterly = new Date(year - 1, 5, 1);
        maxDateQuarterly = new Date(year - 1, 11, 31);
    } else if (today >= march31 && today < june30) {
        minDateQuarterly = new Date(year - 1, 8, 1);
        maxDateQuarterly = march31;
    } else if (today >= june30 && today < september30) {
        minDateQuarterly = new Date(year, 0, 1);
        maxDateQuarterly = june30;
    } else if (today >= september30 && today < december31) {
        minDateQuarterly = new Date(year, 2, 1);
        maxDateQuarterly = september30;
    } else if (today === december31) {
        minDateQuarterly = new Date(year, 5, 1);
        maxDateQuarterly = december31;
    }

    return {
        MinDateMonthly: minDateMonthly,
        MaxDateMonthly: maxDateMonthly,
        MinDateQuarterly: minDateQuarterly,
        MaxDateQuarterly: maxDateQuarterly,
    }
}
