IMPORT iesp;

EXPORT layout := MODULE

  EXPORT request := RECORD
    DATASET(iesp.rnareport.t_RNAReportRequest) rnareportrequest;
  END;

  EXPORT response := iesp.rnareport.t_RNAReportResponse;

END;
