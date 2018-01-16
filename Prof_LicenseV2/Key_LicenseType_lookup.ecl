import Prof_LicenseV2, doxie, ut, Data_Services, lib_Stringlib;


EXPORT Key_LicenseType_lookup(boolean IsFCRA = false) := function

license_type_lookup_base := File_ProfLic_LicenseType_lookup.License_Type_Base(license_type <>'');

filename := if (IsFCRA, 
								Data_Services.Data_location.Prefix() + 'thor_data400::key::prolicv2::fcra::' + doxie.Version_SuperKey + '::professional_license_type_lookup',
								Data_Services.Data_location.Prefix() + 'thor_data400::key::prolicv2::' + doxie.Version_SuperKey + '::professional_license_type_lookup');

return index(license_type_lookup_base, {license_type}, {license_type_lookup_base}, filename);								
								
end;