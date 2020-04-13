import STD;

EXPORT Fn_Valid_Sic(string st) := FUNCTION

    RETURN if
    ( 
        LENGTH(std.str.filter(st, '0123456789')) = 4 OR
        st = '',
        1,
        0
    );
END;