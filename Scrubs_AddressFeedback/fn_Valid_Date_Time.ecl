IMPORT std;

EXPORT fn_Valid_Date_Time(STRING ST) := FUNCTION 

    toLower := std.str.toLowerCase(st);
    
    RETURN IF 
    (
        true,
        1,
        0
    );
END;