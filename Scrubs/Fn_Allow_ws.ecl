//////////////////////////////////////////////////////////////////////////
//                                                                      //
//          This function was built to deal with                        //
//          carriage returns and other strange whitespace               //
//          characters SALT/scrubs can't seem to handle.                //

//          You can use the presets with the second parameter           //
//          or build your own by filling in any other character(s).     //

//          The third parameter is optional if it's important           //
//          for the letters to be uppercase.                            //
//                                                                      //           
//////////////////////////////////////////////////////////////////////////

IMPORT STD;

EXPORT Fn_Allow_ws(string st, string inp, boolean caseMatters = false) := FUNCTION 

    clean_st := TRIM(st,WHITESPACE);
    Up_st := Std.STR.ToUpperCase(clean_st);

    useString   :=  if(caseMatters,clean_st,Up_st);
    Num         := '0123456789';
    Alpha       := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Char        := '_<>{}[]()-~^*=#@!?%$+&,./:;\'`';

    isValidString := CASE
    (
        inp,
        //PRESET MODS
        'Num'           => STD.str.FilterOut(useString,Num) = '',
        'NumChar'       => STD.str.FilterOut(useString,Num+Char) = '',
        'Alpha'         => STD.str.FilterOut(useString,Alpha) = '',  
        'AlphaNum'      => STD.str.FilterOut(useString,Alpha+Num) = '',
        'AlphaChar'     => STD.str.FilterOut(useString,Alpha+Char) = '',
        'AlphaNumChar'  => STD.str.FilterOut(useString,Alpha+Num+Char) = '',
        //CUSTOM CHARACTERS
        STD.STR.FilterOut(useString,inp) = ''
    );


    RETURN IF 
    (
        isValidString
        ,1
        ,0
    );
END;

