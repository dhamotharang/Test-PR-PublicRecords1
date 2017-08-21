
export Map_In_ProviderNPI(string filedate) := function;


Layout_in_ProviderNPI.raw_srctype t_DProviderNPI(Ingenix_NatlProf.File_in_ProviderNPI.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.NPICompanyCount := l.ProviderNPICompanyCount;
self.NPITierTypeID := l.ProviderNPITierTypeID;
self := l;
end;

File_Dental_ProviderNPI := Project(Ingenix_NatlProf.File_in_ProviderNPI.DentalProf,t_DProviderNPI(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderNPI.raw_srctype t_PhyProviderNPI(Ingenix_NatlProf.File_in_ProviderNPI.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.NPICompanyCount := l.ProviderNPICompanyCount;
self.NPITierTypeID := l.ProviderNPITierTypeID;
self := l;
end;

File_Physician_ProviderNPI := Project(Ingenix_NatlProf.File_in_ProviderNPI.Physician,t_PhyProviderNPI(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderNPI.raw_srctype t_AHProviderNPI(Ingenix_NatlProf.File_in_ProviderNPI.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.NPICompanyCount := l.ProviderNPICompanyCount;
self.NPITierTypeID := l.ProviderNPITierTypeID;
self := l;
end;

File_AH_ProviderNPI := Project(Ingenix_NatlProf.File_in_ProviderNPI.Allied_Health,t_AHProviderNPI(LEFT));


File_All_ProviderNPI := File_Dental_ProviderNPI + File_Physician_ProviderNPI + File_AH_ProviderNPI;

Out_ProviderNPI := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderNPI', '~thor_data400::in::ingenix_natlprof_ProviderNPI_' + filedate) > 0,Output('providerName Logical File Already Added'),
            Sequential(
                           output(File_All_ProviderNPI,,'~thor_data400::in::ingenix_natlprof_ProviderNPI_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderNPI', '~thor_data400::in::ingenix_natlprof_ProviderNPI_' + filedate)
                           ));
return Out_ProviderNPI;
end;
