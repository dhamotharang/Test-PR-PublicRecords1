import FLAccidents_Ecrash,codes,ut,AutoStandardI,iesp,AutoKeyI,lib_stringlib,doxie,Std,BatchShare;

//** Added the fix for bug 138974


EXPORT Records(IParam.searchrecords in_mod) := MODULE

		shared Raw_in := Raw(in_mod);
				
		EXPORT getSearchRecords() := FUNCTION 
		
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
		
		by_rptNum := Raw_in.by_rpt_num();
		by_autoRecs := Raw_in.by_auto_recs();	
		
		initial_search_report_by := if(use_rpt_num, by_rptNum, by_autoRecs);
						
		//------- by exact report# or by autoRecs -----------------------------------------------------------------------
		recs_raw_tmp := MAP(use_first_name_search => Raw_in.byFirstName(), 
												use_last_name_search => Raw_in.byLastName(),
												use_location => Raw_in.byLocation(), 
												Raw_in.byReportNumber(initial_search_report_by));
	
		deltaIncidentsFirst := MAP(use_first_name_search => DeltaBaseRecords.readByFirstName(),
														   use_location => DeltaBaseRecords.readByLocation(),
														   use_rpt_num => DeltaBaseRecords.readFirstByReport(),
														   DeltaBaseRecords.readFirstByAuto());  
		
			/*debugInitialSearchBy := MAP(use_first_name_search => 'First Name Search', 
															 use_location => 'location search',
															 use_rpt_num => 'Report number search',
															 'Auto Key Search');*/
																 
			recs_raw_tmp_pen :=project(recs_raw_tmp,TRANSFORM(Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));
			deltaIncidentsFirst_Pen:=project(deltaIncidentsFirst,TRANSFORM(Layouts.recs_with_penalty, SELF.isDelta:=true, SELF.isMatched:=true, SELF:=LEFT));
			deltaMergedInitialReadRecs := recs_raw_tmp_pen + deltaIncidentsFirst_Pen;
			// deltaMergedInitialReadRecs := deltaIncidentsFirst_Pen;//temp remove
			FIRSTCount := 'BAPDEBUG_DeltaIncidentsFirst_COUNT: '+COUNT(deltaIncidentsFirst);

			boolean initial_searchby_exists := EXISTS(deltaMergedInitialReadRecs);

			//---------------------------------------------------------------------------------------------------------------

			//-------- by partial report# -----------------------------------------------------------------------------------
			boolean use_fuzzyrpt_search := use_rpt_num and NOT initial_searchby_exists;
			
			unsigned fuzzy_days_range:= MAP(hasInputDOL => constants.searchDateRange(hasInputDOL,in_mod.UserType),
																			hasInputDOLDateRange => ut.DaysApart(in_mod.dolStartDate,in_mod.dolEndDate),
																			0);
			
			TODAY := ut.GetDate;	

			computed_DOL:= MAP(hasInputDOL => in_mod.dateofloss, 
												 hasInputDOLDateRange => in_mod.dolStartDate,
												 TODAY);
												 
			computed_date_range := if(use_fuzzyrpt_search OR hasInputDOLDateRange,fuzzy_days_range,0);
			
			ds_date_range := functions.create_date_dataset(computed_DOL,computed_date_range,computed_DOL<>TODAY AND ~hasInputDOLDateRange, hasInputDOLDateRange);
			
			STRING8 date_min := MIN(ds_date_range,dateRange);
			STRING8 date_max := MAX(ds_date_range,dateRange);

			partial_recs_tmp := Raw_in.byPartialReportNumber(ds_date_range, hasInputDolParams);
			deltaPartialBatch := DeltaBaseRecords.readPartialReportNumBatch(date_min, date_max);
			partial_recs_tmp_pen :=project(partial_recs_tmp,TRANSFORM(Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));
			deltaPartialBatch_pen:=project(deltaPartialBatch,TRANSFORM(Layouts.recs_with_penalty, SELF.isDelta:=true, SELF.isMatched:=true, SELF:=LEFT));
			deltaMergedPartialReportNo := partial_recs_tmp_pen + deltaPartialBatch_pen;
			//deltaMergedPartialReportNo := deltaPartialBatch_pen;//temp remove
			//---------------------------------------------------------------------------------------------------------------
			
			//--------- by date of loss if sent in_mod ----------------------------------------------------------------------
			dol_recs := Raw_in.byDOL(date_min,date_max);
		
			deltaDOLBatch := DeltaBaseRecords.readDOLBatch(date_min, date_max);
			dol_recs_pen :=project(dol_recs,TRANSFORM(Layouts.recs_with_penalty, SELF.isMatched:=true, SELF:=LEFT));
			deltaDOLBatch_pen:=project(deltaDOLBatch,TRANSFORM(Layouts.recs_with_penalty, SELF.isDelta:=true, SELF.isMatched:=true, SELF:=LEFT));
			
			deltaMergedDOLRecs := dol_recs_pen + deltaDOLBatch_pen;

			//deltaMergedDOLRecs := deltaDOLBatch_pen; //Temp Remove
			
			//---------------------------------------------------------------------------------------------------------------

			/* ********************************* SEARCH LOGIC OVERVIEW *****************************
			 initialLookup  (both versions generically)
						if in_mod.report# not empty then search on that exact, else search by name if that was sent. 
						Also, in the SQL version, if report lookup is empty and a name was provided, try it.

			 use_fuzzyrpt_search=true - if in_mod.report# not empty AND IF records NOT found
			 but initial_searchby_exists is true if something was found above by either method
			
			 setup date range for later use (both versions generically)
						computed_date_range = if NOT hasInputDOL, 90, else depends on user type either 3 or 30
						if above set use_fuzzyrpt_search=true, computed_date_range, else final date_range is 0
			
			 searchByPartialReportNum using date range (SQL Version, which s/b similar to hpcc version)
					 if hasInputDOL, search by partialRptNum + date_range + jurisIfParms + locationIfParms
					 else, search by partialRptNum + jurisIfParms + locationIfParms
			
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
													use_fuzzyrpt_search => deltaMergedPartialReportNo, 			// partial report number search
													hasInputDolParams => deltaMergedDOLRecs,// DOL Search
													dataset([],Layouts.recs_with_penalty));
		
			// DEBUG ONLY -- COMMENT THIS SECTION ***** Very useful if you need to find a search problem ***
			string debugMap := MAP(initial_searchby_exists => 'by autokeys or report number',
													use_fuzzyrpt_search => 'partial report number search',
													hasInputDOL => 'DOL Search',
													hasInputDOLDateRange => 'DOL Range Search',
													'EMPTY SET');

		
			// OUTPUT(debugMap,named('debugMap_PATH_CHOSEN'));

			recs_raw_all := Functions.FilterOutDeletedReports(recs_raw_all_with_deleted);	



			// END DEBUG ONLY -- COMMENT THIS SECTION *******************************************************
			
			// penalize for NAME mismatches
			recs_plus_pen := 
					PROJECT(recs_raw_all,
							TRANSFORM(Layouts.recs_with_penalty,
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

			recs_raw_ids := dedup(
				sort(
					recs_plus_pen(
						penalt<2 
						or (Std.Str.CountWords(lname, ' ') > 1 and BatchShare.Functions.fn_FuzzyLastNameMatch('', lname, '', in_mod.lastname))
						or (Std.Str.CountWords(in_mod.lastname, ' ') > 1 and BatchShare.Functions.fn_FuzzyLastNameMatch('', in_mod.lastname, '', lname))
					),
					penalt,
					l_accnbr,
					-accident_date
				),
				record
			);

			//-- pick up all accounts records, if either of records passed penalty filter --------------------------------------
			recs_raw_dupe := join(recs_raw_all,recs_raw_ids,
												(left.l_accnbr=right.l_accnbr) and
												(left.jurisdiction = right.jurisdiction),
												transform(Layouts.recs_with_penalty,
												self.penalt:=right.penalt,self:=left),limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203))));
												
			//deduping records since we have dupes there due to the nature of our deltabase data 
			//(having extra record for each report with switched case identifier if both case id and state report number are not empty)
			//and also we potentially have a lot of dupes produced by the join above
			recs_raw := Functions.PreferDriverRecords(recs_raw_dupe);
			
			//---------------------------------------------------------------------------------------------------------------
			// ======= search is completed, the remaining is a waterfall approach based on preferences =======
			//---------------------------------------------------------------------------------------------------------------

			// boolean ignore_state_search 				:= in_mod.JurisdictionState='';
			// boolean ignore_jurisdiction_search	:= in_mod.jurisdiction='';
			boolean ignore_state_search 						:= constants.no_state_search(in_mod);
			boolean ignore_jurisdiction_search 			:= constants.no_jurisdiction_search(in_mod);
			boolean ignore_dateofloss_search 		:= in_mod.dateofloss='' AND in_mod.dolStartDate='';
			string incoming_dateofloss_param		:= if(in_mod.dateofloss !='',in_mod.dateofloss,in_mod.dolStartdate);
			recordof(in_mod.agencies) xform_agency():=TRANSFORM
					self:=[];
		  END;
			
			agency_ds := IF(exists(in_mod.agencies), in_mod.agencies, dataset([xform_agency()]));
			ds_filtered :=  JOIN(recs_raw, agency_ds, (left.jurisdiction = right.jurisdiction OR
																											 ignore_jurisdiction_search)
																											 AND 
                                                      (left.jurisdiction_state = right.JurisdictionState OR
																											 ignore_state_search), TRANSFORM(LEFT), ALL);
	
		ds_filtered_reports := Functions.dedupReportRecordsFromParties(ds_filtered);
    ds_dol_range_raw := join(ds_date_range, ds_filtered_reports, 
		                     right.accident_date=left.daterange,
												 transform(Layouts.recs_with_penalty,self:=right),
												 limit(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203)))); 

		ds_dol_range := JOIN(
			ds_dol_range_raw,
			ds_filtered,
			LEFT.l_accnbr = RIGHT.l_accnbr AND
			LEFT.jurisdiction = RIGHT.jurisdiction AND
			LEFT.jurisdiction_state = RIGHT.jurisdiction_state AND
			LEFT.accident_date = RIGHT.accident_date,
			TRANSFORM(Layouts.recs_with_penalty, SELF:=RIGHT),
			LIMIT(constants.MAX_REPORT_NUMBER, fail(203, doxie.ErrorCodes(203)))
		);		
	
    recs_exact1 :=  if (ignore_dateofloss_search, ds_filtered, ds_dol_range);
																
			//partial report number search already filtered on jurisdiction info if present in params
			recs_exact1_final := IF(use_fuzzyrpt_search, 
															IF(hasInputDolParams, recs_raw(ut.DaysApart(accident_date,incoming_dateofloss_param) <= fuzzy_days_range), recs_raw), 
															recs_exact1); 
															
			
			recs_exact_loc:=functions.location_filter(recs_exact1_final,in_mod);
			
			
			boolean direct_match := EXISTS(recs_exact_loc) and not use_fuzzyrpt_search;
			boolean Possible_match := (not direct_match and EXISTS(recs_exact1_final));
			

			// recs_exact_jur:= JOIN(recs_raw, agency_ds, (left.jurisdiction = right.jurisdiction OR
																												// ignore_jurisdiction_search) AND 
                                                       // (left.jurisdiction_state = right.JurisdictionState  OR 
																												// ignore_state_search), TRANSFORM(LEFT) , ALL);
																
																
			recs_exact_dol_state:= JOIN(recs_raw(Constants.valid_match(accident_date,in_mod.dateofloss)), agency_ds, 
																												left.jurisdiction_state = right.JurisdictionState   OR 
																												ignore_state_search, TRANSFORM(LEFT), ALL);

			boolean hasExactJurRecs := EXISTS(ds_filtered);
			
																								
			recs_waterfall_days:= map(hasExactJurRecs and hasInputDolParams => ds_filtered(ut.DaysApart(accident_date,incoming_dateofloss_param)<=fuzzy_days_range),
																hasExactJurRecs => ds_filtered,
																recs_exact_dol_state);
																
			recs_waterfall_ds := JOIN(recs_raw(~hasInputDolParams or ut.DaysApart(accident_date,incoming_dateofloss_param)<=fuzzy_days_range), agency_ds,   
																												left.jurisdiction_state = right.JurisdictionState  OR 
																												ignore_state_search, TRANSFORM(LEFT) ,ALL);
																								
			recs_waterfall_pre_Loc	:=if(EXISTS(recs_waterfall_days),
																			recs_waterfall_days,
																			recs_waterfall_ds);
																								
																								
			recs_waterfall_loc_match := functions.location_filter(recs_waterfall_pre_Loc,in_mod);													
																
			recs_waterfall := if(EXISTS(recs_waterfall_loc_match),recs_waterfall_loc_match,recs_waterfall_pre_Loc);
			recs_filtered := MAP(constants.b_internal_pduser(in_mod.UserType) or direct_match => recs_exact_loc,
														use_fuzzyrpt_search => recs_waterfall,
														use_rpt_num => recs_exact_loc,
														Possible_match => if(exists(recs_exact_loc),recs_exact_loc,recs_exact1_final),
														recs_waterfall);

			//BAP NOTE: 6/4/13 - discussed with Hari/Justin how to handle which record to keep. 
			// When a new record comes in the HPCC would actually be preferable once it shows up, because it would have the cleansing we don't do in deltabase...
			// but if a record exists and they create a new one to replace an old version, then the delta would be preferable because it contains some new corrections.
			// We're going with - If we get both a delta record and a duplicate HPCC record, we want to return the deltabase row instead of the HPCC. 
			
			//** Added the fix for bug 138974, changed the sort to sort by date_aded only with in a source (delt base results,HPCC results).

			recs_filtered_dedup := Functions.PreferDriverRecords(recs_filtered);
	// 7/12/13: REMOVED THESE FROM THE SORT AND DEDUP ... accident_street,accident_cross_street,next_street,																										
			hash_key_recs:=project(deltaMergedInitialReadRecs,Layouts.recs_with_penalty);
			//Add dedup here to remove deltabase if required
			
			//** Added the fix for bug 138974, changed the sort to sort by date_aded only with in a source (delt base results,HPCC results).
			hash_key_recs_dedup := Functions.PreferDriverRecords(hash_key_recs);
																											
	// 7/12/13: REMOVED THESE FROM THE SORT AND DEDUP ... accident_street,accident_cross_street,next_street,																										
			sorted_final_recs := if(hasInputDOLDateRange,SORT(recs_filtered_dedup,-accident_date),recs_filtered_dedup);	

//Person records should not be restricted to 2k, since this is dropping out reports. This is an exisitng bug in production fixed with alias functionality
			// final_records:= if(in_mod.RequestHashKey,hash_key_recs_dedup,choosen(sorted_final_recs,iesp.constants.eCrashMod.MaxRecords));
			final_records:= if(in_mod.RequestHashKey,hash_key_recs_dedup,sorted_final_recs);									 
			
			//associated_reports := Raw_in.getAssociatedReports(final_records);
			
			//final_associated_reports := associated_reports + final_records;								
			
			recs_result := functions.InvolvedPartyTransform(final_records,in_mod,direct_match);
			
			grouped_result_recs := functions.AssociatedReportsTransform(recs_result,in_mod);
			
			final_recs_ds := if(in_mod.GroupRecords, grouped_result_recs, recs_result);
			
			final_recs_result := functions.SortFinalResults(final_recs_ds, in_mod);
			
			// final_recs_result := if(in_mod.GroupRecords, SORT(grouped_result_recs,-DateOfLoss), SORT(recs_result,-DateOfLoss));

			return final_recs_result;
		END;
	
		EXPORT getSubscriptionRecords() := FUNCTION
			Raw_in := Raw(in_mod);
			return Raw_in.getSubscriptionReports();
		END;
		
END;
