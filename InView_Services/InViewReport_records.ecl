IMPORT autostandardi, business_header, corp2_services, doxie, doxie_cbrs, InView_Services, Suppress;

BOOLEAN INCLUDE_MVAWFA_HEADERS := FALSE : STORED('IncludeMVAWFAHeaders');
#CONSTANT ('IsCRS', TRUE);  //sets isCRS to true, which prevents some extra work
UNSIGNED1 max_bus_reg := 30;
doxie_cbrs.mac_Selection_Declare();

#STORED('bdidsDerived', TRUE);

gm := AutoStandardI.GlobalModule();

mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);

//
// Get the best BDID for the input
//    -- filter any records that don't meet the minimum field population specification
//    -- score the remaining records (penalty?, score?)
//    -- pick the best BDID

// recs that match input criteria
best_recs := business_header.fn_RSS_getBestRecords(mod_access, true,false,INCLUDE_MVAWFA_HEADERS,INCLUDE_BUS_DPPA,true,false,false); 

// minimum field population filter
best_recs_filt := best_recs(company_name != '' AND 
													 (prim_range != '' OR predir != '' OR prim_name != '' OR addr_suffix != '' OR
														postdir != '' OR unit_desig != '' OR sec_range != '' OR city != '' OR
														state != '' OR zip != 0 OR zip4 != 0));

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
bdidsTmp := IF(gm.useSupergroup, PROJECT(business_header.getSupergroup(theTop.bdidRecs[1].bdid, gm.uselevels), {UNSIGNED6 bdid}),
																														 theTop.bdidRecs);
app_type := IF (isPeopleWise, Suppress.Constants.ApplicationTypes.PeopleWise, mod_access.application_type);																														 
Suppress.MAC_Suppress(bdidsTmp,bdids,app_type,Suppress.Constants.LinkTypes.BDID,bdid);

// Workaround ends:
best_bdid_found := EXISTS(brByGIDs);

// get the report records for the best BDIDs
recs := doxie_cbrs.all_base_records_prs(bdids, mod_access);

// add equifax gateway results to the output
out_rec := doxie_cbrs.layout_report;

// InView gateway takes some variation of a best record
besr := UNGROUP (recs[1].Best_Information);
best_bdid := PROJECT (besr, TRANSFORM (doxie_cbrs.Layout_BH_Best_String,
                                       SELF.BDID := (UNSIGNED6)LEFT.BDID, SELF := LEFT, SELF :=[]));

// Best record is used instead of bdids, since the equifax gateway call needs name/address info
// redundant "include" is passed all the way to the actual soapcall to prevent possible platform
//    soapcall-always-executed issue
equir := InView_Services.equifax_bus_records (best_bdid, Include_EquifaxBus_val);

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
filt_recs := InView_Services.filter_nonRecent(project(recs_plus, out_rec));

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
