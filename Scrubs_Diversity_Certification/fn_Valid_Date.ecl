import std,scrubs;

EXPORT fn_valid_date(STRING st = '', string future = '') := FUNCTION

    return if(
        Scrubs.fn_valid_date(st, future) > 0
        OR Scrubs.fn_valid_date((string) STD.Date.FromStringToDate(st, '%m/%d/%Y'), future) > 0
        ,1
        ,0
    );

END;