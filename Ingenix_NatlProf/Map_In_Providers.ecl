
export Map_In_Providers(string filedate) := function

//Dental Profession Provider Pre Process
Layout_in_Provider_Preprocess := record
  string  FILETYP;
	string	ProcessDate;
	string	ProviderID;
	string	ProviderIDCompanyCount;
end;

Layout_in_Provider_Preprocess t_DProviderID(Ingenix_NatlProf.File_in_Providers.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.ProviderID := l.ProviderID;
self.ProviderIDCompanyCount := l.ProviderIDCompanyCount;
end;

File_Dental_ProviderID := Project(Ingenix_NatlProf.File_in_Providers.DentalProf,t_DProviderID(LEFT));


//Physician Profession Provider Pre Process

Layout_in_Provider_Preprocess t_PhyProviderID(Ingenix_NatlProf.File_in_Providers.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.ProviderID := l.ProviderID;
self.ProviderIDCompanyCount := l.ProviderIDCompanyCount;
end;

File_Physician_ProviderID := Project(Ingenix_NatlProf.File_in_Providers.Physician,t_PhyProviderID(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_Provider_Preprocess t_AHProviderID(Ingenix_NatlProf.File_in_Providers.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.ProviderID := l.ProviderID;
self.ProviderIDCompanyCount := l.ProviderIDCompanyCount;
end;

File_AH_ProviderID := Project(Ingenix_NatlProf.File_in_Providers.Allied_Health,t_AHProviderID(LEFT));


File_All_Provider := File_Dental_ProviderID + File_Physician_ProviderID + File_AH_ProviderID;

Out_Provider := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerID', '~thor_data400::in::ingenix_natlprof_providerID_' + filedate) > 0,Output('providerID Logical File Already Added'),                          
             Sequential(
                           output(File_All_Provider,,'~thor_data400::in::ingenix_natlprof_providerID_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerID', '~thor_data400::in::ingenix_natlprof_providerID_' + filedate)
                           ));
return Out_Provider;
end;
