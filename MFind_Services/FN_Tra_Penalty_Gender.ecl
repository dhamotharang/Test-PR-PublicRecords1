export FN_Tra_Penalty_Gender(string Gender_Field) := FUNCTION

string1 Gender_val := '' :stored('Gender');

Gender_value := stringlib.stringtouppercase(Gender_val);

return MAP(Gender_value='' or Gender_field[1]=Gender_value => 0,
		Gender_Field='' => 3,
		5);

END;