IMPORT AutoStandardI, Doxie, Gateway;

EXPORT IParams := MODULE

  EXPORT SearchParams := INTERFACE(Doxie.IDataAccess)
    EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
  END;

  EXPORT GetParams() := FUNCTION

    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(
                                          AutoStandardI.GlobalModule());

    in_mod := MODULE(PROJECT(mod_access, SearchParams, OPT))
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;

    RETURN in_mod;
  END;  

END;
