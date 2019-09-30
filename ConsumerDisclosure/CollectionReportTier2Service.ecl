export CollectionReportTier2Service() := macro

  in_req := DATASET([], iesp.consumer_collection_report.t_CollectionReportTier2Request) : STORED('CollectionReportTier2Request');

  first_row := in_req[1] : INDEPENDENT;
  report_options := GLOBAL(first_row.Options);
  reportby := GLOBAL(first_row.ReportBy);
  
  unsigned6 lexID := (unsigned6) reportby.LexID;
  in_mod := ConsumerDisclosure.CollectionReport.IParam.GetParams(reportby, report_options);
  col_recs := ConsumerDisclosure.CollectionReport.RecordsTier2(lexID, in_mod);
  service_header := iesp.ECL2ESP.GetHeaderRow();

  iesp.consumer_collection_report.t_CollectionReportTier2Response xform() := transform
    self._Header.QueryId := service_header.QueryId;
    self._Header.TransactionId := service_header.TransactionId;
    self._Header.Status := 0;
    self._Header.Message := '';
    self._Header.Exceptions := dataset([], iesp.share.t_WsException);
    self.Result.InputEcho := reportby;
    self.Result.LexID := (STRING) lexID;
    self.Result.LNPID := ''; //??
    self.Result.RoxieCluster := STD.System.Thorlib.Cluster();
    self.Result.Collections :=  col_recs;   
  end;
  outfile := DATASET([xform()]);

  output(outfile, named('Results'));

endmacro;  