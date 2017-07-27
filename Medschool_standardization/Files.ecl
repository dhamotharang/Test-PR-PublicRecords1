

IMPORT tools,Medschool_standardization;

EXPORT files(STRING pversion = '', boolean pUseProd = false) := MODULE
		tools.mac_FilesBase(Medschool_standardization.Filenames(pversion,pUseProd).medschool_Base, Medschool_standardization.layouts.layoutMedicalSchoolInfo1, medschool_base);
		tools.mac_FilesBase(Medschool_standardization.Filenames(pversion,pUseProd).medschool_wordlist_Base, Medschool_standardization.layouts.layoutMedicalSchoolWord1, medschool_wordlist_Base);
		tools.mac_FilesBase(Medschool_standardization.Filenames(pversion,pUseProd).non_medschool_Base, Medschool_standardization.layouts.layoutMedicalSchoolInfo1,non_medschool_base);
		tools.mac_FilesBase(Medschool_standardization.Filenames(pversion,pUseProd).non_medschool_wordlist_Base, Medschool_standardization.layouts.layoutMedicalSchoolWord1, non_medschool_wordlist_Base);

end;   