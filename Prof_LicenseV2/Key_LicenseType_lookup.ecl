import Prof_LicenseV2, doxie, ut, Data_Services, lib_Stringlib, vault, _control;



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT Key_LicenseType_lookup(boolean IsFCRA = false) := vault.Prof_LicenseV2.Key_LicenseType_lookup(isFCRA);

#ELSE
EXPORT Key_LicenseType_lookup(boolean IsFCRA = false) := function

license_type_lookup_base := File_ProfLic_LicenseType_lookup.License_Type_Base(license_type <>'');

filename := if (IsFCRA, 
								Data_Services.Data_location.Prefix() + 'thor_data400::key::prolicv2::fcra::' + doxie.Version_SuperKey + '::professional_license_type_lookup',
								Data_Services.Data_location.Prefix() + 'thor_data400::key::prolicv2::' + doxie.Version_SuperKey + '::professional_license_type_lookup');

return index(license_type_lookup_base, {license_type}, {license_type_lookup_base}, filename);								
								
end;


#END;

