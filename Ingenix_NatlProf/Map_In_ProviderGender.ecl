

export Map_In_ProviderGender (string filedate) := function;


Layout_in_ProviderGender.raw_srctype t_DProviderGender(Ingenix_NatlProf.File_in_ProviderGender.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.GenderCompanyCount := l.ProviderGenderCompanyCount;
self.GenderTierTypeID := l.ProviderGenderTierTypeID;
self := l;
end;

File_Dental_ProviderGender := Project(Ingenix_NatlProf.File_in_ProviderGender.DentalProf,t_DProviderGender(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderGender.raw_srctype t_PhyProviderGender(Ingenix_NatlProf.File_in_ProviderGender.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.GenderCompanyCount := l.ProviderGenderCompanyCount;
self.GenderTierTypeID := l.ProviderGenderTierTypeID;
self := l;
end;

File_Physician_ProviderGender := Project(Ingenix_NatlProf.File_in_ProviderGender.Physician,t_PhyProviderGender(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderGender.raw_srctype t_AHProviderGender(Ingenix_NatlProf.File_in_ProviderGender.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.GenderCompanyCount := l.ProviderGenderCompanyCount;
self.GenderTierTypeID := l.ProviderGenderTierTypeID;
self := l;
end;

File_AH_ProviderGender := Project(Ingenix_NatlProf.File_in_ProviderGender.Allied_Health,t_AHProviderGender(LEFT));


File_All_ProviderGender := File_Dental_ProviderGender + File_Physician_ProviderGender + File_AH_ProviderGender;

Out_ProviderGender := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderGender', '~thor_data400::in::ingenix_natlprof_ProviderGender_' + filedate) > 0,Output('ProviderGender Logical File Already Added'),
                Sequential(
                           output(File_All_ProviderGender,,'~thor_data400::in::ingenix_natlprof_ProviderGender_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderGender', '~thor_data400::in::ingenix_natlprof_ProviderGender_' + filedate)
                           ));
return Out_ProviderGender;
end;
