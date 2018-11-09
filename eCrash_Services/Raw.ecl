/*2016-07-11T18:11:51Z (Dmitriy Lazarenko)
adding a comment on why we have limit of 7000 here
*/
IMPORT FLAccidents_Ecrash, ut, doxie,lib_stringlib,std, iesp, eCrash_Services;

EXPORT Raw(eCrash_Services.IParam.searchrecords in_mod) := MODULE
		shared 	accnbr_key:=FLAccidents_Ecrash.key_EcrashV2_accnbrV1;
		shared 	dol_key:=FLAccidents_Ecrash.key_EcrashV2_dol;
		shared 	partial_accnbr_key := FLAccidents_Ecrash.Key_EcrashV2_Partial_Report_Nbr;
		shared 	location_key := FLAccidents_Ecrash.Key_eCrashv2_StAndLocation;
		shared  preferredName_key := FLAccidents_Ecrash.Key_eCrashv2_PrefName_State;
		shared reportLinkKey := FLAccidents_Ecrash.Key_eCrashv2_ReportLinkId;
		shared lastName_key := FLAccidents_Ecrash.Key_EcrashV2_LastName;
		shared VinNbr_key := FLAccidents_Ecrash.key_ecrashV2_VinNbr;
		shared DlnNbrDLState_key := FLAccidents_Ecrash.key_ecrashV2_DlnNbrDLState;
		shared OfficerBadgeNbr_key := FLAccidents_Ecrash.key_ecrashV2_OfficerBadgeNbr;
		shared LicensePlateNbr_key := FLAccidents_Ecrash.key_ecrashV2_LicensePlateNbr;
		
		shared boolean hasJurisdictionInfo    := COUNT(in_mod.agencies(JurisdictionState <> '' AND Jurisdiction <> '')) > 0;
		
		shared boolean containsReportNumber (string src, string report_in) := (report_in = '') or (StringLib.StringFind (src, report_in, 1) >0); //Input report number is already 'cleaned'
		
		shared tmp_dtrange_rec := record
				string8 daterange;
		end;
		
		shared tmp_dtrange_rec_withAgencies := record
				string8 daterange;
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean PrimaryAgency;
		end;

		//BAP
		EXPORT 	by_auto_recs() := FUNCTION
				auto_ds := project(in_mod,eCrash_Services.IParam.autokey_search);
				
				autokey_ds := autokey_ids(auto_ds);
				
				autokey_with_alias := JOIN(autokey_ds, in_mod.agencies, TRUE, TRANSFORM(eCrash_Services.Layouts.search,
																		SELF.JurisdictionState := right.JurisdictionState;
																		SELF.Jurisdiction := right.Jurisdiction;
																		SELF.PrimaryAgency := right.PrimaryAgency;
																		SELF.AgencyORI := right.AgencyORI;
																		SELF := LEFT;), ALL);
																	
				RETURN autokey_with_alias;
		END;
	
		EXPORT by_rpt_num() := FUNCTION				
							
				agency_search_ds := PROJECT(in_mod.agencies, TRANSFORM(eCrash_Services.Layouts.search, 
																												SELF.reportnumber := in_mod.reportnumber;
																												SELF.isdeepdive 	:= false;																												
																												SELF := LEFT;));				
				
				RETURN agency_search_ds;
		END;

		EXPORT byReportNumber(dataset(eCrash_Services.Layouts.search) ids_raw_in) := FUNCTION
							
				rpn_recs_res1:= join(ids_raw_in,accnbr_key,
													keyed(right.l_accnbr=left.reportnumber) and
													keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
													if(in_mod.RequestHashKey,(right.agency_ori = left.AgencyORI and right.image_hash<>''),right.jurisdiction<>''),
													transform(recordof(accnbr_key),
													self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
				// TODO: a hack to return some meaningful response in a case of (incorrectly created) test data;
				//       an error-message is not very appropriate: rather should be something like "too much data associated with an object"
				
				rpn_recs_res_w_jur:= join(ids_raw_in,accnbr_key,
													keyed(right.l_accnbr=left.reportnumber) and
													keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
													keyed(right.jurisdiction_state = left.jurisdictionState) and
													keyed(right.jurisdiction = left.jurisdiction) and
													if(in_mod.RequestHashKey,(right.agency_ori = left.AgencyORI and right.image_hash<>''), true),
													transform(recordof(accnbr_key),
													self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
				
				rpn_recs_res := if(hasJurisdictionInfo,
													 rpn_recs_res_w_jur,
													 rpn_recs_res1);	

				RETURN rpn_recs_res;
		END;
		
		EXPORT byPartialReportNumber(dataset(tmp_dtrange_rec) ds_date_range, boolean hasInputDOL) := FUNCTION
				boolean isPartial := length(in_mod.reportnumber) = 4;
				partial_report_number := if(isPartial, in_mod.reportnumber, in_mod.reportnumber[1..4]);
				
				by_partial_rptNum := PROJECT(in_mod.agencies, TRANSFORM(eCrash_Services.Layouts.search, 
																												SELF.reportnumber := partial_report_number;
																												SELF.isdeepdive 	:= false;																												
																												SELF := LEFT;));
				
				
			eCrash_Services.Layouts.search xformToAccnbr(by_partial_rptNum L, partial_accnbr_key R):=transform
					self.reportnumber := R.l_accnbr;
					self.isdeepdive:=false;
					self.jurisdiction := L.jurisdiction;
					self.jurisdictionstate := L.JurisdictionState;
					self.primaryagency := L.primaryagency;
					self := R;
					self := [];
				end;
				
					//BAP - kevin says needs cleanup, but not yet.
				partial_rpn_recs_res1:= join(by_partial_rptNum,partial_accnbr_key,
													keyed(right.partial_report_nbr=left.reportnumber) and
													keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and 
													keyed (right.jurisdiction != '') and
													wild (right.jurisdiction_state) and
													wild (right.accident_date) and
													(eCrash_Services.Constants.valid_match(right.jurisdiction_state,left.JurisdictionState)) and 
													(eCrash_Services.Constants.valid_match(STD.Str.ToUpperCase(right.jurisdiction),left.jurisdiction)),
													xformToAccnbr(left, right),limit(eCrash_Services.constants.MAX_PARTIAL_NUMBER, fail(203, doxie.ErrorCodes(203))));
										
				partial_rpn_recs_res_w_jur:= join(by_partial_rptNum,partial_accnbr_key,
													keyed(right.partial_report_nbr=left.reportnumber) and
													keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
													keyed(right.jurisdiction_state = left.jurisdictionState) and
													keyed(right.jurisdiction = left.jurisdiction),
													xformToAccnbr(left, right),limit(eCrash_Services.constants.MAX_PARTIAL_NUMBER, fail(203, doxie.ErrorCodes(203))));
													
				partial_recs := if(hasJurisdictionInfo, partial_rpn_recs_res_w_jur, partial_rpn_recs_res1);

				ds_date_range_search_ds := JOIN(in_mod.agencies, ds_date_range, TRUE, TRANSFORM(tmp_dtrange_rec_withAgencies, 
																					SELF.daterange := RIGHT.daterange;
																					SELF := LEFT;), ALL);
				
				eCrash_Services.Layouts.search xformToAccnbrWithDOL(ds_date_range_search_ds L, partial_accnbr_key R):=transform
					self.reportnumber := R.l_accnbr;
					self.isdeepdive:=false;
					self.jurisdiction := L.jurisdiction;
					self.jurisdictionstate := L.JurisdictionState;
					self := L;
				end;
				
				partial_rpn_recs_w_fuzzydol:=	join(ds_date_range_search_ds, partial_accnbr_key,
																				keyed (right.partial_report_nbr=partial_report_number) and 
																				keyed (right.report_code in eCrash_Services.constants.ecrash_src_codes) and 
																				keyed (right.accident_date=left.daterange) and
																				keyed (right.jurisdiction != '') and
																				wild (right.jurisdiction_state) and
																				(eCrash_Services.Constants.valid_match(right.jurisdiction_state,left.JurisdictionState)) and 
																				(eCrash_Services.Constants.valid_match(STD.Str.ToUpperCase(right.jurisdiction),left.jurisdiction)),
																				xformToAccnbrWithDOL(left, right),limit(eCrash_Services.Constants.MAX_ACCIDENTS_PER_DAY, fail(203, doxie.ErrorCodes(203))));
																				
				partial_rpn_recs_res := if(hasInputDOL, partial_rpn_recs_w_fuzzydol, partial_recs);
				
				filter_partial_rpn_res := if(isPartial,
																			partial_rpn_recs_res,
																			partial_rpn_recs_res(containsReportNumber(reportnumber, in_mod.reportnumber)));
				
				dup_partial_recs := dedup(sort(filter_partial_rpn_res, reportnumber, JurisdictionState, jurisdiction, agencyid, agencyori, -primaryagency), reportnumber, JurisdictionState, jurisdiction, agencyid, agencyori, primaryagency);
				//BAP above indexes have no payload so they use the byReportNumber to lookup payload
				partial_rpn_res := byReportNumber(dup_partial_recs);
				
				RETURN partial_rpn_res;
		END;
		
		EXPORT byDOL(string start_date, string end_date) := FUNCTION
		
			// TODO: set limit for exact date of loss + filters match
			// dol := in_mod.dateofloss;
			// in_jurisdiction := STD.Str.ToUpperCase(in_mod.jurisdiction);
			// in_jurisdiction_state := STD.Str.ToUpperCase(in_mod.JurisdictionState);
			boolean ignore_state_search 						:= eCrash_Services.constants.no_state_search(in_mod);
			boolean ignore_jurisdiction_search 			:= eCrash_Services.constants.no_jurisdiction_search(in_mod);
			
      tmp_dol_rec := record
				string8 dol;
				string8 start_date;
				string8 end_date;
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean primaryagency;
		  end;
		
			dol_rec := RECORD
			RECORDOF(dol_key);
			boolean primaryagency;
			end;
			
			dol_search_ds    := PROJECT(in_mod.agencies, transform(tmp_dol_rec, 
																																				self.dol := in_mod.dateofloss;
																																				self.start_date:=start_date;
																																				self.end_date := end_date;
																																				self := left;));
			
			dol_rec xformToDolRec(dol_search_ds L, dol_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
			// Limit 2k records for each agency(left record) and then sort by primary agency to get all the primary records
			//If primary records exceed 2k limit then fail else take remaining to fill 2k from alias records
			agency_dol_recs:=	JOIN(dol_search_ds, dol_key,  keyed (right.accident_date=left.dol) and 
																								keyed (right.report_code in eCrash_Services.constants.ecrash_src_codes) and 
																									keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																									keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState),
																									xformToDolRec(left, right), 
																									limit(eCrash_Services.constants.MAX_ACCIDENTS_PER_AGENCY_PER_DAY + 1, fail(203, doxie.ErrorCodes(203))));
			
			agency_dol_recs_sorted := SORT(agency_dol_recs, -primaryagency, record);

			dol_recs := IF(count(agency_dol_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_ACCIDENTS_PER_AGENCY_PER_DAY + 1), agency_dol_recs_sorted[1..eCrash_Services.Constants.MAX_ACCIDENTS_PER_AGENCY_PER_DAY], fail(agency_dol_recs_sorted, 203, doxie.ErrorCodes(203))); 
			
			agency_dol_fuzzy_recs := JOIN(dol_search_ds, dol_key,  keyed (right.accident_date between left.start_date and left.end_date) and 
																											  keyed (right.report_code in eCrash_Services.constants.ecrash_src_codes) and 
																												keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																												keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState),
																												xformToDolRec(left, right), 
																												limit(eCrash_Services.constants.MAX_ACCIDENTS_PER_AGENCY_PER_DAY + 1, fail(203, doxie.ErrorCodes(203))));
			
			agency_dol_fuzzy_recs_sorted := SORT(agency_dol_fuzzy_recs, -primaryagency);
			
			dol_fuzzy_recs := IF(count(agency_dol_fuzzy_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_ACCIDENTS_PER_AGENCY_PER_DAY + 1), agency_dol_fuzzy_recs_sorted[1..eCrash_Services.Constants.MAX_ACCIDENTS_PER_AGENCY_PER_DAY], fail(agency_dol_fuzzy_recs_sorted, 203, doxie.ErrorCodes(203))); 
			
			dol_fuzzy_recs_filtered := IF(EXISTS(dol_recs), dol_recs, dol_fuzzy_recs);
			
			// dol_fuzzy_recs_filtered :=	LIMIT(dol_recs_temp,2000,fail(203, doxie.ErrorCodes(203)));
																
			final_dol_fuzzy_recs := join(dol_fuzzy_recs_filtered,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
			RETURN final_dol_fuzzy_recs;
																
		END;
		
	EXPORT byLocation() := FUNCTION
			CrossStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationCrossStreet);
			LocStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationStreet);
			start_date := in_mod.DolStartdate;
			end_date := in_mod.DolEnddate;
			DateOfLoss := in_mod.DateOfLoss;
			
		 tmp_loc_rec := record
				string CrossStreet;
				string LocStreet;
				string8 start_date;
				string8 end_date;
				string8 dol;
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean primaryagency;
		  end;
	
			loc_rec := RECORD
				RECORDOF(location_key);
				boolean primaryagency;
			end;
			
			loc_search_ds    := PROJECT(in_mod.agencies, transform(tmp_loc_rec, 
																																				self.CrossStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationCrossStreet);
																																				self.LocStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationStreet);
																																				self.dol := in_mod.dateofloss;
																																				self.start_date:=in_mod.DolStartdate;
																																				self.end_date := in_mod.DolEnddate;
																																				self := left;));
			loc_rec xformToLocRec(loc_search_ds L, location_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
			
			// Limit 7k records for each agency(left record) and then sort by primary agency to get all the primary records
			//If primary records exceed 7k limit then fail else take remaining to fill 7k from alias records
			
			loc_recs :=	JOIN(loc_search_ds, location_key, keyed ((left.CrossStreet <> '' AND right.partial_accident_location[1..LENGTH(TRIM(CrossStreet))] = left.CrossStreet) OR
																														(left.LocStreet <> '' AND right.partial_accident_location[1..LENGTH(TRIM(LocStreet))] = left.LocStreet)) and
																										  keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																									    keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
																									          (left.start_date = '' or (right.accident_date between left.start_date and left.end_date)) and
																										        (left.dol = '' or right.accident_date = left.dol), 
																														xformToLocRec(left, right), 
																														limit(eCrash_Services.constants.MAX_ACCIDENTS_PER_AGENCY_PER_LOCATION + 1, fail(203, doxie.ErrorCodes(203))));
		 
			//7k limit is used because on average if we have more then 7k records here then we run into a memory limit exhausted in recs_raw_dupe join in Records file
			//which is something we need to look at.
			// filtered_loc_recs := Limit(loc_recs,7000,fail(203, doxie.ErrorCodes(203)));
			
			loc_recs_sorted := SORT(loc_recs, -primaryagency, record);
			//add 7000 to constants
			filtered_loc_recs := IF(count(loc_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_ACCIDENTS_PER_AGENCY_PER_LOCATION + 1), loc_recs_sorted[1..eCrash_Services.Constants.MAX_ACCIDENTS_PER_AGENCY_PER_LOCATION], fail(loc_recs_sorted, 203, doxie.ErrorCodes(203))); 
						
			loc_recs_exact := join(filtered_loc_recs,accnbr_key,
													keyed(right.l_accnbr=left.accident_nbr) and
													keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
													keyed(right.jurisdiction_state = left.jurisdiction_state) and
													keyed(right.jurisdiction = left.jurisdiction),
													transform(recordof(accnbr_key),
													self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
													
			RETURN loc_recs_exact;
			
		END;
		
		
		EXPORT byFirstName() := FUNCTION
															
      firstName := STD.Str.ToUpperCase(in_mod.firstname);	
			CrossStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationCrossStreet);
			LocStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationStreet);
			start_date := in_mod.DolStartdate;
			end_date := in_mod.DolEnddate;
			
			tmp_fname_rec := record
				string firstName;	
				string CrossStreet;
				string LocStreet;
				string8 start_date;
				string8 end_date;
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean primaryagency;
		  end;
		
			fname_rec := RECORD
				RECORDOF(preferredName_key);
				boolean primaryagency;
			end;
			
			fname_search_ds    := PROJECT(in_mod.agencies, transform(tmp_fname_rec, 
																																				self.firstName := STD.Str.ToUpperCase(in_mod.firstname);	
																																				self.CrossStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationCrossStreet);
																																				self.LocStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationStreet);
																																				self.start_date:=in_mod.DolStartdate;
																																				self.end_date := in_mod.DolEnddate;
																																				self := left;));
			fname_rec xformToFnameRec(fname_search_ds L, preferredName_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
			
      fname_recs :=	join(fname_search_ds, preferredName_key, 
				keyed(right.fname = left.firstName) and
				keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
				keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
				(left.CrossStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.CrossStreet)) and
				(left.LocStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.LocStreet)) and
				(left.start_date = '' or (right.accident_date between left.start_date and left.end_date)), xformToFnameRec(left, right),
				limit(eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1, fail(203, doxie.ErrorCodes(203))));
			
			fname_recs_sorted 	:= SORT(fname_recs, -primaryagency, record);
			filtered_max_person_fname_recs := IF(count(fname_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_RAW_PERSON_COUNT +1), fname_recs_sorted[1..eCrash_Services.Constants.MAX_RAW_PERSON_COUNT], fail(fname_recs_sorted, 203, doxie.ErrorCodes(203))); 	
			
			filtered_fname_recs := Limit(dedup(sort(filtered_max_person_fname_recs,-primaryagency,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),eCrash_Services.Constants.MAX_PERSON_RECORDS,fail(203, doxie.ErrorCodes(203)));
															 
			first_name_recs_exact := join(filtered_fname_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));

			RETURN first_name_recs_exact;
			
		END;
		
		EXPORT byLastName() := FUNCTION
															
      lastname := STD.Str.ToUpperCase(TRIM(in_mod.lastname));	
			CrossStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationCrossStreet);
			LocStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationStreet);
			start_date := in_mod.DolStartdate;
			end_date := in_mod.DolEnddate;
			
			tmp_lname_rec := record
				string lastname;	
				string CrossStreet;
				string LocStreet;
				string8 start_date;
				string8 end_date;
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean primaryagency;
		  end;
		
			lname_rec := RECORD
				RECORDOF(lastName_key);
				boolean primaryagency;
			end;
			
			lname_search_ds    := PROJECT(in_mod.agencies, transform(tmp_lname_rec, 
																																				self.lastName := STD.Str.ToUpperCase(TRIM(in_mod.lastname));	
																																				self.CrossStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationCrossStreet);
																																				self.LocStreet := STD.Str.ToUpperCase(in_mod.AccidentLocationStreet);
																																				self.start_date:=in_mod.DolStartdate;
																																				self.end_date := in_mod.DolEnddate;
																																				self := left;));
			
			lname_rec xformToLnameRec(lname_search_ds L, lastName_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
			
      lname_recs :=	join(lname_search_ds, lastName_key, 
																		keyed(right.lname = left.lastname) and
																		keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																		keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
																		(left.CrossStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.CrossStreet)) and
																		(left.LocStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.LocStreet)) and
																		(left.start_date = '' or (right.accident_date between left.start_date and left.end_date)), xformToLnameRec(left, right),
																		limit(eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1, fail(203, doxie.ErrorCodes(203))));
			
			lname_recs_sorted 	:= SORT(lname_recs, -primaryagency, record);
			filtered_max_person_lname_recs := IF(count(lname_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1), lname_recs_sorted[1..eCrash_Services.Constants.MAX_RAW_PERSON_COUNT], fail(lname_recs_sorted, 203, doxie.ErrorCodes(203))); 	
      
			filtered_lname_recs := Limit(dedup(sort(filtered_max_person_lname_recs,-primaryagency,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),eCrash_Services.Constants.MAX_PERSON_RECORDS,fail(203, doxie.ErrorCodes(203)));
															 
			last_name_recs_exact := join(filtered_lname_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));

			RETURN last_name_recs_exact;
			
		END;
	
		EXPORT byVin() := FUNCTION
			
			vin_rec := RECORD
				FLAccidents_Ecrash.Layouts.key_slim_layout;
				boolean primaryagency;
			end;
			
			vin_search_ds := eCrash_Services.functions.GetAgencySearchDs(in_mod);	
			
			vin_rec xformToVinRec(vin_search_ds L, VinNbr_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
	

      vin_recs :=	join(vin_search_ds, VinNbr_key, 
																		keyed(right.vin = left.vin) and
																		keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																		keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
																		(left.DriversLicenseNum = '' OR left.DriversLicenseNum = right.driver_license_nbr) and
																		(left.OfficerBadge = '' OR left.OfficerBadge = right.officer_id) and
																		(left.LicensePlate = '' OR left.LicensePlate = right.tag_nbr) and
																		(left.CrossStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.CrossStreet)) and
																		(left.LocStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.LocStreet)) and
																		(left.start_date = '' or (right.accident_date between left.start_date and left.end_date)), xformToVinRec(left, right),
																		limit(eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1, fail(203, doxie.ErrorCodes(203))));

			
			vin_recs_sorted 	:= SORT(vin_recs, -primaryagency, record);
			filtered_max_vin_recs := IF(count(vin_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1), vin_recs_sorted[1..eCrash_Services.Constants.MAX_RAW_PERSON_COUNT], fail(vin_recs_sorted, 203, doxie.ErrorCodes(203))); 	
      
			filtered_vin_recs := Limit(dedup(sort(filtered_max_vin_recs,-primaryagency,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),eCrash_Services.Constants.MAX_PERSON_RECORDS,fail(203, doxie.ErrorCodes(203)));
			
			//try DOL in the join to see if stray records are removed												 
			vin_recs_exact := join(filtered_vin_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
	
			RETURN vin_recs_exact;
			
		END;
	
		EXPORT byDriversLicenseNum() := FUNCTION
		
			dl_rec := RECORD
				FLAccidents_Ecrash.Layouts.key_slim_layout;
				boolean primaryagency;
			end;
		
			dl_search_ds := eCrash_Services.functions.GetAgencySearchDs(in_mod);
			
			dl_rec xformToDLRec(dl_search_ds L, DlnNbrDLState_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
							
      dl_recs :=	join(dl_search_ds, DlnNbrDLState_key, 
																		keyed(right.driver_license_nbr = left.DriversLicenseNum) and
																		wild(right.dlnbr_st) and	
																		keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																		keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
																		(left.vin = '' OR left.vin = right.vin) and
																		(left.OfficerBadge = '' OR left.OfficerBadge = right.officer_id) and
																		(left.LicensePlate = '' OR left.LicensePlate = right.tag_nbr) and
																		(left.CrossStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.CrossStreet)) and
																		(left.LocStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.LocStreet)) and
																		(left.start_date = '' or (right.accident_date between left.start_date and left.end_date)), xformToDLRec(left, right),
																		limit(eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1, fail(203, doxie.ErrorCodes(203))));
			
			dl_recs_sorted 	:= SORT(dl_recs, -primaryagency, record);
			filtered_max_dl_recs := IF(count(dl_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1), dl_recs_sorted[1..eCrash_Services.Constants.MAX_RAW_PERSON_COUNT], fail(dl_recs_sorted, 203, doxie.ErrorCodes(203))); 	
      
			filtered_dl_recs := Limit(dedup(sort(filtered_max_dl_recs,-primaryagency,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),eCrash_Services.Constants.MAX_PERSON_RECORDS,fail(203, doxie.ErrorCodes(203)));
															 
			dl_recs_exact := join(filtered_dl_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
	
			RETURN dl_recs_exact;
			
		END;
		
		EXPORT byOfficerBadge() := FUNCTION
			
			OffBadge_rec := RECORD
				FLAccidents_Ecrash.Layouts.key_slim_layout;
				boolean primaryagency;
			end;
			

			offBadge_search_ds := eCrash_Services.functions.GetAgencySearchDs(in_mod);
			
			OffBadge_rec xformToOffBadgeRec(offBadge_search_ds L, OfficerBadgeNbr_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
						
      offBadge_recs :=	join(offBadge_search_ds, OfficerBadgeNbr_key, 
																		keyed(right.officer_id = left.OfficerBadge) and
																		keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																		keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
																		(left.vin = '' OR left.vin = right.vin) and
																		(left.DriversLicenseNum = '' OR left.DriversLicenseNum = right.driver_license_nbr) and
																		(left.LicensePlate = '' OR left.LicensePlate = right.tag_nbr) and
																		(left.CrossStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.CrossStreet)) and
																		(left.LocStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.LocStreet)) and
																		(left.start_date = '' or (right.accident_date between left.start_date and left.end_date)), xformToOffBadgeRec(left, right),
																		limit(eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1, fail(203, doxie.ErrorCodes(203))));
			
			offBadge_recs_sorted 	:= SORT(offBadge_recs, -primaryagency, record);
			filtered_max_offBadge_recs := IF(count(offBadge_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1), offBadge_recs_sorted[1..eCrash_Services.Constants.MAX_RAW_PERSON_COUNT], fail(offBadge_recs_sorted, 203, doxie.ErrorCodes(203))); 	
      
			filtered_offBadge_recs := Limit(dedup(sort(filtered_max_offBadge_recs,-primaryagency,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),eCrash_Services.Constants.MAX_PERSON_RECORDS,fail(203, doxie.ErrorCodes(203)));
															 
			offBadge_recs_exact := join(filtered_offBadge_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
	
			RETURN offBadge_recs_exact;
			
		END;
		
		EXPORT byLicensePlate() := FUNCTION
			
			LicensePlate_rec := RECORD
				FLAccidents_Ecrash.Layouts.key_slim_layout;
				boolean primaryagency;
			end;
			
		
			licensePlate_search_ds := eCrash_Services.functions.GetAgencySearchDs(in_mod);
			
			LicensePlate_rec xformToLicPlateRec(licensePlate_search_ds L, LicensePlateNbr_key R):=transform
					self.primaryagency := L.primaryagency;
					self := R;
			end;
						
      licensePlate_recs :=	join(licensePlate_search_ds, LicensePlateNbr_key, 
																		keyed(right.tag_nbr = left.LicensePlate) and
																		wild(right.tagnbr_st) and	
																		keyed (left.jurisdiction = '' or right.jurisdiction = left.jurisdiction) and
																		keyed (left.JurisdictionState = '' or right.jurisdiction_state = left.JurisdictionState) and
																		(left.vin = '' OR left.vin = right.vin) and
																		(left.OfficerBadge = '' OR left.OfficerBadge = right.officer_id) and
																		(left.DriversLicenseNum = '' OR left.DriversLicenseNum = right.driver_license_nbr) and
																		(left.CrossStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.CrossStreet)) and
																		(left.LocStreet = '' OR eCrash_Services.Constants.contains_match(right.accident_location,left.LocStreet)) and
																		(left.start_date = '' or (right.accident_date between left.start_date and left.end_date)), xformToLicPlateRec(left, right),
																		limit(eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1, fail(203, doxie.ErrorCodes(203))));
			
			licensePlate_recs_sorted 	:= SORT(licensePlate_recs, -primaryagency, record);
			filtered_max_licensePlate_recs := IF(count(licensePlate_recs_sorted(primaryagency)) < (eCrash_Services.constants.MAX_RAW_PERSON_COUNT + 1), licensePlate_recs_sorted[1..eCrash_Services.Constants.MAX_RAW_PERSON_COUNT], fail(licensePlate_recs_sorted, 203, doxie.ErrorCodes(203))); 	
      
			filtered_licensePlate_recs := Limit(dedup(sort(filtered_max_licensePlate_recs,-primaryagency,accident_nbr,report_code,jurisdiction_state,jurisdiction),accident_nbr,report_code,jurisdiction_state,jurisdiction),eCrash_Services.Constants.MAX_PERSON_RECORDS,fail(203, doxie.ErrorCodes(203)));
															 
			licensePlate_recs_exact := join(filtered_licensePlate_recs,accnbr_key,
																		keyed(right.l_accnbr=left.accident_nbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction),
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
	
			RETURN licensePlate_recs_exact;
			
		END;

		EXPORT getAssociatedReports(dataset(eCrash_Services.Layouts.recs_with_penalty) intialSearchResults) := FUNCTION
		
		  filtered_recs := intialSearchResults(ReportLinkID <> '');
			
			associated_report_links := 	join(filtered_recs,reportLinkKey,
																			 keyed(right.ReportLinkID=left.ReportLinkID) and
																			 right.report_type_id<>left.report_type_id,
																			 transform(recordof(reportLinkKey),
																			 self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
																		 
      
			associated_report_links_full_recs := join(associated_report_links,accnbr_key,
																								keyed(right.l_accnbr=left.accident_nbr) and
																								keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																								keyed(right.jurisdiction_state = left.jurisdiction_state) and
																								right.ReportLinkID = left.ReportLinkID and
																								right.report_type_id = left.report_type_id,
																								transform(recordof(accnbr_key),
																								self := right),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
																								
      associated_reports_keys := project(associated_report_links_full_recs,eCrash_Services.Layouts.recs_with_penalty);
			
			//OUTPUT(associated_reports_keys,named('associatedReports_keys'));
																								
			eCrash_Services.Layouts.recs_with_report_association xformDeltaAssociatedReports(eCrash_Services.Layouts.recs_with_penalty l) := TRANSFORM 
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

			primary_agency  := in_mod.agencies(PrimaryAgency = TRUE)[1];
		  in_jurisdiction := STD.Str.ToUpperCase(primary_agency.jurisdiction);
			in_jurisdiction_state := STD.Str.ToUpperCase(primary_agency.JurisdictionState);
			
			max_results := in_mod.MaxLimit;
			sort_order := in_mod.SortOrder;
			sort_field := in_mod.SortField;
			
			delta_raw_in := RecordsDeltaBase(in_mod);
			delta_incidentIds := delta_raw_in.getSubscriptionIncidentIds(max_results);
		
		  //OUTPUT(count(delta_incidentIds),named('delta_incidentIds'));
			//if (count(temp_in_dataset)%3 = 0,count(temp_in_dataset)/3,(count(temp_in_dataset)/3)+1) ;
			//limiting the in clause so that we don't get back more than 1000 records in each deltabase request
			numberofsets := ((count(delta_incidentIds) - 1) / 200 ) + 1;
	
			eCrash_Services.Layouts.SubsSeqIncidentRecord assignSequence(eCrash_Services.Layouts.SubsIncidentRecord l, Integer sequence) := Transform
				self.sequence := sequence;
				self := l;
			END;
	
			seq_incidentIds := project(delta_incidentIds,assignSequence(LEFT,(counter% numberofsets)+1));
	
			eCrash_Services.Layouts.SubsGroupedIncidentRecord buildIncidentParentRecs(eCrash_Services.Layouts.SubsSeqIncidentRecord l,dataset(eCrash_Services.Layouts.SubsSeqIncidentRecord) r) := Transform		
				SELF.groupedIncidentIds :=  eCrash_Services.fn_CombineWords(SET(r, incidentId), ',');
			END;
	
			incident_grp := GROUP(
												SORT(seq_incidentIds, 
												 sequence
												), 
												sequence
											);
	
			grouped_delta_incidentIds := rollup (incident_grp, group, buildIncidentParentRecs (left, rows (left)));
			
			eCrash_Services.Layouts.recs_with_report_association xformDeltaAssociatedReports(eCrash_Services.Layouts.SubsGroupedIncidentRecord l) := TRANSFORM 
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
					keyed (report_code in eCrash_Services.constants.ecrash_src_codes) and 
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
															
      payload_recs_pen :=project(payload_recs,TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF.isMatched:=true,SELF.l_accnbr:= LEFT.accident_nbr, SELF:=LEFT,SELF:=[]));	
			
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
										transform(recordof(eCrash_Services.Layouts.recs_with_penalty),
										self := right),limit(eCrash_Services.constants.MAX_ACCIDENTS_PER_DAY, fail(203, doxie.ErrorCodes(203))));
										
      //OUTPUT(count(deltabse_person_recs),named('deltabse_person_recs_count'));
			
			payload_person_recs_tmp := join(payload_limit_recs,accnbr_key,
																		keyed(right.l_accnbr=left.l_accnbr) and
																		keyed(right.report_code in eCrash_Services.constants.ecrash_src_codes) and
																		keyed(right.jurisdiction_state = left.jurisdiction_state) and
																		keyed(right.jurisdiction = left.jurisdiction) and 
																		right.accident_date = left.accident_date and
																		right.report_type_id = left.report_type_id ,
																		transform(recordof(accnbr_key),
																		self := right),limit(eCrash_Services.constants.MAX_ACCIDENTS_PER_DAY, fail(203, doxie.ErrorCodes(203))));
																		
      payload_person_recs := project(payload_person_recs_tmp,TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));																		
			
			//OUTPUT(count(payload_person_recs_tmp),named('payload_person_recs_tmp_count'));
			
			//OUTPUT(payload_limit_recs[1],named('payload_limit_recs'));
															
      merged_person_recs :=  deltabse_person_recs + payload_person_recs;
			//merged_person_recs :=  deltabse_person_recs; //Temp Remove
			
			recs_filtered_dedup := eCrash_Services.Functions.PreferDriverRecords(merged_person_recs);
			
			//OUTPUT(count(recs_filtered_dedup),named('recs_filtered_dedup_count'));
			
			recs_result := eCrash_Services.functions.InvolvedPartyTransform(recs_filtered_dedup,in_mod,true);
						
			iesp.ecrash.t_ECrashSearchRecord setLastName(iesp.ecrash.t_ECrashSearchRecord l) := TRANSFORM
				SELF.LastName :=  eCrash_Services.fn_CombineWords(SET(project(l.InvolvedParties(Name.Last <> ''),TRANSFORM(eCrash_Services.Layouts.LastNameSortValue, SELF.LastName:=LEFT.Name.Last)), LastName), ',');
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
		
			grouped_result_recs := eCrash_Services.functions.SubscriptionNonAssociatedGroupedReports(sorted_recs);
			
			return grouped_result_recs;
		END;
		
END;
