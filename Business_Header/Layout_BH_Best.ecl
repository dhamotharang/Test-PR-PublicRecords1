bh := Business_Header.Layout_Business_Header_Base;

export Layout_BH_Best := RECORD
	bh.bdid;	         // Seisint Business Identifier
	unsigned4 dt_last_seen := 0;
	qstring120 company_name := '';
	qstring10 prim_range := '';
	string2   predir := '';
	qstring28 prim_name := '';
	qstring4  addr_suffix := '';
	string2   postdir := '';
	qstring5  unit_desig := '';
	qstring8  sec_range := '';
	qstring25 city := '';
	string2   state := '';
	unsigned3 zip := 0;
	unsigned2 zip4 := 0;
	unsigned6 phone := 0;
	unsigned4 fein := 0;        // Federal Tax ID
	unsigned1 best_flags := 0;
	string2   source := '';	   // source type (non-blank only if DPPA_State is non-blank)
  string2   DPPA_State := ''; // If nonblank, indicates state code for a DPPA restricted record
	unsigned8	RawAID := 0;    // Added for Address_id	
	string2 addr_source := '';
	string2 phone_source := '';
END;