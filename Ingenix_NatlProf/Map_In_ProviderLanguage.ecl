

export Map_In_ProviderLanguage (string filedate) := function;


Layout_in_ProviderLanguage.raw_srctype t_DProviderLanguage(Ingenix_NatlProf.File_in_ProviderLanguage.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.LanguageCompanyCount := l.ProviderLanguageCompanyCount;
self.LanguageTierTypeID := l.ProviderLanguageTierTypeID;
self := l;
end;

File_Dental_ProviderLanguage := Project(Ingenix_NatlProf.File_in_ProviderLanguage.DentalProf,t_DProviderLanguage(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderLanguage.raw_srctype t_PhyProviderLanguage(Ingenix_NatlProf.File_in_ProviderLanguage.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.LanguageCompanyCount := l.ProviderLanguageCompanyCount;
self.LanguageTierTypeID := l.ProviderLanguageTierTypeID;
self := l;
end;

File_Physician_ProviderLanguage := Project(Ingenix_NatlProf.File_in_ProviderLanguage.Physician,t_PhyProviderLanguage(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderLanguage.raw_srctype t_AHProviderLanguage(Ingenix_NatlProf.File_in_ProviderLanguage.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.LanguageCompanyCount := l.ProviderLanguageCompanyCount;
self.LanguageTierTypeID := l.ProviderLanguageTierTypeID;
self := l;
end;

File_AH_ProviderLanguage := Project(Ingenix_NatlProf.File_in_ProviderLanguage.Allied_Health,t_AHProviderLanguage(LEFT));


File_All_ProviderLanguage := File_Dental_ProviderLanguage + File_Physician_ProviderLanguage + File_AH_ProviderLanguage;

Out_ProviderLanguage :=  if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerLanguage', '~thor_data400::in::ingenix_natlprof_providerLanguage_' + filedate) > 0,Output('providerLanguage Logical File Already Added'),
                  Sequential(
                           output(File_All_ProviderLanguage,,'~thor_data400::in::ingenix_natlprof_providerLanguage_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile(	'~thor_data400::in::ingenix_natlprof_providerLanguage', '~thor_data400::in::ingenix_natlprof_providerLanguage_' + filedate)
                           ));
return Out_ProviderLanguage;
end;
