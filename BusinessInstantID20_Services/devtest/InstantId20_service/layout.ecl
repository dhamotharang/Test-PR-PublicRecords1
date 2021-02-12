IMPORT iesp, dev_regression;


EXPORT layout := MODULE

  EXPORT esdl_request := iesp.businessinstantid20.t_BusinessInstantID20Request;

  EXPORT request := RECORD
    dev_regression.layouts.external;
    DATASET(esdl_request) businessinstantid20request  {xpath('businessinstantid20request/row')};
  END;

  EXPORT response := iesp.businessinstantid20.t_BIID20Response;

END;
