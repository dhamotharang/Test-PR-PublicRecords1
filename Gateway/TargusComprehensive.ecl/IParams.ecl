import AutoStandardI, doxie, Gateway;

export IParams := module

  EXPORT ITargusSearchParam := INTERFACE(doxie.IDataAccess)
    EXPORT DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
  END;

  EXPORT GetParams() := FUNCTION

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
    
    in_mod := MODULE(project(mod_access, ITargusSearchParam, OPT))
      EXPORT DATASET (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
    END;
    RETURN in_mod;

  END;  

end;
