IMPORT Address, NID, STD;

EXPORT Fn_Clean_Name_Roxie(STRING fname = '', STRING mname = '', STRING lname = '', STRING fullname = '') := 
  FUNCTION
    fullname_trimmed := TRIM( STD.Str.ToUpperCase(fullname), LEFT, RIGHT );    
    NameReconstr     := IF( fullname_trimmed = '', TRIM(fname) + ' ' + TRIM(mname) +' ' + TRIM(lname), fullname_trimmed ); 
    mod_CleanedName  := Address.CleanNameFields( Address.CleanPerson73( NameReconstr ) );
    RETURN mod_CleanedName;
  END;
