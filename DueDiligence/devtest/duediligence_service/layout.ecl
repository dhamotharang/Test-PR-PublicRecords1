IMPORT iesp, dev_regression;


EXPORT layout := MODULE

  EXPORT esdl_request := iesp.duediligenceattributes.t_DueDiligenceAttributesRequest;

  EXPORT request := RECORD
    dev_regression.layouts.external;
    DATASET(esdl_request) duediligenceattributesrequest  {xpath('duediligenceattributesrequest/row')};
  END;

  EXPORT response := iesp.duediligenceattributes.t_DueDiligenceAttributesResponse;

END;
