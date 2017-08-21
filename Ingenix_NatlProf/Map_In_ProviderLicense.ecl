

export Map_In_ProviderLicense (string filedate) := function;


Layout_in_ProviderLicense.raw_srctype t_DProviderLicense(Ingenix_NatlProf.File_in_ProviderLicense.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.LicenseNumberCompanyCount := l.ProviderLicense_CompanyCount;
self.LicenseNumberTierTypeID := l.ProviderLicense_TierTypeID;
self.licenseState := l.State;
self.Effective_Date := l.License_Effective_Date;
self.Termination_Date := l.License_Termination_Date;
self := l;
end;

File_Dental_ProviderLicense := Project(Ingenix_NatlProf.File_in_ProviderLicense.DentalProf,t_DProviderLicense(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderLicense.raw_srctype t_PhyProviderLicense(Ingenix_NatlProf.File_in_ProviderLicense.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.LicenseNumberCompanyCount := l.ProviderLicense_CompanyCount;
self.LicenseNumberTierTypeID := l.ProviderLicense_TierTypeID;
self.licenseState := l.State;
self.Effective_Date := l.License_Effective_Date;
self.Termination_Date := l.License_Termination_Date;
self := l;
end;

File_Physician_ProviderLicense := Project(Ingenix_NatlProf.File_in_ProviderLicense.Physician,t_PhyProviderLicense(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderLicense.raw_srctype t_AHProviderLicense(Ingenix_NatlProf.File_in_ProviderLicense.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.LicenseNumberCompanyCount := l.ProviderLicense_CompanyCount;
self.LicenseNumberTierTypeID := l.ProviderLicense_TierTypeID;
self.licenseState := l.State;
self.Effective_Date := l.License_Effective_Date;
self.Termination_Date := l.License_Termination_Date;
self := l;
end;

File_AH_ProviderLicense := Project(Ingenix_NatlProf.File_in_ProviderLicense.Allied_Health,t_AHProviderLicense(LEFT));


File_All_ProviderLicense := File_Dental_ProviderLicense + File_Physician_ProviderLicense + File_AH_ProviderLicense;

Out_ProviderLicense := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderLicense', '~thor_data400::in::ingenix_natlprof_ProviderLicense_' + filedate) > 0,Output('ProviderLicense Logical File Already Added'),

Sequential(
                           output(File_All_ProviderLicense,,'~thor_data400::in::ingenix_natlprof_ProviderLicense_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderLicense', '~thor_data400::in::ingenix_natlprof_ProviderLicense_' + filedate)
                           ));
return Out_ProviderLicense;
end;
