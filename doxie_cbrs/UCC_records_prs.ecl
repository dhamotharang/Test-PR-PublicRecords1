import uccd,ut;

export UCC_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

uccs := doxie_cbrs.UCC_Records(bdids);

rec := record //from doxie_crs.layout_UCC_Records
  uccs.level;
	string50  ucc_key;
	unsigned6 did;
	unsigned6 bdid;

	//from party
	string20 				debtor_fname;
	string20 				debtor_mname;
	string20 				debtor_lname;
	string5 				debtor_name_suffix;

	string60 				debtor_name := '';
	
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

ut.MAC_Slim_Back(uccs, rec, uccslim)

return uccslim;
END;