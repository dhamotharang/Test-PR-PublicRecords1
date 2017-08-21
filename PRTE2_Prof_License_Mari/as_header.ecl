// Added date logic in the first_seen, last_Seen & nonglb date fields below. This is for bug# 23340
import header,business_header,mdr,_Validate;

EXPORT as_header := module

//YOU ONLY NEED THIS WHEN YOUR FILE HAS CONSUMERS
  Header.Layout_New_Records map_to_person_header(files.base_search le) := transform
    self.src                      := MDR.sourceTools.src_Mari_Prof_Lic;
		self.vendor_id								:= '';
    self.dt_first_seen            := (unsigned3)le.date_first_seen[1..6]; 
    self.dt_last_seen             := (unsigned3)le.date_last_seen[1..6];
    self.dt_vendor_first_reported := 0;
    self.dt_vendor_last_reported  := 0;
		self.phone										:= le.phn_mari_1;
		self.ssn											:= if(le.ssn_taxid_1 = 'S',le.ssn_taxid_1,'');
		self.dob											:= (integer)le.birth_dte;
    self.did                      := le.did;
    self.title                    := le.title;
    self.fname                    := le.fname;
    self.mname                    := le.mname;
    self.lname                    := le.lname;
    self.name_suffix              := le.name_suffix;
    self.prim_range               := le.bus_prim_range;
    self.predir                   := le.bus_predir;
    self.prim_name                := le.bus_prim_name;
    self.suffix                   := le.bus_addr_suffix;
    self.postdir                  := le.bus_postdir;
    self.unit_desig               := le.bus_unit_desig;
    self.sec_range                := le.bus_sec_range;
    self.city_name                := le.bus_v_city_name;
    self.st                       := le.bus_state;
    self.zip                      := le.bus_zip5;
    self.zip4                     := le.bus_zip4;
    self.county                   := le.bus_county;
    self := le;
    self := [];
  end;

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_mari_recs := project(files.base_search(did>0),map_to_person_header(left));


//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE LEGACY BUSINESS HEADER
map_to_old_business_header(dataset(recordof(files.base_search)) in_ds) := function

	Business_Header.Layout_Business_Header_New xform1(in_ds le, integer c) := transform
		//UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER  
		SELF.BDID                     := le.BDID;	
		SELF.company_name             := Stringlib.StringToUpperCase(le.name_company);
		SELF.vl_id                    := '';
		SELF.vendor_id                := '';
		SELF.source                   := MDR.sourceTools.src_Mari_Prof_Lic;
		SELF.source_group             := '';
		SELF.dt_first_seen            := (UNSIGNED4)le.date_first_seen;
		SELF.dt_last_seen             := (UNSIGNED4)le.date_last_seen;
		SELF.dt_vendor_first_reported := 0;
		SELF.dt_vendor_last_reported  := 0;
		SELF.current                  := IF(le.result_cd_1='C', TRUE, FALSE);
		//the existing data doesn't really support the normalize due to the invalid addresses for admin and tech
		//i just did this so you'd see the proper way of handling if good data was there	
		SELF.prim_range               := CHOOSE(C, le.bus_prim_range,le.mail_prim_range);
		SELF.predir                   := CHOOSE(C, le.bus_predir,le.mail_predir);
		SELF.prim_name                := CHOOSE(C, le.bus_prim_name,le.mail_prim_name);
		SELF.addr_suffix              := CHOOSE(C, le.bus_addr_suffix, le.mail_addr_suffix);
		SELF.postdir                  := CHOOSE(C, le.bus_postdir, le.mail_postdir);
		SELF.unit_desig               := CHOOSE(C, le.bus_unit_desig,le.mail_unit_desig);
		SELF.sec_range                := CHOOSE(C, le.bus_sec_range,le.mail_sec_range);
		SELF.city                     := CHOOSE(C, le.bus_v_city_name,le.mail_v_city_name);
		SELF.state                    := CHOOSE(C, le.bus_state,le.mail_state);
		SELF.zip                      := CHOOSE(C, (unsigned3)le.bus_zip5,(UNSIGNED3)le.mail_zip5);
		SELF.zip4                     := CHOOSE(C, (unsigned2)le.bus_zip4,(UNSIGNED2)le.mail_zip4);
		SELF.county                   := CHOOSE(C, le.bus_county,le.mail_county);
		SELF.msa                      := CHOOSE(C, le.bus_msa,le.mail_msa);
		SELF.geo_lat                  := CHOOSE(C, le.bus_geo_lat,le.mail_geo_lat);
		SELF.geo_long                 := CHOOSE(C, le.bus_geo_long,le.mail_geo_long);
		SELF.phone										:= CHOOSE(C, (UNSIGNED)le.phn_mari_1, (UNSIGNED)le.phn_mari_2);	
		SELF.fein 										:= CHOOSE(C, if(le.tax_type_1 = 'E',(UNSIGNED)le.ssn_taxid_1,0),
																								if(le.tax_type_2 = 'E', (UNSIGNED)le.ssn_taxid_2,0));
  	SELF := le;
		SELF := [];
  END;

	mari_for_old_bh        := NORMALIZE(in_ds,2,xform1(LEFT,COUNTER));
	mari_for_old_bh_filter := mari_for_old_bh(prim_range<>'' and prim_name<>'' and zip>0);

  return mari_for_old_bh_filter;
	
