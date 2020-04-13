import STD;

EXPORT Fn_Valid_Commodity(string st) := FUNCTION
    
    NoLength := LENGTH(std.str.filter(st, '0123456789'));

    RETURN if
    ( 
        NoLength = 6 OR
        NoLength = 8 OR
        NoLength = 10 OR
        st = '',
        1,
        0
    );
END;