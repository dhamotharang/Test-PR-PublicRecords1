IMPORT AutoStandardI, Doxie, Gateway;

EXPORT IParams := MODULE

  EXPORT SearchParams := INTERFACE(Doxie.IDataAccess)
    EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
    EXPORT string AppId := '';
    EXPORT string SearchMode := '';
    EXPORT unsigned1 ResultLimit := 5; // Default at GW
    /* 
      CachedResponseOnly: A flag to request GW to pull results from cache (if available).
      - Cache effective period: 24 Hours
      - Description: To pull a cached response, the GW 'SearchBy' fields should match the previous request.
    */
    EXPORT boolean CachedResponseOnly := false; // Default at GW
  END;

  EXPORT GetParams() := FUNCTION

    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(
                                          AutoStandardI.GlobalModule());

    in_mod := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
      // Note: The Constants.APPID_VIR_TEXT value is what ESP asked us to use for this NetWise (Email) gateway request
      // other queries that use this gateway may need to set some other value.
      // A future enahncement may be for ESP to pass this value into the query in the <SearchBy><AppID>   
      EXPORT string AppId := Gateway.NetwiseSearch.Constants.APPID_VIR_TEXT;
    END;

    RETURN in_mod;
  END;  

  EXPORT GetParams_PersonSearch(boolean cached_response) := FUNCTION

    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

    in_mod := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT dataset(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
      EXPORT string AppId := $.Constants.APPID_WPL_TEXT;
      EXPORT string SearchMode := $.Constants.MODE_PERSON;
      EXPORT unsigned1 ResultLimit := $.Constants.LIMIT_PERSON;
      EXPORT boolean CachedResponseOnly := cached_response;
    END;

    RETURN in_mod;
  END;

END;
