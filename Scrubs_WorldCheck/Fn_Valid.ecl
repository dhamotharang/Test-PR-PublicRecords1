IMPORT std,scrubs;

export Fn_Valid := MODULE 

    EXPORT Date (String st, string future = '') := FUNCTION 

        RETURN if 
        (
            scrubs.Fn_Valid_Date(st, future) > 0
            OR scrubs.Fn_Valid_Date((string) STD.Date.FromStringToDate(st, '%Y-%m-%d'), future) > 0
            ,1
            ,0
        );

    END;

    EXPORT Chars (STRING st, string inMod) := FUNCTION 

        acceptableChars := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_<>{}[]()-~^*=#@!?%$+&,./:;\'';
        Clean_String := STD.str.Filter(st, acceptableChars);

        RETURN IF 
        (
            Scrubs.Fn_Allow_ws(Clean_string, inMod) > 0
            ,1
            ,0
        );

    END;

END;