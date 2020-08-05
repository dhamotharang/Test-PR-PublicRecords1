IMPORT uccv2_services, BIPV2, doxie, Alerts, AutoStandardI;

UNSIGNED2 pt := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));

doxie.MAC_Header_Field_Declare()

includeDeepDive := NOT noDeepDive;

empty_bids := DATASET([],BIPV2.IDlayouts.l_xlink_ids);

EXPORT UCCSearchService_records(DATASET(BIPV2.IDlayouts.l_xlink_ids) linkIds = empty_bids,
                                STRING1 businessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := MODULE
                                
  ids := UCCv2_Services.UCCSearchService_ids(includeDeepDive, linkIds, businessIdFetchLevel);

  tmsids := DEDUP(SORT(PROJECT(ids, UCCv2_Services.layout_tmsid), tmsid), tmsid);

  rpen := UCCv2_Services.UCCRaw.report_view.by_tmsid(tmsids,ssn_mask_value);

  rdd := JOIN(rpen, DEDUP(SORT(ids,tmsid,IF(isDeepDive, 1, 0)), tmsid),
        LEFT.tmsid = RIGHT.tmsid,
        TRANSFORM(uccv2_services.layout_ucc_rollup
                 , SELF.isDeepDive := RIGHT.isDeepDive
                 , SELF.matched_party := IF(NOT RIGHT.isDeepDive,LEFT.matched_party)
                 , SELF := LEFT),
        LEFT OUTER);

  rsrt := SORT(rdd(penalt <= pt), IF(isDeepDive, 1, 0), penalt, -orig_filing_date, RECORD);

  Alerts.mac_ProcessAlerts(rsrt,uccv2_services.alert,rsrt_final);

 

  EXPORT records := rsrt_final;
                                  
END;
