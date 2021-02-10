IMPORT iesp, dev_regression;


EXPORT layout := MODULE

  EXPORT esdl_request := iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsRequest;

  EXPORT request := RECORD
    dev_regression.layouts.external;
    esdl_request smallbusinessanalyticsrequest  {xpath('smallbusinessanalyticsrequest/row')};
  END;

  EXPORT request_defaults := RECORD
    {esdl_request - User} smallbusinessanalyticsrequest  {xpath('smallbusinessanalyticsrequest/row')};
  END;

  EXPORT response := iesp.smallbusinessanalytics.t_SmallBusinessAnalyticsResponse;

END;
