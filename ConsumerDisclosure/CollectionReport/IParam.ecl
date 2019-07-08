IMPORT $,iesp;

EXPORT IParam := MODULE

  EXPORT IReportParam := INTERFACE
    EXPORT BOOLEAN debug;
    EXPORT UNSIGNED request_date;
    EXPORT STRING state_act;
    EXPORT BOOLEAN ReturnEclLayoutText;
    EXPORT isDateOK(unsigned rec_date) := request_date = 0 OR (rec_date = 0) OR (rec_date >= request_date); // including all recs with no date
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