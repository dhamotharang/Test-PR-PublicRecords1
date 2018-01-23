EXPORT MACRO_RiskView_Score_Bin (file,file_name,fieldname, cname):= functionmacro


IMPORT ut;

r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'BIN';
  string50 attribute_value := Scoring_Project.Get_Score_Bin((string)file_name.#expand(fieldname), cname);
decimal20_4 frequency := count(group);
STRING100 file_name := file;
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,Scoring_Project.Get_Score_Bin((string)file_name.#expand(fieldname), cname));

return t_FIELD_NAME;

endmacro;