import AutoHeaderI, AutoStandardI, iesp;

EXPORT IParam := MODULE

  EXPORT reportParams := INTERFACE(AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  END;
  
  EXPORT SetInputReportBy (iesp.addressfeedback.t_AddressFeedbackReportBy reportBy) := FUNCTION
    iesp.ECL2ESP.SetInputAddress (reportBy.Address);
    #stored('DID', reportBy.UniqueId);
    RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
      
  EXPORT getReportModule(iesp.addressfeedback.t_AddressFeedbackReportBy reportBy) := FUNCTION
    in_mod := MODULE(PROJECT(AutoStandardI.GlobalModule(), reportParams, opt))
    END;
    RETURN in_mod;
  END;
  
END;
