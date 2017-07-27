import standard, ut, doxie, CNLD_Facilities; 

inFile := CNLD_Facilities.file_Facilities_AID;
// inFile := CNLD_Facilities.file_Facilities_AID(addr_id != '' or (addr_id = '' and addr_ind not in ['2','3']));

Facility_Key_Layout := RECORD
	CNLD_Facilities.layout_Facilities_AID_schd;
	unsigned6	DID	:= 0;
	unsigned1 zero := 0;
	string1		blank := '';
END;
	

facility_base := PROJECT(inFile, Facility_Key_Layout);

export file_Facilities_Autokeys := facility_base;

