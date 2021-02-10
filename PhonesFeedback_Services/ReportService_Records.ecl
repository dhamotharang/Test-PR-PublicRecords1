IMPORT PhonesFeedback_Services, AutoStandardI, iesp;

EXPORT ReportService_Records := MODULE
  
  EXPORT params := INTERFACE(
    PhonesFeedback_Services.ReportService_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base)
  END;
  
  EXPORT val(params in_mod) := FUNCTION
    ids := PhonesFeedback_Services.ReportService_IDs.val(in_mod);
    recs_fmt := PhonesFeedback_Services.Functions.fnSearchval(ids);
    results_slim := DEDUP(SORT(PROJECT(recs_fmt, iesp.phonesfeedback.t_PhonesFeedbackReportResponse),
      RECORD), RECORD);
    RETURN results_slim;
  END;

END;


