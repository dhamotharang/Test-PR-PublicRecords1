IMPORT FLAccidents_Ecrash, ut, doxie,lib_stringlib,std, iesp;

EXPORT Raw(IParam.searchrecords in_mod) := MODULE
		shared 	accnbr_key:=FLAccidents_Ecrash.key_EcrashV2_accnbrV1;
		shared 	dol_key:=FLAccidents_Ecrash.key_EcrashV2_dol;
		shared 	partial_accnbr_key := FLAccidents_Ecrash.Key_EcrashV2_Partial_Report_Nbr;
		shared 	location_key := FLAccidents_Ecrash.Key_eCrashv2_StAndLocation;
		shared  preferredName_key := FLAccidents_Ecrash.Key_eCrashv2_PrefName_State;
		shared reportLinkKey := FLAccidents_Ecrash.Key_eCrashv2_ReportLinkId;
		shared lastName_key := FLAccidents_Ecrash.Key_EcrashV2_LastName;
		
		shared hasJurisdictionInfo := in_mod.JurisdictionState <> '' and in_mod.Jurisdiction <> '';
		
		shared boolean containsReportNumber (string src, string report_in) := (report_in = '') or (StringLib.StringFind (src, report_in, 1) >0); //Input report number is already 'cleaned'
		
		shared tmp_dtrange_rec := record
				string8 daterange;
		end;
		
		//BAP
		EXPORT 	by_auto_recs() := FUNCTION
				RETURN autokey_ids(project(in_mod,IParam.autokey_search));
		END;
		EXPORT by_rpt_num() := FUNCTION				
				Layouts.search tmp_xform():=TRANSFORM
					self.reportnumber := in_mod.reportnumber;
					self.isdeepdive:=false;
				END;
				RETURN DATASET([tmp_xform()]);
		END;
		
		EXPORT byReportNumber(dataset(Layouts.search) ids_raw_in) := FUNCTION
							
				rpn_recs_res1:= join(ids_raw_in,accnbr_key,
													keyed(right.l_accnbr=left.reportnumber) and
													keyed(right.report_code in constants.ecrash_src_codes) and
													if(in_mod.RequestHashKey,(right.agency_ori = in_mod.AgencyORI and right.image_hash<>''),right.jurisdiction<>''),
													transform(recordof(accnbr_key),
													self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
				// TODO: a hack to return some meaningful response in a case of (incorrectly created) test data;
				//       an error-message is not very appropriate: rather should be something like "too much data associated with an object"
				
				rpn_recs_res_w_jur:= join(ids_raw_in,accnbr_key,
													keyed(right.l_accnbr=left.reportnumber) and
													keyed(right.report_code in constants.ecrash_src_codes) and
													keyed(right.jurisdiction_state = in_mod.jurisdictionState) and
													keyed(right.jurisdiction = in_mod.jurisdiction) and
													if(in_mod.RequestHashKey,(right.agency_ori = in_mod.AgencyORI and right.image_hash<>''), true),
													transform(recordof(accnbr_key),
													self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
				
				rpn_recs_res := if(hasJurisdictionInfo,
													 rpn_recs_res_w_jur,
													 rpn_recs_res1);

        										 
				RETURN rpn_recs_res;
		END;
		
		EXPORT byPartialReportNumber(dataset(tmp_dtrange_rec) ds_date_range, boolean hasInputDOL) := FUNCTION
				boolean isPartial := length(in_mod.reportnumber) = 4;
				partial_report_number := if(isPartial, in_mod.reportnumber, in_mod.reportnumber[1..4]);
				
				Layouts.search tmp_xform_partial():=transform
					self.reportnumber := partial_report_number;
					self.isdeepdive:=false;
				end;
				by_partial_rptNum := dataset([tmp_xform_partial()]);
		
				Layouts.search xformToAccnbr(partial_accnbr_key R):=transform
					self.reportnumber := R.l_accnbr;
					self.isdeepdive:=false;
				end;
		//BAP - kevin says needs cleanup, but not yet.
				partial_rpn_recs_res1:= join(by_partial_rptNum,partial_accnbr_key,
													keyed(right.partial_report_nbr=left.reportnumber) and
													keyed(right.report_code in constants.ecrash_src_codes) and 
													keyed (right.jurisdiction != '') and
													wild (right.jurisdiction_state) and
													wild (right.accident_date) and
													(Constants.valid_match(right.jurisdiction_state,in_mod.JurisdictionState)) and 
													(Constants.valid_match(stringlib.stringtouppercase(right.jurisdiction),in_mod.jurisdiction)),
													xformToAccnbr(right),limit(constants.MAX_PARTIAL_NUMBER, fail(203, doxie.ErrorCodes(203))));
										
				partial_rpn_recs_res_w_jur:= join(by_partial_rptNum,partial_accnbr_key,
													keyed(right.partial_report_nbr=left.reportnumber) and
													keyed(right.report_code in constants.ecrash_src_codes) and
													keyed(right.jurisdiction_state = in_mod.jurisdictionState) and
													keyed(right.jurisdiction = in_mod.jurisdiction),
													xformToAccnbr(right),limit(constants.MAX_PARTIAL_NUMBER, fail(203, doxie.ErrorCodes(203))));
													
				partial_recs := if(hasJurisdictionInfo, partial_rpn_recs_res_w_jur, partial_rpn_recs_res1);
				
				partial_rpn_recs_w_fuzzydol:=	join(ds_date_range, partial_accnbr_key,
																				keyed (right.partial_report_nbr=partial_report_number) and 
																				keyed (right.report_code in constants.ecrash_src_codes) and 
																				keyed (right.accident_date=left.daterange) and
																				keyed (right.jurisdiction != '') and
																				wild (right.jurisdiction_state) and
																				(Constants.valid_match(right.jurisdiction_state,in_mod.JurisdictionState)) and 
																				(Constants.valid_match(stringlib.stringtouppercase(right.jurisdiction),in_mod.jurisdiction)),
																				xformToAccnbr(right),limit(Constants.MAX_ACCIDENTS_PER_DAY, fail(203, doxie.ErrorCodes(203))));
																				
				partial_rpn_recs_res := if(hasInputDOL, partial_rpn_recs_w_fuzzydol, partial_recs);
				
				filter_partial_rpn_res := if(isPartial,
																			partial_rpn_recs_res,
																			partial_rpn_recs_res(containsReportNumber(reportnumber, in_mod.reportnumber)));
				
				dup_partial_recs := dedup(sort(filter_partial_rpn_res, reportnumber), reportnumber);
				//BAP above indexes have no payload so they use the byReportNumber to lookup payload
				partial_rpn_res := byReportNumber(dup_partial_recs);
				
				RETURN partial_rpn_res;
		END;
			
	EXPORT byDOL(string start_date, string end_date) := FUNCTION
		
			// TODO: set limit for exact date of loss + filters match
			
			in_jurisdiction := stringlib.stringtouppercase(in_mod.jurisdiction);
			in_jurisdiction_state := stringlib.stringtouppercase(in_mod.JurisdictionState);
			
			dol_recs:=	dol_key(keyed (accident_date=in_mod.dateofloss) and 
													keyed (report_code in constants.ecrash_src_codes) and 
													keyed (in_jurisdiction = '' or jurisdiction = in_jurisdiction) and
													keyed (in_jurisdiction_state = '' or jurisdiction_state = in_jurisdiction_state));
													
																		
			dol_fuzzy_recs := dol_key(keyed (accident_date between start_date and end_date) and 
																 keyed (report_code in constants.ecrash_src_codes) and 
																 keyed (in_jurisdiction = '' or jurisdiction = in_jurisdiction) and
																 keyed (in_jurisdiction_state = '' or jurisdiction_state = in_jurisdiction_state));
																 
			
			dol_recs_temp := IF(EXISTS(dol_recs), dol_recs, dol_fuzzy_recs);
			
			dol_fuzzy_recs_filtered :=	LIMIT(dol_recs_temp,2000,fail(203, doxie.ErrorCodes(203)));
																
			final_dol_fuzzy_recs := join(dol_fuzzy_recs_filtered,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
			RETURN final_dol_fuzzy_recs;
																
		END;
		
	EXPORT byLocation() := FUNCTION
			CrossStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationCrossStreet);
			LocStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationStreet);
			start_date := in_mod.DolStartdate;
			end_date := in_mod.DolEnddate;
			DateOfLoss := in_mod.DateOfLoss;

			loc_recs :=	location_key(keyed ((CrossStreet <> '' AND partial_accident_location[1..LENGTH(TRIM(CrossStreet))] = CrossStreet) OR
				                              (LocStreet <> '' AND partial_accident_location[1..LENGTH(TRIM(LocStreet))] = LocStreet)) and
															 keyed (in_mod.JurisdictionState = '' or jurisdiction_state=in_mod.JurisdictionState) and 
							                 keyed (in_mod.jurisdiction = '' or jurisdiction=in_mod.jurisdiction) and
															 (start_date = '' or (accident_date between start_date and end_date)) and
															 (DateOfLoss = '' or accident_date = DateOfLoss)
															 );
		 
			//7k limit is used because on average if we have more then 7k records here then we run into a memory limit exhausted in recs_raw_dupe join in Records file
			//which is something we need to look at.
			filtered_loc_recs := Limit(loc_recs,7000,fail(203, doxie.ErrorCodes(203)));
			
			loc_recs_exact := join(filtered_loc_recs,accnbr_key,
													keyed(right.l_accnbr=left.accident_nbr) and
													keyed(right.report_code in constants.ecrash_src_codes) and
													keyed(right.jurisdiction_state = left.jurisdiction_state) and
													keyed(right.jurisdiction = left.jurisdiction),
													transform(recordof(accnbr_key),
													self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
													
			RETURN loc_recs_exact;
			
		END;
		
		
		EXPORT byFirstName() := FUNCTION
															
      firstName := lib_stringlib.StringLib.StringToUpperCase(in_mod.firstname);	
			CrossStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationCrossStreet);
			LocStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationStreet);
			start_date := in_mod.DolStartdate;
			end_date := in_mod.DolEnddate;
																						
      fname_recs :=	LIMIT(
				preferredName_key(keyed(fname = firstName) and
					keyed(in_mod.JurisdictionState = '' or jurisdiction_state=in_mod.JurisdictionState) and
					keyed(in_mod.jurisdiction ='' or jurisdiction=in_mod.jurisdiction) and
					(CrossStreet = '' OR Constants.contains_match(accident_location,CrossStreet)) and
					(LocStreet = '' OR Constants.contains_match(accident_location,LocStreet)) and
					(start_date = '' or (accident_date between start_date and end_date))
				),
				constants.MAX_RAW_PERSON_COUNT,
				FAIL(203, doxie.ErrorCodes(203))
			);
																			
			filtered_name_recs := Limit(dedup(sort(fname_recs,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),2000,fail(203, doxie.ErrorCodes(203)));
															 
			first_name_recs_exact := join(filtered_name_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
																		
			//OUTPUT(filtered_name_recs, named('filtered_name_recs'));
			
			RETURN first_name_recs_exact;
			
		END;
		
		EXPORT byLastName() := FUNCTION
															
      lastname := lib_stringlib.StringLib.StringToUpperCase(TRIM(in_mod.lastname));	
			CrossStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationCrossStreet);
			LocStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationStreet);
			start_date := in_mod.DolStartdate;
			end_date := in_mod.DolEnddate;
																						
      lname_recs :=	LIMIT(
				lastName_key(keyed(lname = lastname) and
					keyed(in_mod.JurisdictionState = '' or jurisdiction_state=in_mod.JurisdictionState) and
					keyed(in_mod.jurisdiction ='' or jurisdiction=in_mod.jurisdiction) and
					(CrossStreet = '' OR Constants.contains_match(accident_location,CrossStreet)) and
					(LocStreet = '' OR Constants.contains_match(accident_location,LocStreet)) and
					(start_date = '' or (accident_date between start_date and end_date))
				),
				constants.MAX_RAW_PERSON_COUNT,
				FAIL(203, doxie.ErrorCodes(203))	
			);
			
      filtered_name_recs := Limit(dedup(sort(lname_recs,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),2000,fail(203, doxie.ErrorCodes(203)));
															 
			last_name_recs_exact := join(filtered_name_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
																		
      //sorted_first_name_recs_exact := CHOOSEN(SORT(first_name_recs_exact,jurisdiction_state,-report_id),1000);
													
			RETURN last_name_recs_exact;
			
		END;
		
		EXPORT getAssociatedReports(dataset(Layouts.recs_with_penalty) intialSearchResults) := FUNCTION
		
		  filtered_recs := intialSearchResults(ReportLinkID <> '');
			
			associated_report_links := 	join(filtered_recs,reportLinkKey,
																			 keyed(right.ReportLinkID=left.ReportLinkID) and
																			 right.report_type_id<>left.report_type_id,
																			 transform(recordof(reportLinkKey),
																			 self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
																		 
      
			associated_report_links_full_recs := join(associated_report_links,accnbr_key,
																								keyed(right.l_accnbr=left.accident_nbr) and
																								keyed(right.report_code in constants.ecrash_src_codes) and
																								keyed(right.jurisdiction_state = left.jurisdiction_state) and
																								right.ReportLinkID = left.ReportLinkID and
																								right.report_type_id = left.report_type_id,
																								transform(recordof(accnbr_key),
																								self := right),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
																								
      associated_reports_keys := project(associated_report_links_full_recs,Layouts.recs_with_penalty);
			
			//OUTPUT(associated_reports_keys,named('associatedReports_keys'));
																								
			Layouts.recs_with_report_association xformDeltaAssociatedReports(Layouts.recs_with_penalty l) := TRANSFORM 
				SELF.recs := RecordsDeltaBase(in_mod).getAssociatedReports(l);
			END;
			
			delta_associated_parent_reports := project(filtered_recs,xformDeltaAssociatedReports(LEFT));
			
			delta_associated_reports := NORMALIZE(delta_associated_parent_reports, LEFT.recs, TRANSFORM(RIGHT));
			
			delta_merged_associated_reports := associated_reports_keys + delta_associated_reports;
																								
      RecordsSorted := SORT(delta_merged_associated_reports, 
					fname,
					lname,
					accident_date,
					jurisdiction_state,
					jurisdiction,
					//all the TM and TF reports have orig_accnbr and addl_report_number switched
					IF(report_code = 'EA', orig_accnbr, addl_report_number),
					IF(report_code = 'EA', addl_report_number, orig_accnbr), 
					report_type_id,
					if (report_code = 'TM', 1, 0), //TM has the least priority
					-(UNSIGNED8)report_id,
						-isDelta,
					-date_added,
					if(record_type = 'DRIVER', 0, 1) //DRIVER records have more information
				);
				
			final_recs := DEDUP(
									   RecordsSorted,
										 fname,
										 lname,
										 accident_date,
									 	 jurisdiction_state,
										 jurisdiction,
										 IF(report_code = 'EA', orig_accnbr, addl_report_number),
										 IF(report_code = 'EA', addl_report_number, orig_accnbr),
										 report_type_id
									   ); 
			
			//output(associated_reports_keys,named('associated_recs_from_keys'));
      
		  return final_recs;
			
		END;
		
		EXPORT getSubscriptionReports() := FUNCTION
		
		  in_jurisdiction := stringlib.stringtouppercase(in_mod.jurisdiction);
			in_jurisdiction_state := stringlib.stringtouppercase(in_mod.JurisdictionState);	
			max_results := in_mod.MaxLimit;
			sort_order := in_mod.SortOrder;
			sort_field := in_mod.SortField;
			
			delta_raw_in := RecordsDeltaBase(in_mod);
			delta_incidentIds := delta_raw_in.getSubscriptionIncidentIds(max_results);
		
		  //OUTPUT(count(delta_incidentIds),named('delta_incidentIds'));
			//if (count(temp_in_dataset)%3 = 0,count(temp_in_dataset)/3,(count(temp_in_dataset)/3)+1) ;
			//limiting the in clause so that we don't get back more than 1000 records in each deltabase request
			numberofsets := ((count(delta_incidentIds) - 1) / 200 ) + 1;
	
			Layouts.SubsSeqIncidentRecord assignSequence(Layouts.SubsIncidentRecord l, Integer sequence) := Transform
				self.sequence := sequence;
				self := l;
			END;
	
			seq_incidentIds := project(delta_incidentIds,assignSequence(LEFT,(counter% numberofsets)+1));
	
			Layouts.SubsGroupedIncidentRecord buildIncidentParentRecs(Layouts.SubsSeqIncidentRecord l,dataset(Layouts.SubsSeqIncidentRecord) r) := Transform		
				SELF.groupedIncidentIds :=  eCrash_Services.fn_CombineWords(SET(r, incidentId), ',');
			END;
	
			incident_grp := GROUP(
												SORT(seq_incidentIds, 
												 sequence
												), 
												sequence
											);
	
			grouped_delta_incidentIds := rollup (incident_grp, group, buildIncidentParentRecs (left, rows (left)));
			
			Layouts.recs_with_report_association xformDeltaAssociatedReports(Layouts.SubsGroupedIncidentRecord l) := TRANSFORM 
				SELF.recs := delta_raw_in.getSubscriptionReports(l.groupedIncidentIds);
			END;
			
			delta_associated_parent_reports := project(grouped_delta_incidentIds,xformDeltaAssociatedReports(LEFT));
			
			delta_associated_reports := NORMALIZE(delta_associated_parent_reports, LEFT.recs, TRANSFORM(RIGHT));
		
		  //Group the delta records so that we get unique reports.
		  transformed_delta_pen_recs := eCrash_Services.Functions.dedupReportRecordsFromParties(delta_associated_reports);
			
			//OUTPUT(transformed_delta_pen_recs,named('transformed_delta_pen_recs_count'));
			end_date := ut.GetDate;	

			start_date := ut.date_math(end_date,-365);
			
			//OUTPUT(start_date,named ('start_date'));
			//OUTPUT(end_date,named ('end_date'));

			payload_recs := CHOOSEN(
				dol_key(keyed (accident_date  BETWEEN start_Date and  end_date) and 
					keyed (report_code in constants.ecrash_src_codes) and 
					keyed (jurisdiction_state = in_jurisdiction_state) and 
					keyed (jurisdiction = in_jurisdiction) and
					report_type_id = 'A'
				),
				2000000
			);
															
				/*payload_recs := eCrash_Services.Key_Subscription(
															keyed (jurisdiction = in_jurisdiction) and
															keyed (jurisdiction_state = in_jurisdiction_state) and 
															keyed (report_code in eCrash_Services.constants.ecrash_src_codes) and 
															keyed (accident_date  BETWEEN start_Date and  end_date) and 
															report_type_id = 'A');*/
															
			//OUTPUT(count(payload_recs),named ('payload_recs'));											
															
      payload_recs_pen :=project(payload_recs,TRANSFORM(Layouts.recs_with_penalty, SELF.isMatched:=true,SELF.l_accnbr:= LEFT.accident_nbr, SELF:=LEFT,SELF:=[]));	
			
			merged_recs_raw := payload_recs_pen + transformed_delta_pen_recs;
			merged_recs := eCrash_Services.Functions.FilterOutDeletedReports(merged_recs_raw);
			
			//merged_recs := transformed_delta_pen_recs; //Temp Remove
			//OUTPUT(count(payload_recs_pen),named('payload_recs_pen_count'));
			//TODO add data from keys.
			RecordsSorted := SORT(merged_recs, 
													accident_date,
													jurisdiction_state,
													jurisdiction,
													//all the TM and TF reports have orig_accnbr and addl_report_number switched
													IF(report_code = 'EA', orig_accnbr, addl_report_number),
													IF(report_code = 'EA', addl_report_number, orig_accnbr), 
													report_type_id,
													if (report_code = 'TM', 1, 0), //TM has the least priority
													-(UNSIGNED8)report_id,
														-isDelta,
													-date_added
												);
			duped_recs := DEDUP(
												 RecordsSorted,
												 accident_date,
												 jurisdiction_state,
												 jurisdiction,
												 IF(report_code = 'EA', orig_accnbr, addl_report_number), 
												 IF(report_code = 'EA', addl_report_number, orig_accnbr),
												 report_type_id
												 ); 
      
			//OUTPUT(count(duped_recs),named('duped_recs_count'));
												 
			limit_recs := TOPN(duped_recs, max_results, -(UNSIGNED8)report_id);
			
			deltabase_limit_recs := limit_recs(isDelta=true);
			payload_limit_recs := limit_recs(isDelta=false);
			
			//OUTPUT(payload_limit_recs,named('payload_limit_recs')); 
			//OUTPUT(count(deltabase_limit_recs),named('deltabase_limit_recs_count')); 
			
		  //get back the person records for choosen delta records
			deltabse_person_recs := join(deltabase_limit_recs,delta_associated_reports,
										right.l_accnbr=left.l_accnbr and
										right.accident_date = right.accident_date and
										right.jurisdiction_state = left.jurisdiction_state and
										right.jurisdiction = left.jurisdiction and
										right.report_type_id = left.report_type_id and
										right.report_code = left.report_code and
										right.report_id = left.report_id,
										transform(recordof(Layouts.recs_with_penalty),
										self := right),limit(constants.MAX_ACCIDENTS_PER_DAY, fail(203, doxie.ErrorCodes(203))));
										
      //OUTPUT(count(deltabse_person_recs),named('deltabse_person_recs_count'));
			
			payload_person_recs_tmp := join(payload_limit_recs,accnbr_key,
																		keyed(right.l_accnbr=left.l_accnbr) and
																		keyed(right.report_code in constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction) and 
																		right.accident_date = left.accident_date and
																		right.report_type_id = left.report_type_id ,
																		transform(recordof(accnbr_key),
																		self := right),limit(constants.MAX_ACCIDENTS_PER_DAY, fail(203, doxie.ErrorCodes(203))));
																		
      payload_person_recs := project(payload_person_recs_tmp,TRANSFORM(Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));																		
			
			//OUTPUT(count(payload_person_recs_tmp),named('payload_person_recs_tmp_count'));
			
			//OUTPUT(payload_limit_recs[1],named('payload_limit_recs'));
															
      merged_person_recs :=  deltabse_person_recs + payload_person_recs;
			//merged_person_recs :=  deltabse_person_recs; //Temp Remove
			
			recs_filtered_dedup := Functions.PreferDriverRecords(merged_person_recs);
			
			//OUTPUT(count(recs_filtered_dedup),named('recs_filtered_dedup_count'));
			
			recs_result := functions.InvolvedPartyTransform(recs_filtered_dedup,in_mod,true);
						
			iesp.ecrash.t_ECrashSearchRecord setLastName(iesp.ecrash.t_ECrashSearchRecord l) := TRANSFORM
				SELF.LastName :=  eCrash_Services.fn_CombineWords(SET(project(l.InvolvedParties(Name.Last <> ''),TRANSFORM(Layouts.LastNameSortValue, SELF.LastName:=LEFT.Name.Last)), LastName), ',');
				self := l;
			END;
			
			final_recs_results := project(recs_result, setLastName(LEFT));
			
			//=> if(sort_order='DESC', '-AccidentLocation', 'AccidentLocation')
			/*sortField := MAP(sort_field = 'AccidentLocation' => if(sort_order='DESC', '-AccidentLocation', 'AccidentLocation'),
			                   sort_field = 'ReportNumber' => if(sort_order='DESC', '-ReportNumber', 'ReportNumber'),
												 sort_field = 'DateOfLoss' => if(sort_order='DESC', '-DateOfLoss', 'DateOfLoss'),
												 sort_field = 'LastName' => if(sort_order='DESC', '-LastName', 'LastName'),
												 'DateOfLoss');*/
												 
		/*	MAC_Sort(ds, sortField) := MACRO
			 result1 := sort(ds,sortField);
			ENDMACRO;*/
			
			//MAC_Sort(final_recs_results, sortField);
			
			sorted_recs := MAP(sort_field = 'AccidentLocation' => if(sort_order='DESC', SORT(final_recs_results,-AccidentLocation), SORT(final_recs_results,AccidentLocation)),
			                   sort_field = 'ReportNumber' => if(sort_order='DESC', SORT(final_recs_results,-ReportNumber), SORT(final_recs_results,ReportNumber)),
												 sort_field = 'DateOfLoss' => if(sort_order='DESC', SORT(final_recs_results,-DateOfLoss), SORT(final_recs_results,DateOfLoss)),
												 sort_field = 'LastName' => if(sort_order='DESC', SORT(final_recs_results,-LastName), SORT(final_recs_results,LastName)),
												 SORT(recs_result,-DateOfLoss));
		
			grouped_result_recs := functions.SubscriptionNonAssociatedGroupedReports(sorted_recs);
			
			return grouped_result_recs;
		END;
			
END;
