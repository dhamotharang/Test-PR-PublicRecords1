IMPORT iesp;

//non-ESDL input/output
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
    string  _transactionid;
    string  _batchuid;
    string  _gcid;
    string  lexidsourceoptout;
    string __deathmasterpurpose
  END;

  EXPORT esdl_request := iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesRequest;

  EXPORT request := RECORD(permissions)
    DATASET(esdl_request) AntiMoneyLaunderingRiskAttributesRequest {xpath('AntiMoneyLaunderingRiskAttributesRequest/Row')};

    //taken from query's WU
    string historydateyyyymm;
    //string gateways;
    string _batchjobid;
    string blind;
    string _blind;
    string allowall;
    string outcometrackingoptout;
    string instantidarchivingoptin;
  END;

  EXPORT request_defaults := request - permissions;

  EXPORT response := iesp.amlrattributes.t_AntiMoneyLaunderingRiskAttributesResponse;

END;
