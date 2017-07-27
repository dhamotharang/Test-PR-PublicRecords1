import uccv2_services, BIPV2, doxie, Alerts, AutoStandardI;

unsigned2 pt	:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));

doxie.MAC_Header_Field_Declare()

includeDeepDive := not noDeepDive;

empty_bids := dataset([],BIPV2.IDlayouts.l_xlink_ids);

EXPORT UCCSearchService_records(DATASET(BIPV2.IDlayouts.l_xlink_ids) linkIds = empty_bids, 
																STRING1 businessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := MODULE
																
	ids := UCCv2_Services.UCCSearchService_ids(includeDeepDive, linkIds, businessIdFetchLevel);

	tmsids := dedup(sort(project(ids, UCCv2_Services.layout_tmsid), tmsid), tmsid);

	rpen := UCCv2_Services.UCCRaw.report_view.by_tmsid(tmsids,ssn_mask_value);

	rdd := join(rpen, dedup(sort(ids,tmsid,if(isDeepDive, 1, 0)), tmsid), 
				left.tmsid = right.tmsid,
				transform(uccv2_services.layout_ucc_rollup
								 , self.isDeepDive := right.isDeepDive
								 , self.matched_party := IF(not right.isDeepDive,left.matched_party)
								 , self := left),
				left outer);

	rsrt := sort(rdd(penalt <= pt), if(isDeepDive, 1, 0), penalt, -orig_filing_date, record);

	Alerts.mac_ProcessAlerts(rsrt,uccv2_services.alert,rsrt_final);

	// doxie.MAC_Marshall_Results(rsrt_final,rmar);

	// output(ids,		named('ids'));		// DEBUG
	// output(tmsids,	named('tmsids'));	// DEBUG
	// output(rpen,		named('rpen'));		// DEBUG
	// output(rsrt,		named('rsrt'));		// DEBUG

	// export UCCSearchService_records := rmar;

	export records := rsrt_final;
																	
END;
