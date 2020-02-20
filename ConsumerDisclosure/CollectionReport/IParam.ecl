IMPORT $,iesp;

EXPORT IParam := MODULE

  EXPORT IReportParam := INTERFACE
    EXPORT BOOLEAN debug;
    EXPORT UNSIGNED request_date;
    EXPORT STRING state_act;
    EXPORT BOOLEAN ReturnEclLayoutText;
    EXPORT isDateOK(unsigned rec_date, unsigned1 dt_format) := FUNCTION 
      dt_YYYYMMDD := IF(dt_format = $.Constants.DateFormat.YYYYMM, rec_date*100, rec_date); // make sure format is YYYYMMDD
      RETURN request_date = 0 OR (rec_date = 0) OR (dt_YYYYMMDD >= request_date); // including all recs with no date
    END;
  END;

  EXPORT GetParams(
    iesp.consumer_collection_report.t_CollectionReportBy reportby, 
    iesp.consumer_collection_report.t_CollectionReportOptions options
    ) := FUNCTION

    inmod := MODULE  (IReportParam)  
      EXPORT BOOLEAN debug := false : STORED('debug');
      EXPORT UNSIGNED request_date := (UNSIGNED) iesp.ECL2ESP.DateToInteger(reportby.RequestDate);
      EXPORT STRING state_act := reportby.StateAct;
      EXPORT BOOLEAN ReturnEclLayoutText := options.ReturnEclLayoutText;
    END;

    RETURN inmod;

  END;

END;