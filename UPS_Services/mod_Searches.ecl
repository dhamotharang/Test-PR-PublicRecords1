import autoheaderi, autostandardi,BIPV2, doxie, doxie_cbrs, iesp, address, UPS_Services, ut;


export mod_Searches := MODULE

	shared AIT := AutoStandardI.InterfaceTranslator;
	shared Constant := iesp.Constants.RA;

	// person and business records have slightly different layouts (esp names).
	// This common layout is a standard layout which fits both biz and person 
	// responses after this mod is called.  Only the fields which we are 
	// interested in are preserved..

	// ***** BUSINESS SEARCH ***** 
	export BusinessSearch := MODULE

		
		shared fn_RestrictBusinessSearch(//AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full in_mod, 
																					dataset(BIPV2.IDfunctions.rec_SearchInput) dsInput,
																					UPS_Services.mod_Params.BusinessSearch BizParams,
																										BOOLEAN useName = true, 
																										BOOLEAN useStreet = true,
																										BOOLEAN useCity = true,
																										BOOLEAN useState = true,
																										BOOLEAN useZip = true,
																										BOOLEAN usePhone = true,
																										BOOLEAN useALL = FALSE) := FUNCTION

			InputRow := dsInput[1];
			inName := if((useName OR useAll), InputRow.company_name, '');

			// Bugzilla 41403
			// we only want to run the street searches if we have a prim_range and
			// a prim_name.  Otherwise, we could end up with overly-broad queries 
			// such as street name + zip or street name + city + state.
			reallyUseStreet := ((useStreet OR useAll) AND InputRow.prim_range <> '' AND InputRow.prim_name <> '');
			inPrimRange := if(reallyUseStreet, InputRow.prim_range, '');
			inPrimName := if(reallyUseStreet, InputRow.prim_name, '');
			inSecRange := if(reallyUseStreet, InputRow.sec_range, '');

			inCity := if((useCity OR useAll), InputRow.city, '');
			inState := if((useState OR useAll), InputRow.state, '');
			inZip:= if((useZip OR useAll), InputRow.zip5, '');
			inPhone := if((usePhone OR useAll), InputRow.phone10, '');


			// Format to BIP search layout
			search_input := project(dsInput,UPS_Services.transforms.adjustSearchInput(left,false,inName,inPhone));

			//this will only be used for cases with '&' or ' AND '
			search_input_altName := project(dsInput,UPS_Services.transforms.adjustSearchInput(left,true,inName,inPhone));
			
			hasStreet := InputRow.prim_range <> '' OR InputRow.prim_name <> '' OR InputRow.sec_range <> '';
			execute := 
				useALL OR
				(
					(
						// this makes sure that every field is either populated or not in use
						(NOT useName OR InputRow.company_name <> '') AND
						(NOT reallyUseStreet OR hasStreet) AND
						(NOT useCity OR InputRow.city <> '') AND
						(NOT useState OR InputRow.state <> '') AND
						(NOT useZip OR InputRow.zip5 <> '') AND
						(NOT usePhone OR InputRow.phone10 <> '')
					)
					AND
					(			
						// the bad situation is where every field NOT used is empty (because we do an extra search)
						// so, one of the not used fields needs to have a value (or else its just a repeat of the all search)
						// hmm, would this already be taken care of by the first half of the definition of execute if useALL didnt exist?
						(NOT useName AND InputRow.company_name <> '') OR
						(NOT reallyUseStreet AND hasStreet) OR
						(NOT useCity AND InputRow.city <> '') OR
						(NOT useState AND InputRow.state <> '') OR
						(NOT useZip AND InputRow.zip5 <> '') OR
						(NOT usePhone AND InputRow.phone10 <> '')					
					)
				);

  // Get links ids for the search criteria		
	
	in_mod2 := module(AutoStandardI.DataRestrictionI.params)  
	  export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := BizParams.datarestrictionmask;
		export unsigned1 DPPAPurpose := BizParams.dppapurpose;
		export unsigned1 GLBPurpose := BizParams.glbpurpose;
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;	
	end;
	
	finalInput 	:= 	search_input + if(ut.mod_AmpersandTools.hasAmpersandOrHasAnd(inName),search_input_altName);

	tmpTopResultsScoredGrouped := if(	execute,UPS_Services.fn_BIPLookup(finalInput,in_mod2));

																														 
			rval := DEDUP(SORT(tmpTopResultsScoredGrouped, RECORD), RECORD);
			#IF(UPS_Services.Debug.debug_flag)
				BizQueryHistoryLayout := RECORD
					BOOLEAN Company;
					BOOLEAN Street;
					BOOLEAN City;
					BOOLEAN State;
					BOOLEAN Zip;
					BOOLEAN Phone;
					BOOLEAN _All;
					BOOLEAN executed;
				END;
				hist_ds := DATASET( [ { useName, useStreet, useCity, useState, 
																useZip, usePhone, UseAll, execute } ], BizQueryHistoryLayout);

				BizQueryValsLayout := RECORD
					BOOLEAN   execute;
					UNSIGNED  numResp;
					STRING120 Company;
					STRING10  PrimRange;
					STRING30  PrimName;
					STRING10  SecRange;
					STRING30  City;
					STRING2   State;
					STRING5   Zip;
					STRING10  Phone;
				END;
				vals_ds := DATASET( [ { execute, COUNT(rval), inName, inPrimRange, inPrimName, inSecRange, 
																inCity, inState, inZip, inPhone } ], BizQueryValsLayout);
				output(hist_ds, NAMED('BizQueryHistory'), EXTEND);
				output(vals_ds, NAMED('BizQueryValues'), EXTEND);
			#END
			return DEDUP(SORT(tmpTopResultsScoredGrouped, RECORD), RECORD);
		END;

													 
	shared RecWeightedLinkID := RECORD(UPS_Services.layouts.RecBipRecordOut2)
			UNSIGNED2 RAweight;
	end;

	shared dataset(RecWeightedLinkID) fn_WeightLinkIds(DATASET(UPS_Services.layouts.RecBipRecordOut2) recs, UNSIGNED2 weight) := FUNCTION

			RecWeightedLinkID weightedTransform(recs L) := TRANSFORM
				SELF := L;
				SELF.RAweight := weight;
			END;

			out_recs := PROJECT(recs, weightedTransform(LEFT));
			return out_recs;
		END;

		shared LinkIds(dataset(BIPV2.IDfunctions.rec_SearchInput) dsInput,
										UPS_Services.mod_Params.BusinessSearch BizParams) := FUNCTION
											
			// Get the LinkIds
			mInput := project(dsInput,transform(BIPV2.IDfunctions.rec_SearchInput,
					self.state := if(
					left.state <> '', 	//if state is given, use it
					left.state,
					if(left.city <> '',	//if state empty and city given, guess the state.
					address.Key_CityStChance(left.state = '' and keyed(city_name = left.city) and percent_chance > 50)[1].st, //no reason not to guess, but > 50 makes me deterministic
					left.state //blank
					)
				);
					self.allow7digitmatch := false;
					self := left));
					
			// Query BIP in various ways and weight the results.
			linkID_all := fn_RestrictBusinessSearch(mInput,BizParams, true, true, true, true, true, true, TRUE);
			wt_all := fn_WeightLinkIds(linkID_all, 15);

			linkID_street_city_state_zip := fn_RestrictBusinessSearch(mInput,BizParams, false, true, true, true, true, false);
			wt_street_city_state_zip := fn_WeightLinkIDs(linkID_street_city_state_zip, 3);

			linkID_name_city_state_zip := fn_RestrictBusinessSearch(mInput, BizParams, true, false, true, true, true, false);
			wt_linkID_name_city_state_zip := fn_WeightLinkIDs(linkID_name_city_state_zip, 1);
			
			linkID_name_zip_fuzzy := fn_RestrictBusinessSearch(mInput, BizParams, true, false, false, false, true, false); 
			wt_name_zip_fuzzy := project(
   				linkID_name_zip_fuzzy, 
   				transform(
   					RecWeightedLinkID,
   					self.RAweight := 
   						if(left.match_zip >0,left.match_zip,0)
   						+ if(left.is_FullMatch,2,0)
   						+ if(left.match_company_name > 0	or 
							     left.match_company_name_prefix > 0 or 	
									  left.match_cnp_name > 0,1,0),
   					self := left
   				)
   			);;
			
			linkID_phone := fn_RestrictBusinessSearch(mInput, BizParams, false, false, false, false, false, true);
			wt_phone := fn_WeightLinkIDs(linkID_phone, 7);

			combined_linkIDs := wt_all + 
												wt_street_city_state_zip +
												wt_name_zip_fuzzy +   
												wt_phone +
												wt_linkID_name_city_state_zip;

			grouped_linkIDs := GROUP(SORT(combined_linkIDs, UltID , OrgID ,SELEID ,ProxID), UltID , OrgID ,SELEID ,ProxID);
			clinkids := project(combined_linkIDs,transform(UPS_Services.layouts.RecBipRecordOut2, self := left , self :=[]));
			linkIDWeights := RECORD
				combined_linkIDs ;
				UNSIGNED4 SumRAweight := SUM(GROUP,combined_linkIDs.RAweight);
			END;

			scored_linkIDs := TABLE(grouped_linkIDs, linkIDWeights);
			sorted_linkIDs := SORT(scored_linkIDs, /*-RAweight*/ SumRAweight, ultid, orgid, seleid, proxid,-proxweight);

			max_linkIDs := 150;  // TODO - should be based on MaxResults!
			num_linkIDs := COUNT(sorted_linkIDs);
			ref_linkID := if (num_linkIDs > max_linkIDs, max_linkIDs, num_linkIDs);
			target_score := sorted_linkIDs[ref_linkID].SumRAweight;
			target_linkIDs := IF(num_linkIDs <= max_linkIDs, sorted_linkIDs, sorted_linkIDs(SumRAweight > target_score));

			linkIDs := PROJECT(MAP(num_linkIDs <= max_linkIDs => sorted_linkIDs,
											 COUNT(target_linkIDs) > (0.5 * max_linkIDs) => target_linkIDs,
											 CHOOSEN(sorted_linkIDs, max_linkIDs)), UPS_Services.layouts.RecBipRecordOut2);

			#IF(UPS_Services.Debug.debug_flag)
			output(wt_all, NAMED('linkID_wt_all'));
			output(count(linkIDs), NAMED('numlinkIDs'));
			output(linkIDs, NAMED('linkIDs'));
			#END

			return linkIDs;
		END;

		export records(UPS_Services.SearchParams SearchParams,
										 UPS_Services.mod_Params.BusinessSearch BizParams) := FUNCTION
			
			dsInput := dataset([UPS_Services.transforms.ConstructBipInput(SearchParams)]);
			
			bset := linkIDs(dsInput,BizParams);
			uselinkIDs := 
			MAP(
				exists(bset) => bset, 
				UPS_Services.Constants.DO_SECOND_SEARCH => mod_SecondSearch.Business(SearchParams, BizParams).records,
				DATASET([], UPS_Services.layouts.RecBipRecordOut2)
			);

			//Get the biz records
			 biz_allphones :=  uselinkIDs;

			//Get the best biz phone
			best_biz_phone := biz_allphones;
			
			//Put the best phone onto the biz record
			biz := best_biz_phone;

			// convert biz records to output layout
			UPS_Services.layout_Common bizToLayoutTransform(biz L) := TRANSFORM
				SELF.rollup_key := L.PowID;
				SELF.rollup_key_type := UPS_Services.Constants.TAG_ROLLUP_KEY_LINKID;
				SELF.dt_last_seen := (INTEGER) L.dt_last_seen;
				SELF.dt_first_seen := (INTEGER) L.dt_first_seen;
				SELF.fname := '';
				SELF.mname := '';
				SELF.lname := '';
				SELF.name_suffix := '';
				SELF.company_name := L.company_name;
				SELF.phone := L.company_phone;				
				SELF.prim_range := L.prim_range;
				SELF.predir := L.predir;
				SELF.prim_name := L.prim_name;
				SELF.suffix := L.addr_suffix;
				SELF.postdir := L.postdir;
				SELF.unit_desig := L.unit_desig;
				SELF.sec_range := L.sec_range;
				SELF.city_name := L.city;
				SELF.state := L.st;
				SELF.zip := L.zip;
				SELF.postalcode := '';
				SELF.zip4 := L.zip4;

				SELF.score_name := 0;
				SELF.score_addr := 0;
				// SELF.score_addrStreet := 0;
				// SELF.score_addrCityStZip := 0;
				SELF.score_phone := 0;	
				SELF.listing_type := ''; // Used only for canadian data to determine if business/individual 
				SELF.history_flag := '';   // Used only in canadian data
				SELF.Current := map (trim(L.powid_status_public) = 'I' => 'N',
															   trim(L.powid_status_public) <> 'I' => 'Y',
																	'U');
			END;

			resp := CHOOSEN(PROJECT(SORT(biz,ultid, orgid, seleid, proxid,PowID), bizToLayoutTransform(LEFT)), Constant.MAX_SEARCH_RECORDS);//now deterministic

			#IF(UPS_Services.Debug.debug_flag)
			output(resp, NAMED('business_recs'));
			output(count(resp), NAMED('num_business_recs'));
			output(dsInput, NAMED('dsInput'));
			#END
			return resp;
		END;  // records() function
	END;		// BusinessSearch module


	// ***** PERSON SEARCH ***** 
	export PersonSearch := MODULE

		shared params := mod_Params.PersonSearch;
		shared max_dids := 100;  // TODO - this should be based on MaxResults!


		export records(params in_mod) := FUNCTION
			
			
			dppaVal := AIT.DPPA_Purpose.val(project(in_mod, AIT.DPPA_Purpose.params));
			glbVal := AIT.GLB_Purpose.val(project(in_mod, AIT.GLB_Purpose.params));
			industryClass := AIT.industry_class_val.val(project(in_mod,AIT.industry_class_val.params));

			// use mod_header_records ONLY to resolve DIDs, skipping daily/util/gong lookups.
			
			HeaderRecordLookup(DATASET(doxie.layout_references_hh) dids) := 
					doxie.mod_header_records(false, /* do daily/gong/quick search */
																	 false, /* include dailies */
																	 false, /* allow wildcard */
																	 0,     /* dateval */
																	 dppaVal,
																	 glbVal,
																	 false, /* ln_branded_value */
																	 false,	/* include_gong */
																	 false, /* probation_override_value */
																	 industryClass,
																	 false, /* no scrub */
																	 false, /* suppress_gong_noncurrent */
																	 [],    /* daily_autokey_skipset */
																	 false, /* AllowGongFallBack */
																	 false,  /* ApplyBpsFilter */
																	 false).mod_Header(dids); /* GongByDidOnly */
			
			// use mod_header_records only to access daily/gong/util files.  In addition to
			// the values in GlobalModule being used for lookups, any records related to the
			// DIDs passed in will be included
			
			GongAndDailyLookup(DATASET(doxie.layout_references_hh) dids) := 
					doxie.mod_header_records(NOT EXISTS(dids),  /* do daily/gong/quick search */
																	 NOT EXISTS(dids),  /* include dailies */
																	 true,  /* allow wildcard */
																	 0,     /* dateval */
																	 dppaVal,
																	 glbVal,
																	 false, /* ln_branded_value */
																	 NOT EXISTS(dids),	/* include_gong */
																	 false, /* probation_override_value */
																	 industryClass,
																	 false, /* no scrub */
																	 false, /* suppress_gong_noncurrent */
																	 [],    /* daily_autokey_skipset */
																	 false, /* AllowGongFallBack */
																	 false,  /* ApplyBpsFilter */
																	 EXISTS(dids)).mod_Daily(dids); /* GongByDidOnly */


			// might need this for a call to autoheaderi fetch
			AHI_mod := module (project (in_mod, AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, opt))
				export addr := address.Addr1FromComponents(in_mod.prim_range, in_mod.predir, in_mod.prim_name, in_mod.suffix, in_mod.postdir, /*unitdesig*/'', in_mod.sec_range) ;
				export NoFail := true; //give daily searches a chance - proven to return more results
				export checknamevariants := FALSE;
			end;

			// autoheaderi does a better job than the partial fetch when state and zip are missing
			std_dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(AHI_mod);
			par_dids := PROJECT(mod_PartialMatch(in_mod).dids, doxie.layout_references_hh);
			
			dset := CHOOSEN(SORT(if(in_mod.state = '' and in_mod.zip = '', std_dids, par_dids),did), max_dids);//now deterministic
			
			DIDs := 
			MAP(
				exists(dset) 
					=> dset, 
				UPS_Services.Constants.DO_SECOND_SEARCH 
					=> mod_SecondSearch.Individual(in_mod).records,
					DATASET([], doxie.layout_references_hh)
			);
			
			emptyDIDs := DATASET([], doxie.layout_references_hh);

			hdr_recs := HeaderRecordLookup(dids).records;

			// calling GongAndDailyLookup with the set of empty DIDs allows it to be
			// run in parallel with mod_PartialMatch.  Calling it with the set of DIDs
			// returned by HeaderRecordLookup forces it to be run sequentially.  The
			// parallel/sequential behavior may be toggled by the line uncommented below.

			daily_recs := GongAndDailyLookup(emptyDIDs).records;    // parallel with mod_PartialMatch
			// gong_recs := GongAndDailyLookup(dids).records;        // executed sequentially (after mod_PM)

			//WFPV8_recs := UPS_Services.fn_WaterfallPhonesLookup(dids,in_mod);
			ind := hdr_recs + daily_recs; // + WFPV8_recs;
					
			// convert records to output layout
			UPS_Services.layout_Common indToLayoutTransform(ind L) := TRANSFORM
				SELF.rollup_key := if (L.did <> 0, L.did, L.rid);
				SELF.rollup_key_type := if (L.did <> 0, UPS_Services.Constants.TAG_ROLLUP_KEY_DID, UPS_Services.Constants.TAG_ROLLUP_KEY_RID);

				SELF.dt_last_seen := (INTEGER) L.dt_last_seen;
				SELF.dt_first_seen := (INTEGER) L.dt_first_seen;

				SELF.fname := L.fname;
				SELF.mname := L.mname;
				SELF.lname := L.lname;
				SELF.name_suffix := L.name_suffix;

				SELF.company_name := '';

				SELF.phone := if (L.phone = '', L.listed_phone, L.phone);

				SELF.prim_range := L.prim_range;
				SELF.predir := L.predir;
				SELF.prim_name := L.prim_name;
				SELF.suffix := L.suffix;
				SELF.postdir := L.postdir;
				SELF.unit_desig := L.unit_desig;
				SELF.sec_range := L.sec_range;
				SELF.city_name := L.city_name;
				SELF.state := L.st;
				SELF.zip := L.zip;
				SELF.postalcode := '';
				SELF.zip4 := L.zip4;
				SELF.score_name := 0;
				SELF.score_addr := 0;	
				// SELF.score_addrStreet := 0;
				// SELF.score_addrCityStZip := 0;
				SELF.score_phone := 0;
				SELF.listing_type := ''; // Used only for canadian data to determine if business/individual 
				SELF.history_flag := ''; // Used only for canadian data
			END;

			resp := CHOOSEN(PROJECT(SORT(ind,did,rid,phone<>''), indToLayoutTransform(LEFT)), //now deterministic
											Constant.MAX_SEARCH_RECORDS);
			#if(UPS_Services.Debug.debug_flag)
			output(resp, NAMED('ind_hdr'));
			#end
			return resp;
		END;	// PersonSearch.records() function
	END;  // PersonSearch module
	

END;  // mod_Searches module