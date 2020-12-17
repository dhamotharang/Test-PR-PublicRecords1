import AutoStandardI,BankruptcyV3,BipV2,BizLinkFull,CriminalRecords_Services,deathv2_services,iesp,
LiensV2,NID,dx_Property,Suppress,Std,ut,BusinessCredit_Services, topbusiness_services;
 
export ContactSection := module
	export fn_fullView(	dataset(TopBusiness_Services.ContactSection_Layouts.rec_Input) ds_in_data,
											TopBusiness_Services.ContactSection_Layouts.rec_OptionsLayout in_options,
											AutoStandardI.DataRestrictionI.params in_mod,
                      unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS) := function

		string8 CurDate 	:= (string) STD.Date.today();
		FETCH_LEVEL 		:= in_options.BusinessReportFetchLevel;
		// this key has restrictions build into it based on the DRM being
		// in stored value and DRM module called from within the kfetch restricts
		// particular sources from being returned in the kfetch.

		// adding in this dedup logic per bug # : 124264/124268

		// note macro within kfetch has a default of 25,000 in 
		// main join use constant to reduce if needed.
		// ds_quickheader_contactsRaw := dedup(
		// Bipv2_build.key_contact_linkids.kFetch(
		// project(ds_in_data,transform(BIPV2.IDlayouts.l_xlink_ids,
		// self := left)),
		// FETCH_LEVEL,,,TopBusiness_Services.Constants.ContactsKfetchMaxLimit)(source <> 'D' and source <> '')
		// , all, except dt_vendor_last_reported, dt_vendor_first_reported);
				
		ds_contactLinkds := TopBusiness_Services.Key_Fetches(
														project(ds_in_data, BIPV2.IDlayouts.l_xlink_ids),
														FETCH_LEVEL,TopBusiness_Services.Constants.ContactsKfetchMaxLimit
														).ds_contact_linkidskey_recs;
                            
		ds_quickheader_contactsRaw_ddp := dedup(ds_contactLinkds(source <> 'D' and source <> ''),all, except dt_vendor_last_reported, dt_vendor_first_reported);
		ds_quickheader_contactsRaw_w_rest := ds_quickheader_contactsRaw_ddp(source not in BusinessCredit_Services.Constants.EXCLUDED_EXPERIAN_SRC);	// restricting experian sources
		ds_quickheader_contactsRaw := if(in_options.restrictexperian, ds_quickheader_contactsRaw_w_rest, ds_quickheader_contactsRaw_ddp);
		
		// setting acctno exclusively here to speed up report query can add join back in in future if multiple acctno's needed in report
		acctno 										:=  ds_in_data[1].acctno;
		ds_all_contactsRestricted :=  project(ds_quickheader_contactsRaw,		                           
																		transform({string20 acctno; TopBusiness_Services.ContactSection_Layouts.rec_layout_contacts_common;},
																			self.acctno 					:= acctno,
																			self.source 					:= left.source,
																			self.source_docid 		:= (string50) left.vl_id, //'FROM_HEADER_FILE';
																			self.proxid 					:= left.proxid,
																			self.ultid  					:= left.ultid,
																			self.seleid 					:= left.seleid,
																			self.orgid  					:= left.orgid;
																			self.dotid  					:= 0, // done for bug # : 122843..
																			self.powid  					:= 0, // this is 0 from bus header key 
																			self.empid  					:= 0,	// this is 0 from bus header key					
																			self.date_first_seen 	:= (unsigned4)left.dt_first_seen_contact,
																			self.date_last_seen 	:= (unsigned4)left.dt_last_seen_contact,
																			self.ssn 							:= left.contact_ssn,
																			self.did 							:= left.contact_did,
																			self.score 						:= 0,
																			self.name_prefix 			:= left.contact_name.title,
																			self.name_first 			:= left.contact_name.fname,
																			self.Nickname 				:= NID.PreferredFirstVersionedStr(left.contact_name.fname, NID.version),
																			self.name_middle 			:= left.contact_name.mname,
																			self.name_last 				:= left.contact_name.lname,
																			self.name_suffix 			:= left.contact_name.name_suffix,
																			self.prim_range 			:= left.company_address.prim_range,
																			self.predir 					:= left.company_address.predir,
																			self.prim_name 				:= left.company_address.prim_name,
																			self.addr_suffix 			:= left.company_address.addr_suffix,
																			self.postdir 					:= left.company_address.postdir,
																			self.unit_desig 			:= left.company_address.unit_desig,
																			self.sec_range 				:= left.company_address.sec_range,
																			self.city_name 				:= left.company_address.v_city_name,
																			self.state 						:= left.company_address.st,
																			self.zip 							:= left.company_address.zip,
																			self.zip4 						:= left.company_address.zip4,
																			self.position_title 	:= trim(left.contact_job_title_derived,left,right),					                                  
																			self.position_type 		:= TopBusiness_Services.Constants.POSITION_TYPE_CURRENT,
																			self.isCurrent   			:= if ((unsigned4) left.dt_last_seen_contact <> 0, 
																																	 (unsigned4) left.dt_last_seen_contact >= 
																																	 (unsigned4) ut.DateFrom_DaysSince1900(ut.DaysSince1900(CurDate[1..4],CurDate[5..6], CurDate[7..8]) - (integer)'730'),
																																	 false),
																			self.phone 						:= '',
																			self.email 						:= '',
																			self.isExecutive 			:= left.executive_ind,
																			self 									:= []));
			
		//Sort the data to mark the records in order of selection as best
		sorted_raw_data 		:= sort(ds_all_contactsRestricted,acctno,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
		sorted_raw_data_3 	:= project(sorted_raw_data,
															transform({recordof(left);iesp.share.t_address address;},
																self.address := iesp.ECL2ESP.SetAddress(
																											left.prim_name, left.prim_range, left.predir, left.postdir,left.addr_suffix,
																											left.unit_desig, left.sec_range, left.city_name,left.state, left.zip, left.zip4,'','','','',''),
																self := left));

    // could do this..the if (name_* <> '', 0, 1) idea is to make the names that are longer and have more parts in them		
		dedup_sorted_raw_data_3 := dedup(sort(sorted_raw_data_3,
																					acctno, 
																					#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																					-did,
																					name_last, name_first, name_middle, name_suffix,
																					position_title, 
																					date_last_seen, date_first_seen, 
																					if (address.state <> '', 0, 1), if (address.unitnumber <> '', 0, 1)),
																		acctno, 
																		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		did,
																		name_last, name_first, name_middle, name_suffix, position_title, 
																		date_last_seen, date_first_seen);
 																																	
		tmp_ds :=	group( sort(dedup_sorted_raw_data_3,
													acctno,
													#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
													did,
													name_last, Nickname, name_middle, name_suffix, position_title),
									 acctno,
									 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
									 did,
									 name_last, Nickname, name_middle, name_suffix,position_title);
   		
    rolled_ds := rollup(tmp_ds,group, 
									  transform(recordof(left),
                      self.date_last_seen :=  max(rows(left)(date_last_seen <> 0),date_last_seen), 
                      self.date_first_seen := min(rows(left)(date_first_seen <> 0), date_first_seen),  																					
											self.IsCurrent := exists(rows(left)(isCurrent)),
											self.ContactSourceDocs := choosen( project(dedup(rows(left),all), 
																													transform( iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
																														self.businessIDs.ultid  := left.ultid,
																														self.businessIDs.orgid  := left.orgid,
																														self.BusinessIDs.seleid := left.seleid,
																														self.BusinessIDs.proxid := left.proxid,
																														self.BusinessIDs.powid  := left.powid,
																														self.BusinessIDs.empid  := left.empid,
																														self.BusinessIDs.dotid  := left.dotid,				
																														self.Source  						:= left.Source,
																														self.idValue 						:= left.source_docid,
																														self.idType  						:= TopBusiness_Services.Constants.busvlid,
																														self.section 						:= TopBusiness_Services.Constants.ContactSectionname,
																														self.address 						:= [],
																														self.name 							:= [],
																														self 										:= left)),in_sourceDocMaxCount);
                      self := left));
											
		rolled_ds_dedup := dedup(sort(rolled_ds,acctno,
																	#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	did, 
																	name_last, name_first, name_middle, name_suffix, -position_title, 
																	-date_last_seen, -date_first_seen,
																	if (address.state <> '', 0, 1)),
														acctno,
														#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
														did, 
														name_last, name_first, name_middle, name_suffix, position_title, 
														date_last_seen, date_first_seen);
		// rolled_ds_dedup with 0 dids will be last in the group..Also reverse sort on -position_title -date_last_seen and -date_first_seen
		// also has the effect of bringing recs with actual dates to the top and brings along the
		//isExecutive, isCurrent boolean to the top cause recs with no position_title sort to the bottom															
		temppositionrec := record
			rolled_ds_dedup.position_title;			
			rolled_ds_dedup.isExecutive;
			rolled_ds_dedup.isCurrent;
			rolled_ds_dedup.date_first_seen;
			rolled_ds_dedup.date_last_seen;
		end;
		
		prep_unroll :=			project(dedup(sort(rolled_ds_dedup,acctno,
																			#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			position_type,name_last,nickname,name_middle,name_suffix,position_title,
																			-did,
																			date_last_seen, 
																			date_first_seen), 
																acctno,
																#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																position_type,name_last,nickname,name_middle,name_suffix,position_title,
																did,
																date_last_seen, 
																date_first_seen),
													transform(recordof(left),
														self.position_title := if(left.position_type = TopBusiness_Services.Constants.POSITION_TYPE_REGISTERED_AGENT,'REGISTERED AGENT',left.position_title),
														self := left));
				
		prep_roll1Group :=	group(	prep_unroll,acctno,
																#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																position_type,name_last,nickname,name_middle,name_suffix,position_title);
		
		prep_roll1 			:=	rollup( prep_roll1Group,	group,
													transform(recordof(left),
														self.date_last_seen := max(rows(left)(date_last_seen <> 0),date_last_seen),
														self.date_first_seen := min(rows(left)(date_first_seen <> 0),date_first_seen),
														self.IsCurrent := count(rows(left)(isCurrent)) > 0,
														self.did := max(rows(left),did),
														self := left));

		// This ensures that we don't roll all non-DIDed entities together into a single entry.
		prep_roll2 := 			rollup( group( sort(prep_roll1,acctno,
																						#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																						position_type,did,
																						if(did = 0,name_last + nickname,''),
																						position_title,
																						-length(trim(name_first,left,right)),
																						-length(trim(name_suffix, left, right))),
															acctno,				
															#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															position_type,did != 0,
															did,if(did = 0,name_last + nickname,''),
															position_title),
															group,
															transform(recordof(left),
																self.date_last_seen 	:= max(rows(left)(date_last_seen <> 0),date_last_seen),
																self.date_first_seen 	:= min(rows(left)(date_first_seen <> 0),date_first_seen),
																self.IsCurrent 				:= exists(rows(left)(isCurrent)),
																self := left));
																
		tmp_prep := 				rollup(group(sort(prep_roll2,
																					acctno,
																					#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																					position_type,
																					did,
																					if(did = 0,name_last + nickname,''),
																					-length(name_first),
																					-length(name_suffix),
																					if (isCurrent,0,1)),
															acctno,				
															#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),				
															position_type,
															did != 0,
															did,
															if(did = 0,name_last + nickname,'')),				                                           
															group,
															transform({recordof(left) - temppositionrec;dataset(temppositionrec) positions;},
																self.positions 	:= project(rows(left),temppositionrec),
																self 						:= left));
				   
		layout_derog_bools_contact := record
			recordof(tmp_prep);
			boolean bkFlag;
			boolean liensFlag;
			boolean foreClosureFlag;
			boolean nodFlag;
			boolean deathFlag;
			unsigned executiveElsewhere;
			boolean HasCriminalConviction;
			boolean IsSexualOffender;
		end;
				
		personinfoBk 					:= join(tmp_prep, BankruptcyV3.key_bankruptcyv3_did(),
																	keyed(left.did=right.did),
																	transform(layout_derog_bools_contact,
																		self.bkflag := right.did != 0,
																		self := left,
																		self := []), 
																		left outer, keep(1));
														
		PersonInfoLien 				:= join(personInfoBk,LiensV2.key_liens_DID,
																	keyed(left.did= right.did), 
																	transform(layout_derog_bools_contact,
																	 self.liensFlag := right.did != 0,
																	 self := left,
																	 self := []),
																	 left outer, keep(1));

		PersonInfoForeclosure := join(personInfoLien,dx_Property.Key_Foreclosure_DID,
																	keyed(left.did= right.did), 
																	transform(layout_derog_bools_contact,
																		self.foreclosureFlag := right.did != 0,
																		self := left,
																		self := []),
																		left outer, keep(1));
																		
		PersonInfoNOD 				:= join(personInfoForeclosure,dx_Property.Key_NOD_DID,
																	keyed(left.did= right.did), 
																	transform(layout_derog_bools_contact,
																		self.nodFlag := right.did != 0,
																		self := left), 
																		left outer, keep(1));
		// right side has all non zero contact_did's.
		// this key is not restricted (i.e. filtering DNB DMI (source =D) but report is not displaying data
		// as a result of what this key returns so the lack of data restriction is not an issue.
		
		// adding join condition of left.seleid <> right.seleid so as to keep at least 1 seleid
		// of a contact who exists in another seleid based business. to fix a bug.
		contactElsewhere  := sort(dedup(sort(join(PersonInfoNOD,BizLinkFull.Key_BizHead_L_CONTACT_DID.key,
																							keyed(left.did = right.contact_did) and
																							left.seleid <> right.seleid,
																							transform(right),limit(0),keep(1)), 
																		contact_did,
																		#expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
															contact_did, 
															#expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
												 contact_did,record);

		// this join establishes if a person is an executive at another company other than 
		// the one the current report is being run on and sets a non zero value if so -- a flag on the GUI
		// to show an indicator for the particular person contact.
		// note : no keyed fields on this join.

		PersonInfoExec 		:=	join(	personInfoNOD, contactElsewhere,
																left.did = right.contact_did and
																left.seleid <> right.seleid,											 											
																transform(recordof(left),
																	IsExec := project(left.positions,transform({boolean isExecutive;},
																																		self := left))(isExecutive = true);
																	self.executiveElsewhere := if (left.did <> 0 and exists(IsExec) ,right.seleid,0),
																	self := left),
																left outer, keep(1));
																		 
		string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(autostandardi.globalModule(), AutoStandardI.InterfaceTranslator.ssn_mask_val.params));      														 

		AKAs_DOD := deathv2_services.raw.get_report.FROM_DIDS(project(PersonInfoExec,
																														transform({unsigned6 did},
																															self.did := left.did)), ssn_mask_value);
		personInfoDeath 	:=	join(	PersonInfoExec, akas_dod,
																left.did = (unsigned6) right.did,
																transform(layout_derog_bools_contact,
																	self.deathFlag := ((unsigned6) right.did) != 0,
																	self := left),
																left outer, keep(1));
																
		recsIn := PROJECT(personInfoDeath,TRANSFORM({layout_derog_bools_contact,unsigned6 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT,SELF:=[]));
		CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
		crimIndicatorRecsOut := if(in_options.IncludeCriminalIndicators,recsOut,recsIn);

		prep	:=	crimIndicatorRecsOut(name_last <> ''); // bug # 122044. filter added to weed out rows of no name information

    Others:= 	project(prep(position_type = TopBusiness_Services.Constants.POSITION_TYPE_OTHERS),
								transform({	dedup_sorted_raw_data_3.isCurrent;
														dedup_sorted_raw_data_3.acctno;	
														dedup_sorted_raw_data_3.ultid;
														dedup_sorted_raw_data_3.orgid;
														dedup_sorted_raw_data_3.seleid;
														dedup_sorted_raw_data_3.proxid;
														dedup_sorted_raw_data_3.powid;
														dedup_sorted_raw_data_3.empid;
														dedup_sorted_raw_data_3.dotid;															 
														iesp.topbusinessReport.t_TopBusinessIndividual;},
									temp_positions := project(choosen(sort( project(left.positions (position_title <> '' and date_last_seen <> 0 and date_first_seen <> 0),
																														transform({boolean IsCurrent; iesp.topbusinessReport.t_TopBusinessPosition;},
																															 self.companyTitle := left.position_title,        															
																															 self.FromDate := iesp.ecl2esp.ToDate(left.date_first_seen),
																															 self.ToDate := iesp.ecl2esp.ToDate(left.date_last_seen),															 
																															 self := left)),
																												if (CompanyTitle <> '', 0,1),
																												if (isCurrent,0,1),record),
																										iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_POSITION_RECORDS),
																						iesp.topbusinessReport.t_TopBusinessPosition);
									self.BestPosition := temp_positions[1],
									self.OtherCurrents := [],
									self.AllOthers := [],
									// The ExecutiveElsewhere flag indicates whether the individual is or was an
									// executive at another business.
									self.ExecutiveElsewhere := left.executiveElsewhere,																 
									self.Name  := iesp.ecl2esp.setname(left.name_first, left.name_middle, left.name_last, left.name_suffix, left.name_prefix, ''),		
									self.Address := left.address,
									// all these 5 booleans set above in personInfoDeath attr and several attrs before that
									self.IsDeceased := left.deathFlag,
									self.HasDerog := left.bkFlag OR left.liensFlag OR left.foreclosureFlag OR left.nodFlag,
									self.UniqueID := (string12) left.did,
									self.isCurrent := exists(left.positions(isCurrent)),
									self := left,
									self := []));						

		// project keep track of existing executive indicators and current Indicators as it builds the different datasets.
		// mapping different projects allow on the fly calculation of the 'OtherCurrents' and 'AllOthers'.

		individuals := project(prep(position_type = TopBusiness_Services.Constants.POSITION_TYPE_CURRENT), 
										transform({	dedup_sorted_raw_data_3.isCurrent;
																dedup_sorted_raw_data_3.isExecutive;									
																dedup_sorted_raw_data_3.position_type;
																dedup_sorted_raw_data_3.acctno;	
																dedup_sorted_raw_data_3.ultid;
																dedup_sorted_raw_data_3.orgid;
																dedup_sorted_raw_data_3.seleid;
																dedup_sorted_raw_data_3.proxid;
																dedup_sorted_raw_data_3.powid;
																dedup_sorted_raw_data_3.empid;
																dedup_sorted_raw_data_3.dotid;															
																iesp.topbusinessReport.t_TopBusinessIndividual;},
											tmpExec := exists(left.positions(isExecutive));
											self.isExecutive := tmpExec,
											tempCurrent := if(self.isExecutive,exists(left.positions(isExecutive and isCurrent)),exists(left.positions(isCurrent)));
											self.isCurrent := tempCurrent,
											temp_positions := sort( project(left.positions ,
																								transform({boolean IsCurrent; boolean IsExecutive; iesp.topbusinessReport.t_TopBusinessPosition;},
																								 self.companyTitle := left.position_title,        															
																								 self.FromDate := iesp.ecl2esp.ToDate(left.date_first_seen),
																								 self.ToDate := iesp.ecl2esp.ToDate(left.date_last_seen),
																								 self.isCurrent := left.isCurrent,
																								 self := left)),
																				if (isExecutive, 0, 1),
																				if (isCurrent,0,1), 
																				if (CompanyTitle <> '', 0,1),  
																				record); // sort criteria
											self.BestPosition := project(map( self.isExecutive and self.isCurrent => temp_positions(IsExecutive and IsCurrent),			
																												self.isExecutive => temp_positions(IsExecutive),
																												/* otherwise => */ temp_positions), 
																									iesp.topbusinessReport.t_TopBusinessPosition)[1],
											self.OtherCurrents := map(self.isExecutive and self.isCurrent =>
																									sort(project(choosen(temp_positions(IsCurrent and companytitle != self.BestPosition.companytitle),
																																			iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_POSITION_RECORDS),
																															iesp.topbusinessReport.t_TopBusinessPosition), 
																											-ToDate.year,
																											-ToDate.Month,
																											-ToDate.Day),
																								/* otherwise => */ dataset([],iesp.topbusinessReport.t_TopBusinessPosition)),
											self.AllOthers := map(self.isExecutive and self.isCurrent =>
																							sort(project(choosen(temp_positions(not IsCurrent),
																																	iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_POSITION_RECORDS),
																									iesp.topbusinessReport.t_TopBusinessPosition),
																							-ToDate.year,
																							-ToDate.Month,
																							-ToDate.Day),
																						self.isExecutive => 
																							sort(project(choosen(temp_positions(companytitle != self.BestPosition.companytitle),
																																	iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_POSITION_RECORDS),
																													iesp.topbusinessReport.t_TopBusinessPosition),
																									-ToDate.Year, 
																									-ToDate.Month,
																									-ToDate.Day), 
																						/* otherwise => */ choosen(project(temp_positions(companytitle != self.BestPosition.companytitle and not IsCurrent),				                           
																																							iesp.topbusinessReport.t_TopBusinessPosition),
																																			iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_POSITION_RECORDS)
																						), //Ends Map
			
											// The ExecutiveElsewhere flag indicates whether the individual is or was an executive at another business.
											self.ExecutiveElsewhere := left.executiveElsewhere,
											self.Name := iesp.ecl2esp.setname(left.name_first, left.name_middle, left.name_last, left.name_suffix, left.name_prefix, ''),		
											self.Address := left.address,
											// all these 5 booleans set above in personInfoDeath attr and several attrs before that
											self.IsDeceased := left.deathFlag,
											self.HasDerog := left.bkFlag OR left.liensFlag OR left.foreclosureFlag OR left.nodFlag,
											self.HasCriminalConviction := left.HasCriminalConviction;
											self.IsSexualOffender := left.IsSexualOffender;
											self.uniqueID := (string12) left.did,
											self.ssn := left.ssn,
											self.SourceDocs := if (tempCurrent and tmpExec, choosen(dedup(left.ContactSourceDocs,all), in_sourceDocMaxCount)),
											self := left,
										) //End of Transform
									); //End of individuals Project
				 
	 	Suppress.MAC_Mask(individuals, individuals_supressed, ssn, blank, true, false);
		// Roll up into a section
		Add_contactsAll := dedup(ds_in_data,acctno, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), all);
		
    // adding here.
	   TopBusiness_Services.ContactSection_Layouts.rec_final ContactsXform() := TRANSFORM
		          self.acctno := Add_contactsAll[1].acctno,
							 self.PriorContactCount 			:=	if( count(individuals_supressed(IsCurrent=false and isExecutive=false)) > iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														count(individuals_supressed(IsCurrent=false and isExecutive=false)) 
																													),
												self.TotalPriorContactCount :=	count(individuals_supressed(IsCurrent=false and isExecutive=false)),
												self.CurrentContactCount 		:=	if( count(individuals_supressed(IsCurrent=true and isExecutive=false)) > iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														count(individuals_supressed(IsCurrent=true and isExecutive=false))
																													),
												self.TotalCurrentContactCount :=count(individuals_supressed(IsCurrent=true and isExecutive=false)),
												self.PriorExecutivecount 			:=if(	count(individuals_supressed(IsCurrent=false and isExecutive=true)) > iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														count(individuals_supressed(IsCurrent=false and isExecutive=true))
																													),
												self.TotalPriorExecutiveCount := count(individuals_supressed(IsCurrent=false and isExecutive=true));
												self.CurrentExecutiveCount 		:= if(count(individuals_supressed(IsCurrent=true and isExecutive=true)) >
																														iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS,
																														count(individuals_supressed(IsCurrent=true and isExecutive=true)) 
																														),
												self.TotalCurrentExecutiveCount := count(individuals_supressed(IsCurrent=true and isExecutive=true)),
												self.PriorIndividuals	:= choosen(project(sort(individuals_supressed(IsCurrent=false and IsExecutive=false),
																																		 Name.Last, 
																																		 Name.First,
																																		 Name.Middle,
																																		 record),
																																iesp.topbusinessReport.t_TopBusinessIndividual),
																												iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS),		
												self.CurrentIndividuals := choosen(project(sort(individuals_supressed(IsCurrent=true and IsExecutive=false), 
																																				Name.Last, 
																																				Name.First,
																																				Name.Middle,
																																				record),
																																	iesp.topbusinessReport.t_TopBusinessIndividual),
																													iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS),	
												self.CurrentExecutives	:= choosen(project(sort(individuals_supressed(IsCurrent=true and IsExecutive=true), 
																																				Name.Last, 
																																				Name.First,
																																				Name.Middle,
																																				record),
																																	iesp.topbusinessReport.t_TopBusinessIndividual),
																													iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS),
												self.PriorExecutives := choosen(project(sort(individuals_supressed(IsCurrent=false and IsExecutive=true), 
																																		 Name.Last, 
																																		 Name.First, 
																																		 Name.Middle,
																																		 record),
																																iesp.topbusinessReport.t_TopBusinessIndividual),
																												iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS),	      													 
												self.CurrentSourceDocs := if(exists(individuals_supressed(isCurrent)), 
																											choosen(project(individuals_supressed(isCurrent and isExecutive).SourceDocs,
																																transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
																																	self := left)), 
																															in_sourceDocMaxCount)
																										),
												self := [];
                    
     END;  
	   add_contacts := dataset([ ContactsXform() ]);
		 
		final_results :=	denormalize(add_contacts,others, 
												left.acctno = right.acctno,
												group,
												transform(recordof(left),
													self.OtherAssociatedPersonCount := count(rows(right)),
													self.OtherAssociatedPersons 		:= choosen(project(sort(rows(right), 
																																									Name.Last, 
																																									Name.First, 
																																									name.Middle,
																																									record),
																																						 iesp.topbusinessReport.t_TopBusinessIndividual),
																																		iesp.constants.TopBusiness.MAX_COUNT_BIZRPT_CONTACT_RECORDS),
													self := left));
		
		// output(count(ds_quickheader_contactsRaw), named('count_ds_quickheader_contactsRaw'));
		// output(choosen(ds_quickheader_contactsRaw,5000), named('ds_quickheader_contactsRaw'));		 
		// output(ds_all_contactsRestricted, named('ds_all_contactsRestricted'));		 
		// output(sorted_raw_data, named('sorted_raw_data'));
		// output(sorted_raw_data_3, named('sorted_raw_data_3'));		
		// output(dedup_sorted_raw_data_3, named('dedup_sorted_raw_data_3'));
		// output(tmp_ds, named('tmp_ds'));		 
		// output(rolled_ds, named('rolled_ds'));
		// output(rolled_ds_dedup, named('rolled_ds_dedup'));
		// output(prep_unroll, named('prep_unroll'));
		// output(prep_roll1Group, named('prep_roll1Group'));
		// output(prep_roll1, named('prep_roll1'));
		// output(prep_roll2, named('prep_roll2'));
		// output(tmp_prep, named('tmp_prep'));	
		// output(personinfoBk, named('personinfoBk'));	
		// output(PersonInfoLien, named('PersonInfoLien'));	
		// output(PersonInfoForeclosure, named('PersonInfoForeclosure'));	
		// output(PersonInfoNOD, named('PersonInfoNOD'));
		// output(contactElsewhere, named('contactElsewhere'));
		// output(PersonInfoExec, named('PersonInfoExec'));		 		 	
		// output(personInfoDeath, named('personInfoDeath'));	
		// output(prep, named('prep')); 		
		// output(Others, named('Others')); 		
		// output(individuals, named('individuals'));
		// output(add_contacts, named('add_contacts'));
		// output(individuals_supressed, named('individuals_supressed'));
		// output(final_results, named('final_results'));
		
	 return final_results; 
	end; // function.
end; // module