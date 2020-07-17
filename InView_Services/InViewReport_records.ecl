import business_header, doxie_cbrs, autostandardi, Suppress, corp2_services;

boolean INCLUDE_MVAWFA_HEADERS := false : stored('IncludeMVAWFAHeaders');
#constant ('IsCRS', true);  //sets isCRS to true, which prevents some extra work
UNSIGNED1 max_bus_reg := 30;
doxie_cbrs.mac_Selection_Declare();

#stored('bdidsDerived', true);

mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

//
// Get the best BDID for the input
//    -- filter any records that don't meet the minimum field population specification
//    -- score the remaining records (penalty?, score?)
//    -- pick the best BDID

// recs that match input criteria
best_recs := business_header.fn_RSS_getBestRecords(mod_access, true,false,INCLUDE_MVAWFA_HEADERS,INCLUDE_BUS_DPPA,true,false,false); 

// minimum field population filter
best_recs_filt := best_recs(company_name != '' and 
													 (prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or
														postdir != '' or unit_desig != '' or sec_range != '' or city != '' or
														state != '' or zip != 0 or zip4 != 0));

brByGIDs := SORT(Business_Header.fn_RSS_rollupBestRecords(best_recs_filt, mod_access, 10), -score, -best_flags);
// tm := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.InterfaceTranslator.bdid_dataset.params, OPT))
	// EXPORT bdid := brByGIDs[1].bdid_list;
// END;

// collect the bdid list for the best scoring group id
// bdids := AutoStandardI.InterfaceTranslator.bdid_dataset.val(tm);

// The few lines above have been commented out to work around a potential ECL code generator bug.
// The algorithm was taken from "AutoStandardI.InterfaceTranslator.bdid_dataset.val()".
// Workaround begins:
theTop := brByGIDs[1];
gm := AutoStandardI.GlobalModule();
bdidsTmp := IF(gm.useSupergroup, PROJECT(business_header.getSupergroup(theTop.bdidRecs[1].bdid, gm.uselevels), {UNSIGNED6 bdid}),
																														 theTop.bdidRecs);
app_type := IF (isPeopleWise, Suppress.Constants.ApplicationTypes.PeopleWise, application_type_value);																														 
Suppress.MAC_Suppress(bdidsTmp,bdids,app_type,Suppress.Constants.LinkTypes.BDID,bdid);

// Workaround ends:
best_bdid_found := exists(brByGIDs);

// get the report records for the best BDIDs
recs := doxie_cbrs.all_base_records_prs(bdids, ssn_mask_val, mod_access);

// add equifax gateway results to the output
out_rec := doxie_cbrs.layout_report;

// InView gateway takes some variation of a best record
besr := ungroup (recs[1].Best_Information);
best_bdid := PROJECT (besr, TRANSFORM (doxie_cbrs.Layout_BH_Best_String,
                                       SELF.BDID := (UNSIGNED6)LEFT.BDID, SELF := LEFT, SELF :=[]));

// Best record is used instead of bdids, since the equifax gateway call needs name/address info
// redundant "include" is passed all the way to the actual soapcall to prevent possible platform
//    soapcall-always-executed issue
equir := equifax_bus_records (best_bdid, Include_EquifaxBus_val);

out_rec AppendEquifax (recs L) := transform
  Self.EquifaxBusinessReport := if (Include_EquifaxBus_val, equir.records);
  // Looks like having counts defined as a dataset is redundancy: can be at most one record
  SELF.Source_Counts := if (Include_EquifaxBus_val, 
                            project (L.source_counts, transform (recordof (L.source_counts),
                                                                 Self.EquifaxBusinessReport_Section := equir.records_count,
                                                                 Self := Left)),
																																 L.source_counts);
  Self := L;
end;
recs_plus := project (recs, AppendEquifax (Left));

// filter non-recent records according to product rules
filt_recs := filter_nonRecent(project(recs_plus, out_rec));

// Do additional filtering by showing only current corporate data and limiting the number of
// business registrations (after bringing the most recent to the top).
doxie_cbrs.layout_report get_current_info(doxie_cbrs.layout_report L) := TRANSFORM
  corp2_services.layout_corp2_rollup get_current_corp(corp2_services.layout_corp2_rollup LE) := TRANSFORM
  	SELF.corp_hist := LE.corp_hist(record_type = 'C');
		
	  SELF := LE;
	END;
		
	SELF.profile_information_v2 := PROJECT(L.profile_information_v2, get_current_corp(LEFT));
	SELF.business_registrations := CHOOSEN(
	                                 SORT(L.business_registrations, -record_date, -bdid, RECORD),
																	 max_bus_reg,
																	 FEW);

	SELF := L;
END;

corp_filt_recs := PROJECT(filt_recs, get_current_info(LEFT));

export InViewReport_records := if(best_bdid_found, corp_filt_recs);
