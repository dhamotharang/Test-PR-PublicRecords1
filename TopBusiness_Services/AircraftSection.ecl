import faa, autostandardI, TopBusiness_Services, BIPv2, iesp, MDR, Codes;

export Aircraftsection := MODULE;
 export fn_fullView (
	dataset(TopBusiness_Services.AircraftSection_Layouts.rec_input) ds_in_data,
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod,
  unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
	) := function	  
	
	rec_party_layout := record
	   string30  serial_number;
		 string8  aircraft_number;
		 string8  registration_date;
		 string1  current_prior_flag; 
		 string8  date_last_seen; // more populated than cert_issue_date and varies more
														 // than last_action_date
		string120 company_name;
		string20 name_last;
		string20 name_first;
		string20 name_middle;
		string5 name_suffix;
		string5 name_title;
		iesp.share.t_Address address;
	end;
	
	rec_layout := record
	  iesp.share.t_BusinessIdentity;	
		string2  source;
		string30 source_docid;
		string10 source_party;
		string8  aircraft_number; // may or may not need this depending if data team builds a new key
		                          // using serial_number -- or n_number.
		string30  serial_number;
		string1  current_prior_flag;  // either A - active H - historical for faa source		
		string8  date_last_seen; // more populated than cert_issue_date and varies more
		                       // than last_action_date
    string8  model_year; //  string8 	year_mfr; in data
		string20 model; // string20 model_name in data
		string8  registration_date;  // cert_issue_date in data
		string8  registration_number; // n_number					      	
		string13 	aircraft_type;
		integer   engines;
		string30 	manufacturer;  //aircraft_mfr_nam
		iesp.share.t_Address registration_address;	
  end;		
												    
	 ds_in_data_deduped := dedup(ds_in_data,all);
	 // we'll need 1st 100 of both of active (A) and historical (H) from the main key
	 // so double the input dataset to include both for each bid
	 //
	 // BIP 2.0 ideas take initial join and add both 'A' and 'H' to it
	 // split across both
	 // source codes
	 // have to think about how to do these sections in light of the fact
	 // that we dont' have aircraft party key...
	 // what fields do we have in party key that are in the final layout.
	 // MDR.sourceTools.src_Aircrafts                 := 'AR';
	 // MDR.sourceTools.src_Airmen                    := 'AM';
	 //
	 ds_in_data_normalized := normalize(ds_in_data_deduped,2,
		transform({ds_in_data_deduped.proxid;ds_in_data_deduped.dotid;ds_in_data_deduped.orgid;
		           ds_in_data_deduped.ultid;ds_in_data_deduped.seleid;
							 ds_in_data_deduped.powid;ds_in_data_deduped.empid;
							 string1 current_prior_flag;},
			self.proxid := left.proxid,
			self.dotid := left.dotid,
			self.ultid := left.ultid,
			self.seleid := left.seleid,
			self.orgid := left.orgid,
			self.powid := left.powid,
			self.empid := left.empid,
			self.current_prior_flag := choose(counter,'A','H')));

   FETCH_LEVEL := in_options.businessReportfetchLevel;

   // Fetch the Aircraft linkids key data
   ds_aircraft_raw_recs := TopBusiness_Services.Key_Fetches(
															project(ds_in_data_deduped, 
															BIPV2.IDlayouts.l_xlink_ids), 
													    FETCH_LEVEL).ds_airc_linkidskey_recs;
										
   ds_aircraft_recs := join(ds_in_data_normalized,ds_aircraft_raw_recs,
	                 BIPV2.IDmacros.mac_JoinTop3Linkids() AND	                			
									left.current_prior_flag = right.current_flag,									
	   transform({recordof(right);},
		   self := right;			
			 ),limit(10000, skip));		      	

	// Trim down only to get recs that are unique by linkids
	ds_aircraft_recs_unique_linkids := 
	     dedup(sort(ds_aircraft_recs,
			    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
				 serial_number,n_number,
			                             -cert_issue_date,record),
																	  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),	                                 
																	 serial_number,n_number);
 
    TopBusiness_Services.AircraftSection_Layouts.rec_aircraftParent party_xform(
	   recordof(ds_aircraft_recs_unique_linkids) l,   	 
		 dataset(recordof(ds_aircraft_recs)) r)	:= transform
		  self.prior_parties := choosen(sort(project(r(current_flag = 'H'),transform(TopBusiness_services.aircraftSection_layouts.rec_party_layout,
			                          self.address := iesp.ECL2ESP.SetAddress(
																	left.prim_name,left.prim_range,left.predir,left.postdir,
																	left.addr_suffix,left.unit_desig,left.sec_range,left.v_city_name,
																	left.st,left.zip,left.z4,'','','','','');
			                          self := left, 																
																 )), -cert_issue_date, record), iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS);		 
      self.current_parties := choosen(sort(project(r(current_flag = 'A'),transform(TopBusiness_services.aircraftSection_layouts.rec_party_layout,
			                          self.address := iesp.ECL2ESP.SetAddress(
																	left.prim_name,left.prim_range,left.predir,left.postdir,
																	left.addr_suffix,left.unit_desig,left.sec_range,left.v_city_name,
																	left.st,left.zip,left.z4,'','','','','');
			                          self := left,																
																)), -cert_issue_date, record), iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS);
      self.current_prior_flag := l.current_flag;		
			self.source := MDR.sourceTools.src_Aircrafts;
			self.source_docid := l.serial_number;
			self.aircraft_number := l.n_number;
			self.model_year := l.year_mfr; //r.model_year;
			self.registration_name		:= iesp.ECL2ESP.SetNameAndCompany (l.fname, l.mname, l.lname, l.name_suffix, 
                                                        l.title, , l.compname);
			self.registration_address := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
						 l.addr_suffix, l.unit_desig, l.sec_range, l.v_city_name,
						 l.st, l.zip, 
							l.z4, //left.zip4
							'', //left.countyname, 
						 '', //left.postalcode = '',
						 '', //left.addr1 = '',
						 '', //left.addr2 = '',
						 '' //left.stcityzip = ''
						 );
      self.registration_date := l.cert_issue_date;
			self.registration_number := l.n_number;
			self.engines := choosen(project(faa.key_aircraft_info()(code = l.mfr_mdl_code),
			                   transform({integer engines;}, 
												 self.engines := (integer) left.number_of_engines)),1)[1].engines;			 
			self.source_party := '';
		  self := l;			
	end;
	
  // get all recs from the initial linkids join
	// whose party information is needed for population of return dataset later.
  ds_recs_parent_child := denormalize(ds_aircraft_recs_unique_linkids,ds_aircraft_recs ,	  
		left.serial_number = right.serial_number AND
		left.n_number = right.n_number AND
		(left.cert_issue_date = right.cert_issue_date or right.current_flag = 'A'),
		group,
		party_xform(left,rows(right)));							 
  
   iesp.topbusinessReport.t_topBusinessAircraftParty
	   party_info( TopBusiness_Services.AircraftSection_Layouts.rec_party_layout l) := transform
		 self.Name.First := l.fname;
		 self.Name.Last := l.lname;
		 Self.Name.middle := l.mname;
		 self.Name.Full := '';
		 self.Name.suffix := l.name_suffix;
		 self.Name.prefix := l.title;
		 self.companyName := l.compname;
		 self.serialNumber := l.serial_number;		 
		 self.registrationDate := iesp.ECL2ESP.toDate((integer) l.cert_issue_date);
		 Self.Address := l.address;				 
	 end;		 		 
	 
	 TopBusiness_Services.AircraftSection_Layouts.rec_linkids_plus_AircraftDetail				
				xform_parent( TopBusiness_Services.AircraftSection_Layouts.rec_aircraftParent l) := transform					
					self.RegistrationDate  := iesp.ECL2ESP.toDate ((integer)l.registration_date),
					self.PriorParties   := choosen(dedup(project(l.prior_parties, party_info(left)), all), iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS);
					self.CurrentParties := choosen(dedup(project(l.current_parties, party_info(left)),all), iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS);
					self.AircraftNumber := l.aircraft_number;
					self.ModelYear := l.model_year;
					self.AircraftType := codes.FAA_AIRCRAFT_REF.TYPE_AIRCRAFT(l.type_aircraft);
					self.SerialNumber := l.serial_number;
					self.Manufacturer := l.aircraft_mfr_name;
					self.Model := l.model_name;					
					self.RegistrationAddress := l.registration_address;
					self.RegistrationNumber := l.registration_number;
					self.SourceDocs := dataset([transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,
																			self.IdType := 'n_number';
																			self.IdValue := l.aircraft_number,
																			self.Section := topBusiness_services.constants.AircraftSectionName;																								 

																			self.Source := MDR.sourceTools.src_Aircrafts,																		
																			self.businessIDs.proxid := l.proxid;
																			self.businessIDs.dotid := l.dotid;
																			self.businessIDs.powid := l.powid;
																			self.businessIDs.seleid := l.seleid;
																			self.businessIDs.empid := l.empid;
																			self.businessIDs.ultid := l.ultid;
																			self.businessIDs.orgid := l.orgid;
																			self.address := [];
																			self.name.CompanyName := l.registration_name.companyName;
																			self.name := []; 
																			self := l;
																			)]);
					self := l;          			
		end;
	
	 ds_aircraft_recs_denorm := dedup(project(ds_recs_parent_child, xform_parent(left)), all);
					
  TopBusiness_Services.AircraftSection_Layouts.rec_linkids_plus_AircraftRecord 
	rollup_rptdetail(	 
		TopBusiness_Services.AircraftSection_Layouts.rec_linkids_plus_AircraftDetail l,
	  dataset(TopBusiness_Services.AircraftSection_Layouts.rec_linkids_plus_AircraftDetail) allrows) := transform
		
    self.acctno  := '';			
		self.proxid  := l.proxid;
		self.dotid   := l.dotid;
		self.ultid   := l.ultid;
		self.orgid   := l.orgid;
		self.seleid := l.seleid;
		self.powid   := l.powid;
		self.empid   := l.empid;
		
		self.currentRecordCount :=  if ( count(allrows(current_prior_flag='A')) >
															 iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS,
															      iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS,
																		count(allrows(current_prior_flag='A')) ); 
		self.TotalCurrentRecordCount :=  count(allrows(current_prior_flag='A'));
		
		self.priorRecordCount :=  if ( count(allrows(current_prior_flag='H')) >
															 iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS,
															      iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS,
																		count(allrows(current_prior_flag='H')) ); 
		self.TotalPriorRecordCount := count(allrows(current_prior_flag='H'));
    self.currentAircrafts := choosen(sort(dedup(project( allrows(current_prior_flag = 'A'),
		                        transform(iesp.topbusinessReport.t_topBusinessAircraft, 														  
														  self := left)), all), -RegistrationDate.Year,-RegistrationDate.Month,-RegistrationDate.Day,record),iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS);
		self.priorAircrafts   := choosen(sort(dedup(project( allrows(current_prior_flag = 'H'),
		                        transform(iesp.topbusinessReport.t_topBusinessAircraft, 														   
														  self := left)), all), -RegistrationDate.Year,-RegistrationDate.Month,-RegistrationDate.Day,record),iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS);
															
		self.CurrentSourceDocs := if(count(allrows(current_prior_flag='A')) > 0,
		   choosen(
		   project(allrows(current_prior_flag='A').sourceDocs, 
			  transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,			
				self := left)),
				 in_sourceDocMaxCount)
				 );
   self.PriorSourceDocs := if(count(allrows(current_prior_flag='H')) > 0,
		   choosen(
			        project(allrows(current_prior_flag='H').sourceDocs, 
			  transform(iesp.TopBusiness_share.t_TopBusinessSourceDocInfo,			
				self := left)), 
				      in_sourceDocMaxCount)
				);			
	end;
 
  ds_all_grouped := group(sort(ds_aircraft_recs_denorm,  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																								 record), #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																								 ); 
  ds_all_rptdetail_rolled := rollup(ds_all_grouped,
																 group,
																 rollup_rptdetail(left,rows(left)));
 
   ds_raw_data_wAcctno := join(ds_in_data,ds_all_rptdetail_rolled, // in_data has acctno on it
	                         BIPV2.IDmacros.mac_JoinTop3Linkids(),
														transform(TopBusiness_Services.AircraftSection_Layouts.rec_linkids_plus_AircraftRecord,
														   self.acctno   := left.acctno,
															 self          := right),
												left outer); // 1 out rec for every left (in_data) rec 																			 																		
																		 
    ds_final_results := rollup(group(sort(ds_raw_data_wAcctno,acctno),acctno),group,
		  transform(TopBusiness_Services.AircraftSection_Layouts.rec_Final,	
			 self.TotalAircraftRecordCount := left.currentRecordCount + left.priorRecordCount,
			 self.AircraftRecordCount := if (left.currentRecordCount + left.priorRecordCount < 
			                               iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS,																		 
																		  left.currentRecordCount + left.priorRecordCount,
																			iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS);
																		  // assume this is total of both current/prior		   
			 self.AircraftRecords := left;
		   self := left));			
			 
			 // debug outputs.
			 // output(ds_in_data_deduped, named('ds_in_data_deduped'));
			 // output(ds_aircraft_raw_recs, named('ds_aircraft_raw_recs'));
			 // output(ds_aircraft_recs, named('ds_aircraft_recs'));
			 
			
	     // output(ds_recs_parent_child, named('ds_recs_parent_child'));
			 //output(ds_aircraft_recs_denorm, named('ds_aircraft_recs_denorm'));
		   // output(ds_all_grouped, named('all_grouped'));
		   // output(ds_all_rptdetail_rolled, named('all_rptdetail_rolled'));
			 
     return ds_final_results;						 
 end; // function

end; // module