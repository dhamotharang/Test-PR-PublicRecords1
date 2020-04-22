import STD,scrubs;

EXPORT Functions := MODULE

    //CHECK FOR VALID SIC CODE
    EXPORT fn_Valid_Sic(string st) := FUNCTION

        sic := std.str.filter(st, '0123456789');

        RETURN if
        ( 
            LENGTH(sic) in [0,4,8]
            AND scrubs.functions.fn_valid_SicCode(sic) > 0
            ,
            1,
            0
        );
    END;

    //CHECK FOR VALID COMMODITY CODE
    EXPORT fn_Valid_Commodity(string st) := FUNCTION

        RETURN if
        ( 
            LENGTH(std.str.filter(st, '0123456789')) in [0,6,8,10],
            1,
            0
        );
    END;

    //CHECK FOR VALID NAICS CODE
    EXPORT fn_Valid_NAICS(string st) := FUNCTION

        naics := std.str.filter(st, '0123456789');

        RETURN if
        ( 
            LENGTH(naics) in [0,6]
            AND scrubs.functions.fn_validate_NAICSCode(naics) > 0
            ,
            1,
            0
        );
    END;

    //CHECK FOR VALID DATE DESPITE FORMAT
    EXPORT fn_Valid_Date(STRING st = '', string future = '') := FUNCTION

        return if(
            Scrubs.fn_valid_date(st, future) > 0
            OR Scrubs.fn_valid_date((string) STD.Date.FromStringToDate(st, '%m/%d/%Y'), future) > 0
            ,1
            ,0
        );

    END;

END;