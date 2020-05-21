IMPORT STD,SCRUBS;


EXPORT Fn_Valid_Date(STRING st, STRING future = '') := FUNCTION

    RETURN IF 
    (
        Scrubs.fn_valid_date(st, future) > 0
        OR Scrubs.fn_valid_date((string) std.Date.FromStringToDate(st,'%Y-%m-%d'), future) > 0
        ,1
        ,0
    );
END;

