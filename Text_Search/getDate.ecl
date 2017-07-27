IMPORT lib_Timelib;
EXPORT STRING10 getDate(INTEGER4 daysFromToday) := FUNCTION
  adjusted_date := timelib.AdjustDateBySeconds(timelib.CurrentDate(TRUE), daysFromToday*86400);
  STRING4 yyyy := INTFORMAT(adjusted_date DIV 10000, 4, 1);
  STRING2 mm := INTFORMAT((adjusted_date % 10000) DIV 100, 2, 1);   // left zeros
  STRING2 dd := INTFORMAT(adjusted_date % 100, 2, 1);   // left zeros
  RETURN yyyy + '/' + mm + '/' + dd;
END;