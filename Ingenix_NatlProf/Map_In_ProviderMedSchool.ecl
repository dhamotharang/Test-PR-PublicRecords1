
export Map_In_ProviderMedSchool (string filedate) := function;


Layout_in_ProviderMedSchool.raw_srctype t_DProviderMedSchool(Ingenix_NatlProf.File_in_ProviderMedSchool.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.MedSchoolCompanyCount := l.ProviderSchoolCompanyCount;
self.MedSchoolTierTypeID := l.ProviderSchoolTierTypeID;
self := l;
end;

File_Dental_ProviderMedSchool := Project(Ingenix_NatlProf.File_in_ProviderMedSchool.DentalProf,t_DProviderMedSchool(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderMedSchool.raw_srctype t_PhyProviderMedSchool(Ingenix_NatlProf.File_in_ProviderMedSchool.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.MedSchoolCompanyCount := l.ProviderSchoolCompanyCount;
self.MedSchoolTierTypeID := l.ProviderSchoolTierTypeID;
self := l;
end;

File_Physician_ProviderMedSchool := Project(Ingenix_NatlProf.File_in_ProviderMedSchool.Physician,t_PhyProviderMedSchool(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderMedSchool.raw_srctype t_AHProviderMedSchool(Ingenix_NatlProf.File_in_ProviderMedSchool.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.MedSchoolCompanyCount := l.ProviderSchoolCompanyCount;
self.MedSchoolTierTypeID := l.ProviderSchoolTierTypeID;
self := l;
end;

File_AH_ProviderMedSchool := Project(Ingenix_NatlProf.File_in_ProviderMedSchool.Allied_Health,t_AHProviderMedSchool(LEFT));


File_All_ProviderMedSchool := File_Dental_ProviderMedSchool + File_Physician_ProviderMedSchool + File_AH_ProviderMedSchool;

Out_ProviderMedSchool := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerMedSchool', '~thor_data400::in::ingenix_natlprof_providerMedSchool_' + filedate) > 0,Output('ProviderMedSchool Logical File Already Added'),

Sequential(
                        output(File_All_ProviderMedSchool,,'~thor_data400::in::ingenix_natlprof_providerMedSchool_' + filedate,CSV(quote(''),separator('|'),maxlength(8192)),overwrite),
												

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerMedSchool', '~thor_data400::in::ingenix_natlprof_providerMedSchool_' + filedate)
                           ));
return Out_ProviderMedSchool;
end;
