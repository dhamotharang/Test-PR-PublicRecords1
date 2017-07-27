import uccd;
export layout_UCC_Records := record, maxlength(30000)
  unsigned2 penalt;
	//uccd.Key_Party_DID;
	string50  ucc_key;
	unsigned6 did;
	unsigned6 bdid;

	//from party
	string20 				debtor_fname;
	string20 				debtor_mname;
	string20 				debtor_lname;
	string5 				debtor_name_suffix;

	string60 				debtor_name := '';
	string10        debtor_prim_range := '';
	string2         debtor_predir := '';
	string28        debtor_prim_name := '';
	string4         debtor_addr_suffix := '';
	string2         debtor_postdir := '';
	string10        debtor_unit_desig := '';
	string8         debtor_sec_range := '';
	string25        debtor_city_name := '';
	STRING18 			  debtor_county_name := '';
	string2         debtor_st := '';
	string5         debtor_zip := '';
	string4         debtor_zip4 := '';
	
	string60 				secured_name := '';
	string10        secured_prim_range := '';
	string2         secured_predir := '';
	string28        secured_prim_name := '';
	string4         secured_addr_suffix := '';
	string2         secured_postdir := '';
	string10        secured_unit_desig := '';
	string8         secured_sec_range := '';
	string25        secured_city_name := '';
	STRING18 			  secured_county_name := '';
	string2         secured_st := '';
	string5         secured_zip := '';
	string4         secured_zip4 := '';
	
	//from collateral
	DATASET(uccd.Layout_Collateral_ChildDS) collateral_children;
	
	//from summary
	STRING2				  filing_state := '';
	STRING4  				filing_count := '';   		
	STRING4  				document_count := '';    
	STRING3  				debtor_count := '';      
	STRING3  				secured_count := '';  
	
	//from event
	string8				  orig_filing_date := '';
	string8   			filing_date := '';
	string32  			event_document_num := '';
	string60			  filing_type_desc := '';

end;