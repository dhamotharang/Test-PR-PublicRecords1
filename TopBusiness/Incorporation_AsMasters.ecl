import Corp2,MDR,VersionControl;

export Incorporation_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := corp2.files(,,VersionControl._Flags.IsDataland).aid.corp.qa;
		
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(corp_process_date != '' and corp_orig_sos_charter_nbr != '' and
		                  corp_legal_name != '' and not ((corp_ln_name_type_cd = '03' OR corp_ln_name_type_cd = '04')
		                  and (corp_ln_name_type_desc = 'TRADEMARK'
													OR corp_ln_name_type_desc = 'TRADESTYLE'
													OR corp_ln_name_type_desc = 'BRANDNAME' 
													OR corp_ln_name_type_desc = 'SLOGAN'
													OR corp_ln_name_type_desc = 'TRADENAME'													
													) 
										 ));
											// may be other rows having  corp_ln_name_type_desc
											// other than "LEGAL" which we may want to include ???
									  		
		 extract := normalize(filtered,if(left.corp_addr1_v_city_name != left.corp_addr1_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,			 
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
				self.source_party    := 'CORP',
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen  := left.dt_last_seen,
				self.company_name    := stringlib.StringToUpperCase(left.corp_legal_name),
				self.company_name_type := if(left.corp_ln_name_type_desc = 'LEGAL',Constants.Company_Name_Types.LEGAL,Constants.Company_Name_Types.UNKNOWN),
				self.address_type := map(
					left.corp_address1_type_desc = 'BUSINESS' => Constants.Address_Types.BUSINESS,
					left.corp_address1_type_desc = 'MAILING' => Constants.Address_Types.MAILING,
					Constants.Address_Types.UNKNOWN),
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid             := left.append_addr1_rawaid,
				self.prim_range      := left.corp_addr1_prim_range,
				self.predir          := left.corp_addr1_predir,
				self.prim_name       := left.corp_addr1_prim_name,
				self.addr_suffix     := left.corp_addr1_addr_suffix,
				self.postdir         := left.corp_addr1_postdir,
				self.unit_desig      := left.corp_addr1_unit_desig,
				self.sec_range       := left.corp_addr1_sec_range,
				self.city_name       := choose(counter,
					left.corp_addr1_p_city_name,
					left.corp_addr1_v_city_name),
				self.state           := left.corp_addr1_state,
				self.zip             := left.corp_addr1_zip5,
				self.zip4            := left.corp_addr1_zip4,
				self.county_fips     := left.corp_addr1_county,
				self.msa             := left.corp_addr1_msa,
				self.phone           := left.corp_phone10,
				self.fein            :=  ''; 
				self.url             := left.corp_web_address,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.corp_state_origin,
				self.incorp_number := left.corp_orig_sos_charter_nbr;
				));
											
		 extract_2 := normalize(filtered(corp_addr2_prim_name != ''),if(left.corp_addr2_v_city_name != left.corp_addr2_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,			 
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
				self.source_party    := 'CORP',
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen  := left.dt_last_seen,
				self.company_name    := stringlib.StringToUpperCase(left.corp_legal_name),
				self.company_name_type := if(left.corp_ln_name_type_desc = 'LEGAL',Constants.Company_Name_Types.LEGAL,Constants.Company_Name_Types.UNKNOWN),
				self.address_type := map(
					left.corp_address2_type_desc = 'BUSINESS' => Constants.Address_Types.BUSINESS,
					left.corp_address2_type_desc = 'MAILING' => Constants.Address_Types.MAILING,
					Constants.Address_Types.UNKNOWN),
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid             := left.append_addr2_rawaid,
				self.prim_range      := left.corp_addr2_prim_range,
				self.predir          := left.corp_addr2_predir,
				self.prim_name       := left.corp_addr2_prim_name,
				self.addr_suffix     := left.corp_addr2_addr_suffix,
				self.postdir         := left.corp_addr2_postdir,
				self.unit_desig      := left.corp_addr2_unit_desig,
				self.sec_range       := left.corp_addr2_sec_range,
				self.city_name       := choose(counter,
					left.corp_addr2_p_city_name,
					left.corp_addr2_v_city_name),
				self.state           := left.corp_addr2_state,
				self.zip             := left.corp_addr2_zip5,
				self.zip4            := left.corp_addr2_zip4,
				self.county_fips     := left.corp_addr2_county,
				self.msa             := left.corp_addr2_msa,
				self.phone           := left.corp_phone10,
				self.fein            :=  ''; 
				self.url             := left.corp_web_address,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.corp_state_origin,
				self.incorp_number := left.corp_orig_sos_charter_nbr;
				));
											
		 extract_corp_raaddr := normalize(filtered(corp_addr1_prim_name = '' and corp_addr1_zip5 = ''),if(left.corp_addr1_v_city_name != left.corp_addr1_p_city_name,2,1),
			transform(Layout_Linking.Unlinked,			 
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
				self.source_party    := 'CORP',
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen  := left.dt_last_seen,
				self.company_name    := stringlib.StringToUpperCase(left.corp_legal_name),
				self.company_name_type := Constants.Company_Name_Types.LEGAL,
				self.address_type := Constants.Address_Types.REGAGENT,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid             := left.append_ra_rawaid;
				self.prim_range      := left.corp_ra_prim_range;
				self.predir          := left.corp_ra_predir;
				self.prim_name       := left.corp_ra_prim_name;
				self.addr_suffix     := left.corp_ra_addr_suffix;
				self.postdir         := left.corp_ra_postdir;
				self.unit_desig      := left.corp_ra_unit_desig;
				self.sec_range       := left.corp_ra_sec_range;
				self.city_name       := choose(counter,
					left.corp_ra_p_city_name,
					left.corp_ra_v_city_name),
				self.state           := left.corp_ra_state;
				self.zip             := left.corp_ra_zip5;
				self.zip4            := left.corp_ra_zip4;
				self.county_fips     := left.corp_ra_county;
				self.msa             := left.corp_ra_msa;
				self.phone           := left.corp_phone10,
				self.fein            :=  ''; 
				self.url             := left.corp_web_address,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := left.corp_state_origin,
				self.incorp_number := left.corp_orig_sos_charter_nbr;
				));
											
			extract_ra := normalize(filtered(corp_ra_cname1 != ''),
			  if(left.corp_ra_v_city_name != left.corp_ra_p_city_name,2,1),
			  transform(layout_linking.unlinked,
					self.source := MDR.sourceTools.fCorpV2(left.corp_key),
					self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
					self.source_party    := 'RA' + hash32(left.corp_ra_cname1),
					self.date_first_seen := left.dt_first_seen,
					self.date_last_seen  := left.dt_last_seen,
					self.company_name    := left.corp_ra_cname1;
					self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
					self.address_type := Constants.Address_Types.UNKNOWN,
					self.phone_type := Constants.Phone_Types.UNKNOWN,
					self.aid             := left.append_ra_rawaid;
					self.prim_range      := left.corp_ra_prim_range;
					self.predir          := left.corp_ra_predir;
					self.prim_name       := left.corp_ra_prim_name;
					self.addr_suffix     := left.corp_ra_addr_suffix;
					self.postdir         := left.corp_ra_postdir;
					self.unit_desig      := left.corp_ra_unit_desig;
					self.sec_range       := left.corp_ra_sec_range;
					self.city_name       := choose(counter,
						left.corp_ra_p_city_name,
						left.corp_ra_v_city_name),
					self.state           := left.corp_ra_state;
					self.zip             := left.corp_ra_zip5;
					self.zip4            := left.corp_ra_zip4;
					self.county_fips     := left.corp_ra_county;
					self.msa             := left.corp_ra_msa;
					self.phone           := left.corp_ra_phone_number;
					self.fein            := left.corp_ra_fein;
					self.url             := left.corp_ra_web_address;
					self.duns          := '';
					self.experian      := '';
					self.zoom := '',
					self.incorp_state  := '';
					self.incorp_number := '';
					));					
		return dedup(dedup(extract + extract_2 + extract_corp_raaddr + extract_ra,record,all,local),record,all);
	end;
		
	export dataset(Layout_Incorporation.Unlinked) As_Incorporation_Master := function

		filtered := base;  // only current corp recs are needed ???

		extract_base := project(filtered,
		  transform(Layout_Incorporation.Unlinked,
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
				//                       ^--- is this unique enough???
				self.source_party := 'CORP',
		    self.corp_state_origin         := left.corp_state_origin;
        self.corp_legal_name           := left.corp_legal_name;
				self.corp_orig_sos_charter_nbr := left.corp_orig_sos_charter_nbr; 
        self.corp_orig_bus_type_desc   := left.corp_orig_bus_type_desc;
				// Fill in the latest_filing_date from the most recent event_filing_date 
				// for the corp_key (done below) or if none exists, 
				// use corp_filing_date (if popoulated) OR corp_inc_date.  ???
        self.latest_filing_date        := if(left.corp_filing_date !='',
																				     left.corp_filing_date,
																						 left.corp_inc_date);
			  self.corp_status_desc          := left.corp_status_desc;
				self.corp_status_date          := if(left.corp_status_date = '' OR 
				                                     left.corp_status_date = '0',
																						 '',left.corp_status_date);
		    self.corp_foreign_domestic_ind := left.corp_foreign_domestic_ind;
		    self.corp_for_profit_ind       := left.corp_for_profit_ind;
				//self.filing_type := left.corp_filing_desc; //???
				// v--- ???
				self.corp_term_exist_exp       := map(left.corp_term_exist_exp[2] != '' => left.corp_term_exist_exp, // 4/6/8 digit dates
				                                      left.corp_term_exist_exp[1] = 'P' => 'Perpetual', // convert P to Perpetual
																						  // other 1 char codes: (N = Number of Years?) => ???
																						  /* otherwise, default to blank */       '');
        self.start_date                := left.corp_inc_date; // ???
				self.dt_vendor_last_reported   := (string) left.dt_vendor_last_reported; // is this needed ???
        self.corp_key                  := left.corp_key; // needed for linking ???		    
        self.record_type               := left.record_type; // needed for linking ???		    
				self.event_filing_date         := ''; // will be filled in below
		    self.event_filing_desc         := ''; // will be filled in below
				self.corp_structure            := left.corp_orig_org_structure_desc;
				self.corp_foreign_state        := left.corp_forgn_state_cd;
			));
			
		// Get the last 2 years of corp filing event(history) info (date & description) 
		// from the base corp2 events file by filtering & denormalizing.
    event_base := corp2.files(,,VersionControl._Flags.IsDataland).base.events.qa;

    // Get the current/run date
    integer4 run_yyyymmdd := (integer4) StringLib.GetDateYYYYMMDD();
    // Subtract 2 years from the current/run date
    string8 two_years_back_date := (string)(run_yyyymmdd - 00020000);

		event_filtered := event_base(event_filing_date >= two_years_back_date); //???
		
    extract_denormed := denormalize(extract_base,event_filtered,
		                                  left.corp_key = right.corp_key and
																			left.record_type = right.record_type,
																		transform(Layout_Incorporation.Unlinked,
																		  // 3 fields from the event (right) file
																		  self.latest_filing_date := if(right.event_filing_date !='',
																			                              right.event_filing_date,
																																	  left.latest_filing_date); 
																		  self.event_filing_date  := right.event_filing_date;
		                                  self.event_filing_desc  := right.event_filing_desc;
																			// all others fields from extract (left) file
																			self := left));

		//return extract;		// version 1
		 return extract_denormed; // version 2 ???
		
	end;
	
	export dataset(Layout_Contacts.Unlinked) As_Contact_Master := function	
	
	  filtered_ra := base(corp_ra_lname1  != '');	 
	  corp_extract_ra := project(filtered_ra,
		  transform(Layout_contacts.Unlinked,		
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
				self.source_party  := 'CORP',
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen := left.dt_last_seen,
				self.name_prefix   := left.corp_ra_title1;
		    self.name_first    := left.corp_ra_fname1;
		    self.name_middle   := left.corp_ra_mname1;
		    self.name_last     := left.corp_ra_lname1;
		    self.name_suffix   := left.corp_ra_name_suffix1;
				self.prim_range := left.corp_ra_prim_range,
				self.predir := left.corp_ra_predir,
				self.prim_name := left.corp_ra_prim_name,
				self.addr_suffix := left.corp_ra_addr_suffix,
				self.postdir := left.corp_ra_postdir,
				self.unit_desig := left.corp_ra_unit_desig,
				self.sec_range := left.corp_ra_sec_range,
				self.city_name := left.corp_ra_v_city_name,
				self.state := left.corp_ra_state,
				self.zip := left.corp_ra_zip5,
				self.zip4 := left.corp_ra_zip4,
		    self.position_title := left.corp_ra_title_desc; // this is not right so commenting out stringlib.StringToUpperCase(left.corp_legal_name);
				self.email         := left.corp_email_address;
				self.ssn           := '';
				self.did           := 0,
				self.score         := 0,
				self.phone         := left.corp_ra_phone10;
				self.position_type := 'R';					    
			));			
			
			contacts_base := corp2.files(,,VersionControl._Flags.IsDataland).base.cont.qa; // need to call macro somehow here ???
			filtered := contacts_base(cont_lname  != '');
			contacts_extract := project(filtered,
			  transform(Layout_contacts.Unlinked,
					self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				  // how to differentiate this from previous section
					self.source_docid  := trim(left.corp_key) + '//' + left.corp_process_date,
					self.source_party  := 'CORP',
					self.date_first_seen := left.dt_first_seen,
					self.date_last_seen := left.dt_last_seen,
				  self.name_prefix   := left.cont_title;
				  self.name_first    := left.cont_fname;
				  self.name_middle   := left.cont_mname;
				  self.name_last     := left.cont_lname;
				  self.name_suffix   := left.cont_name_suffix;
					self.prim_range := left.cont_prim_range,
					self.predir := left.cont_predir,
					self.prim_name := left.cont_prim_name,
					self.addr_suffix := left.cont_addr_suffix,
					self.postdir := left.cont_postdir,
					self.unit_desig := left.cont_unit_desig,
					self.sec_range := left.cont_sec_range,
					self.city_name := left.cont_v_city_name,
					self.state := left.cont_state,
					self.zip := left.cont_zip5,
					self.zip4 := left.cont_zip4,
				  self.position_title := stringlib.StringToUpperCase(left.cont_title_desc);
					self.position_type := 'C';		
				  self.email         := left.cont_email_address;
					self.ssn           := '';
					self.did           := left.did,
					self.score         := 0,
					self.phone         := '';					
			  ));
		return corp_extract_ra + contacts_extract;
	end;
	
		export dataset(Layout_Mark.Unlinked) As_Mark_Master := function
		
		filtered := base((corp_ln_name_type_cd = '03' OR corp_ln_name_type_cd = '04')
		                  and (corp_ln_name_type_desc = 'TRADEMARK'
													OR corp_ln_name_type_desc = 'TRADESTYLE'
													OR corp_ln_name_type_desc = 'BRANDNAME' 
													OR corp_ln_name_type_desc = 'SLOGAN'
													OR corp_ln_name_type_desc = 'TRADENAME'													
													) 
										 );
		extract := project(filtered,
		  transform(Layout_Mark.Unlinked,			
					self.source := MDR.sourceTools.fCorpV2(left.corp_key),
					self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
					self.source_party    := 'CORP',
					self.date_first_seen := left.dt_first_seen;
					self.date_last_seen  := left.dt_last_seen;					
					self.mark_type := Map(left.corp_ln_name_type_desc =  'TRADEMARK' => 'TM',
                                left.corp_ln_name_type_desc =  'TRADESTYLE' => 'TS',
																left.corp_ln_name_type_desc =  'BRANDNAME' => 'BN',
																left.corp_ln_name_type_desc =  'SLOGAN' => 'SL',		
																left.corp_ln_name_type_desc =  'TRADENAME' => 'TN',
																''); 
					self.mark_description := stringlib.StringToUpperCase(left.corp_legal_name);
					));
		
			return extract;		
		end;
	
	export dataset(Layout_URLs.Unlinked) As_URL_Master := function
	
		filtered := base(corp_web_address != '');
		extract := project(filtered,
		           transform(Layout_URLs.Unlinked,
								 self.source := MDR.sourceTools.fCorpV2(left.corp_key),
								 self.source_docid    := trim(left.corp_key) + '//' + left.corp_process_date,
								 self.source_party := 'CORP',
							   self.url          := left.corp_web_address;
								 ));
	  return extract;	
		end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	  filtered := base(corp_sic_code != '' OR corp_naic_code != '');
		extract := project(filtered,
		           transform(Layout_Industry.Unlinked,
								 self.source       := MDR.sourceTools.fCorpV2(left.corp_key),
								 self.source_docid := trim(left.corp_key) + '//' + left.corp_process_date,
								 self.source_party := 'CORP',
								 self.SicCode      := left.corp_sic_code;
								 self.NAICS        := left.corp_naic_code;
			           // Even though the field used below is labeled as "...bus_type_desc", 
								 // the field has industry type info in it instead of an actual description
								 // of the company/business.
			           // So it was decided to put that type of info in industry_description 
								 // field on the layout_industry instead of in the business_description
								 // on the layout_abstract.
                 self.industry_description := left.corp_orig_bus_type_desc;
							 ));
		return extract;
	  end;
			
end;