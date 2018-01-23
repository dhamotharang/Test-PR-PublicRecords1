EXPORT MACRO_addrs_per_adl(file_name,fieldname, cname):= functionmacro

IMPORT ut;

r_FIELD_NAME := record 
  string100 field_name := fieldname;
		string100 category := cname;
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)file_name.#expand(fieldname) = 0 => '00',
																	(integer)file_name.#expand(fieldname) between 01 and 05  => '01 to 05',
																	(integer)file_name.#expand(fieldname) between 06 and 10  => '06 to 10',
																	(integer)file_name.#expand(fieldname) between 11 and 15  => '11 to 15',
																	(integer)file_name.#expand(fieldname) between 16 and 20  => '16 to 20',
																	(integer)file_name.#expand(fieldname) >= 21 => '> 20',
																	 'UNDEFINED');
 decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME, MAP((integer)file_name.#expand(fieldname) = 0 => '00',
																	(integer)file_name.#expand(fieldname) between 01 and 05  => '01 to 05',
																	(integer)file_name.#expand(fieldname) between 06 and 10  => '06 to 10',
																	(integer)file_name.#expand(fieldname) between 11 and 15  => '11 to 15',
																	(integer)file_name.#expand(fieldname) between 16 and 20  => '16 to 20',
																	(integer)file_name.#expand(fieldname) >= 21 => '> 20',
																	 'UNDEFINED'));

return t_FIELD_NAME;

endmacro;