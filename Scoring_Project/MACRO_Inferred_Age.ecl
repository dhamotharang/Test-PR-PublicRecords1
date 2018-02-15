EXPORT MACRO_Inferred_Age (file_name,fieldname, cname):= functionmacro

IMPORT ut;

r_FIELD_NAME := record 
  string100 field_name := fieldname;
		string100 category := cname;
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)file_name.#expand(fieldname) = 0 => '00',
																	(integer)file_name.#expand(fieldname) between 01 and 10  => '01 to 10',
																	(integer)file_name.#expand(fieldname) between 11 and 20  => '11 to 20',
																	(integer)file_name.#expand(fieldname) between 21 and 30  => '21 to 30',
																	(integer)file_name.#expand(fieldname) between 31 and 40  => '31 to 40',
																	(integer)file_name.#expand(fieldname) between 41 and 50  => '41 to 50',
																	(integer)file_name.#expand(fieldname) between 51 and 60  => '51 to 60',
																	(integer)file_name.#expand(fieldname) between 61 and 70  => '61 to 70',
																	(integer)file_name.#expand(fieldname) between 71 and 80  => '71 to 80',
																	(integer)file_name.#expand(fieldname) >= 81 => '> 80',
																	'UNDEFINED');
 decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME, MAP((integer)file_name.#expand(fieldname) = 0 => '00',
																	(integer)file_name.#expand(fieldname) between 01 and 10  => '01 to 10',
																	(integer)file_name.#expand(fieldname) between 11 and 20  => '11 to 20',
																	(integer)file_name.#expand(fieldname) between 21 and 30  => '21 to 30',
																	(integer)file_name.#expand(fieldname) between 31 and 40  => '31 to 40',
																	(integer)file_name.#expand(fieldname) between 41 and 50  => '41 to 50',
																	(integer)file_name.#expand(fieldname) between 51 and 60  => '51 to 60',
																	(integer)file_name.#expand(fieldname) between 61 and 70  => '61 to 70',
																	(integer)file_name.#expand(fieldname) between 71 and 80  => '71 to 80',
																	(integer)file_name.#expand(fieldname) >= 81 => '> 80',
																	'UNDEFINED'));

return t_FIELD_NAME;

endmacro;