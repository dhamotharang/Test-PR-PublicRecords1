IMPORT lib_stringlib.StringLib;
IMPORT lib_timelib.TimeLib;

EXPORT Date := MODULE


// A record structure with the different date elements separated out.
EXPORT Date_rec := RECORD
    INTEGER2    year;
    UNSIGNED1   month;
    UNSIGNED1   day;
END;


// An unsigned number holding a date in the decimal form YYYYMMDD.
// This type doesn't support dates before 1AD.
EXPORT Date_t := UNSIGNED4;


// A number of elapsed days.  Origin depends on the function called.
EXPORT Days_t := INTEGER4;


// A record structure with the different time elements separated out.
EXPORT Time_rec := RECORD
    UNSIGNED1   hour;
    UNSIGNED1   minute;
    UNSIGNED1   second;
END;


// An unsigned number holding a time of day in the decimal form HHMMDD.
EXPORT Time_t := UNSIGNED3;


// A signed number holding a number of seconds.  Can be used to represent either
// a duration or the number of seconds since epoch (Jan 1, 1970).
EXPORT Seconds_t := INTEGER8;


// A record structure with the different date and time elements separated out.
EXPORT DateTime_rec := RECORD
    Date_rec;
    Time_Rec;
END;


// A signed number holding a number of microseconds.  Can be used to represent
// either a duration or the number of microseconds since epoch (Jan 1, 1970).
EXPORT Timestamp_t := INTEGER8;

EXPORT Date_t DateFromParts(INTEGER2 year, UNSIGNED1 month, UNSIGNED1 day) := (year * 100 + month) * 100 + day;


/**
 * Combines hour, minute second to create a time type.
 *
 * @param hour          The hour (0-23).
 * @param minute        The minute (0-59).
 * @param second        The second (0-59).
 * @return              A time created by combining the fields.
 */

EXPORT Time_t TimeFromParts(UNSIGNED1 hour, UNSIGNED1 minute, UNSIGNED1 second) := (hour * 100 + minute) * 100 + second;


/**
 * Combines date and time components to create a seconds type.  The date must
 * be represented within the Gregorian calendar after the year 1600.
 *
 * @param year                  The year (1601-30827).
 * @param month                 The month (1-12).
 * @param day                   The day (1..daysInMonth).
 * @param hour                  The hour (0-23).
 * @param minute                The minute (0-59).
 * @param second                The second (0-59).
 * @param is_local_time         TRUE if the datetime components are expressed
 *                              in local time rather than UTC, FALSE if the
 *                              components are expressed in UTC.  Optional,
 *                              defaults to FALSE.
 * @return                      A Seconds_t value created by combining the fields.
 */

EXPORT Seconds_t SecondsFromParts(INTEGER2 year,
                                  UNSIGNED1 month,
                                  UNSIGNED1 day,
                                  UNSIGNED1 hour,
                                  UNSIGNED1 minute,
                                  UNSIGNED1 second,
                                  BOOLEAN is_local_time = FALSE) :=
    TimeLib.SecondsFromParts(year, month, day, hour, minute, second, is_local_time);


EXPORT SecondsToParts(Seconds_t seconds) := FUNCTION
    parts := ROW(TimeLib.SecondsToParts(seconds));

    result := MODULE
        EXPORT INTEGER2 year := parts.year + 1900;
        EXPORT UNSIGNED1 month := parts.mon + 1;
        EXPORT UNSIGNED1 day := parts.mday;
        EXPORT UNSIGNED1 hour := parts.hour;
        EXPORT UNSIGNED1 minute := parts.min;
        EXPORT UNSIGNED1 second := parts.sec;
        EXPORT UNSIGNED1 day_of_week := parts.wday + 1;
        EXPORT Date_t date := DateFromParts(year,month,day);
        EXPORT Time_t time := TimeFromParts(hour,minute,second);
    END;

    RETURN result;
END;



EXPORT Seconds_t SecondsFromDateTimeRec(DateTime_rec datetime, BOOLEAN is_local_time = FALSE) :=
    SecondsFromParts(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute, datetime.second, is_local_time);

end;