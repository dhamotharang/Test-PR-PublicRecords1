//////////////////////////////////////////////////////////////////////////
//                                                                      //
//          This function was built to deal with                        //
//          carriage returns and other strange whitespace               //
//          characters SALT/scrubs can't seem to handle.                //

//          You can use the presets with the second parameter           //
//          or build your own by filling in any other character(s).     //
//                                                                      //           
//////////////////////////////////////////////////////////////////////////

IMPORT STD;

EXPORT Fn_Allow_ws(string st, string inp, boolean caseMatters = false) := FUNCTION 

    clean_st := TRIM(st,WHITESPACE);
    Up_st := Std.STR.ToUpperCase(clean_st);

    Num     := '0123456789';
    Alpha   := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Char    := '_<>{}[]()-~^*=#@!?%$+&,./:;\'';

    isValidString := CASE
    (
        inp,
        //PRESETS MODS
        'Num'           => STD.str.FilterOut(Up_st,Num) = '',
        'Float'         => STD.str.FilterOut(Up_st,Num+Char) = '',
        'Alpha'         => STD.str.FilterOut(Up_st,Alpha) = '',  
        'AlphaNum'      => STD.str.FilterOut(Up_st,Alpha+Num) = '',
        'AlphaChar'     => STD.str.FilterOut(Up_st,Alpha+Char) = '',
        'AlphaNumChar'  => STD.str.FilterOut(Up_st,Alpha+Num+Char) = '',
        //CUSTOM CHARACTERS
        if
        (
            caseMatters
            ,STD.STR.FilterOut(clean_st,inp) = ''
            ,STD.STR.FilterOut(Up_st,inp) = ''
        )
    );


    RETURN IF 
    (
        isValidString
        ,1
        ,0
    );
END;