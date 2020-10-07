IMPORT iesp;
EXPORT layout := MODULE

  EXPORT request := RECORD
    DATASET(iesp.businesscreditreport.t_BusinessCreditReportRequest) BusinessCreditReportRequest;
  END;

  EXPORT response := iesp.businesscreditreport.t_BusinessCreditReportResponse;

END;
