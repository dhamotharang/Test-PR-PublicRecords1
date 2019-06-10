import FBNV2;

export Layout_Contact := RECORD
	FBNV2.Layout_Common.Contact and not [CONTACT_FEI_NUM, global_sid, record_sid];
	string25 state;
	string25 county_name;
	string10 CONTACT_FEI_NUM;
	string10 Contact_Type_decoded;
	string10 Contact_Name_Format_decoded;
END;