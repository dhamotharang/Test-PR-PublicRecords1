IMPORT iesp, dev_regression;


EXPORT layout := MODULE

  EXPORT esdl_request := iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest;

  EXPORT request := RECORD
    dev_regression.layouts.external;
    DATASET(esdl_request) duediligencepersonreportrequest  {xpath('duediligencepersonreportrequest/row')};
  END;

  EXPORT response := iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse;

END;
