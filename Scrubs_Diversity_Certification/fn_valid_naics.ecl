import STD;

EXPORT Fn_Valid_NAICS(string st) := FUNCTION

    RETURN if
    ( 
        LENGTH(std.str.filter(st, '0123456789')) <= 6 OR
        st = '',
        1,
        0
    );
END;