import header,business_header,mdr,_Validate, Domains;

EXPORT as_headers := module

//YOU ONLY NEED THIS WHEN YOUR FILE HAS CONSUMERS
  Header.Layout_New_Records map_to_person_header(files.file_whois_base le) := transform
    self.src                      := MDR.sourceTools.src_Whois_domains;
    
		self.dt_first_seen            := (integer)(le.date_first_seen[1..6]); 
		self.dt_last_seen             := (integer)(le.date_last_seen[1..6]);
    self.dt_vendor_first_reported := 0;
    self.dt_vendor_last_reported  := 0;
    self.did                      := le.did;
    self.title                    := le.title;
    self.fname                    := le.fname;
    self.mname                    := le.mname;
    self.lname                    := le.lname;
    self.name_suffix              := le.name_suffix;
    self.prim_range               := le.prim_range;
    self.predir                   := le.predir;
    self.prim_name                := le.prim_name;
    self.suffix                   := le.suffix;
    self.postdir                  := le.postdir;
    self.unit_desig               := le.unit_desig;
    self.sec_range                := le.sec_range;
    self.city_name                := le.v_city_name;
    self.st                       := le.state;
    self.zip                      := le.zip;
    self.zip4                     := le.zip4;
    self.county                   := le.county[3..5];
    self := le;
    self := [];
  end;

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_domain_recs := project(files.file_whois_base(did>0),map_to_person_header(left));


//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE LEGACY BUSINESS HEADER
map_to_old_business_header(dataset(recordof(files.file_whois_base)) in_ds) := function

	Business_Header.Layout_Business_Header_New xform1(in_ds le, integer c) := transform
		//UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER  
		SELF.BDID                     := le.BDID;	
		SELF.company_name             := Stringlib.StringToUpperCase(le.registrant_name);
		SELF.vl_id                    := le.domain_name;
		SELF.vendor_id                := le.domain_name;
		SELF.source                   := MDR.sourceTools.src_Whois_domains;
		SELF.source_group             := le.domain_name;
		SELF.dt_first_seen            := (UNSIGNED4)le.date_first_seen;
		SELF.dt_last_seen             := (UNSIGNED4)le.date_last_seen;
		SELF.dt_vendor_first_reported := 0;
		SELF.dt_vendor_last_reported  := 0;
		SELF.current                  := IF(le.current_flag='Y', TRUE, FALSE);
		//the existing data doesn't really support the normalize due to the invalid addresses for admin and tech
		//i just did this so you'd see the proper way of handling if good data was there	
		SELF.prim_range               := CHOOSE(C, le.prim_range,le.admin_prim_range, le.tech_prim_range);
		SELF.predir                   := CHOOSE(C, le.predir,le.admin_predir, le.tech_predir);
		SELF.prim_name                := CHOOSE(C, le.prim_name,le.admin_prim_name, le.tech_prim_name);
		SELF.addr_suffix              := CHOOSE(C, le.suffix, le.admin_suffix, le.tech_suffix);
		SELF.postdir                  := CHOOSE(C, le.postdir, le.admin_postdir, le.tech_postdir);
		SELF.unit_desig               := CHOOSE(C, le.unit_desig,le.admin_unit_desig, le.tech_unit_desig);
		SELF.sec_range                := CHOOSE(C, le.sec_range,le.admin_sec_range, le.tech_sec_range);
		SELF.city                     := CHOOSE(C, le.v_city_name,le.admin_v_city_name, le.tech_v_city_name);
		SELF.state                    := CHOOSE(C, le.state,le.admin_state, le.tech_state);
		SELF.zip                      := CHOOSE(C, (unsigned3)le.zip,(UNSIGNED3)le.admin_zip, (UNSIGNED3)le.tech_zip);
		SELF.zip4                     := CHOOSE(C, (unsigned2)le.zip4,(UNSIGNED2)le.admin_zip4, (UNSIGNED2)le.tech_zip4);
		SELF.county                   := CHOOSE(C, le.county[3..5],le.admin_county[3..5], le.tech_county[3..5]);
		SELF.msa                      := CHOOSE(C, le.msa,le.admin_msa, le.tech_msa);
		SELF.geo_lat                  := CHOOSE(C, le.geo_lat,le.admin_geo_lat, le.tech_geo_lat);
		SELF.geo_long                 := CHOOSE(C, le.geo_long,le.admin_geo_long, le.tech_geo_long);
    
		SELF := le;
		SELF := [];
  END;

	domains_for_old_bh        := NORMALIZE(in_ds,3,xform1(LEFT,COUNTER));
	domains_for_old_bh_filter := domains_for_old_bh(prim_range<>'' and prim_name<>'' and zip>0);

  return dedup(sort(domains_for_old_bh_filter,bdid,company_name,prim_name,city,state,zip),all);
	
