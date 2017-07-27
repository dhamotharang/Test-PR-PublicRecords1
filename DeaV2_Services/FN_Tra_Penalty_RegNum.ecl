import business_header;

export FN_Tra_Penalty_RegNum(string reg_field) := 
FUNCTION

//REgistration Number penalty

String9 reg_num := '' : STORED('Registration_Number');

return if(reg_num = '', 0, Regsimilar(reg_field, reg_num));

END;