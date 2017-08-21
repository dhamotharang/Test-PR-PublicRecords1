import YellowPages,MDR;

export YellowPages_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := YellowPages.Files().Base.QA;

  // Extract company_name/address/phone/url data for the linking layout.
  export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
		
		filtered := base(primary_key != '' and business_name != ''); // ???
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source          := MDR.sourceTools.src_Yellow_Pages,
				self.source_docid    := left.primary_key, // and/or phone10 or ???
				self.source_party    := '',
 				self.date_first_seen := (unsigned4) left.pub_date, // ???
				self.date_last_seen  := (unsigned4) left.pub_date, // ???
	      self.company_name    := stringlib.StringToUpperCase(left.business_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid             := 0,
				self.prim_range      := left.prim_range,
				self.predir          := left.predir,
				self.prim_name       := left.prim_name,
				self.addr_suffix     := left.suffix,
				self.postdir         := left.postdir,
				self.unit_desig      := left.unit_desig,
				self.sec_range       := left.sec_range,
				self.city_name       := choose(counter,left.p_city_name,left.v_city_name),
				self.state           := left.st,
				self.zip             := left.zip,
				self.zip4            := left.zip4,
				self.county_fips     := left.county,
				self.msa             := left.msa,
				self.phone           := left.phone10,
				// certain other fields set to null because they are not on the yellowpages base file
				self.fein            := '',
				self.url             := left.web_address, //??? not currently populated on yp base
				self.duns            := '',
				self.experian        := '',
				self.zoom := '',
				self.incorp_state    := '',
				self.incorp_number   := '',
		));
		
		return extract;
	
	end;

  // Extract sics/naics data for the Industry layout.
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	
		filtered := base(primary_key != '' and business_name != '' and 
		                 (sic_code != '' or naics_code !=''));

		extract := normalize(filtered,map(left.sic4 != '' => 4,
		                                  left.sic3 != '' => 3,
		                                  left.sic2 != '' => 2,
		                                                     1),
			transform(Layout_Industry.Unlinked,
				self.source               := MDR.sourceTools.src_Yellow_Pages,
				self.source_docid         := left.primary_key, // and/or phone10 or ???
				self.source_party         := '',
        self.SicCode              := choose(counter,left.sic_code,left.sic2,left.sic3,left.sic4),
		    self.NAICS                := if(counter=1,left.naics_code,''),
				self.industry_description := ''
      ));
		
		return extract;
	
	end;

  // Extract executive name/address/phone?/email? data for the Contacts layout.
  // NOTE: As of 02/15/11, the executive_name/exec_*name fields are currently not populated on yp base file
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function
	
		filtered := base(primary_key != '' and business_name != '' and  //???
                     executive_name != '');                         //??? 
                 // (lname != '' or exec_lname != ''));    //???
		
		extract := project(filtered,
			transform(Layout_Contacts.Unlinked,
				self.source          := MDR.sourceTools.src_Yellow_Pages,
				self.source_docid    := left.primary_key, // and/or phone10 or ???
				self.source_party    := '',
				self.date_first_seen := (unsigned4)left.pub_date,
				self.date_last_seen := (unsigned4)left.pub_date,
        self.ssn           := '',
				self.did           := 0,
				self.score         := 0,
				self.name_prefix   := left.exec_title,
				self.name_first    := left.exec_fname,
				self.name_middle   := left.exec_mname,
				self.name_last     := left.exec_lname,
				self.name_suffix   := left.exec_name_suffix,
				self.prim_range := '',
				self.predir := '',
				self.prim_name := '',
				self.addr_suffix := '',
				self.postdir := '',
				self.unit_desig := '',
				self.sec_range := '',
				self.city_name := '',
				self.state := '',
				self.zip := '',
				self.zip4 := '',
				self.position_title := stringlib.StringToUpperCase(left.executive_title),
				self.position_type := 'C';
 				self.phone         := left.phone10,  // don't use because this is the business phone#, not the person's phone# ???
		    self.email         := '', // left.email_address  the executive's email ???			
    ));
		
		return extract;
	
	end;

  // Extract executive url data for the URLs layout.
  // NOTE: As of 02/15/11, web_address is currently not populated on yp base file
	export dataset(Layout_URLs.Unlinked) As_URL_Master := function
	
		filtered := base(primary_key != '' and business_name != '' and web_address != ''); // ???

		extract := project(filtered,
			transform(Layout_URLs.Unlinked,
				self.source          := MDR.sourceTools.src_Yellow_Pages,
				self.source_docid    := left.primary_key, // and/or phone10 or ???
				self.source_party    := '',
				self.url             := left.web_address,
    ));

		return extract;
	
	end;

end;
