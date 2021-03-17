IMPORT iesp;

EXPORT layout := MODULE

  EXPORT request := RECORD
    DATASET(iesp.TopBusinessReport.t_TopBusinessReportRequest) TopBusinessReportRequest;
  END;

  EXPORT response := RECORD
    iesp.topbusinessReport.t_TopBusinessReportResponse;
  END;

END;
