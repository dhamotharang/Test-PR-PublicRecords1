import TopBusiness, iesp, AutoStandardI, NID, TopBusiness_services, 
       Corp2, Bipv2, MDR;

export RegisteredAgentSection := module 

 export fn_fullView(
	dataset(RegisteredAgentSection_Layouts.rec_Input) in_data,
	RegisteredAgentSection_Layouts.Rec_OptionsLayout in_options,
  AutoStandardI.DataRestrictionI.params in_mod	
	) := function
	 
	 FETCH_LEVEL := in_options.BusinessReportFetchLevel;
	 // first fetch key information from corp file
																						
   ds_raw_corp :=   TopBusiness_Services.Key_Fetches( 
	                      project(in_data,transform(BIPV2.IDlayouts.l_xlink_ids, 
							       self := left))
										 ,FETCH_LEVEL).ds_corp_linkidskey_recs;								 								      
	 ds_corpRA :=   ds_raw_corp(corp_ra_lname1 != '');
								
	                   
	 ds_CompRA := dedup(ds_raw_corp(corp_ra_cname1 != '' and corp_ra_lname1 = ''), all);
	 		 	  	
	  // corp_ra_name

	 ds_All_raw_RAData := dedup(project(ds_corpRA,
	    transform(TopBusiness_Services.RegisteredAgentSection_Layouts.rec_layout_contacts_common,		
		    self.proxid := left.proxid;
				self.ultid  := left.ultid;
				self.seleid := left.seleid;
				self.orgid  := left.orgid;
				self.dotid  := left.dotid;
				self.powid  := left.powid;
				self.empid  := left.empid;				
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key),
				//self.source_party    := 'CORP',
				self.companyName := ''; //left.corp_ra_name;
				self.date_first_seen := left.dt_first_seen,
				                         // bug 123464 based on state list
																 //
				RA_state := trim(left.corp_ra_state, left, right);
				self.date_last_seen := if (RA_state 
				              in ['AZ', 'ID', 'IL', 'IN', 'LA', 
											'OH', 'OK', 'SD', 'VA'] 
										and left.corp_ra_effective_date <> '',
									(unsigned4) left.corp_ra_effective_date,
												// otherwise
												left.corp_ra_dt_last_seen);
				 
				self.name_prefix    := left.corp_ra_title1;
		    self.name_first     := left.corp_ra_fname1;
				self.Nickname        := NID.PreferredFirstVersionedStr(left.corp_ra_fname1, NID.version);
		    self.name_middle    := left.corp_ra_mname1;
		    self.name_last      := left.corp_ra_lname1;
		    self.name_suffix    := left.corp_ra_name_suffix1;
				self.prim_range     := left.corp_ra_prim_range,
				self.predir         := left.corp_ra_predir,
				self.prim_name      := left.corp_ra_prim_name,
				self.addr_suffix    := left.corp_ra_addr_suffix,
				self.postdir        := left.corp_ra_postdir,
				self.unit_desig     := left.corp_ra_unit_desig,
				self.sec_range      := left.corp_ra_sec_range,
				self.city_name      := left.corp_ra_v_city_name,
				self.state          := left.corp_ra_state,
				self.zip            := left.corp_ra_zip5,
				self.zip4           := left.corp_ra_zip4,
		    self.position_title := left.corp_ra_title_desc; 				                   
				self.email          := left.corp_email_address;
				self.ssn            := '';
				self.did            := 0,
				self.score          := 0,
				self.phone          := left.corp_ra_phone10;
				self.position_type  := 'R';		
				self.IsExecutive := false;
				self.isCurrent := false;
				//self.record_type := left.record_type;
				)), all); 
								
				
				// NOW DO same with corp_ra_name <> '' set (company named RA's)
					 ds_raw_compRA := dedup(project(ds_compRA,
	    transform(TopBusiness_Services.RegisteredAgentSection_Layouts.rec_layout_contacts_common,
		
		    self.proxid := left.proxid;
				self.ultid  := left.ultid;
				self.orgid  := left.orgid;
				self.seleid := left.seleid;
				self.dotid  := left.dotid;
				self.powid  := left.powid;
				self.empid  := left.empid;				
				self.source := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid    := trim(left.corp_key),								
				self.companyName     := trim(left.corp_ra_cname1, left, right);
				self.date_first_seen := left.dt_first_seen,
				self.date_last_seen := left.dt_last_seen,
				self.name_prefix    := left.corp_ra_title1;
		    self.name_first     := left.corp_ra_fname1;
				self.Nickname        := NID.PreferredFirstVersionedStr(left.corp_ra_fname1, NID.version);
		    self.name_middle    := left.corp_ra_mname1;
		    self.name_last      := left.corp_ra_lname1;
		    self.name_suffix    := left.corp_ra_name_suffix1;
				self.prim_range     := left.corp_ra_prim_range,
				self.predir         := left.corp_ra_predir,
				self.prim_name      := left.corp_ra_prim_name,
				self.addr_suffix    := left.corp_ra_addr_suffix,
				self.postdir        := left.corp_ra_postdir,
				self.unit_desig     := left.corp_ra_unit_desig,
				self.sec_range      := left.corp_ra_sec_range,
				self.city_name      := left.corp_ra_v_city_name,
				self.state          := left.corp_ra_state,
				self.zip            := left.corp_ra_zip5,
				self.zip4           := left.corp_ra_zip4,
		    self.position_title := left.corp_ra_title_desc; 				                   
				self.email          := left.corp_email_address;
				self.ssn            := '';
				self.did            := 0,
				self.score          := 0,
				self.phone          := left.corp_ra_phone10;
				self.position_type  := 'R';		
				self.IsExecutive    := false;
				self.isCurrent      := false;
				//self.record_type := left.record_type;
				)),all);
						                        	
		ds_all_RAAcctno := join(in_data,  ds_All_raw_RAData,	                
									 BIPV2.IDmacros.mac_JoinTop3Linkids(),									 
									 transform({string25 acctno;recordof(ds_All_raw_RAData);},
									   self.acctno := left.acctno;
										 self := right),limit(TopBusiness_Services.Constants.defaultJoinLimit),
										 keep(TopBusiness_Services.Constants.defaultJoinLimit), left outer);	         
	
	layout_d := record
	  recordof(ds_all_RAAcctno);
		integer companyPosition_order;		
	end;
	
	// Sort the data to mark the records in order of selection as best
	
	sorted_raw_data := project(sort(ds_all_RAAcctno(position_type='R'),
		acctno,
		ultid,
		orgid,
		seleid	
		),
		transform(layout_d,					     									
		  self.companyPosition_order := 999; // set to a high value here
			self.isExecutive := false;
			self := left));			
	
	sorted_constants := sort(TopBusiness_Services.ExecutiveTitles, order);
	
  sorted_raw_data_3 := join(sorted_raw_data, 	sorted_constants,
	                          left.position_title = right.position_title,
														transform({recordof(left);iesp.share.t_address address;},                                           
														  self.companyPosition_order := if (right.position_title = '', 999, right.order);
                              self.isExecutive := right.isExecutive;
															self.address := iesp.ECL2ESP.SetAddress(
															         left.prim_name, left.prim_range, left.predir, left.postdir,left.addr_suffix,
																			 left.unit_desig, left.sec_range, left.city_name,left.state, left.zip, left.zip4,
																			 '','','','','');  //  we want best address from contacts key (company address by default
															// and then make it person address if rec has a did on it?
															self := left),
															left outer,lookup);		
																														
    dedup_sorted_raw_data_3 := dedup(sort(sorted_raw_data_3,
																					acctno, 
																					#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						did,																																							
																					name_last, name_first, name_middle, name_suffix,
																					position_title, -date_last_seen, date_first_seen, if (address.state <> '', 0, 1)),
																				acctno,  
																				#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),did,																				
																				name_last, name_first, name_middle, name_suffix, position_title, date_last_seen, date_first_seen);															  											
														
  tmp_ds := 			group(
	                     sort(dedup_sorted_raw_data_3,acctno,
											      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
														did,name_last, Nickname, name_middle, name_suffix, position_title),
                              acctno,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),did,name_last, Nickname, name_middle, name_suffix,position_title);
   		   
   rolled_ds2 := rollup(tmp_ds,group,
                   transform(recordof(left),
                      self.date_last_seen :=  max(rows(left)(date_last_seen <> 0),date_last_seen), 
                      self.date_first_seen := min(rows(left)(date_first_seen <> 0), date_first_seen),  																						
											self.IsCurrent := if (count(rows(left)(isCurrent)) > 0, true, false);								
                      self := left));											
																			 
  rolled_ds_dedup := dedup(sort(rolled_ds2,acctno,
	                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
												     -did, name_last, name_first, name_middle, name_suffix, -position_title, -date_last_seen, -date_first_seen,if (address.state <> '', 0, 1)),
                              acctno,
															#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															  did, name_last, name_first, name_middle, name_suffix, position_title, date_last_seen, date_first_seen);
  // rolled_ds_dedup with 0 dids will be last in the group..Also reverse sort on -position_title -date_last_seen and -date_first_seen
	 // also has the effect of bringing recs with actual dates to the top and brings along the
	                             //isExecutive, isCurrent boolean to the top cause recs with no position_title sort to the bottom															
		temppositionrec := record
			rolled_ds_dedup.position_title;
			rolled_ds_dedup.CompanyPosition_order;
			rolled_ds_dedup.isExecutive;
			rolled_ds_dedup.isCurrent;
			rolled_ds_dedup.date_first_seen;
			rolled_ds_dedup.date_last_seen;
		end;
		
    prep_unroll := project(
			dedup(sort(rolled_ds_dedup,acctno,
			               #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
										  position_type,name_last,nickname,name_middle,name_suffix,position_title,did,date_last_seen, date_first_seen), 
			                          acctno, 
																#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																position_type,name_last,nickname,name_middle,name_suffix,position_title,did,date_last_seen, date_first_seen),
			transform(recordof(left),
			  // do you want this line or not?
				self.position_title := if(left.position_type = 'R','REGISTERED AGENT',left.position_title),
				self := left));
		prep_roll1 := rollup(
			group(prep_unroll,acctno,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),position_type,name_last,nickname,name_middle,name_suffix,position_title),
			group,
			transform(recordof(left),
				self.date_last_seen := max(rows(left)(date_last_seen <> 0),date_last_seen),
				self.date_first_seen := min(rows(left)(date_first_seen <> 0),date_first_seen),
				self.IsCurrent := if(count(rows(left)(isCurrent)) > 0,true,false),
				self.did := max(rows(left),did),
				self := left));
		// For this and the next rollup, we have to be careful to group by first and last name when DID is 0.
		// This ensures that we don't roll all non-DIDed entities together into a single entry.
		prep_roll2 := rollup(
			group(
				sort(prep_roll1,acctno,
				#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
				 position_type,did,if(did = 0,name_last + nickname,''),position_title,-length(trim(name_first,left,right)),-length(trim(name_suffix, left, right))),
				acctno,
				#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
				position_type,did != 0,did,if(did = 0,name_last + nickname,''),position_title),
			group,
			transform(recordof(left),
				self.date_last_seen := max(rows(left)(date_last_seen <> 0),date_last_seen),
				self.date_first_seen := min(rows(left)(date_first_seen <> 0),date_first_seen),
				self.IsCurrent := if(count(rows(left)(isCurrent)) > 0,true,false),
				self := left));
		
		// ***** NOW do rollup with companynamed RA's ******
     					
     	prep_rollComp := rollup(
			group(
				sort(ds_raw_compRA,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
				          companyName,position_type,position_title,-date_last_seen,if (prim_range <> '', 0,1),
				                                                   if (city_name <> '', 0, 1), if (state <> '', 0, 1), if (zip <> '', 0, 1) ,record),
				#expand(BIPV2.IDmacros.mac_ListTop3Linkids())
				,companyName,position_type,position_title),
			group,
			transform(recordof(left),
				self.date_last_seen := max(rows(left)(date_last_seen <> 0),date_last_seen),
				self.date_first_seen := min(rows(left)(date_first_seen <> 0),date_first_seen),
				self.IsCurrent := if(count(rows(left)(isCurrent)) > 0,true,false),
				self := left));
				   
	 layout_derog_bools_contact := record
		                      recordof(prep_roll2);
													boolean bkFlag;
													boolean liensFlag;
													boolean foreClosureFlag;
													boolean nodFlag;
													boolean deathFlag;
													unsigned executiveElsewhere;
			end;
				
   RegisteredAgents :=
		project(prep_roll2, 
			transform({			          
                    dedup_sorted_raw_data_3.acctno; 										
                 iesp.topbusinessReport.t_TopBusinessRegisteredAgentEntity;},
	
			self.BusinessIds.ultid :=  left.ultid;
			self.BusinessIds.orgid := left.orgid;
			self.BusinessIds.seleid := left.seleid;
			self.BusinessIds.proxid := left.proxid;
			self.BusinessIds.powid := left.powid;
			self.BusinessIds.empid := left.empid;
			self.BusinessIds.dotid := left.dotid;
      self.FromDate :=  iesp.ecl2esp.ToDate(left.date_first_seen); 																							    																                
			self.ToDate := iesp.ecl2esp.ToDate(left.date_last_seen); 																 															                                   																
																 
      self.Name  := iesp.ecl2esp.setname(left.name_first, left.name_middle, left.name_last, left.name_suffix, left.name_prefix, '');			
      self.Address := left.address;			 // will be used for advanced person search roxie query		 						
			self.Title := left.position_title;
			self.CompanyName := left.companyName; 
			self.phone := '';
      self.IsDeceased := false;													
			self.HasDerog :=   false; 
      self.UniqueId := (string12) left.did;												 
      
			self := left;		
			self := []; // no source docs.
			));
																
		  // add account # into this DS with this join.
			// we waited until down here to do it cause the ds_compRAs do not
			// have person information which needed to hit all kinds of
			// routines above such as watchdog did (uniqueid)lookup above.
			// 
		tmpRegisteredAgentBusinesses := dedup(join(in_data,  prep_rollComp,            
				 BIPV2.IDmacros.mac_JoinTop3Linkids(),				 
				transform({string25 acctno;
				           iesp.topbusinessReport.t_TopBusinessRegisteredAgentEntity;},
					self.acctno := left.acctno;
					self.BusinessIds.ultid :=  left.ultid;
					self.BusinessIds.orgid := left.orgid;
					self.BusinessIds.seleid := left.seleid;
					self.BusinessIds.proxid := left.proxid;
					self.BusinessIds.powid := left.powid;
					self.BusinessIds.empid := left.empid;
					self.BusinessIds.dotid := left.dotid;
					self.title := right.position_title;
					
					self.companyName := right.companyName;
					self.phone := '';
					self.FromDate :=  iesp.ecl2esp.ToDate(right.date_first_seen); 	
					self.ToDate :=  iesp.ecl2esp.ToDate(right.date_last_seen); 					
					// self.name_prefix    :=  ''; //right.corp_ra_title1;
					// self.name_first     :=  ''; //right.corp_ra_fname1;
					// self.Nickname        := ''; //NID.PreferredFirstVersionedStr(left.corp_ra_fname1, NID.version);
					// self.name_middle    := '';//left.corp_ra_mname1;
					// self.name_last      := '';//left.corp_ra_lname1;
					// self.name_suffix    := '';//left.corp_ra_name_suffix1;
					self.address := iesp.ECL2ESP.SetAddress(
															         right.prim_name, right.prim_range, right.predir,
																			 right.postdir,right.addr_suffix,
																			 right.unit_desig, right.sec_range,
																			 right.city_name,right.state, right.zip, right.zip4,
																			 '','','','','');
          self.name := [];
					self.IsDeceased := false;// n/A 												
					self.HasDerog :=   false; // N/A 
					self.UniqueId := ''; // N/A 										
					self := [];
					),limit(TopBusiness_Services.Constants.defaultJoinLimit),
					  keep(TopBusiness_Services.Constants.defaultJoinLimit)), all);
						
      RegisteredAgentsCombined := RegisteredAgents+ tmpRegisteredAgentBusinesses; 
			                                                                             
			                              
  // do counts and sort the company registered agents to the bottom of the bunch.
  // add_agents := denormalize(in_data,RegisteredAgentsCombined,
		// left.acctno = right.acctno,
		// group,
		// transform(TopBusiness_Services.RegisteredAgentSection_Layouts.rec_final,
			// self.RegisteredAgentCount := count(rows(right)),
			// self.RegisteredAgents := choosen(sort( 
				// project(rows(right),iesp.topbusinessReport.t_TopBusinessRegisteredAgentEntity),
				// Name.Last,Name.First,Name.Middle, companyName,-FromDate.Year, -FromDate.Month, -FromDate.Day, 
				      // record),
			  // iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_REGISTEREDAGENT_RECORDS);
			// self := left));	
																
			TopBusiness_Services.RegisteredAgentSection_Layouts.rec_final RegAgentXform() := TRANSFORM
							SELF.Acctno := In_data[1].Acctno;
							SELF.ultid := In_data[1].ultid;
							SELF.orgid := In_data[1].orgid;
							SELF.seleid := In_data[1].seleid;
							self.Proxid := In_data[1].proxid;
							self.dotID := In_data[1].dotid;
							SELF.empid := In_data[1].empid;
							SELF.POWID := In_data[1].powid;
							SELF.RegisteredAgentCount := COUNT(RegisteredAgentsCombined);
							SELF.REgisteredAgents :=  choosen(sort( 
								project(RegisteredAgentsCombined,iesp.topbusinessReport.t_TopBusinessRegisteredAgentEntity),
									Name.Last,Name.First,Name.Middle, companyName,-FromDate.Year, -FromDate.Month, -FromDate.Day, 
										record),
											iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_REGISTEREDAGENT_RECORDS);
												 
												 END;
													
													Add_agents := DATASET([ RegAgentXform() ]);
  			  			
  // output(sorted_raw_data, named('sorted_raw_data'));			
	
  // output(ds_raw_corp, named('ds_raw_corp'));			
	 // output(ds_raw_corpRA, named('ds_raw_corpRA'));
	
  //output(ds_raw_compRA, named('ds_raw_compRA'));
// output(dedup_sorted_raw_data_3, named('dedup_sorted_raw_data_3'));
// output(tmp_ds, named('tmp_ds'));
// output(rolled_ds, named('rolled_ds'));
// output(prep_roll1, named('prep_roll1'));
   // output(prep_roll2, named('prep_roll2'));
    // output(prep_rollComp, named('prep_rollComp'));	
    // output(tmpRegisteredAgentBusinesses, named('tmpRegisteredAgentBusinesses'));
   // output(RegisteredAgents, named('RegisteredAgents'));
	 
// output(ds_CompRA, named('ds_CompRA'));
// output(ds_corpRA, named('ds_corpRA'));

// output(RegisteredAgentsCombined, named('RegisteredAgentsCombined'));
// output(add_agents, named('add_agents'));
// output(best_records, named('best_records'));
return add_agents;		
end;	 // function
end; // module
			
			
			