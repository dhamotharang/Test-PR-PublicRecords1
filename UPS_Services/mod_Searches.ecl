import autoheaderi, autostandardi, doxie, doxie_cbrs, business_header, iesp, address, UPS_Services, ut;


export mod_Searches := MODULE

	shared AIT := AutoStandardI.InterfaceTranslator;
	shared Constant := iesp.Constants.RA;

	// person and business records have slightly different layouts (esp names).
	// This common layout is a standard layout which fits both biz and person 
	// responses after this mod is called.  Only the fields which we are 
	// interested in are preserved..

	export layout := UPS_Services.layout_Common;

	// ***** BUSINESS SEARCH ***** 
	export BusinessSearch := MODULE

		export params := mod_Params.BusinessSearch;
		
		shared fn_RestrictBusinessSearch(AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full in_mod, 
																										BOOLEAN useName = true, 
																										BOOLEAN useStreet = true,
																										BOOLEAN useCity = true,
																										BOOLEAN useState = true,
																										BOOLEAN useZip = true,
																										BOOLEAN usePhone = true,
																										BOOLEAN useALL = FALSE) := FUNCTION

			inName := if((useName OR useAll), in_mod.companyname, '');

			// Bugzilla 41403
			// we only want to run the street searches if we have a prim_range and
			// a prim_name.  Otherwise, we could end up with overly-broad queries 
			// such as street name + zip or street name + city + state.
			reallyUseStreet := ((useStreet OR useAll) AND in_mod.prim_range <> '' AND in_mod.prim_name <> '');
			inPrimRange := if(reallyUseStreet, in_mod.prim_range, '');
			inPrimName := if(reallyUseStreet, in_mod.prim_name, '');
			inSecRange := if(reallyUseStreet, in_mod.sec_range, '');

			inCity := if((useCity OR useAll), in_mod.city, '');
			inState := if((useState OR useAll), in_mod.state, '');
			inZip:= if((useZip OR useAll), in_mod.zip, '');
			inPhone := if((usePhone OR useAll), in_mod.phone, '');

			search_mod := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export companyname := inName;
				export phone := inPhone;
			end;

			//this will only be used for cases with '&' or ' AND '
			search_mod_altName := module(project(search_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export companyname := ut.mod_AmpersandTools.createAlternativeName(inName);
			end;
			
			hasStreet := in_mod.prim_range <> '' OR in_mod.prim_name <> '' OR in_mod.sec_range <> '';
			execute := 
				useALL OR
				(
					(
						// this makes sure that every field is either populated or not in use
						(NOT useName OR in_mod.companyname <> '') AND
						(NOT reallyUseStreet OR hasStreet) AND
						(NOT useCity OR in_mod.city <> '') AND
						(NOT useState OR in_mod.state <> '') AND
						(NOT useZip OR in_mod.zip <> '') AND
						(NOT usePhone OR in_mod.phone <> '')
					)
					AND
					(			
						// the bad situation is where every field NOT used is empty (because we do an extra search)
						// so, one of the not used fields needs to have a value (or else its just a repeat of the all search)
						// hmm, would this already be taken care of by the first half of the definition of execute if useALL didnt exist?
						(NOT useName AND in_mod.companyname <> '') OR
						(NOT reallyUseStreet AND hasStreet) OR
						(NOT useCity AND in_mod.city <> '') OR
						(NOT useState AND in_mod.state <> '') OR
						(NOT useZip AND in_mod.zip <> '') OR
						(NOT usePhone AND in_mod.phone <> '')					
					)
				);

			bdids:= 
			if(
				execute, 
				AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(search_mod) +
				if(
					ut.mod_AmpersandTools.hasAmpersandOrHasAnd(inName),
					AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(search_mod_altName)
				)
			);

			rval := DEDUP(SORT(bdids, RECORD), RECORD);
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
			return DEDUP(SORT(bdids, RECORD), RECORD);
		END;

		shared weightedBDID := RECORD
			doxie.layout_ref_bdid.bdid;
			UNSIGNED2 weight := 1;
		END;

		shared fn_WeightBDIDs(DATASET(doxie.layout_ref_bdid) recs, UNSIGNED2 weight) := FUNCTION

			weightedBDID weightedTransform(recs L) := TRANSFORM
				SELF := L;
				SELF.weight := weight;
			END;

			out_recs := PROJECT(recs, weightedTransform(LEFT));
			return out_recs;
		END;

		export bdids(params in_mod) := FUNCTION
			// Get the BDIDs
			mb := module(project(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export NoFail := true; 
				//these three to help performance
				export score_results := false;		// we will do our own penalizing
				export use_word_search := false;	//we do our own word search
				export use_exec_search := false;  //this is for business contacts, which we dont need since we also do a person search
				export state := 
				if(
					in_mod.state <> '', 	//if state is given, use it
					in_mod.state,
					if(in_mod.city <> '',	//if state empty and city given, guess the state.
					address.Key_CityStChance(in_mod.state = '' and keyed(city_name = in_mod.city) and percent_chance > 50)[1].st, //no reason not to guess, but > 50 makes me deterministic
					in_mod.state //blank
					)
				);
			end;

			bdid_all := fn_RestrictBusinessSearch(mb, true, true, true, true, true, true, TRUE);
			wt_all := fn_WeightBDIDs(bdid_all, 15);

			bdid_street_city_state_zip := fn_RestrictBusinessSearch(mb, false, true, true, true, true, false);
			wt_street_city_state_zip := fn_WeightBDIDs(bdid_street_city_state_zip, 3);

			bdid_name_city_state_zip := fn_RestrictBusinessSearch(mb, true, false, true, true, true, false);
			wt_bdid_name_city_state_zip := fn_WeightBDIDs(bdid_name_city_state_zip, 1);

			bdid_name_zip_metaphone := AutoHeaderI.FetchI_Hdr_Biz_Metaphone().records(project(mb,AutoHeaderI.FetchI_Hdr_Biz_Metaphone().params, opt));
			wt_name_zip_metaphone := 
			project(
				bdid_name_zip_metaphone, 
				transform(
					weightedBDID,
					self.weight := 
						if(left.matched_zip_or_city,2,0)
						+ if(left.matched_full_input,2,0)
						+ if(left.num_individual_input_words_matched > 0,1,0),
					self := left
				)
			);;

			bdid_phone := fn_RestrictBusinessSearch(mb, false, false, false, false, false, true);
			wt_phone := fn_WeightBDIDs(bdid_phone, 7);

			combined_bdids := wt_all + 
												wt_street_city_state_zip +
												wt_name_zip_metaphone + wt_phone +
												wt_bdid_name_city_state_zip;

			grouped_bdids := GROUP(SORT(combined_bdids, bdid), bdid);

			bdidWeights := RECORD
				combined_bdids.bdid;
				UNSIGNED4 weight := SUM(GROUP, combined_bdids.weight);
			END;

			scored_bdids := TABLE(grouped_bdids, bdidWeights);
			sorted_bdids := SORT(scored_bdids, -weight, -bdid);

			max_bdids := 150;  // TODO - should be based on MaxResults!
			num_bdids := COUNT(sorted_bdids);
			ref_bdid := if (num_bdids > max_bdids, max_bdids, num_bdids);
			target_score := sorted_bdids[ref_bdid].weight;
			target_bdids := IF(num_bdids <= max_bdids, sorted_bdids, sorted_bdids(weight > target_score));

			// bdids := IF(EXISTS(target_bdids),
										// PROJECT(target_bdids, doxie.layout_ref_bdid),
										// PROJECT(CHOOSEN(sorted_bdids, max_bdids), doxie.layout_ref_bdid));

			bdids := PROJECT(MAP(num_bdids <= max_bdids => sorted_bdids,
											 COUNT(target_bdids) > (0.5 * max_bdids) => target_bdids,
											 CHOOSEN(sorted_bdids, max_bdids)), doxie.layout_ref_bdid);

			#IF(UPS_Services.Debug.debug_flag)
			output(wt_all, NAMED('bdid_wt_all'));
			output(wt_street_city_state, NAMED('bdid_city_state'));
			output(wt_street_zip, NAMED('bdid_street_zip'));
			output(wt_name_street_city_state, NAMED('bdid_last_street_city_state'));
			output(wt_name_street_zip, NAMED('bdid_last_street_zip'));
			output(wt_name_city_state, NAMED('bdid_last_city_state'));
			output(wt_name_zip, NAMED('bdid_last_zip'));
			output(wt_bdid_name_city_state_zip, NAMED('bdid_name_city_state_zip'));
			output(wt_phone, NAMED('bdid_phone'));
			output(wt_name_zip_metaphone, NAMED('bdid_name_zip_metaphone'));
			output(count(bdids), NAMED('numBDIDs'));
			output(bdids, NAMED('BDIDs'));
			#END

			return bdids;
		END;

		export records(params in_mod) := FUNCTION
				
			bset := bdids(in_mod);
			useBDIDs := 
			MAP(
				exists(bset) 
					=> bset, 
				UPS_Services.Constants.DO_SECOND_SEARCH 
					=> mod_SecondSearch.Business(in_mod).records,
					DATASET([], doxie.layout_ref_bdid)
			);

			//Get the biz records
			biz_allphones := doxie_cbrs.fn_getBaseRecs(project(useBDIDs, doxie_cbrs.layout_references), in_use_supergroup := FALSE, append_goup_id := FALSE);

			//Get the best biz phone
			best_biz_phone := Business_Header.BestPhone(
				project(
					ungroup(biz_allphones), 
					transform(
						business_header.Layout_Business_Header_Base,
						self.zip := (integer)left.zip,
						self.zip4 := (integer)left.zip4,
						self.phone := (integer)left.phone,
						self.fein := (integer)left.fein,
						self.match_company_name := '',
						self.match_branch_unit := '',		
						self := left
					)
				)
			);

			//Put the best phone onto the biz record
			biz := 
			join(
				biz_allphones,
				best_biz_phone,
				left.bdid = right.bdid,
				transform(
					recordof(biz_allphones),
					self.phone := if(right.phone = 0, '', (string)right.phone),
					self := left
				),
				keep(1),
				left outer
			);

			// convert biz records to output layout
			layout bizToLayoutTransform(biz L) := TRANSFORM
				SELF.rollup_key := L.bdid;
				SELF.rollup_key_type := UPS_Services.Constants.TAG_ROLLUP_KEY_BDID;
				SELF.dt_last_seen := (INTEGER) L.dt_last_seen;
				SELF.dt_first_seen := 0;
				SELF.fname := '';
				SELF.mname := '';
				SELF.lname := '';
				SELF.name_suffix := '';
				SELF.company_name := L.company_name;
				SELF.phone := L.phone;				
				SELF.prim_range := L.prim_range;
				SELF.predir := L.predir;
				SELF.prim_name := L.prim_name;
				SELF.suffix := L.addr_suffix;
				SELF.postdir := L.postdir;
				SELF.unit_desig := L.unit_desig;
				SELF.sec_range := L.sec_range;
				SELF.city_name := L.city;
				SELF.state := L.state;
				SELF.zip := L.zip;
				SELF.postalcode := '';
				SELF.zip4 := L.zip4;

				SELF.score_name := 0;
				SELF.score_addr := 0;
				// SELF.score_addrStreet := 0;
				// SELF.score_addrCityStZip := 0;
				SELF.score_phone := 0;	
				SELF.listing_type := '';   // Used only in canadian data to determine if business/individual 
				SELF.history_flag := '';   // Used only in canadian data
			END;

			resp := CHOOSEN(PROJECT(SORT(biz,bdid,rcid), bizToLayoutTransform(LEFT)), Constant.MAX_SEARCH_RECORDS);//now deterministic

			#IF(UPS_Services.Debug.debug_flag)
			output(resp, NAMED('business_recs'));
			output(count(resp), NAMED('num_business_recs'));
			#END
			return resp;
		END;  // records() function
	END;		// BusinessSearch module


	// ***** PERSON SEARCH ***** 
	export PersonSearch := MODULE

		export params := mod_Params.PersonSearch;
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

			gong_recs := GongAndDailyLookup(emptyDIDs).records;    // parallel with mod_PartialMatch
			// gong_recs := GongAndDailyLookup(dids).records;        // executed sequentially (after mod_PM)

			ind := hdr_recs + gong_recs;

			// convert records to output layout
			layout indToLayoutTransform(ind L) := TRANSFORM
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

			resp := CHOOSEN(PROJECT(SORT(ind,did,rid), indToLayoutTransform(LEFT)), //now deterministic
											Constant.MAX_SEARCH_RECORDS);
			#if(UPS_Services.Debug.debug_flag)
			// output(std_dids, NAMED('ind_std_dids'));
			// output(par_dids, NAMED('ind_par_dids'));
			output(resp, NAMED('ind_hdr'));
			#end
			return resp;
		END;	// PersonSearch.records() function
	END;  // PersonSearch module
	

END;  // mod_Searches module