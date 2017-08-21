import header;

export set_weekly_ind(dataset(recordof(header.layout_new_records)) in_file) := function

 set1 := ['A','F','N','W','Y','5'];
 set2 := ['2','6','8','9','S','Z'];
 set3 := ['2','6','9'];

 filtered_down := in_file(jflag3 in set1
                          or
						  (jflag3 in set2 and valid_ssn='C')
						  or
						  //this introduces name & address changes BUT ALSO unconfirmed SSN's
						  //leave it to roxie to potentially ignore the SSN
						  (jflag3 in set3 and trim(valid_ssn)='')
						 );

 return filtered_down;
 
end;					  