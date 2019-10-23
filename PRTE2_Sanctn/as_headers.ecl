import header,business_header,mdr,_Validate, std, ut;

EXPORT as_headers := module

//YOU ONLY NEED THIS WHEN YOUR FILE HAS CONSUMERS
  Header.Layout_New_Records map_to_person_header(files.base_party_ext le) := transform
    self.src                      := MDR.sourceTools.src_Mari_Public_Sanc;
	  self.vendor_id								:= le.cust_name;																										
		lTODAY := ((string)Std.Date.Today())[1..6];																								
    self.dt_first_seen            := ((unsigned3)lTODAY); 
    self.dt_last_seen             := ((unsigned3)lTODAY);
    self.dt_vendor_first_reported := 0;
    self.dt_vendor_last_reported  := 0;
		self.phone										:= '';
		self.ssn											:= le.SSNUMBER;
		self.dob											:= (unsigned) le.link_dob;
    self.did                      := le.did;
    self.title                    := le.title;
    self.fname                    := le.fname;
    self.mname                    := le.mname;
    self.lname                    := le.lname;
    self.name_suffix              := le.name_suffix;
    self.prim_range               := le.prim_range;
    self.predir                   := le.predir;
    self.prim_name                := le.prim_name;
    self.suffix                   := le.addr_suffix;
    self.postdir                  := le.postdir;
    self.unit_desig               := le.unit_desig;
    self.sec_range                := le.sec_range;
    self.city_name                := le.v_city_name;
    self.st                       := le.st;
    self.zip                      := le.zip5;
    self.zip4                     := le.zip4;
    self.county                   := le.fips_county;
    self := le;
    self := [];
  end;

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_pubic_sanctn_recs := project(files.base_party_ext(did>0),map_to_person_header(left));


//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE LEGACY BUSINESS HEADER
map_to_old_business_header(dataset(recordof(files.base_party_ext)) in_ds) := function

	Business_Header.Layout_Business_Header_New xform1(in_ds le) := transform
		//UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER  
		SELF.BDID                     := le.BDID;	
		SELF.company_name             := STD.Str.ToUpperCase(le.cname);
		
		tmp_incident_number := ut.rmv_ld_zeros(le.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(le.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		SELF.vl_id                    := std.str.CleanSpaces(trim(le.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);;
		SELF.vendor_id                := le.cust_name;
		SELF.source                   := MDR.sourceTools.src_Mari_Public_Sanc;
		SELF.source_group             := '';
		
		lTODAY := ((string)Std.Date.Today())[1..6];																								
    self.dt_first_seen            := ((unsigned3)lTODAY); 
    self.dt_last_seen             := ((unsigned3)lTODAY);
		SELF.dt_vendor_first_reported := 0;
		SELF.dt_vendor_last_reported  := 0;
		SELF.current                  := TRUE;
		//the existing data doesn't really support the normalize due to the invalid addresses for admin and tech
		//i just did this so you'd see the proper way of handling if good data was there	
		SELF.prim_range               := le.prim_range;
		SELF.predir                   := le.predir;
		SELF.prim_name                := le.prim_name;
		SELF.addr_suffix              := le.addr_suffix;
		SELF.postdir                  := le.postdir;
		SELF.unit_desig               := le.unit_desig;
		SELF.sec_range                := le.sec_range;
		SELF.city                     := le.v_city_name;
		SELF.state                    := le.st;
		SELF.zip                      := (unsigned3)le.zip5;
		SELF.zip4                     := (unsigned2)le.zip4;
		SELF.county                   := le.fips_county;
		SELF.msa                      := '';
		SELF.geo_lat                  := le.geo_lat;
		SELF.geo_long                 := le.geo_long;
		SELF.phone										:= 0;	
		SELF.fein 										:= (unsigned)le.link_fein;
  	SELF := le;
		SELF := [];
  END;

	
	sanctn_for_old_bh_filter := dedup(project(in_ds(prim_range<>'' and prim_name<>'' and zip5>''), xform1(left)),record);

  return sanctn_for_old_bh_filter;
	
end;

export old_business_header_public_sanctn_recs := map_to_old_business_header(files.base_party_ext(cname<>'' and bdid>0));


//YOU ONLY NEED THIS WHEN YOUR FILE HAS A PERSON ASSOCIATED TO A BUSINESS - THIS SENDS DATA INTO THE LEGACY BUSINESS CONTACTS
map_to_old_business_contacts(dataset(recordof(files.base_party_ext)) in_ds) := function  

  Business_Header.Layout_Business_Contact_Full_New xform2(in_ds le) := transform 
  //UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER
	  SELF.source               := MDR.sourceTools.src_Mari_Public_Sanc;
	  SELF.BDID                 := le.BDID;
	  SELF.DID                  := le.DID;
	  SELF.company_source_group := '';
	  SELF.company_name         := STD.Str.ToUpperCase(le.cname);
	  lTODAY := ((string)Std.Date.Today())[1..6];																								
    self.dt_first_seen        := ((unsigned3)lTODAY); 
    self.dt_last_seen         := ((unsigned3)lTODAY);
		
	  tmp_incident_number := ut.rmv_ld_zeros(le.INCIDENT_NUMBER);
		tmp_party_number 		:= ut.rmv_ld_zeros(le.PARTY_NUMBER);
		cln_party_number 		:= if(trim(tmp_party_number) = '0','',tmp_party_number);
		SELF.vl_id                := std.str.CleanSpaces(trim(le.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);;
	  SELF.vendor_id            := le.cust_name;
	  SELF.record_type          := 'C';		
		self.zip4									:= 0;
	  SELF.company_prim_range   := le.prim_range;
		SELF.company_predir       := le.predir;
		SELF.company_prim_name    := le.prim_name;
		SELF.company_addr_suffix  := le.addr_suffix;
		SELF.company_postdir      := le.postdir;
		SELF.company_unit_desig   := le.unit_desig;
		SELF.company_sec_range    := le.sec_range;
		SELF.company_city         := le.v_city_name;
		SELF.company_state        := le.st;
		SELF.company_zip          := (unsigned3)le.zip5;
		SELF.company_zip4         := (unsigned2)le.zip4;
		SELF.company_phone				:= 0;
		SELF.company_fein					:= (unsigned)le.link_fein;
	  SELF.fname                := le.fname;
	  SELF.mname                := le.mname;
	  SELF.lname                := le.lname;
	  SELF.name_suffix          := le.name_suffix; 
	  SELF := le;
    SELF := [];
	END;

	public_sanctn_for_old_bc_filter := project(in_ds(prim_range<>'' and prim_name<>'' and zip5>''), xform2(left));
	
  return public_sanctn_for_old_bc_filter;

end;

export old_business_contacts_public_sanctn_recs := map_to_old_business_contacts(files.base_party_ext(cname <>'' and bdid>0 and fname<>'' and lname<>'')); 

end;