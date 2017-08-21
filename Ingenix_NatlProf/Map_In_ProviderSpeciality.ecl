export Map_In_ProviderSpeciality (string filedate) := function;


Layout_in_ProviderSpeciality.raw_srctype t_DProviderSpeciality(Ingenix_NatlProf.File_in_ProviderSpeciality.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.SpecialtyCompanyCount := l.ProviderSpecialityCompanyCount;
self.SpecialtyTierTypeID := l.ProviderSpecialityTierTypeID;
self := l;
end;

File_Dental_ProviderSpeciality := Project(Ingenix_NatlProf.File_in_ProviderSpeciality.DentalProf,t_DProviderSpeciality(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderSpeciality.raw_srctype t_PhyProviderSpeciality(Ingenix_NatlProf.File_in_ProviderSpeciality.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.SpecialtyCompanyCount := l.ProviderSpecialityCompanyCount;
self.SpecialtyTierTypeID := l.ProviderSpecialityTierTypeID;
self := l;
end;

File_Physician_ProviderSpeciality := Project(Ingenix_NatlProf.File_in_ProviderSpeciality.Physician,t_PhyProviderSpeciality(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderSpeciality.raw_srctype t_AHProviderSpeciality(Ingenix_NatlProf.File_in_ProviderSpeciality.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.SpecialtyCompanyCount := l.ProviderSpecialityCompanyCount;
self.SpecialtyTierTypeID := l.ProviderSpecialityTierTypeID;
self := l;
end;

File_AH_ProviderSpeciality := Project(Ingenix_NatlProf.File_in_ProviderSpeciality.Allied_Health,t_AHProviderSpeciality(LEFT));


File_All_ProviderSpeciality := File_Dental_ProviderSpeciality + File_Physician_ProviderSpeciality + File_AH_ProviderSpeciality;

Out_ProviderSpeciality := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerSpeciality', '~thor_data400::in::ingenix_natlprof_providerSpeciality_' + filedate) > 0,Output('providerSpeciality Logical File Already Added'),                          
              Sequential(
                           output(File_All_ProviderSpeciality,,'~thor_data400::in::ingenix_natlprof_providerSpeciality_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerSpeciality', '~thor_data400::in::ingenix_natlprof_providerSpeciality_' + filedate)
                           ));
return Out_ProviderSpeciality;
end;