end;

export old_business_header_mari_recs := map_to_old_business_header(files.base_search(name_company<>'' and bdid>0));

//YOU ONLY NEED THIS WHEN YOUR FILE HAS A PERSON ASSOCIATED TO A BUSINESS - THIS SENDS DATA INTO THE LEGACY BUSINESS CONTACTS
map_to_old_business_contacts(dataset(recordof(files.base_search)) in_ds) := function  

  Business_Header.Layout_Business_Contact_Full_New xform2(in_ds le, integer c) := transform 
  //UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER
	  SELF.source               := MDR.sourceTools.src_Mari_Prof_Lic;;
	  SELF.BDID                 := le.BDID;
	  SELF.DID                  := le.DID;
	  SELF.company_source_group := '';
	  SELF.company_name         := Stringlib.StringToUpperCase(le.name_company);
	  SELF.dt_first_seen        := (UNSIGNED4)le.date_first_seen;
	  SELF.dt_last_seen         := (UNSIGNED4)le.date_last_seen;
	  SELF.vl_id                := '';
	  SELF.vendor_id            := '';
	  SELF.record_type          := IF(le.result_cd_1 = 'C', 'C', 'H');		
	  SELF.prim_range           := CHOOSE(C, le.bus_prim_range,le.mail_prim_range);
		SELF.predir               := CHOOSE(C, le.bus_predir,le.mail_predir);
		SELF.prim_name            := CHOOSE(C, le.bus_prim_name,le.mail_prim_name);
		SELF.addr_suffix          := CHOOSE(C, le.bus_addr_suffix, le.mail_addr_suffix);
		SELF.postdir              := CHOOSE(C, le.bus_postdir, le.mail_postdir);
		SELF.unit_desig           := CHOOSE(C, le.bus_unit_desig,le.mail_unit_desig);
		SELF.sec_range            := CHOOSE(C, le.bus_sec_range,le.mail_sec_range);
		SELF.city                 := CHOOSE(C, le.bus_v_city_name,le.mail_v_city_name);
		SELF.state                := CHOOSE(C, le.bus_state,le.mail_state);
		SELF.zip                  := CHOOSE(C, (unsigned3)le.bus_zip5,(UNSIGNED3)le.mail_zip5);
		SELF.zip4                 := CHOOSE(C, (unsigned2)le.bus_zip4,(UNSIGNED2)le.mail_zip4);
		SELF.county               := CHOOSE(C, le.bus_county,le.mail_county);
		SELF.msa                  := CHOOSE(C, le.bus_msa,le.mail_msa);
		SELF.geo_lat              := CHOOSE(C, le.bus_geo_lat,le.mail_geo_lat);
		SELF.geo_long             := CHOOSE(C, le.bus_geo_long,le.mail_geo_long);
	  SELF.fname                := CHOOSE(C, le.fname,le.fname);
	  SELF.mname                := CHOOSE(C, le.mname,le.mname);
	  SELF.lname                := CHOOSE(C, le.lname,le.lname);
	  SELF.name_suffix          := CHOOSE(C, le.name_suffix,le.name_suffix); 
	  SELF := le;
    SELF := [];
	END;

	mari_for_old_bc        := NORMALIZE(in_ds,2,xform2(LEFT,COUNTER));
	mari_for_old_bc_filter := mari_for_old_bc(prim_range<>'' and prim_name<>'' and zip>0);
	
  return mari_for_old_bc_filter;

end;

export old_business_contacts_mari_recs := map_to_old_business_contacts(files.base_search(name_company<>'' and bdid>0 and fname<>'' and lname<>'')); 

