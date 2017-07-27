import FAA, codes, iesp, MDR;

export FAA_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := faa.file_aircraft_registration_in;
		
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(compname != '');
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Aircrafts,
				self.source_docid := trim(left.serial_number,left,right) + '//' + trim(left.n_number,left,right) + '//' + if(left.cert_issue_date != '',trim(left.cert_issue_date,left,right),trim(left.last_action_date,left,right)),
				self.source_party := 'REGISTRANT';
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen := (unsigned4)left.date_last_seen,
				self.company_name := left.compname,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.addr_suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := choose(counter,
					left.p_city_name,
					left.v_city_name),
				self.state := left.st,
				self.zip := left.zip,
				self.zip4 := left.z4,
				self.county_fips := left.county,
				self.msa := left.msa,
				self.phone := '',
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_Aircraft.Main.Unlinked) As_Aircraft_Master := function
	  
			extract_tmp:=  project(base,
			  transform({Layout_Aircraft.Main.Unlinked; string12 mfr_mdl_code;},
					self.source := MDR.sourceTools.src_Aircrafts,
					self.source_docid := trim(left.serial_number,left,right) + '//' + trim(left.n_number,left,right) + '//' + if(left.cert_issue_date != '',trim(left.cert_issue_date,left,right),trim(left.last_action_date,left,right)),
					self.Aircraft_number  := left.n_number;
					self.serial_number := left.serial_number;
					self.current_prior_flag  :=	left.current_flag; 
									// either A - active H - historical for faa source			
          self.date_last_seen := left.date_last_seen;
					          // more populated than cert_issue_date and varies more
		                // than last_action_date
          
				  self.model_year := left.year_mfr;  // string8 	year_mfr;
					self.model := left.model_name;
					self.manufacturer := left.aircraft_mfr_name;																
          self.Aircraft_Type := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(left.type_aircraft),																    														
          self.engines := 0; 					             																											
					 self.registration_date    := left.cert_issue_date; // not populated a lot
					 self.registration_number  := left.n_number;
					 self.registration_address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir,
						 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
						 left.st, left.zip, 
							'', //left.zip4
							'', //left.countyname, 
						 '', //left.postalcode = '',
						 '', //left.addr1 = '',
						 '', //left.addr2 = '',
						 '' //left.stcityzip = ''
						 );
          self.mfr_mdl_code := left.mfr_mdl_code; // needed for key lookup for getting # of engines						 
					self := left;
					self := [];
			  ));
				
				 TopBusiness.Layout_Aircraft.Main.Unlinked xform({TopBusiness.Layout_Aircraft.Main.Unlinked, string12 mfr_mdl_code}  l,
						                                           recordof(faa.key_aircraft_info) r) := transform
           self.engines := (integer) r.number_of_engines;
				   self := l;
         end;																											 
				 
				 extract := join(extract_tmp, faa.key_aircraft_info(),
				                           left.mfr_mdl_code = right.code,
																	 xform(left,right));
				
      return extract;						       						
	end;
	
	export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party := function
	  
		extract := project(base,
			transform(Layout_Aircraft.Party,
				self.aircraft_number := left.n_number,
				self.serial_number := left.serial_number,				
				self.registration_date := left.cert_issue_date,
				self.current_prior_flag := left.current_flag,
				self.date_last_seen := left.date_last_seen;
									// more populated than cert_issue_date and varies more
									// than last_action_date
				self.company_name := left.compname,
				self.name_last := left.lname,
				self.name_first := left.fname,
				self.name_middle := left.mname,
				self.name_suffix := left.name_suffix,
				self.name_title := left.title,						
				self.address := iesp.ECL2ESP.SetAddress(
					left.prim_name,left.prim_range,left.predir,left.postdir,
					left.addr_suffix,left.unit_desig,left.sec_range,left.v_city_name,
					left.st,left.zip,left.z4,'','','','','')));
				
		return dedup(extract,all);					       						
		
	end;
end;	