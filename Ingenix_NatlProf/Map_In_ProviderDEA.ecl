

export Map_In_ProviderDEA (string filedate) := function;


Layout_in_ProviderAddressDEANumber.raw_srctype t_DProviderDEA(Ingenix_NatlProf.File_in_ProviderAddressDEANumber.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.DEANumberCompanyCount := l.ProviderDEACompanyCount;
self.DEANumberTierTypeID := l.ProviderDEATierTypeID;
self := l;
end;

File_Dental_ProviderDEA := Project(Ingenix_NatlProf.File_in_ProviderAddressDEANumber.DentalProf,t_DProviderDEA(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderAddressDEANumber.raw_srctype t_PhyProviderDEA(Ingenix_NatlProf.File_in_ProviderAddressDEANumber.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.DEANumberCompanyCount := l.ProviderDEACompanyCount;
self.DEANumberTierTypeID := l.ProviderDEATierTypeID;
self := l;
end;

File_Physician_ProviderDEA := Project(Ingenix_NatlProf.File_in_ProviderAddressDEANumber.Physician,t_PhyProviderDEA(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderAddressDEANumber.raw_srctype t_AHProviderDEA(Ingenix_NatlProf.File_in_ProviderAddressDEANumber.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.DEANumberCompanyCount := l.ProviderDEACompanyCount;
self.DEANumberTierTypeID := l.ProviderDEATierTypeID;
self := l;
end;

File_AH_ProviderDEA := Project(Ingenix_NatlProf.File_in_ProviderAddressDEANumber.Allied_Health,t_AHProviderDEA(LEFT));


File_All_ProviderDEA := File_Dental_ProviderDEA + File_Physician_ProviderDEA + File_AH_ProviderDEA;

Out_ProviderDEA := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderDEA', '~thor_data400::in::ingenix_natlprof_ProviderDEA_' + filedate) > 0,Output('ProviderDEA Logical File Already Added'),
                 Sequential(
                          output(File_All_ProviderDEA,,'~thor_data400::in::ingenix_natlprof_ProviderDEA_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderDEA', '~thor_data400::in::ingenix_natlprof_ProviderDEA_' + filedate)
                           ));
return Out_ProviderDEA;
end;