//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE NEW BUSINESS HEADER
//IN THE NEW HEADER BUSINESSES AND CONTACTS ARE IN THE SAME FILE SO IN THIS MAPPING YOU INCLUDE BOTH OF THEM
map_to_new_business_header(dataset(recordof(files.base_search)) in_ds) := function

  Business_Header.Layout_Business_Linking.Linking_Interface xform3(in_ds le, integer c) := transform
	  SELF.source 					              := MDR.sourceTools.src_Mari_Prof_Lic;
		SELF.dt_first_seen 				          := IF(_Validate.Date.fIsValid(le.date_first_seen),(unsigned4)le.date_first_seen,0);
		SELF.dt_last_seen 				          := IF(_Validate.Date.fIsValid(le.date_last_seen),(unsigned4)le.date_last_seen,0);
		SELF.company_bdid 						      := (INTEGER)le.bdid;
		SELF.contact_did                    := le.did;
		SELF.company_name 			      	    := Stringlib.StringToUpperCase(le.name_company);
	  SELF.vl_id 			            		    := '';	
		SELF.current                     		:= IF(le.result_cd_1='C', TRUE, FALSE);		
		SELF.company_address.prim_range    	:= CHOOSE(C, le.bus_prim_range,le.mail_prim_range);
		SELF.company_address.predir        	:= CHOOSE(C, le.bus_predir,le.mail_predir);
		SELF.company_address.prim_name     	:= CHOOSE(C, le.bus_prim_name,le.mail_prim_name);
		SELF.company_address.addr_suffix   	:= CHOOSE(C, le.bus_addr_suffix, le.mail_addr_suffix);
		SELF.company_address.postdir       	:= CHOOSE(C, le.bus_postdir, le.mail_postdir);
		SELF.company_address.unit_desig    	:= CHOOSE(C, le.bus_unit_desig,le.mail_unit_desig);
		SELF.company_address.sec_range     	:= CHOOSE(C, le.bus_sec_range,le.mail_sec_range);
		SELF.company_address.p_city_name    := CHOOSE(C, le.bus_p_city_name,le.mail_p_city_name);
		SELF.company_address.v_city_name    := CHOOSE(C, le.bus_v_city_name,le.mail_v_city_name);
		SELF.company_address.st         		:= CHOOSE(C, le.bus_state,le.mail_state);
		SELF.company_address.zip           	:= CHOOSE(C, le.bus_zip5,le.mail_zip5);
		SELF.company_address.zip4          	:= CHOOSE(C, le.bus_zip4,le.mail_zip4);
	  SELF.company_address.cart           := CHOOSE(C, le.bus_cart,le.mail_cart);
	  SELF.company_address.cr_sort_sz     := CHOOSE(C, le.bus_cr_sort_sz,le.mail_cr_sort_sz);
	  SELF.company_address.lot            := CHOOSE(C, le.bus_lot,le.mail_lot);
	  SELF.company_address.lot_order      := CHOOSE(C, le.bus_lot_order,le.mail_lot_order);
	  SELF.company_address.dbpc           := CHOOSE(C, le.bus_dpbc,le.mail_dpbc);
	  SELF.company_address.chk_digit      := CHOOSE(C, le.bus_chk_digit,le.mail_chk_digit);
	  SELF.company_address.fips_state     := CHOOSE(C, le.bus_ace_fips_st,le.mail_ace_fips_st);
		SELF.company_address.fips_county   	:= CHOOSE(C, le.bus_county,le.mail_county);
	  SELF.company_address.geo_lat       	:= CHOOSE(C, le.bus_geo_lat,le.mail_geo_lat);
	  SELF.company_address.geo_long       := CHOOSE(C, le.bus_geo_long,le.mail_geo_long);
		SELF.company_address.msa           	:= CHOOSE(C, le.bus_msa,le.mail_msa);
		SELF.company_address.geo_blk        := CHOOSE(C, le.bus_geo_blk,le.mail_geo_blk);
	  SELF.company_address.geo_match      := CHOOSE(C, le.bus_geo_match,le.mail_geo_match);
	  SELF.company_address.err_stat       := CHOOSE(C, le.bus_err_stat,le.mail_err_stat);
		SELF.contact_name.title             := CHOOSE(C, le.title,le.title); 	
		SELF.contact_name.fname             := CHOOSE(C, le.fname,le.fname); 		
		SELF.contact_name.mname             := CHOOSE(C, le.mname,le.mname); 		
		SELF.contact_name.lname             := CHOOSE(C, le.lname,le.lname); 		
		SELF.contact_name.name_suffix       := CHOOSE(C, le.name_suffix,le.name_suffix); 		
		SELF.company_fein 									:= CHOOSE(C, if(le.ssn_taxid_1 = 'E',le.ssn_taxid_1,''),
																								if(le.ssn_taxid_2 = 'E', le.ssn_taxid_2,''));
		SELF.company_phone									:= CHOOSE(C, le.phn_mari_1, le.phn_mari_2);	
		SELF.phone_type											:= CHOOSE(C, 'T','T');			 // 'F' - fax; 'T' - Telephone
		SELF.company_url										:= CHOOSE(C, le.url, le.url);
		SELF.company_charter_number					:= CHOOSE(C, le.charter, le.charter);
		SELF 																:= le;
		SELF 																:= [];
	END;

  mari_for_new_bh        := normalize(in_ds,2,xform3(left,counter));
	mari_for_new_bh_filter := mari_for_new_bh(company_address.prim_range<>'' and company_address.prim_name<>'' and company_address.zip<>'');
	
  return mari_for_new_bh_filter;

end;

export new_business_header_mari_recs := map_to_new_business_header(files.base_search(name_company<>'' and bdid>0)); 

end;

 
