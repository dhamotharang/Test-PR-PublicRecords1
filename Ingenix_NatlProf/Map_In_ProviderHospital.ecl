
export Map_In_ProviderHospital (string filedate) := function;


Layout_in_ProviderHospital.raw_srctype t_DProviderHospital(Ingenix_NatlProf.File_in_ProviderHospital.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.HospitalNameCompanyCount := l.ProviderHospitalCompanyCount;
self.HospitalNameTierTypeID := l.ProviderHospitalTierTypeID;
self.HospitalName := '';
self := l;
end;

File_Dental_ProviderHospital := Project(Ingenix_NatlProf.File_in_ProviderHospital.DentalProf,t_DProviderHospital(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderHospital.raw_srctype t_PhyProviderHospital(Ingenix_NatlProf.File_in_ProviderHospital.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.HospitalNameCompanyCount := l.ProviderHospitalCompanyCount;
self.HospitalNameTierTypeID := l.ProviderHospitalTierTypeID;
self.HospitalName := '';
self := l;
end;

File_Physician_ProviderHospital := Project(Ingenix_NatlProf.File_in_ProviderHospital.Physician,t_PhyProviderHospital(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderHospital.raw_srctype t_AHProviderHospital(Ingenix_NatlProf.File_in_ProviderHospital.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.HospitalNameCompanyCount := l.ProviderHospitalCompanyCount;
self.HospitalNameTierTypeID := l.ProviderHospitalTierTypeID;
self.HospitalName := '';
self := l;
end;

File_AH_ProviderHospital := Project(Ingenix_NatlProf.File_in_ProviderHospital.Allied_Health,t_AHProviderHospital(LEFT));


File_All_ProviderHospital := File_Dental_ProviderHospital + File_Physician_ProviderHospital + File_AH_ProviderHospital;

Out_ProviderHospital := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerHospital', '~thor_data400::in::ingenix_natlprof_providerHospital_' + filedate) > 0,Output('providerHospital Logical File Already Added'),
                Sequential(
                           output(File_All_ProviderHospital,,'~thor_data400::in::ingenix_natlprof_providerHospital_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerHospital', '~thor_data400::in::ingenix_natlprof_providerHospital_' + filedate)
                           ));
return Out_ProviderHospital;
end;
