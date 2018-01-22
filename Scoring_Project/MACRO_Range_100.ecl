EXPORT MACRO_Range_100 (file_name,fieldname, cname):= functionmacro


IMPORT ut;


// rc := record
// string field_name;
// string distribution_type ;
// STRING50 attribute_value ;
// end;

// Bks_project := PROJECT(file_name, TRANSFORM(rc,
                                                // self.field_name:= fieldname;
                                                // self.distribution_type := 'RANGE';
																				        // self.attribute_value := MAP((integer)left.#expand(fieldname) between 0 and 10 => '00-10',
                                                                     // (integer)left.#expand(fieldname) between 11 and 20 => '11-20',
																																		 // (integer)left.#expand(fieldname) between 21 and 30 => '21-30',
                                                                     // (integer)left.#expand(fieldname) between 31 and 40 => '31-40',
																																		 // (integer)left.#expand(fieldname) between 41 and 50 => '41-50',
                                                                     // (integer)left.#expand(fieldname) between 51 and 60 => '51-60',
																																		 // (integer)left.#expand(fieldname) between 61 and 70 => '61-70',
																																		 // (integer)left.#expand(fieldname) between 71 and 80 => '71-80',
																																		 // (integer)left.#expand(fieldname) between 81 and 90 => '81-90',
																																		 // (integer)left.#expand(fieldname) between 91 and 100 => '91-100',
																																		 // (integer)left.#expand(fieldname) > 100 => '>100',
																																		   // 'UNDEFINED')));
		

// r_FIELD_NAME := record 
  // Bks_project.field_name;
  // Bks_project.distribution_type ;
  // Bks_project.attribute_value ;
  // frequency := count(group);
// end;


// t_FIELD_NAME := table(Bks_project,r_FIELD_NAME,field_name,distribution_type,attribute_value);

// return t_FIELD_NAME;

// endmacro;


r_FIELD_NAME := record 
  string100 field_name := fieldname;
		string100 category := cname;
  string30 distribution_type := 'RANGE';
  string50 attribute_value := Scoring_Project.Map_Range_100((string)file_name.#expand(fieldname));
 decimal20_4 frequency := count(group);
end;


t_FIELD_NAME := table(file_name,r_FIELD_NAME,Scoring_Project.Map_Range_100((string)file_name.#expand(fieldname)));

return t_FIELD_NAME;

endmacro;
