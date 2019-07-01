import STD;
EXPORT MonthRange(Std.Date.Date_t fromDate, Std.Date.Date_t toDate) := FUNCTION
    years := Std.Date.Year(toDate) - Std.Date.Year(fromDate);
    months := Std.Date.Month(toDate) - Std.Date.Month(fromDate);
    result := years * 12 + months + 1;

    RETURN result;
END;