end;

export old_business_header_domain_recs := map_to_old_business_header(files.file_whois_base(registrant_name<>'' and bdid>0));

//YOU ONLY NEED THIS WHEN YOUR FILE HAS A PERSON ASSOCIATED TO A BUSINESS - THIS SENDS DATA INTO THE LEGACY BUSINESS CONTACTS
map_to_old_business_contacts(dataset(recordof(files.file_whois_base)) in_ds) := function  

  Business_Header.Layout_Business_Contact_Full_New xform2(in_ds le, integer c) := transform 
  //UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER
	  SELF.source               := MDR.sourceTools.src_Whois_domains;
	  SELF.BDID                 := le.BDID;
	  SELF.DID                  := le.DID;
	  SELF.company_source_group := le.domain_name;
	  SELF.company_name         := Stringlib.StringToUpperCase(le.registrant_name);
	  SELF.dt_first_seen        := (UNSIGNED4)le.date_first_seen;
	  SELF.dt_last_seen         := (UNSIGNED4)le.date_last_seen;
	  SELF.vl_id                := le.domain_name;
	  SELF.vendor_id            := le.domain_name;
	  SELF.record_type          := IF(le.current_flag='Y', 'C', 'H');		
	  SELF.prim_range           := CHOOSE(C, le.prim_range,le.admin_prim_range, le.tech_prim_range);
	  SELF.predir               := CHOOSE(C, le.predir,le.admin_predir, le.tech_predir);
	  SELF.prim_name            := CHOOSE(C, le.prim_name,le.admin_prim_name, le.tech_prim_name);
	  SELF.addr_suffix          := CHOOSE(C, le.suffix, le.admin_suffix, le.tech_suffix);
	  SELF.postdir              := CHOOSE(C, le.postdir, le.admin_postdir, le.tech_postdir);
	  SELF.unit_desig           := CHOOSE(C, le.unit_desig,le.admin_unit_desig, le.tech_unit_desig);
	  SELF.sec_range            := CHOOSE(C, le.sec_range,le.admin_sec_range, le.tech_sec_range);
	  SELF.city                 := CHOOSE(C, le.v_city_name,le.admin_v_city_name, le.tech_v_city_name);
	  SELF.state                := CHOOSE(C, le.state,le.admin_state, le.tech_state);
	  SELF.zip                  := CHOOSE(C, (unsigned3)le.zip,(UNSIGNED3)le.admin_zip, (UNSIGNED3)le.tech_zip);
	  SELF.zip4                 := CHOOSE(C, (unsigned2)le.zip4,(UNSIGNED2)le.admin_zip4, (UNSIGNED2)le.tech_zip4);
	  SELF.county               := CHOOSE(C, le.county[3..5],le.admin_county[3..5], le.tech_county[3..5]);
	  SELF.msa                  := CHOOSE(C, le.msa,le.admin_msa, le.tech_msa);
	  SELF.geo_lat              := CHOOSE(C, le.geo_lat,le.admin_geo_lat, le.tech_geo_lat);
	  SELF.geo_long             := CHOOSE(C, le.geo_long,le.admin_geo_long, le.tech_geo_long);
	  SELF.fname                := CHOOSE(C, le.fname      ,le.fname      ,le.fname);
	  SELF.mname                := CHOOSE(C, le.mname      ,le.mname      ,le.mname);
	  SELF.lname                := CHOOSE(C, le.lname      ,le.lname      ,le.lname);
	  SELF.name_suffix          := CHOOSE(C, le.name_suffix,le.name_suffix,le.name_suffix);
	  SELF.name_score           := CHOOSE(C, le.name_score ,le.name_score ,le.name_score);
	  SELF := le;
    SELF := [];
	END;

	domains_for_old_bc        := NORMALIZE(in_ds,3,xform2(LEFT,COUNTER));
	domains_for_old_bc_filter := domains_for_old_bc(prim_range<>'' and prim_name<>'' and zip>0);

  return dedup(sort(domains_for_old_bc_filter,bdid,company_name,prim_name,city,state,zip),all);

end;

export old_business_contacts_domain_recs := map_to_old_business_contacts(files.file_whois_base(registrant_name<>'' and bdid>0 and fname<>'' and lname<>'')); 

EXPORT new_business_header := Domains.fWhois_As_Business_Header(files.file_whois_base(bdid>0)); 

//future use when prte2_business_header file becomes available
//EXPORT new_business_contact := Domains.fWhois_As_Business_Contact(files.file_whois_base,true); 

end;
