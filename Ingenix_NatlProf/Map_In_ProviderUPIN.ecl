export Map_In_ProviderUPIN (string filedate) := function;


Layout_in_ProviderUPIN.raw_srctype t_DProviderUPIN(Ingenix_NatlProf.File_in_ProviderUPIN.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.UPINCompanyCount := l.ProviderUPINCompanyCount;
self.UPINTierTypeID := l.ProviderUPINTierTypeID;
self := l;
end;

File_Dental_ProviderUPIN := Project(Ingenix_NatlProf.File_in_ProviderUPIN.DentalProf,t_DProviderUPIN(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderUPIN.raw_srctype t_PhyProviderUPIN(Ingenix_NatlProf.File_in_ProviderUPIN.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.UPINCompanyCount := l.ProviderUPINCompanyCount;
self.UPINTierTypeID := l.ProviderUPINTierTypeID;
self := l;
end;

File_Physician_ProviderUPIN := Project(Ingenix_NatlProf.File_in_ProviderUPIN.Physician,t_PhyProviderUPIN(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderUPIN.raw_srctype t_AHProviderUPIN(Ingenix_NatlProf.File_in_ProviderUPIN.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.UPINCompanyCount := l.ProviderUPINCompanyCount;
self.UPINTierTypeID := l.ProviderUPINTierTypeID;
self := l;
end;

File_AH_ProviderUPIN := Project(Ingenix_NatlProf.File_in_ProviderUPIN.Allied_Health,t_AHProviderUPIN(LEFT));


File_All_ProviderUPIN := File_Dental_ProviderUPIN + File_Physician_ProviderUPIN + File_AH_ProviderUPIN;

Out_ProviderUPIN := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderUPIN', '~thor_data400::in::ingenix_natlprof_ProviderUPIN_' + filedate) > 0,Output('SanctionedProviders Logical File Already Added'),                          
               Sequential(
                           output(File_All_ProviderUPIN,,'~thor_data400::in::ingenix_natlprof_ProviderUPIN_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderUPIN', '~thor_data400::in::ingenix_natlprof_ProviderUPIN_' + filedate)
                           ));
return Out_ProviderUPIN;
end;
