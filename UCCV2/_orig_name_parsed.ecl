import Address;
export _orig_name_parsed(STRING pName,
                         STRING pNameOrder) := 
module
 export _name := Address.Clean_n_Validate_Name(regexreplace('\054',pName,''),StringLib.StringToUpperCase(pNameOrder),,,false).CleanNameRecord;
 export title := _name.title;
 export fname := _name.fname;
 export mname := _name.mname;
 export lname := _name.lname;
 export name_suffix := _name.name_suffix;
 export name_score := _name.name_score;
 export boolean is_company := if(_name.fname = '' and _name.lname = '',true, false);
end;