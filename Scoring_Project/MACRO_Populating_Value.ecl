EXPORT MACRO_Populating_Value (file_name,fieldname, cname):= functionmacro


IMPORT ut;


r_FIELD_NAME := record 
  string100 field_name := fieldname;
		string100 category := cname;
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := IF(length(trim((string)file_name.#expand(fieldname))) = 0, 'Null Value', 'Value Populated');
 decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,IF(length(trim((string)file_name.#expand(fieldname))) = 0, 'Null Value', 'Value Populated'));

return t_FIELD_NAME;

endmacro;


