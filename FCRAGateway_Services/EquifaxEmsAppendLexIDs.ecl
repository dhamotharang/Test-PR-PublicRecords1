IMPORT iesp, Gateway, FCRA, FCRAGateway_Services;

EXPORT EquifaxEmsAppendLexIDs(DATASET(iesp.equifax_ems.t_CreditReportRecord) ds_ems_reports,
  iesp.share.t_User user) := FUNCTION
  
  //New layout, report + lexID resolution request, internal to this attribute.
  //This will allow appending resolved lexIDs to each report.
  report_w_lexID_request_layout := RECORD
  
    //Currently using didville, which uses picklist layout.
    iesp.person_picklist.t_PersonPickListRequest lexID_request;
    iesp.equifax_ems.t_CreditReportRecord report;
  END;

  //This transform keeps the report and creates a lexID request.
  report_w_lexID_request_layout append_lexID_request(iesp.equifax_ems.t_CreditReportRecord report) := TRANSFORM
      SELF.report := report;
      SELF.lexID_request.User := user;
      SELF.lexID_request.SearchBy := report.BureauBorrower;
      SELF := [];
  END;

  //There are multiple reports, each with their own PII. Append a lexid_request to each.
  ds_ems_lexID_reqs := PROJECT(ds_ems_reports, append_lexID_request(LEFT));

  //getDidville accepts one request at a time. This transform will append the result to each report.
  FCRAGateway_Services.Layouts.equifax_ems.lexID_appended_report
    append_lexIDs(report_w_lexID_request_layout req) := TRANSFORM
    
      //Returns a dataset, with only the first row populated.
      //Can't use ROW within a transform.
      dville_result := FCRA.getDidVilleRecords(req.lexID_request)[1];
      dville_record := dville_result.Records[1];
      
      //Check for errors and 0 the lexID if any found just to be safe.
      is_dville_ok := dville_result._header.status = 0;
      SELF.resolved_lexID := IF(is_dville_ok, (unsigned6)dville_record.uniqueID, 0);
      SELF := req.report;
  END;

  ds_lexid_appended_reports := PROJECT(ds_ems_lexID_reqs, append_lexIDs(LEFT));

  #IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsGateway)
    OUTPUT(ds_ems_lexID_reqs, NAMED('ds_ems_lexID_reqs'));
    OUTPUT(ds_lexid_appended_reports, NAMED('ds_lexid_appended_reports'));
  #END

  RETURN ds_lexid_appended_reports;
END;