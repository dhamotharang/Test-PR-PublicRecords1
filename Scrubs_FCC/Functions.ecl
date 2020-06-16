IMPORT std,scrubs;

EXPORT Functions := MODULE 

    EXPORT fn_valid_date(STRING st = '', string future = '') := FUNCTION

        return if(
            Scrubs.Functions.fn_valid_date(st, future) > 0
            OR Scrubs.Functions.fn_valid_date((string) STD.Date.FromStringToDate(st, '%m/%d/%Y'), future) > 0
            ,1
            ,0
        );

    END;
END;