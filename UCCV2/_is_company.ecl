import Address;
export _is_company(STRING pName) := 
FUNCTION
 _name_f1 := Address.Clean_n_Validate_Name(regexreplace('\054',pName,''),'F',,,false).CleanNameRecord;
 BOOLEAN is_comp_f := if(_name_f1.fname = '' and _name_f1.lname = '',true, false);

 _name_l1 := Address.Clean_n_Validate_Name(regexreplace('\054',pName,''),'L',,,false).CleanNameRecord;
 BOOLEAN is_comp_l := if(_name_l1.fname = ''  and _name_l1.lname = '',true, false);

RETURN is_comp_f OR is_comp_l;
end;