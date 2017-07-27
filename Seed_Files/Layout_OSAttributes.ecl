import Models;

export Layout_OSAttributes := RECORD
	string20 table_name;
	string30 account;
	string15 fname;
	string20 lname;
	string9  zip;
	string9  social;
	string10 homephone;
	//reusing CBD attribute layout rather than cutting and pasting the same layout/attribtues again
	Models.Layout_CBDAttributes -IdentityV1 -RelationshipV1;

END;