export CollectionReportService() := macro

  in_req := DATASET([], iesp.consumer_collection_report.t_CollectionReportRequest) : STORED('CollectionReportRequest');

  first_row := in_req[1] : INDEPENDENT;
  report_options := GLOBAL(first_row.options);
  report_by := GLOBAL(first_row.ReportBy);

  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.SetInputReportBy(ROW(report_by, transform(iesp.bpsreport.t_BpsReportBy, self := left, self := [])));
  iesp.ECL2ESP.SetInputUser (first_row.User);

  in_lexid := (unsigned6) report_by.LexID;
  request_date := iesp.ECL2ESP.DateToString(report_by.RequestDate);
  in_mod := CCPA.IParam.GetCollectionReportParams( report_options);
  
  col_recs := CCPA.Records.GetCollections(in_lexid, request_date, in_mod);
  service_header := iesp.ECL2ESP.GetHeaderRow();

  iesp.consumer_collection_report.t_CollectionReportResponse xform() := transform
    self._Header.QueryId := service_header.QueryId;
    self._Header.TransactionId := service_header.TransactionId;
    self._Header.Status := 0;
    self._Header.Message := '';
    self._Header.Exceptions := dataset([], iesp.share.t_WsException);
    self.Result.InputEcho := report_by;
    self.Result.LNPID := ''; //??
    self.Result.RoxieCluster := STD.System.Thorlib.Cluster();
    self.Result.Collections :=  col_recs;   
  end;
  outfile := DATASET([xform()]);

  output(outfile, named('Results'));

endmacro;  