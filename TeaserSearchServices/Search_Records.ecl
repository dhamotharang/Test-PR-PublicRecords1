
import AutoStandardI,iesp, ut, doxie,  Header, NID, Suppress, RiskWise, STD, Suppress;

export Search_Records := module
	export params := interface(
		AutoStandardI.InterfaceTranslator.lname_value.params,
		AutoStandardI.InterfaceTranslator.lname_set_value.params,
		AutoStandardI.InterfaceTranslator.fname_value.params,
		AutoStandardI.InterfaceTranslator.mname_value.params,
		AutoStandardI.InterfaceTranslator.city_value.params,
		AutoStandardI.InterfaceTranslator.state_value.params,
		AutoStandardI.InterfaceTranslator.zip_value.params,
		AutoStandardI.InterfaceTranslator.zip_val.params,
		AutoStandardI.InterfaceTranslator.pname_value.params,
		AutoStandardI.InterfaceTranslator.zipradius_value.params,
		AutoStandardI.InterfaceTranslator.dob_val.params,
		AutoStandardI.InterfaceTranslator.agelow_val.params,
		AutoStandardI.InterfaceTranslator.agehigh_val.params,
		AutoStandardI.InterfaceTranslator.phonetics.params,
		AutoStandardI.InterfaceTranslator.nicknames.params,
		// added line here
		AutoStandardI.InterfaceTranslator.did_value.params)
		export IncludeFullHistory := false;
		export IncludeRelativeNames := false;
		export AlwaysReturnRecords := false;
		export IncludePhoneIndicator := false;
		export IncludePhones := false;
		
		export IncludePhoneNumber := false;		
   
		export RElaxedMiddleNameMatch := false;
		export IncludeAllAddresses := false;
		export WidenSearchResults := false; 
		export string12 PreferredUniqueId := '';
		export string32 applicationType	:= suppress.Constants.ApplicationTypes.Consumer;
	end;
	
	export val(params in_mod) := function
    global_mod := AutoStandardI.GlobalModule();
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);
    
		lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
		lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
		fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
		mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
		city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
		state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
		zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
		zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
		pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
		zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.zipradius_value.params));
		dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));
		agelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agelow_val.params));
		agehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.agehigh_val.params));
		phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
		nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
		// added line
		did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.did_value.params));
		
		in_yob := dob_val div 10000; 
		in_mob := (dob_val div 100) % 100;
		in_day := dob_val % 100;

		//unsigned8 todays_date := (unsigned8)Stringlib.getDateYYYYMMDD();
		unsigned8 todays_date := (unsigned8) STD.Date.today();
		unsigned8 yob_val_low := map(
			dob_val != 0 => dob_val div 10000,
			agehigh_val = 0 => 1900,
			(todays_date div 10000 - agehigh_val - 1));
		unsigned8 yob_val_high := map(
			dob_val != 0 => dob_val div 10000, 
			agelow_val = 0 => todays_date div 10000,
			(todays_date div 10000 - agelow_val));

		// ensure no overflow
		maxReturnCount := ut.Min2(iesp.ECL2ESP.Marshall.return_count, iesp.Constants.ThinRps.MaxCountResponseRecords);

		in_dph_lname := metaphonelib.DMetaPhone1(lname_value)[1..6];
		in_pfname := NID.PreferredFirstNew(fname_value);

		//use RiskWise key as its indexed on City and State, so can search if one of these elements is missing on search criteria
    zips_within_city := //limit(
                       RiskWise.Key_ZipCitySt(
		      keyed(city = city_value) and keyed(state_value = '' or state = state_value));
					//,ut.limits.FETCH_KEYED);	
		zips_within_city_strs := set(project(zips_within_city, transform({string5 zip}, self.zip := left.zip5)),zip);
		zip_value_strs :=set(project(dataset(zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);
	
	  state_set := map(state_value <> '' => [state_value],
        city_value <> '' => set(zips_within_city, state),
        ALL);			
		
		//keyed(st in state_set) and	
		teaser_search(widen = false) := macro
			keyed(dph_lname = in_dph_lname) and
				keyed(lname IN lname_set_value) and
				keyed(in_mod.IncludeFullHistory or isCurrent) and 
				keyed(st in state_set) and
				keyed(fname_value = '' or Functions.PrefFirstMatch2(pfname, fname_value)) and
				keyed(fname_value = '' or fname = fname_value) and
				keyed(widen or ((zip_val = '' or zip = zip_val) and 
				(city_value = '' or zip in zips_within_city_strs))) and
				keyed((dob_val = 0 and agelow_val = 0 and agehigh_val = 0) or yob between yob_val_low and yob_val_high) and
				keyed(in_mod.RelaxedMiddleNameMatch or (mname_value = '' or minit = mname_value[1]))
		endmacro;		
		
		teaser_fuzzy_search(fuz_widen = false) := macro
			keyed(dph_lname = in_dph_lname) and
			keyed(phonetics or lname IN lname_set_value) and
			keyed(in_mod.IncludeFullHistory or isCurrent) and
			keyed(st in state_set) and
			keyed(fname_value = '' or Functions.PrefFirstMatch2(pfname, fname_value)) and
			keyed(nicknames or fname_value = '' or fname = fname_value) and
			keyed(fuz_widen or ((zipradius_value = 0 or zip_value = [] or zip in zip_value_strs) and
				(zipradius_value <> 0 or zip_val = '' or zip = zip_val) and
				(zipradius_value <> 0 or city_value = '' or zip in zips_within_city_strs))) and
			keyed((dob_val = 0 and agelow_val = 0 and agehigh_val = 0) or yob between yob_val_low and yob_val_high) and
			keyed(in_mod.RelaxedMiddleNameMatch or (mname_value = '' or minit = mname_value[1]))
		endmacro;

    teaser_key := Header.key_teaser_cnsmr_search;

		exact_recs := //limit(
                   teaser_key(teaser_search());
									  //,ut.limits.FETCH_KEYED);

		fuzzy_recs := //limit(
		                 teaser_key(teaser_fuzzy_search());
										 //,ut.limits.FETCH_KEYED);

		exact_widen_recs := //limit(
		                        teaser_key(teaser_search(in_mod.WidenSearchResults));
		                     //,ut.limits.FETCH_KEYED);
				
		fuzzy_widen_recs := //limit(
                           teaser_key(teaser_fuzzy_search(in_mod.WidenSearchResults));
		                     //,ut.limits.FETCH_KEYED);

		exact_limit := limit(exact_recs,ut.limits.FETCH_KEYED, FAIL(203, doxie.ErrorCodes(203)),keyed);		
		
		exact_widen_limit := choosen(exact_recs + exact_widen_recs, ut.limits.FETCH_KEYED);		

		// if always returning records
		// use a choosen to pick a large enough sample (10K for now), then
		// a topn to pick the best candidates
		exact_sample := choosen(exact_recs, ut.limits.FETCH_UNKEYED);
		exact_WO_sample := choosen(exact_recs + exact_widen_recs, ut.limits.FETCH_UNKEYED);
		
		use_fuzzy := (phonetics or nicknames or zipradius_value <> 0) AND DID_value = '';		
		
			// if always returning records
		// use a choosen to pick a large enough sample (10K for now), then
		// a topn to pick the best candidates
	
	 get_fuzzy_recs(DATASET(RECORDOF(Header.key_teaser_cnsmr_search)) fuzzed_recs, 
					DATASET(RECORDOF(Header.key_teaser_cnsmr_search)) rec_limit,
					DATASET(RECORDOF(Header.key_teaser_cnsmr_search)) sample_recs,
					boolean WidenSearch=false) := FUNCTION
		// only fail the fuzzy fetch as too broad if the exact fetch found none
		fuzzy_fail := if(WidenSearch, choosen(fuzzed_recs,ut.limits.FETCH_KEYED),
						limit(fuzzed_recs,ut.limits.FETCH_KEYED, FAIL(203, doxie.ErrorCodes(203)),keyed));
		fuzzy_skip := if(WidenSearch, choosen(fuzzed_recs,ut.limits.FETCH_KEYED),
						limit(fuzzed_recs,ut.limits.FETCH_KEYED, SKIP, keyed));
		fuzzy_limit_cands := if(count(rec_limit) > 0, fuzzy_skip, fuzzy_fail);
		
		// only need to take the fuzzy results if the exact matches don't provide as many as requested
		// need to allow a few extra since there can be up to maxReturnCount records per DID that could match the input criteria
		fuzzy_limit := if(count(rec_limit) < maxReturnCount * 5, fuzzy_limit_cands);
		fuzzy_limit_final := if(use_fuzzy, fuzzy_limit);
		
		fuzzy_sample_cands := choosen(fuzzed_recs, ut.limits.FETCH_UNKEYED);
		fuzzy_sample := if(count(sample_recs) < maxReturnCount * 5, fuzzy_sample_cands); 
		fuzzy_sample_final := if(use_fuzzy, fuzzy_sample);
		
		// if AlwaysReturnRecords is requested, do a choosen and always return records;
		// otherwise, allow searches that produce more than the limit to fail if the search criteria are too broad
		recs_wch := if(in_mod.AlwaysReturnRecords, sample_recs + fuzzy_sample_final, 
																							 rec_limit + fuzzy_limit_final);
																							 
		recs_ddp := dedup(sort(recs_wch, record), record);

		// final cleanup (doing what couldn't be done in the keyed conditions above)
		// 1. need to postfilter any wildly dissimilar last names when phonetics is enabled
		// 2. need to make sure that middle initial matches don't have different mnames
		// 3. need to see if a full dob provided that it doesn't mismatch
		recs_clean_pre := recs_ddp((~phonetics or datalib.namesimilar(lname,lname_value,1) <= 6) and
													 (in_mod.RelaxedMiddleNameMatch or 
													 mname_value = '' or mname = mname_value or 
													  mname[1] = mname_value or mname = mname_value[1]) and
														(in_mob = 0 or (dob div 100) % 100 = in_mob) and
														(in_day = 0 or (dob % 100) = in_day));
                            
    recs_clean := Suppress.MAC_SuppressSource(recs_clean_pre,mod_access);                       
		RETURN recs_clean;										
	end;		
	
	

		cleaned_recs := get_fuzzy_recs(fuzzy_recs, exact_limit, exact_sample);

		cleaned_recs_retried := get_fuzzy_recs(fuzzy_recs + fuzzy_widen_recs, exact_widen_limit, exact_WO_sample, in_mod.WidenSearchResults);		
		//if the result set is less than maxReturnCount retry without city
		cleaned_recs_final := if(count(cleaned_recs) < maxReturnCount and in_mod.WidenSearchResults, cleaned_recs_retried, cleaned_recs);

		recs_clean_tsr := project(cleaned_recs_final, Header.layout_teaser);
		
		// even though the teaser keys are built with pull file applied, the build cycles are different
		// so still need to pull in the query to account for recent additions.
		// 
		// currently, we can only pull by DID; keys will need to be modified to preserve SSN so that 
		// pulling by SSN can be implemented
		
		// add a single row of header.layout_teaser if did value is input directly
		// filter by number is already take care of by autostandardI interface transaltor in set of did_value
		did_rec := PROJECT(dataset([{did_value}], doxie.layout_references),
		                                       TRANSFORM(header.layout_teaser,
																					       SELF.did := LEFT.DID;
																								 SELF := []))(did <> 0);   
		recs_clean_tsrWithdid := recs_clean_tsr && did_rec;
																
		
		Suppress.MAC_Suppress(recs_clean_tsrWithDID,recs_pull_tsr,in_mod.applicationType,Suppress.Constants.LinkTypes.DID,did);
		
		recs_grp := group(sort(recs_pull_tsr, did, -isCurrent), did);
		recs := rollup(recs_grp, GROUP, Functions.combine(LEFT,ROWS(LEFT), in_mod.IncludeAllAddresses));
		
		// filter out minors from the final result 
		recs_nominors := Doxie.compliance.MAC_FilterOutMinors(recs,uniqueid,dob_val,False);

		recs_ageChecked := recs_nominors(exists(dobs(age >= agelow_val and 
																	(agehigh_val = 0 or age <= agehigh_val))));
													
		recs_top := topn(recs_ageChecked,maxReturnCount, 
											 penalt, -Addresses[1].DateLastSeen.Year, -Addresses[1].DateLastSeen.Month,
											 -totalRecords, Addresses[1].zip5, record);
		// get historical names and addresses if requested
		recs_ref := project(recs_top, transform(doxie.layout_references, 
								 													  self.did := (unsigned6) left.uniqueid));
											 
		recs_history := Functions.historicalNamesAddrs(recs_ref, in_mod.IncludeAllAddresses,mod_access);
		recs_history_use := IF(in_mod.IncludeFullHistory, recs_history, recs_top);
		
		// add phone indicator if requested
		recs_phone := Functions.AddPhoneIndicator(recs_history_use, in_mod.IncludePhones);
		recs_phone_use := if(in_mod.IncludePhoneIndicator or in_mod.IncludePhones,recs_phone, recs_history_use);

		// add relative names if requested
		with_rels := Functions.AddRelativeNames(recs_phone_use,in_mod.applicationType);
		Final_res := IF(in_mod.IncludeRelativeNames, with_rels, recs_phone_use);
  
		//return standard output when no PreferredUniqueId entered, otherwise, return data with the PreferredUniqueId matching what the user entered a lexid
		final_sorted := SORT(final_res, 		                    
												  if((integer)UniqueId = (integer)in_mod.PreferredUniqueId, 0, 1), penalt, -Addresses[1].DateLastSeen.Year,
						-Addresses[1].DateLastSeen.Month,-Addresses[1].DateLastSeen.Day, -totalRecords, record);		
		
 		
		final_out := PROJECT(final_sorted, Layouts.records);
	  //output(recs_clean_tsr, named('recs_clean_tsr'));
		//output(did_value, named('did_value'));
		return final_out;
	end;
end;