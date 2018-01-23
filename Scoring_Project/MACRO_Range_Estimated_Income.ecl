EXPORT MACRO_Range_Estimated_Income(file_name,fieldname, cname):= functionmacro

IMPORT ut;


r_FIELD_NAME := record 
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'RANGE';
  string50 attribute_value := MAP((integer)file_name.#expand(fieldname) < 0 => '< 0',
																	(integer)file_name.#expand(fieldname) = 0 => '00000',
																	(integer)file_name.#expand(fieldname) between 00001 and 25000  => '00001-25000',
																	(integer)file_name.#expand(fieldname) between 25001 and 50000  => '25001-50000',
																	(integer)file_name.#expand(fieldname) between 50001 and 75000  => '50001-75000',
																	(integer)file_name.#expand(fieldname) between 75001 and 100000 => '75001-100000',
																	(integer)file_name.#expand(fieldname) > 100000 => '> 100000',
																  'UNDEFINED');
 decimal20_4 frequency := count(group);
end;


tb := table(file_name,r_FIELD_NAME,MAP((integer)file_name.#expand(fieldname) < 0 => '< 0',
																	(integer)file_name.#expand(fieldname) = 0 => '00000',
																	(integer)file_name.#expand(fieldname) between 00001 and 25000  => '00001-25000',
																	(integer)file_name.#expand(fieldname) between 25001 and 50000  => '25001-50000',
																	(integer)file_name.#expand(fieldname) between 50001 and 75000  => '50001-75000',
																	(integer)file_name.#expand(fieldname) between 75001 and 100000 => '75001-100000',
																	(integer)file_name.#expand(fieldname) > 100000 => '> 100000',
																  'UNDEFINED'));

ap1 := file_name((decimal20_4)file_name.#expand(fieldname) > 0);		
									 

rc1 := record
string100 field_name;
string100 category ;
string30 distribution_type;
STRING50 attribute_value;
decimal20_4 frequency;
end;

a := dataset([{'','','average','average',0}],rc1);
	
tb1 := PROJECT(a, transform(rc1,      self.field_name := fieldname;
																			self.category := cname;
																			self.distribution_type := 'AVERAGE';
																			self.attribute_value := 'Avg Vals >0';
																			self.frequency := AVE(ap1, (decimal20_4)ap1.#expand(fieldname));
																			));
																			
t_FIELD_NAME := tb1 + tb;																				

return t_FIELD_NAME;

endmacro;