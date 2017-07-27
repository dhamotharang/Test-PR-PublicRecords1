/*

Layout for Results output

*/
export AddressHistory_Layout_OutBatch := RECORD
  integer4     sequence;
	integer4     seq;  //Input sequence - primarily needed when batched input is used
	unsigned6    did;
	unsigned3    dt_first_seen; 
	unsigned3    dt_last_seen;
	string10     phone;
	string5      title;
	string20     fname;
	string20     mname;
	string20     lname;
	string5      name_suffix;
	string64     addr1;   
	string25     city_name;
	string2      st;
	string5      zip;
	string4      zip4;
	string1      tnt;
	string120    listed_name;
	string10     listed_phone;
END;