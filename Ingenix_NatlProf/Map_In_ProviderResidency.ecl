
export Map_In_ProviderResidency (string filedate) := function;


Layout_in_ProviderResidency.raw_srctype t_DProviderResidency(Ingenix_NatlProf.File_in_ProviderResidency.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.ResidencyCompanyCount := l.ProviderResidencyCompanyCount;
self.ResidencyTierTypeID := l.ProviderResidencyTierTypeID;
self := l;
end;

File_Dental_ProviderResidency := Project(Ingenix_NatlProf.File_in_ProviderResidency.DentalProf,t_DProviderResidency(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderResidency.raw_srctype t_PhyProviderResidency(Ingenix_NatlProf.File_in_ProviderResidency.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.ResidencyCompanyCount := l.ProviderResidencyCompanyCount;
self.ResidencyTierTypeID := l.ProviderResidencyTierTypeID;
self := l;
end;

File_Physician_ProviderResidency := Project(Ingenix_NatlProf.File_in_ProviderResidency.Physician,t_PhyProviderResidency(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderResidency.raw_srctype t_AHProviderResidency(Ingenix_NatlProf.File_in_ProviderResidency.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.ResidencyCompanyCount := l.ProviderResidencyCompanyCount;
self.ResidencyTierTypeID := l.ProviderResidencyTierTypeID;
self := l;
end;

File_AH_ProviderResidency := Project(Ingenix_NatlProf.File_in_ProviderResidency.Allied_Health,t_AHProviderResidency(LEFT));


File_All_ProviderResidency := File_Dental_ProviderResidency + File_Physician_ProviderResidency + File_AH_ProviderResidency;

Out_ProviderResidency :=  if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerResidency', '~thor_data400::in::ingenix_natlprof_providerResidency_' + filedate) > 0,Output('providerResidency Logical File Already Added'),            
              Sequential(
                         output(File_All_ProviderResidency,,'~thor_data400::in::ingenix_natlprof_providerResidency_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerResidency', '~thor_data400::in::ingenix_natlprof_providerResidency_' + filedate)
                           ));
return Out_ProviderResidency;
end;
