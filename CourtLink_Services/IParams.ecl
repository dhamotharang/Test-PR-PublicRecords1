IMPORT AutoStandardI, doxie, iesp;

EXPORT IParams := MODULE

  EXPORT ContactRiskSearch := INTERFACE(doxie.IDataAccess)
    EXPORT STRING1 CaseTypeSearchFDCPA := '';
    EXPORT STRING1 CaseTypeSearchFCRA := '';
    EXPORT STRING1 CaseTypeSearchTCPA := '';
  END;

  EXPORT GetContactRiskSearchParams(iesp.contactrisksearch.t_ContactRiskSearchOption in_options) := FUNCTION
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

    search_params := MODULE(PROJECT(mod_access, ContactRiskSearch, OPT))
      EXPORT STRING1 CaseTypeSearchFDCPA := in_options.CaseTypeSearchFDCPA;
      EXPORT STRING1 CaseTypeSearchFCRA := in_options.CaseTypeSearchFCRA;
      EXPORT STRING1 CaseTypeSearchTCPA := in_options.CaseTypeSearchTCPA;
    END;

    RETURN search_params;
  END;

END;
