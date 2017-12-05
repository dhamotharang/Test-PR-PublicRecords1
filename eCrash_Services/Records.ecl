/*2017-10-16T22:02:17Z (Sajish Sasikumar)
Added Name criss cross validation for VIN/LicensePlate/TagNumber/OfficerBadge searches
*/
/*2017-10-03T22:31:05Z (Dmitriy Lazarenko)
[ECH-5359] removing partial report search capabilities. Cleaning up paths (adding "eCrash_Services." prefix where needed)
*/
import FLAccidents_Ecrash, codes, ut, AutoStandardI, iesp, AutoKeyI, lib_stringlib, doxie, Std, BatchShare, Gateway, eCrash_Services;

//** Added the fix for bug 138974


EXPORT Records(eCrash_Services.IParam.searchrecords in_mod) := MODULE

		shared Raw_in := Raw(in_mod);
				
		EXPORT getKYrecords() := FUNCTION	
				
				appriss_agency_key := FLAccidents_Ecrash.key_EcrashV2_agency;
				
				boolean KY_state  := in_mod.Agencies.JurisdictionState = 'KY';
				KY_Agency_ds 			:= in_mod.Agencies(KY_state);
				NONKY_Agency_ds   := in_mod.Agencies(NOT KY_State);
			
				eCrash_Services.Layouts.KY_Response_incident xform_proj(RECORDOF(KY_Agency_ds) l) := TRANSFORM
					self.state := l.JurisdictionState;
					self.AgencyName := l.Jurisdiction;
					self.AgencyORI  := l.AgencyORI;
					self := l;
					self := [];
				END; 
				
				DATASET(eCrash_Services.Layouts.KY_Response_incident) agency_validation_ds_1 := PROJECT(KY_Agency_ds,xform_proj(LEFT));	
				DATASET(eCrash_Services.Layouts.KY_Response_incident) NONKY_Agency_ds_ref := PROJECT(NONKY_Agency_ds,xform_proj(LEFT));	

				KY_Apriss_Agency_Ds := join(agency_validation_ds_1,appriss_agency_key
   																, keyed(right.Agency_State_Abbr = left.state) 
																		and keyed(right.agency_name = left.AgencyName ) 
																	,	transform(eCrash_Services.Layouts.KY_Response_incident, self.source_id := right.source_id, self.AgencyORI := right.Agency_ori, self := left)
																	,	limit(eCrash_Services.constants.MAX_PARTIAL_NUMBER, fail(203, doxie.ErrorCodes(203))) , left outer);
				
				boolean appriss_agency 	 := TRIM(KY_Apriss_Agency_Ds.source_id) = 'A';
				
				KY_Apriss_Agencies	 		 := PROJECT(KY_Apriss_Agency_Ds(appriss_agency), 
																						 TRANSFORM(iesp.ecrash.t_ECrashSearchAgency,
																											self.JurisdictionState := left.state;
																											self.Jurisdiction := left.AgencyName;
																											self  := left;));
																											 
				KY_Non_Apriss_Agencies	 := KY_Apriss_Agency_Ds(NOT appriss_agency);
				
				IsSafeToPerformSoap  := in_mod.KY_SearchEspNAME <> '' AND in_mod.KY_SearchEspURL <> '' and COUNT(KY_Apriss_Agencies) > 0;
								
				KY_Response := IF(IsSafeToPerformSoap,Gateway.SoapCall_KY( KY_Apriss_Agencies , in_mod));
				
				eCrash_Services.Layouts.KY_Response_incident Xform_norm( iesp.ky_search.t_KYCrashSearchIncident Incidents
																													,	 RECORDOF(KY_Response) Response_agency ) := TRANSFORM 																																													
								self.Message := Response_agency.Response._header.message;
								self := Incidents;
								self := [];
				END;
				
				// Get the incidents from the response alongwith the primaryagency & agencyid
				KY_incidents	 := normalize(KY_Response,LEFT.Response.incidents,Xform_norm(RIGHT,LEFT));		
												
				// Validation 1  -- Last name &  dol are mandatory
				boolean first_validation_param_exists := 	in_mod.DateOfLoss <> '' AND in_mod.lastname <> '';
				
				KY_incidents_interim := IF(first_validation_param_exists AND IsSafeToPerformSoap, KY_incidents, agency_validation_ds_1); 
				//Validation 2 - No agency name or have a soap error message
				boolean invalid_soap_response := KY_incidents_interim.message <> '' OR 
																					COUNT(KY_incidents_interim(ReportNumber <> ''))= 0;
																					
				DATASET(eCrash_Services.Layouts.KY_Response_incident) agency_validation_ds_2 := KY_incidents_interim(invalid_soap_response);
								
				DATASET(eCrash_Services.Layouts.KY_Response_incident) KY_incidents_prejoin:= KY_incidents_interim(NOT invalid_soap_response);
				
				KY_incidents_prejoin_dedup := DEDUP(SORT(KY_incidents_prejoin, State, AgencyName, AgencyORI), State, AgencyName, AgencyORI);
				
				KY_Incidents_appriss_withAgency := JOIN(KY_incidents_prejoin_dedup , KY_Apriss_Agency_Ds,
																					  left.State = right.State
																						and  left.AgencyName = right.AgencyName
																						and  (right.AgencyORI = '' OR left.AgencyORI = right.AgencyORI),
																					  transform(RECORDOF(KY_incidents_prejoin),
																									 boolean matching_rec := (left.State = right.State and 
																																						left.AgencyName = right.AgencyName and
																																						(right.AgencyORI = '' OR left.AgencyORI = right.AgencyORI)); 
																									 self.Agencyid := IF(matching_rec, right.Agencyid, left.Agencyid); 
																									 self.PrimaryAgency := IF(matching_rec, right.PrimaryAgency, left.PrimaryAgency); 
																									 self.AgencyMatch := matching_rec;
																									 self.IsReadyForPublic := TRUE;
																									 self.source_id := right.source_id;
																								   self := left;));
				
			
				
				// Validation 3 -- agency should be  appriss	
				agency_validation_ds_3 := KY_Incidents_appriss_withAgency(NOT AgencyMatch);				

				KY_INcidents_Appriss_prefinal := KY_Incidents_appriss_withAgency(AgencyMatch);
					
				iesp.ecrash.t_ECrashSearchRecord xform_final_result(RECORDOF(KY_INcidents_Appriss_prefinal) L) := TRANSFORM
					self.VendorCode := eCrash_Services.Constants.VENDOR_CRASHLOGIC ; 
					self.JurisdictionState := L.State;
					self.Jurisdiction := 	L.AgencyName;
					self.AgencyORI := L.AgencyORI;
					self.AgencyId  := L.AgencyId;
					self.AccidentLocation.Street := L.PrimaryStreet;
					self.AccidentLocation.CrossStreet := L.CrossStreet;
				  self.ReportCode  := eCrash_Services.Constants.REPORT_CODE_KY;
					self.StateReportNumber  := L.CaseNumber;
					self.ResultType  := IF(L.PrimaryAgency , eCrash_Services.constants.DIRECT_hit, eCrash_Services.constants.POSSIBLE_hit);
					self.Reports := project(dataset(L),transform(iesp.ecrash.t_ECrashSearchRecordData
																							,	self.ContribSource := left.source_id
																							, self.ReportType  :=  eCrash_Services.Constants.REPORT_CODE_ACCIDENT
																							, self.VendorCode :=  eCrash_Services.Constants.VENDOR_CRASHLOGIC
																							, self.Jurisdiction := left.AgencyName
																							, self.JurisdictionState := left.State
																							, Self.AgencyId := left.AgencyId
																							, self.AgencyORI := left.AgencyORI
																							, self.DateOfLoss.Year := (integer2)in_mod.DateOfLoss[1..4]
																							, self.DateOfLoss.Month := (integer2)in_mod.DateOfLoss[5..6]	
																							, self.DateOfLoss.Day := (integer2)in_mod.DateOfLoss[7..8]
																							, self.AccidentLocation.Street := left.PrimaryStreet
																							, self.AccidentLocation.CrossStreet := left.CrossStreet
																							, self.ResultType  := IF(L.PrimaryAgency, eCrash_Services.constants.DIRECT_hit, eCrash_Services.constants.POSSIBLE_hit)
																							, self.StateReportNumber  := left.CaseNumber;
																							, self.InvolvedParties := project(L.persons
																																								,transform(iesp.ecrash.t_ECrashInvolvedParty
																																									, self.Name.First := (string20) left.FirstName
																																									, self.Name.Last  := (string20) left.Lastname
																																									, self.DriverLicenseNumber :=  left.DriversLicenseNumber
																																									, self.Address.State  := (string2) left.DriversLicenseState	
																																									, self := []
																																												)) 
																											, self := left
																											, self := []));					
					self := L;
					self := [];
				END;
				
				final_KY_Incidents := project(KY_INcidents_Appriss_prefinal,xform_final_result(left));
						
				// Return the ALias_Agencies & KY_response dataset 				
				Agencies_HPCC_Delta := If(NOT first_validation_param_exists,agency_validation_ds_1 + NONKY_Agency_ds_ref, NONKY_Agency_ds_ref	+	KY_Non_Apriss_Agencies + agency_validation_ds_2	+	agency_validation_ds_3);
				
				// JOin with the initial agencies datset to get the Agency details
				nonky_agencies_final	:= JOIN(	Agencies_HPCC_Delta
																				, in_mod.Agencies
																				, 	 left.State = right.JurisdictionState
																				and  left.AgencyName = right.Jurisdiction
																				and  (right.AgencyORI = '' OR left.AgencyORI = right.AgencyORI)
																				and  (right.Agencyid = '' OR left.Agencyid = right.Agencyid)
																				, transform(iesp.ecrash.t_ECrashSearchAgency,
																										self := right;), lookup);																												

				RECORD_DS :=RECORD
					dataset(RECORDOF(nonky_agencies_final)) alias_agencies ,
					dataset(RECORDOF(Final_KY_Incidents)) ky_response_final
				END;
				
				return dataset([{nonky_agencies_final , final_KY_Incidents }],RECORD_DS);
			
		END;			
				
		EXPORT getSearchRecords(dataset(iesp.ecrash.t_ECrashSearchAgency) Agencies
												 ,  dataset(iesp.ecrash.t_ECrashSearchRecord) KY_Response) := FUNCTION 
		
		DeltaBaseRecords := RecordsDeltaBase(in_mod);
		boolean hasLocationInformation := in_mod.AccidentLocationCrossStreet <> '' OR in_mod.AccidentLocationStreet <> '';
		boolean hasInputDOL := in_mod.dateOfLoss <> '';
		boolean hasInputDOLDateRange := in_mod.dolstartdate <> '' and in_mod.dolenddate <> '';
		
		boolean dateRangeProblem := (in_mod.dolstartdate <> '' and in_mod.dolenddate = '') 
		                            or (in_mod.dolstartdate = '' and in_mod.dolenddate <> '');
		
		boolean invalidDate := (in_mod.dolstartdate <> '' and in_mod.dolstartdate < '19000000')
														or (in_mod.dolenddate <> '' and in_mod.dolenddate < '19000000')
														or (in_mod.dateOfLoss <> '' and in_mod.dateOfLoss < '19000000');

		IF(dateRangeProblem,fail(301, doxie.ErrorCodes(301)));
		
		IF(invalidDate,fail(303, doxie.ErrorCodes(303)));
		
		boolean hasInputDolParams := hasInputDol OR hasInputDOLDateRange;
		
		boolean use_rpt_num:= in_mod.reportnumber<>'';
		boolean use_first_name_search := in_mod.firstname != '' AND in_mod.lastname = '' AND ~use_rpt_num;  
		boolean use_last_name_search := in_mod.lastname != '' AND in_mod.firstname = '' AND ~use_rpt_num ;  
		boolean use_location := ~use_rpt_num AND hasLocationInformation;
		boolean use_vin := in_mod.VehicleVin <> '' AND ~use_rpt_num;
		boolean use_drivers_license_num := in_mod.driversLicenseNumber <> '' AND ~use_rpt_num;
		boolean use_license_plate := in_mod.LicensePlate <> '' AND ~use_rpt_num;
		boolean use_officer_badge := in_mod.OfficerBadgeNumber <> '' AND ~use_rpt_num;
		
		by_rptNum := Raw_in.by_rpt_num();
		by_autoRecs := Raw_in.by_auto_recs();	
		
		initial_search_report_by := if(use_rpt_num, by_rptNum, by_autoRecs);
			
		//------- by exact report# or by autoRecs -----------------------------------------------------------------------
		recs_raw_tmp := MAP(use_vin => Raw_in.byVin(),
												use_drivers_license_num => Raw_in.byDriversLicenseNum(),
												use_license_plate => Raw_in.byLicensePlate(),
												use_officer_badge => Raw_in.byOfficerBadge(),
												use_first_name_search => Raw_in.byFirstName(),  
												use_last_name_search => Raw_in.byLastName(),
												use_location => Raw_in.byLocation(), 
												Raw_in.byReportNumber(initial_search_report_by)); 
	
		deltaIncidentsFirst := MAP(use_first_name_search => DeltaBaseRecords.readByFirstName(),
														   use_location => DeltaBaseRecords.readByLocation(),
														   use_rpt_num => DeltaBaseRecords.readFirstByReport(),
															 DeltaBaseRecords.readFirstByAuto());  
		/*
			debugInitialSearchBy := MAP(use_first_name_search => 'First Name Search', 
															 use_last_name_search => 'Last Name Search', 
															 use_location => 'location search',
															 use_rpt_num => 'Report number search',
															 'Auto Key Search');
			output(debugInitialSearchBy, named('debugInitialSearchBy'));	
*/
																 
			recs_raw_tmp_pen :=project(recs_raw_tmp,TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));
			deltaIncidentsFirst_Pen:=project(deltaIncidentsFirst,TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF.isDelta:=true, SELF.isMatched:=true, SELF:=LEFT));
			deltaMergedInitialReadRecs := recs_raw_tmp_pen + deltaIncidentsFirst_Pen;
			 
			
			FIRSTCount := 'BAPDEBUG_DeltaIncidentsFirst_COUNT: '+COUNT(deltaIncidentsFirst);

			BOOLEAN initial_searchby_exists := EXISTS(deltaMergedInitialReadRecs);

			//---------------------------------------------------------------------------------------------------------------

			UNSIGNED dol_days_range:= IF(hasInputDOLDateRange, ut.DaysApart(in_mod.dolStartDate,in_mod.dolEndDate), 0); 
			
			TODAY := (STRING)Std.Date.Today();
			computed_DOL:= MAP(
				hasInputDOL => in_mod.dateofloss, 
				hasInputDOLDateRange => in_mod.dolStartDate,
				TODAY
			);
												 
			computed_date_range := IF(hasInputDOLDateRange, dol_days_range, 0);
			ds_date_range := eCrash_Services.functions.create_date_dataset(
				computed_DOL,
				computed_date_range,
				hasInputDOLDateRange
			);
			
			STRING8 date_min := MIN(ds_date_range,dateRange);
			STRING8 date_max := MAX(ds_date_range,dateRange);

			//---------------------------------------------------------------------------------------------------------------
			
			//--------- by date of loss if sent in_mod ----------------------------------------------------------------------
			
			dol_recs := Raw_in.byDOL(date_min, date_max);
			deltaDOLBatch := DeltaBaseRecords.readDOLBatch(date_min, date_max);
			dol_recs_pen :=project(dol_recs,TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));
			deltaDOLBatch_pen:=project(deltaDOLBatch,TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF.isDelta:=true, SELF.isMatched:=true, SELF:=LEFT));
			
			deltaMergedDOLRecs := dol_recs_pen + deltaDOLBatch_pen;
				
			//---------------------------------------------------------------------------------------------------------------

			/* ********************************* SEARCH LOGIC OVERVIEW *****************************
			 initialLookup  (both versions generically)
						if in_mod.report# not empty then search on that exact, else search by name if that was sent. 
						Also, in the SQL version, if report lookup is empty and a name was provided, try it.

			 use_fuzzyrpt_search=true - if in_mod.report# not empty AND IF records NOT found
			 but initial_searchby_exists is true if something was found above by either method
			
			 setup date range for later use (both versions generically)
						computed_date_range = amount of days in the DOL range provided
						if above set use_fuzzyrpt_search=true, computed_date_range, else final date_range is 0
			
			 searchByDOL using date range (SQL Version, which s/b similar to hpcc version)
					 exactLookup - if hasInputDOL, do a lookup by exactly that date 
								DOLEqualsSQLIfParms + fuzzyCaseIdentitySQL + jurisAndStateIfParmsElseNotNull+ANYStreetSQLifParms
					 and always do a fuzzyLookup - use computed date range to do 
								DOLBetweenOrEqSQL + fuzzyCaseIdentitySQL + jurisAndStateIfParmsElseNotNull+ANYStreetSQLifParms
					 IF(EXISTS(exactLookup) return exactLookup, else return fuzzyLookup
			 Now you have 3 returned datasets: initialLookup, searchByPartialReportNum, searchByDOL 
			****************************************************************************************/


			//---------------------------------------------------------------------------------------------------------------
			//Deltabase merges must happen prior to this point.  
			//---------------------------------------------------------------------------------------------------------------
			
			//---------------------------------------------------------------------------------------------------------------
			//----- choose the most relevant search results -----------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------
			
			//TODO- in SQL deltabase, I wonder if name lookups are better than partial reads - SEE IF TESTING HAS ISSUES
			
			recs_raw_all_with_deleted := MAP(initial_searchby_exists => deltaMergedInitialReadRecs, 	// by autokeys or report number
																			 hasInputDolParams AND ~use_rpt_num => deltaMergedDOLRecs,// DOL Search
																			 dataset([],eCrash_Services.Layouts.recs_with_penalty));
		
			// DEBUG ONLY -- COMMENT THIS SECTION ***** Very useful if you need to find a search problem ***
			string debugMap := MAP(initial_searchby_exists => 'by autokeys or report number',
														 hasInputDOL => 'DOL Search',
														 hasInputDolParams  AND ~use_rpt_num => 'DOL Range Search',
														 'EMPTY SET');

			// OUTPUT(debugMap,named('debugMap_PATH_CHOSEN'));
			// END DEBUG ONLY -- COMMENT THIS SECTION *******************************************************
			
			recs_raw_all := eCrash_Services.Functions.FilterOutDeletedReports(recs_raw_all_with_deleted);				
			
			// penalize for NAME mismatches
			recs_plus_pen := 
					PROJECT(recs_raw_all,
							TRANSFORM(eCrash_Services.Layouts.recs_with_penalty,
									tempindvmod := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
											EXPORT fname_field := left.fname;
											EXPORT mname_field := '';
											EXPORT lname_field := left.lname;
											EXPORT allow_wildcard := false;
									END;

									tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);
									self.penalt := tempPenaltIndv;
									self := left;
							)
				 );

			recs_raw_ids := DEDUP(
				SORT(
					recs_plus_pen(
						penalt<2 
						OR ((Std.Str.CountWords(lname, ' ') > 1 OR Std.Str.CountWords(in_mod.lastname, ' ') > 1) 
							AND eCrash_Services.Functions.StringTokenMatch(lname, in_mod.lastname)
						)
					),
					penalt,
					l_accnbr,
					-accident_date
				),
				RECORD
			);

			//-- pick up all accounts records, if either of records passed penalty filter --------------------------------------
			recs_raw_dupe := join(recs_raw_all,recs_raw_ids,
												(left.l_accnbr=right.l_accnbr) and
												(left.jurisdiction = right.jurisdiction),
												transform(eCrash_Services.Layouts.recs_with_penalty,
												self.penalt:=right.penalt,self:=left),limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
												
			//deduping records since we have dupes there due to the nature of our deltabase data 
			//(having extra record for each report with switched case identifier if both case id and state report number are not empty)
			//and also we potentially have a lot of dupes produced by the join above
			recs_raw := eCrash_Services.Functions.PreferDriverRecords(recs_raw_dupe);
			
			//---------------------------------------------------------------------------------------------------------------
			// ======= search is completed, the remaining is a waterfall approach based on preferences =======
			//---------------------------------------------------------------------------------------------------------------

			boolean ignore_state_search 						:= eCrash_Services.constants.no_state_search(in_mod);
			boolean ignore_jurisdiction_search 			:= eCrash_Services.constants.no_jurisdiction_search(in_mod);
			boolean ignore_dateofloss_search 		:= in_mod.dateofloss='' AND in_mod.dolStartDate='';
			string incoming_dateofloss_param		:= if(in_mod.dateofloss !='',in_mod.dateofloss,in_mod.dolStartdate);
						// VIYER - ECH - 4910 
/*  			recordof(in_mod.agencies) xform_agency():=TRANSFORM
      					self:=[];
      		  END;
   
   			
   			agency_ds := IF(exists(in_mod.agencies), in_mod.agencies, dataset([xform_agency()]));
*/

			recordof(Agencies) xform_agency():=TRANSFORM
      					self:=[];
      END;
			
			agency_ds := IF(exists(Agencies), Agencies, dataset([xform_agency()]));
			
			ds_filtered :=  JOIN(recs_raw, agency_ds, (left.jurisdiction = right.jurisdiction OR
																											 ignore_jurisdiction_search)
																											 AND 
                                                      (left.jurisdiction_state = right.JurisdictionState OR
																											 ignore_state_search), TRANSFORM(LEFT), ALL);
	
			ds_filtered_reports := eCrash_Services.Functions.dedupReportRecordsFromParties(ds_filtered);
			ds_dol_range_raw := join(ds_date_range, ds_filtered_reports, 
													 right.accident_date=left.daterange,
													 transform(eCrash_Services.Layouts.recs_with_penalty,self:=right),
													 limit(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203)))); 

			ds_dol_range := JOIN(
				ds_dol_range_raw,
				ds_filtered,
				LEFT.l_accnbr = RIGHT.l_accnbr AND
				LEFT.jurisdiction = RIGHT.jurisdiction AND
				LEFT.jurisdiction_state = RIGHT.jurisdiction_state AND
				LEFT.accident_date = RIGHT.accident_date,
				TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF:=RIGHT),
				LIMIT(eCrash_Services.constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203)))
			);		
	
			recs_exact1 :=  if (ignore_dateofloss_search, ds_filtered, ds_dol_range);
			
			recs_exact_loc := eCrash_Services.functions.location_filter(recs_exact1,in_mod);
			
			
			boolean direct_match := EXISTS(recs_exact_loc);
			boolean Possible_match := (not direct_match and EXISTS(recs_exact1));
			

			// recs_exact_jur:= JOIN(recs_raw, agency_ds, (left.jurisdiction = right.jurisdiction OR
																												// ignore_jurisdiction_search) AND 
                                                       // (left.jurisdiction_state = right.JurisdictionState  OR 
																												// ignore_state_search), TRANSFORM(LEFT) , ALL);
																
																
			recs_exact_dol_state:= JOIN(recs_raw(eCrash_Services.Constants.valid_match(accident_date,in_mod.dateofloss)), agency_ds, 
																												left.jurisdiction_state = right.JurisdictionState   OR 
																												ignore_state_search, TRANSFORM(LEFT), ALL);

			boolean hasExactJurRecs := EXISTS(ds_filtered);
			
			recs_waterfall_days:= map(hasExactJurRecs and hasInputDolParams => ds_filtered(ut.DaysApart(accident_date,incoming_dateofloss_param) <= dol_days_range),
																hasExactJurRecs => ds_filtered,
																recs_exact_dol_state);
																
			recs_waterfall_ds := JOIN(recs_raw(~hasInputDolParams or ut.DaysApart(accident_date,incoming_dateofloss_param) <= dol_days_range), agency_ds,   
																												left.jurisdiction_state = right.JurisdictionState  OR 
																												ignore_state_search, TRANSFORM(LEFT) ,ALL);
																								
			recs_waterfall_pre_Loc	:=if(EXISTS(recs_waterfall_days),
																			recs_waterfall_days,
																			recs_waterfall_ds);
																								
																								
			recs_waterfall_loc_match := eCrash_Services.functions.location_filter(recs_waterfall_pre_Loc,in_mod);													
																
			recs_waterfall := if(EXISTS(recs_waterfall_loc_match), recs_waterfall_loc_match, recs_waterfall_pre_Loc); 

			recs_filtered := MAP(eCrash_Services.constants.b_internal_pduser(in_mod.UserType) OR direct_match OR use_rpt_num => recs_exact_loc,												
														Possible_match => IF(EXISTS(recs_exact_loc), recs_exact_loc, recs_exact1),
														recs_waterfall);

			recs_filtered_Debug := MAP(eCrash_Services.constants.b_internal_pduser(in_mod.UserType) OR direct_match OR use_rpt_num => 'recs_filtered_1',
														Possible_match => if(exists(recs_exact_loc),'recs_filtered_2','recs_filtered_3'),
														'recs_filtered_4');
			//output(recs_filtered_Debug, named('recs_filtered_Debug'));
			//BAP NOTE: 6/4/13 - discussed with Hari/Justin how to handle which record to keep. 
			// When a new record comes in the HPCC would actually be preferable once it shows up, because it would have the cleansing we don't do in deltabase...
			// but if a record exists and they create a new one to replace an old version, then the delta would be preferable because it contains some new corrections.
			// We're going with - If we get both a delta record and a duplicate HPCC record, we want to return the deltabase row instead of the HPCC. 
			
			//** Added the fix for bug 138974, changed the sort to sort by date_aded only with in a source (delt base results,HPCC results).

			recs_filtered_dedup := eCrash_Services.Functions.PreferDriverRecords(recs_filtered);
	// 7/12/13: REMOVED THESE FROM THE SORT AND DEDUP ... accident_street,accident_cross_street,next_street,																										
			hash_key_recs:=project(deltaMergedInitialReadRecs,eCrash_Services.Layouts.recs_with_penalty);
			//Add dedup here to remove deltabase if required
			
			//** Added the fix for bug 138974, changed the sort to sort by date_aded only with in a source (delt base results,HPCC results).
			hash_key_recs_dedup := eCrash_Services.Functions.PreferDriverRecords(hash_key_recs);
																											
	// 7/12/13: REMOVED THESE FROM THE SORT AND DEDUP ... accident_street,accident_cross_street,next_street,																										
			sorted_final_recs := if(hasInputDOLDateRange,SORT(recs_filtered_dedup,-accident_date),recs_filtered_dedup);	

