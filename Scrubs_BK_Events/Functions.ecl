IMPORT STD, Scrubs;

EXPORT Functions := MODULE 

    EXPORT Fn_Valid_Date(STRING St, STRING ft = '') := FUNCTION 

        RETURN IF 
        (
            Scrubs.Fn_Valid_Date(st, ft) > 0
            OR Scrubs.Fn_Valid_Date(st[..8], ft) > 0
            ,1
            ,0
        );

    END;

END;