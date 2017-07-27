export Layout_UCC := module
  export main := module
		export Unlinked := record
			string2   source;
			string50  source_docid;				
			string3  	Filing_Jurisdiction;
			string14 	orig_filing_number;		
			string40 	orig_filing_type;	
			string8  	orig_filing_date;	
			string30	Status_type;
			string8   expiration_date;				
			string14  filing_number;	
			string40  filing_type;	
			string8   filing_date;	
			string8   filing_status;
			string3  	page;
			string9  	contract_type;
			string17 	amount;
			string17 	irs_serial_number;	
			string8  	effective_date;					
			string120 filing_agency;
			string64 	filing_agency_address;
			string30 	filing_agency_city;
			string2  	filing_agency_state;
			string30 	filing_agency_county;
			string9  	filing_agency_zip;
		end;
	
		export Linked := record
			unsigned6 bid;
			string10  source_party;
			Unlinked;		
			string1   status_code;
		end;
	end;
					
  export party := record
		string3   filing_jurisdiction;
		string14  orig_filing_number;
		string14  filing_number;
		string120 Orig_name;
		unsigned6	bdid;
		unsigned6 did;
		string5		title;
		string20	lname;
		string20	fname;
		string20	mname;
		string5		name_suffix;
		string9 	ssn;
		string10 	fein;
		string45 	Incorp_state;
		string30 	corp_number;
		string30 	corp_type;	
		
		// string60  	Orig_address1;
			// string60 	Orig_address2;
			// string30 	Orig_city;
			// string2  	Orig_state;
			// string5  	Orig_zip5;
			// string4  	Orig_zip4;
			// string30	Orig_country;
			// string30 	Orig_province;
			// string9  	Orig_postal_code;
			string1  	foreign_indc;
			string1  	Party_type;			
			string10	prim_range;
			string2		predir;
			string28	prim_name;
						
			string4		suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	p_city_name;
			string25	v_city_name;			
			string2		st;
			string5		zip5;
			string4		zip4;
			string3		county;
			string18 county_name;
			string10	geo_lat;
			string11	geo_long;

	// typeof(k_party.Orig_address1) address1;
	// typeof(k_party.Orig_address2) address2;
	end;
	
	export Collateral := record
		string3   filing_jurisdiction;
		string14  orig_filing_number;
		string14  filing_number;
		unsigned2 CollateralNumber;
		unsigned2 CollateralSequence;
		string100 CollateralDescription;
	end;

end;