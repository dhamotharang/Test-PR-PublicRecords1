IMPORT AutoStandardI, Doxie, Gateway;

EXPORT IParams := MODULE

  EXPORT SearchParams := INTERFACE(Doxie.IDataAccess)
    EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
    EXPORT string AppId := '';
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

END;
