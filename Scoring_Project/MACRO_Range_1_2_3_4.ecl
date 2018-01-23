﻿EXPORT MACRO_Range_1_2_3_4(file_name,fieldname, cname):= functionmacro

IMPORT ut;

r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := MAP((integer)file_name.#expand(fieldname) = 0 => '00',
																	(integer)file_name.#expand(fieldname) = 1 => '01',
																	(integer)file_name.#expand(fieldname) = 2 => '02',
																	(integer)file_name.#expand(fieldname) = 3 => '03',
																	(integer)file_name.#expand(fieldname) >= 4 => '> 03',
																	'UNDEFINED');
decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,MAP((integer)file_name.#expand(fieldname) = 0 => '00',
																	(integer)file_name.#expand(fieldname) = 1 => '01',
																	(integer)file_name.#expand(fieldname) = 2 => '02',
																	(integer)file_name.#expand(fieldname) = 3 => '03',
																	(integer)file_name.#expand(fieldname) >= 4 => '> 03',
																	'UNDEFINED'));

return t_FIELD_NAME;

endmacro;