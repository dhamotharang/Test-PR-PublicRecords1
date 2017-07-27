/*

Layout used for AddressHistory_Batch_Service

*/
export  AddressHistory_Layout_InBatch := record
 	unsigned6    seq;  //Input sequence
	string9      ssn;
	string120    name;
	string20     fname;
	string20     mname;
	string20     lname;
	string5      suffix;
	string120    addr1;
	string120    addr2;
	string10     prim_range;
	string28     prim_name; 
	string8      sec_range;
	string25     city;
	string2      st;
	string5      z5;
	string10     phone10;
	string8      dob;
end;