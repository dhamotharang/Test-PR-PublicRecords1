IMPORT iesp;

EXPORT layout := MODULE

  SHARED permissions := RECORD
    string  applicationtype;
    string  dppapurpose;
    string  glbpurpose;
    string  datapermissionmask;
    string  datarestrictionmask;
    string  industryclass;
    string  excludedmvpii;
    string  ssnmask;
    string  dlmask;
    string  dobmask;
    string  intendeduse;
    string  ignorefares;
    string  ignorefidelity;
    string  lnbranded;
    string  includeminors;
    string  probationoverride;
  END;

  EXPORT esdl_request := iesp.propertyhistoryplus.t_PropertyHistoryPlusReportRequest;

  EXPORT request := RECORD (permissions)
    DATASET(esdl_request) PropertyHistoryPlusReportRequest;
  END;

  EXPORT request_defaults := request - permissions;

  EXPORT response := iesp.propertyhistoryplus.t_PropertyHistoryPlusReportResponse;

END;