//Person records should not be restricted to 2k, since this is dropping out reports. This is an exisitng bug in production fixed with alias functionality
			// final_records:= if(in_mod.RequestHashKey,hash_key_recs_dedup,choosen(sorted_final_recs,iesp.constants.eCrashMod.MaxRecords));
			final_records:= if(in_mod.RequestHashKey,hash_key_recs_dedup,sorted_final_recs);									 
			
			//associated_reports := Raw_in.getAssociatedReports(final_records);
			
			//final_associated_reports := associated_reports + final_records;								
			
			recs_result := eCrash_Services.functions.InvolvedPartyTransform(final_records,in_mod,direct_match);
		
			boolean has_vin := in_mod.VehicleVin <> '';
			boolean has_drivers_license_num := in_mod.driversLicenseNumber <> '';
			boolean has_license_plate := in_mod.LicensePlate <> '';
			boolean has_officer_badge := in_mod.OfficerBadgeNumber <> '';
		
			//filter involved party records by presence of each vehicle search parameter (vin/lic_num/tag_nbr)
			input_first_name_upper_cased := STD.Str.ToUpperCase(in_mod.firstname);
			input_last_name_upper_cased := STD.Str.ToUpperCase(in_mod.lastname);
			results_vin_filtered := IF(has_vin,
					recs_result (EXISTS(InvolvedParties((Vehicle.Vin = in_mod.VehicleVin) and 
																(input_first_name_upper_cased = '' OR input_first_name_upper_cased = Name.First) and
																(input_last_name_upper_cased = '' OR input_last_name_upper_cased = Name.Last)))),
					recs_result);
					
			results_lic_filtered := IF(has_drivers_license_num,
					results_vin_filtered (EXISTS(InvolvedParties((DriverLicenseNumber = in_mod.driversLicenseNumber)and 
																(input_first_name_upper_cased = '' OR input_first_name_upper_cased = Name.First) and
																(input_last_name_upper_cased = '' OR input_last_name_upper_cased = Name.Last)))), 
					results_vin_filtered);
					
			results_tag_filtered := IF(has_license_plate, 
					results_lic_filtered (EXISTS(InvolvedParties((Vehicle.Licenseplate = in_mod.LicensePlate)and 
																(input_first_name_upper_cased = '' OR input_first_name_upper_cased = Name.First) and
																(input_last_name_upper_cased = '' OR input_last_name_upper_cased = Name.Last)))), 
					results_lic_filtered);
			
			results_filtered := IF(has_officer_badge, 
					results_tag_filtered ((OfficerBadgeNumber = in_mod.OfficerBadgeNumber) and 
  															(EXISTS(InvolvedParties((input_first_name_upper_cased = '' OR input_first_name_upper_cased = Name.First) and
																												(input_last_name_upper_cased = ''  OR input_last_name_upper_cased = Name.Last))))), 
					results_tag_filtered);
	
			grouped_result_recs := eCrash_Services.functions.AssociatedReportsTransform(results_filtered,in_mod);
			
			final_recs_ds := if(in_mod.GroupRecords, grouped_result_recs, results_filtered);
			
				// VIYER - ECH 4910 - 08/07/2017
			final_recs := final_recs_ds + KY_Response;
			final_recs_result := eCrash_Services.functions.SortFinalResults(final_recs, in_mod);
			
			// final_recs_result := if(in_mod.GroupRecords, SORT(grouped_result_recs,-DateOfLoss), SORT(recs_result,-DateOfLoss));

			return final_recs_result;
		END;
	
		EXPORT getSubscriptionRecords() := FUNCTION
			Raw_in := Raw(in_mod);
			return Raw_in.getSubscriptionReports();
		END;
		
END;
