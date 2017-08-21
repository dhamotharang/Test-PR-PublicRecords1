
export Map_In_ProviderGroup (string filedate) := function;


Layout_in_ProviderGroup.raw_srctype t_DProviderGroup(Ingenix_NatlProf.File_in_ProviderGroup.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.GroupNameCompanyCount := l.ProviderGroupCompanyCount;
self.GroupNameTierTypeID := l.ProviderGroupTierTypeID;
self.GroupPracticeID := l.GroupID;
self.GroupName := '';
self := l;
end;

File_Dental_ProviderGroup := Project(Ingenix_NatlProf.File_in_ProviderGroup.DentalProf,t_DProviderGroup(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderGroup.raw_srctype t_PhyProviderGroup(Ingenix_NatlProf.File_in_ProviderGroup.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.GroupNameCompanyCount := l.ProviderGroupCompanyCount;
self.GroupNameTierTypeID := l.ProviderGroupTierTypeID;
self.GroupPracticeID := l.GroupID;
self.GroupName := '';
self := l;
end;

File_Physician_ProviderGroup := Project(Ingenix_NatlProf.File_in_ProviderGroup.Physician,t_PhyProviderGroup(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderGroup.raw_srctype t_AHProviderGroup(Ingenix_NatlProf.File_in_ProviderGroup.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.GroupNameCompanyCount := l.ProviderGroupCompanyCount;
self.GroupNameTierTypeID := l.ProviderGroupTierTypeID;
self.GroupPracticeID := l.GroupID;
self.GroupName := '';
self := l;
end;

File_AH_ProviderGroup := Project(Ingenix_NatlProf.File_in_ProviderGroup.Allied_Health,t_AHProviderGroup(LEFT));


File_All_ProviderGroup := File_Dental_ProviderGroup + File_Physician_ProviderGroup + File_AH_ProviderGroup;

Out_ProviderGroup := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderGroup', '~thor_data400::in::ingenix_natlprof_ProviderGroup_' + filedate) > 0,Output('ProviderGroup Logical File Already Added'),
               Sequential(
                           output(File_All_ProviderGroup,,'~thor_data400::in::ingenix_natlprof_ProviderGroup_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderGroup', '~thor_data400::in::ingenix_natlprof_ProviderGroup_' + filedate)
                           ));
return Out_ProviderGroup;
end;
