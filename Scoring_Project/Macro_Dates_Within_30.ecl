EXPORT Macro_Dates_Within_30 (file_name,fieldname, cname, offset1):= functionmacro

import std;
import ut;


r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'DATE-DAYS-APART';
  string50 attribute_value := MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	length(trim((string)file_name.#expand(fieldname))) > 8 => 'DateLength > 8',
																	length(trim((string)file_name.#expand(fieldname))) < 8  => 'DateLength < 8',
																	(unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 'Greater Than ' +  (string)offset1 + ' days');
decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,MAP( RegexFind('[a-zA-Z.~!@&%#$^*()_=+?<>,/"{}|]',TRIM((string)file_name.#expand(fieldname),LEFT,RIGHT))  => 'undefined',
																	(unsigned)file_name.#expand(fieldname) = 0 => 'Count 0',
																	length(trim((string)file_name.#expand(fieldname))) = 0 => 'blank',
																	length(trim((string)file_name.#expand(fieldname))) > 8 => 'DateLength > 8',
																	length(trim((string)file_name.#expand(fieldname))) < 8  => 'DateLength < 8',
																	(unsigned)file_name.#expand(fieldname) > (unsigned)Scoring_Project.Function_Last30Days(ut.GetDate, offset1) => 'Less Than ' +  (string)offset1 + ' days',
																	 'Greater Than ' +  (string)offset1 + ' days'));
	

return t_FIELD_NAME;

endmacro;

