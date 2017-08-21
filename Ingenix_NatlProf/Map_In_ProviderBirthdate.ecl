
export Map_In_ProviderBirthdate (string filedate) := function;


Layout_in_ProviderBirthdate.raw_srctype t_DProviderBirthdate(Ingenix_NatlProf.File_in_ProviderBirthdate.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.BirthDateCompanyCount := l.ProviderDOBCompanyCount;
self.BirthDateTierTypeID := l.ProviderDOBTierTypeID;
self := l;
end;

File_Dental_ProviderBirthdate := Project(Ingenix_NatlProf.File_in_ProviderBirthdate.DentalProf,t_DProviderBirthdate(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderBirthdate.raw_srctype t_PhyProviderBirthdate(Ingenix_NatlProf.File_in_ProviderBirthdate.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.BirthDateCompanyCount := l.ProviderDOBCompanyCount;
self.BirthDateTierTypeID := l.ProviderDOBTierTypeID;
self := l;
end;

File_Physician_ProviderBirthdate := Project(Ingenix_NatlProf.File_in_ProviderBirthdate.Physician,t_PhyProviderBirthdate(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderBirthdate.raw_srctype t_AHProviderBirthdate(Ingenix_NatlProf.File_in_ProviderBirthdate.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.BirthDateCompanyCount := l.ProviderDOBCompanyCount;
self.BirthDateTierTypeID := l.ProviderDOBTierTypeID;
self := l;
end;

File_AH_ProviderBirthdate := Project(Ingenix_NatlProf.File_in_ProviderBirthdate.Allied_Health,t_AHProviderBirthdate(LEFT));


File_All_ProviderBirthdate := File_Dental_ProviderBirthdate + File_Physician_ProviderBirthdate + File_AH_ProviderBirthdate;

Out_ProviderBirthdate := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerbirthdate', '~thor_data400::in::ingenix_natlprof_providerbirthdate_' + filedate) > 0,Output('providerbirthdate Logical File Already Added'),
                Sequential(
                          output(File_All_ProviderBirthdate,,'~thor_data400::in::ingenix_natlprof_providerbirthdate_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerbirthdate', '~thor_data400::in::ingenix_natlprof_providerbirthdate_' + filedate)
                           ));
return Out_ProviderBirthdate;
end;
