// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Focus Search.
*/
IMPORT LiensV2,text_search,alerts,doxie,ut,AutoStandardI;
EXPORT FocusSearchService := MACRO

  // boolean-specific parameters
  STRING FocusString := '' : STORED('FocusSearch');

  in_lienskeys := DATASET([], Text_Search.Layout_ExternalKey) : STORED('FocusDocIDs',few);

  // general-use parameters
  STRING6 ssn_mask_value := 'NONE' : STORED('SSNMask');
  UNSIGNED8 MaxResults_val := 2000 : STORED('MaxResults');
  UNSIGNED8 MaxResultsThisTime_val := 2000 : STORED('MaxResultsThisTime');
  UNSIGNED8 SkipRecords_val := 0 : STORED('SkipRecords');
  BOOLEAN isAlert := FALSE : STORED('ReturnHashes');
  appType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));


  // boolean search
  TSConsts := LiensV2.Constants.text_search;
  info := Text_Search.FileName_Info_Instance(
    TSConsts.stem,
    TSConsts.srcType,
    TSConsts.qual
  );

  // Define alert info
  AlertInfo := Text_Search.Alert_Info.SetAlertParams(TSConsts.dateSegName,TSConsts.alertSWDays,'',isAlert);

  // process Focus Keys
  //fdocs := project(in_lienskeys, TRANSFORM(Text_Search.Layout_ExternalKey, SELF.ExternalKey := LEFT.TMSID));
  fdocs := in_lienskeys;

  focusreq := Text_Search.Focus_Search_Module(info, FocusString,FALSE,,, MaxResults_val, TRUE,,fdocs,AlertInfo);
  ans := focusreq.ExtKeyAnswers;
  errCode := focusreq.error_code;
  errMsg := focusreq.error_msg;
  noErr := errCode = 0;
  IF(~noErr, ut.outputMessage(errCode, errMsg));

  // match tmsids with scores
  wkeys := PROJECT(ans, TRANSFORM(liensV2_services.layout_TMSID, SELF.TMSID := LEFT.ExternalKey));

  tmsids := DEDUP(wkeys, tmsid, ALL);

  // generate the report
  rpen := LiensV2_Services.liens_raw.report_view.by_tmsid(tmsids, ssn_mask_value,,,,,appType);

  rpen_sorted := SORT(rpen, -orig_filing_date, RECORD);

  Alerts.mac_ProcessAlerts(rpen_sorted,liensv2_services.alert,final_res);

  orec := RECORD
    RECORDOF(final_res);
    Text_Search.Layout_ExternalKey;
  END;
  orec addExt ( final_res l) := TRANSFORM
    SELF := l;
    SELF.ExternalKey := l.TMSID;
  END;
  final_res2 := PROJECT(final_res, addext(LEFT));

  // paging
  doxie.MAC_Marshall_Results_NoCount(final_res2, paged_results,, outputCount);

  // output count & results, and we're done
  IF(noErr, outputCount);
  IF(noErr, OUTPUT( paged_results, NAMED('Results')));

ENDMACRO;
