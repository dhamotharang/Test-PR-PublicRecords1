EXPORT MACRO_distinct_values (file_name,fieldname, cname):= functionmacro


IMPORT ut;

r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := (string)file_name.#expand(fieldname);
decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,(string)file_name.#expand(fieldname));

return t_FIELD_NAME;

endmacro;