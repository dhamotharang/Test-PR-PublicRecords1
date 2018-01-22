EXPORT MACRO_disthphonewphone (file_name,fieldname, cname) := functionmacro


r_FIELD_NAME := record
  string100 field_name := fieldname;
  string100 category := cname;
  string30 distribution_type := 'COUNT';
  string50 attribute_value := MAP( (string)file_name.#expand(fieldname) = '9999' => '9999',
																		(integer)file_name.#expand(fieldname) = 0 => '0',
																		(integer)file_name.#expand(fieldname) > 0 and  (integer)file_name.#expand(fieldname) < 9999 => '1-9998',																		
																		'Unknown');
 decimal20_4 frequency := count(group);
end;


tb := table(file_name,r_FIELD_NAME,MAP( (string)file_name.#expand(fieldname) = '9999' => '9999',
																		(integer)file_name.#expand(fieldname) = 0 => '0',
																		(integer)file_name.#expand(fieldname) > 0 and  (integer)file_name.#expand(fieldname) < 9999 => '1-9998',																		
																		'Unknown'));
																		



ap1 := file_name((integer)file_name.#expand(fieldname) <> 9999);											 

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
																			self.attribute_value := 'Avg for Values <9999';
																			self.frequency := AVE(ap1, (decimal20_4)ap1.#expand(fieldname));
																			));
																			
t_FIELD_NAME := tb1 + tb;																				

return t_FIELD_NAME;

endmacro;