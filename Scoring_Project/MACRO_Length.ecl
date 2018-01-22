EXPORT MACRO_Length(file_name,fieldname, cname):= functionmacro


IMPORT ut;


r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'LENGTH';
  string50 attribute_value := length(trim((string)file_name.#expand(fieldname)));
decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,length(trim((string)file_name.#expand(fieldname))));

return t_FIELD_NAME;

endmacro;