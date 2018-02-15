EXPORT MACRO_Range_10 (file_name,fieldname, cname):= functionmacro


IMPORT ut;



r_FIELD_NAME := record 
  string100 field_name := fieldname;
		string100 category := cname;
  string30 distribution_type := 'RANGE';
  string50 attribute_value := Scoring_Project.Map_Range_10((string)file_name.#expand(fieldname));
 decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,Scoring_Project.Map_Range_10((string)file_name.#expand(fieldname)));

return t_FIELD_NAME;

endmacro;