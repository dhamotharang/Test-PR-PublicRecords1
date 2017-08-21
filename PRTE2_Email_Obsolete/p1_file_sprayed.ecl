
//LexId,email,fname,lname,address,city,zip,st,phone,source,ip,date_time,dob,nonincentiviezed_opt_in,incentivized_opt_in

EXPORT p1_file_sprayed:=MODULE
  EXPORT layout:=RECORD
		STRING LexId;
    STRING email;
    STRING fname;
    STRING lname;
    STRING address;
    STRING city;
    STRING zip;
    STRING state;
    STRING phone;
    STRING source;
    STRING ip;
    STRING date_time;
    // STRING gender;
    STRING dob;
    STRING nonincentivized_opt_in;
    STRING incentivized_opt_in;
  END;
	
	EXPORT file:=DATASET( _constants.fileSprayedString,layout,CSV(heading(1),terminator('\n'),separator(','),quote('')))(email!='EMail');

END;

