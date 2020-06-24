import doxie,AutoStandardI ;
EXPORT ConvertcfgtoIdataaccess(dataset(healthcare_header_services.Layouts.common_runtime_config) cfg) := function
g_mod :=  AutoStandardI.GlobalModule();

 mod_access := MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(g_mod));

  EXPORT unsigned1 glb := cfg[1].glb;

  EXPORT unsigned1 dppa := cfg[1].dppa;

  EXPORT string DataRestrictionMask :=cfg[1].DRM;
  EXPORT string DataPermissionMask :=cfg[1].DPM;

end;
return mod_access;
end;