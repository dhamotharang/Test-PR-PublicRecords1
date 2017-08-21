import Prof_LicenseV2,prof_License;

Export as_header := module

Export new_business_header:=Prof_License.fProf_License_As_Business_header (files.DS_prolicv2_AID,true);

EXPORT new_business_contact := Prof_License.fProf_License_As_Business_contact (files.DS_prolicv2_AID,true); 

Export new_person_header:=Prof_License.proflic_as_header (files.DS_prolicv2_AID,,true);

EXPORT new_business_linking := Prof_LicenseV2.fProf_License_As_Business_Linking(files.DS_File_prolicv2_Base((unsigned6)bdid <> 0), true); 

End;