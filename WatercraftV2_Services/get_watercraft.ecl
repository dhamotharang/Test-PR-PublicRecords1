IMPORT doxie, codes, fcra, ut, FFD;

EXPORT get_watercraft(dataset(WatercraftV2_Services.Layouts.search_watercraftkey) in_watercraftkeys, 
											string in_ssn_mask_type = '',
											boolean isFCRA = false,
											dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
											boolean include_non_regulated_sources = false,
											dataset(FFD.Layouts.PersonContextBatchSlim ) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
											integer8 inFFDOptionsMask = 0) := MODULE

	shared layout_w_key_plus_rec := WatercraftV2_Services.Layouts.w_key_plus_rec;
	shared layout_c_key_plus_rec := WatercraftV2_Services.Layouts.c_key_plus_rec;
	
	shared owner_key_recs := WatercraftV2_Services.get_owner_records(in_watercraftkeys, IsFCRA, flagfile, include_non_regulated_sources, slim_pc_recs, inFFDOptionsMask);
	/*
	Because all searches seem to start with owners, the owner records search only seems to require a watercraft_key, not a state_origin 
	or a sequence_key.  In fact, the owners search will return ALL possibilities if those two fields are blank. But when they are blank,
	the coastguard and detail record searches are incorrect because they don't have the two key fields. So once the owners search
	has completed, we will need to extract a new dataset for the "in_watercraftkeys" that is built from the owner_key_recs. 
	See https://jira.rsi.lexisnexis.com/browse/DF-18665 for the details
	*/
	shared newSearchWatercraftKeys := DEDUP(SORT(PROJECT(owner_key_recs, WatercraftV2_Services.Layouts.search_watercraftkey), RECORD), RECORD);

	shared details_key_recs := WatercraftV2_Services.get_detail_records(newSearchWatercraftKeys, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
	shared coast_key_recs := WatercraftV2_Services.get_coastguard_records(newSearchWatercraftKeys, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);

	//********* REPORT VIEW FUNCTION
	EXPORT report(boolean isReport = false) := FUNCTION

			doxie.MAC_Header_Field_Declare(IsFCRA); //TODO: only (!) for DateVal
			
			wOwners_report := WatercraftV2_Services.get_owners(owner_key_recs, in_ssn_mask_type, IsFCRA).report(isReport);

			layout_report_w_extra_info := WatercraftV2_Services.Layouts.WCReportEX;

			WatercraftV2_Services.Layouts.owner_report_rec xformGender(WatercraftV2_Services.Layouts.owner_report_rec l) := transform
					self.gender := CASE(l.gender,
															'M' => 'MALE',
															'F' => 'FEMALE',
															'B' => 'BUSINESS',
															'');
					self :=l;		
			end;

			layout_report_w_extra_info get_coastguard(WatercraftV2_Services.Layouts.int_raw_rec l, layout_c_key_plus_rec r) := transform
				self.state_origin_full :=codes.GENERAL.STATE_LONG(l.state_origin);
				self.owners := project(l.owners,xformGender(left));
				self.NonDMVSource := l.NonDMVSource;
				self :=l;		
				self := r;  // StatementIds get assigned here
				self :=[];
			end;

			coast_recs := join (wOwners_report, coast_key_recs,
													(left.subject_did = right.subject_did) and 
													(left.state_origin = right.state_origin) and
													(left.watercraft_key = right.watercraft_key) and
													(left.sequence_key = right.sequence_key), 
													get_coastguard(left,right), left outer);

			layout_report_w_extra_info get_main(layout_report_w_extra_info l, layout_w_key_plus_rec r) := transform
				self.watercraft_key := l.watercraft_key;
				self.sequence_key := l.sequence_key;
				self.state_origin := l.state_origin;
				self.NonDMVSource := l.NonDMVSource;
				self.rec_type := case(r.history_flag, '' => 'Current',
																							'E' => 'Expired',
																							'H' => 'Historical',
																							'');
				self.lienholders :=dataset([{r.lien_1_name,r.lien_1_address_1,r.lien_1_address_2,r.lien_1_city,
																			r.lien_1_state,r.lien_1_zip,r.lien_1_date,r.lien_1_indicator},
																			{r.lien_2_name,r.lien_2_address_1,r.lien_2_address_2,r.lien_2_city,
																			r.lien_2_state,r.lien_2_zip,r.lien_2_date,r.lien_2_indicator}],WatercraftV2_Services.layouts.lien_rec)
																			(lien_name<>'' or lien_address_1<>'' or lien_address_2 <>'');
				self.engines := dataset([{r.watercraft_hp_1,r.engine_make_1,r.engine_model_1,r.engine_number_1,r.engine_year_1,r.watercraft_number_of_engines},
																 {r.watercraft_hp_2,r.engine_make_2,r.engine_model_2,r.engine_number_2,r.engine_year_2,r.watercraft_number_of_engines},
																 {r.watercraft_hp_3,r.engine_make_3,r.engine_model_3,r.engine_number_3,r.engine_year_3,r.watercraft_number_of_engines}],
																 WatercraftV2_Services.Layouts.engine_rec)
																 (watercraft_hp <> '' or engine_make <> '' or engine_model <> '');			
				self.hull_number := if(l.hull_number <> '',l.hull_number,r.hull_number);
				self.name_of_vessel :=if(r.watercraft_name<> '',r.watercraft_name,l.name_of_vessel);
				self.isDisputed := l.isDisputed or r.isDisputed;
				self.StatementIds := l.statementids + r.statementids;
				self := r; //fields from the right with the same name as left side are empty on the left side and getting filled from w_key, except for fields named above.
				self := l; //fields we wish to retain from the left side do not overlap the right side, except for fields named above.
			end;

			wLiens_engines := join(coast_recs, details_key_recs,
														(left.subject_did = right.subject_did) and
														(left.state_origin = right.state_origin) and
														(left.watercraft_key = right.watercraft_key) and
														(left.sequence_key = right.sequence_key) and
														(dateVal=0 or (unsigned3) right.purchase_date[1..6] <= dateVal),
														get_main (left, right), left outer);
		
		layout_report_w_extra_info fullrecroll(layout_report_w_extra_info l,dataset(layout_report_w_extra_info) r)
				:=transform
				self.lienholders := choosen(Normalize(r,left.lienholders,Transform(RIGHT)),ut.limits.MAX_WATERCRAFT_LH);
				self.engines := choosen(Normalize(r,left.engines,Transform(RIGHT)),ut.limits.MAX_WATERCRAFT_ENGINES);
				
				self :=l;   // we only need the owners from the left side because every record to be rolled up will have
										// the same owners
			END;
						
			sorted_wLiens_engines := sort(wLiens_engines,subject_did,state_origin,watercraft_key,sequence_key);
			rolledres :=rollup(group(sorted_wLiens_engines,subject_did,state_origin,watercraft_key,sequence_key),group,fullrecroll(left,rows(left)));
			
			layout_report_w_extra_info sortchildren(layout_report_w_extra_info l):=transform
				self.owners := dedup(sort(l.owners,lname,fname,company_name,record),record);
				self.lienholders :=dedup(sort(l.lienholders,record),record);
				self.engines :=dedup(sort(l.engines,engine_year,record),record);
				self := l;
			end;

			res := project(dedup(sort(rolledres,penalt,watercraft_key,-sequence_key,state_origin, -date_last_seen,record),record) ,sortchildren(left));

			return res;
				
	end;

	//********* SEARCH VIEW FUNCTION
	EXPORT search() := FUNCTION	
	
			outrec := WatercraftV2_Services.Layouts.search_out;			

			wOwners_search := WatercraftV2_Services.get_owners(owner_key_recs, in_ssn_mask_type, isFCRA).search();
			
			outrec get_hull(outrec le, layout_c_key_plus_rec ri):=transform
				self.hull_number :=ri.hull_number;
				self.watercraft_name := ri.name_of_vessel;
				self.StatementIDs := ri.StatementIDs;
				self.isDisputed 	:= ri.isDisputed;
				self := le;
			END;

			with_hullnum :=join(wOwners_search, coast_key_recs,
													(left.subject_did = right.subject_did) and 
													(left.state_origin=right.state_origin) and
													(left.watercraft_key =right.watercraft_key) and
													(left.sequence_key =right.sequence_key) and
													(right.name_of_vessel <> '' or right.hull_number <> ''),
													get_hull(left,right),
													Left Outer,keep(1),limit(0));									
			
			outrec get_watercraft_name(outrec le, layout_w_key_plus_rec ri):=transform
				self.watercraft_name 			:= if(ri.watercraft_name<> '',ri.watercraft_name,le.watercraft_name);
				self.hull_number 					:= if(le.hull_number <> '',le.hull_number,ri.hull_number);
				self.registration_number 	:= ri.registration_number;
				self.registration_date 		:= ri.registration_date;
				self.Make 								:= ri.watercraft_make_description;
				self.Model 								:= ri.watercraft_model_description;
				self.YearMake 						:= (integer)ri.model_year;
				self.MajorColor 					:= ri.watercraft_color_1_description;
				self.MinorColor 					:= ri.watercraft_color_2_description;
				self.watercraft_length		:= (unsigned2) ri.watercraft_length;
				self.engines 							:= dataset([{ri.watercraft_hp_1,ri.engine_make_1,ri.engine_model_1,ri.engine_number_1,ri.engine_year_1,ri.watercraft_number_of_engines},
																							{ri.watercraft_hp_2,ri.engine_make_2,ri.engine_model_2,ri.engine_number_2,ri.engine_year_2,ri.watercraft_number_of_engines},
																							{ri.watercraft_hp_3,ri.engine_make_3,ri.engine_model_3,ri.engine_number_3,ri.engine_year_3,ri.watercraft_number_of_engines}],
																							WatercraftV2_Services.layouts.engine_rec)(watercraft_hp <> '' or engine_make <> '' or engine_number <> '');
				self.StatementIDs 				:= ri.StatementIDs + le.StatementIDs;
				self.isDisputed 					:= ri.isDisputed OR le.isDisputed;
				self := le;
			END;	

			res :=	join(with_hullnum, details_key_recs,  
									(left.subject_did = right.subject_did) and 
									(left.state_origin		=	right.state_origin) and
									(left.watercraft_key 	=	right.watercraft_key) and
									(left.sequence_key 		=	right.sequence_key) and
									(right.watercraft_name <>'' or right.registration_date <>'' or right.registration_number<>''),
									get_watercraft_name(left,right),
									Left Outer, keep(1),limit(0));

			return res;
	END;
END;