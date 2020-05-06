//////////////////////////////////////////////////////////////////////////
//                                                                      //
//          This function was built to deal with                        //
//          carriage returns and other strange whitespace               //
//          characters SALT/scrubs can't seem to handle.                //

//          You can use the presets with the second parameter           //
//          or build your own by filling in any other character(s).     //
<<<<<<< HEAD
=======

//          The third parameter is optional if it's important           //
//          for the letters to be uppercase.                            //
>>>>>>> b6d11da21e36a47af6f6ec9e970a67b37bc3241e
//                                                                      //           
//////////////////////////////////////////////////////////////////////////

IMPORT STD;

<<<<<<< HEAD
EXPORT Fn_Allow_ws(string st, string inp) := FUNCTION 
=======
EXPORT Fn_Allow_ws(string st, string inp, boolean caseMatters = false) := FUNCTION 
>>>>>>> b6d11da21e36a47af6f6ec9e970a67b37bc3241e

    clean_st := TRIM(st,WHITESPACE);
    Up_st := Std.STR.ToUpperCase(clean_st);

<<<<<<< HEAD
    Num     := '0123456789';
    Alpha   := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Char    := '_<>{}[]()-~^*=#@!?%$+&,./:;\'';
=======
    useString   :=  if(caseMatters,clean_st,Up_st);
    Num         := '0123456789';
    Alpha       := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Char        := '_<>{}[]()-~^*=#@!?%$+&,./:;\'';
>>>>>>> b6d11da21e36a47af6f6ec9e970a67b37bc3241e

    isValidString := CASE
    (
        inp,
<<<<<<< HEAD
        //PRESETS MODS
        'Num'           => STD.str.FilterOut(Up_st,Num) = '',                        
        'Alpha'         => STD.str.FilterOut(Up_st,Alpha) = '',                                 //Ex in SALT:
        'AlphaNum'      => STD.str.FilterOut(Up_st,Alpha+Num) = '',                             //FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, 'AlphaNum')
        'AlphaChar'     => STD.str.FilterOut(Up_st,Alpha+Char) = '',
        'AlphaNumChar'  => STD.str.FilterOut(Up_st,Alpha+Num+Char) = '',
        //CUSTOM CHARACTERS
        STD.STR.FilterOut(clean_st,inp) = ''
=======
        //PRESET MODS
        'Num'           => STD.str.FilterOut(useString,Num) = '',
        'NumChar'       => STD.str.FilterOut(useString,Num+Char) = '',
        'Alpha'         => STD.str.FilterOut(useString,Alpha) = '',  
        'AlphaNum'      => STD.str.FilterOut(useString,Alpha+Num) = '',
        'AlphaChar'     => STD.str.FilterOut(useString,Alpha+Char) = '',
        'AlphaNumChar'  => STD.str.FilterOut(useString,Alpha+Num+Char) = '',
        //CUSTOM CHARACTERS
        STD.STR.FilterOut(useString,inp) = ''
>>>>>>> b6d11da21e36a47af6f6ec9e970a67b37bc3241e
    );


    RETURN IF 
    (
        isValidString
        ,1
        ,0
    );
<<<<<<< HEAD
END;
=======
END;

>>>>>>> b6d11da21e36a47af6f6ec9e970a67b37bc3241e
