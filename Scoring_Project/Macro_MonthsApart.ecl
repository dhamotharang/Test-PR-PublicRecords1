EXPORT Macro_MonthsApart (file_name,fieldname, cname, offset):= functionmacro

import std;
import ut;


r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'DATE-MONTHS-APART';
  string50 attribute_value := MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	length(trim((string)file_name.#expand(fieldname))) > 6 => 'DateLength > 6',
																	length(trim((string)file_name.#expand(fieldname))) < 6  => 'DateLength < 6',
																	ut.MonthsApart((ut.getdate)[1..6], (string)file_name.#expand(fieldname)) <= offset => 'Less Than ' +  (string)offset + ' month',
																	 'Greater Than ' +  (string)offset + ' month');
decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME, MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	length(trim((string)file_name.#expand(fieldname))) > 6 => 'DateLength > 6',
																	length(trim((string)file_name.#expand(fieldname))) < 6  => 'DateLength < 6',
																	ut.MonthsApart((ut.getdate)[1..6], (string)file_name.#expand(fieldname)) <= offset => 'Less Than ' +  (string)offset + ' month',
																	 'Greater Than ' +  (string)offset + ' month'));
	

return t_FIELD_NAME;

endmacro;