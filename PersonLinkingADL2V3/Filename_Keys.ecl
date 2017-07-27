import ut,Data_services,Doxie,_control;

export Filename_Keys := module

shared string superkey_version := if(_Control.mod_xADLversion.QA_version, doxie.version_superkey, 'built');

export kaddress3 := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderADDRESS3Refs_' + superkey_version;
export kDOB := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderDORefs_' + superkey_version;
export kSSN := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderSRefs_' + superkey_version;
export kSSN4 := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderSSN4Refs_' + superkey_version;
export kLFZ := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderLFZRefs_' + superkey_version;
export kphone := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderPHRefs_' + superkey_version;
export kZPRF := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderZPRFRefs_' + superkey_version;
export kFLST := Data_services.Data_location.Prefix('person_xADL2') + 'key::PersonLinkingADL2V3PersonHeaderFLSTRefs_' + superkey_version;

end;

 