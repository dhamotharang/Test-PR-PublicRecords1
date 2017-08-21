

export Map_In_ProviderName(string filedate) := function;


Layout_in_ProviderName.raw_srctype t_DProviderName(Ingenix_NatlProf.File_in_ProviderName.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.Gender := '';
self.NameScore := l.RecSequenceNbr;
self := l;
end;

File_Dental_ProviderName := Project(Ingenix_NatlProf.File_in_ProviderName.DentalProf,t_DProviderName(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderName.raw_srctype t_PhyProviderName(Ingenix_NatlProf.File_in_ProviderName.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.Gender := '';
self.NameScore := l.RecSequenceNbr;
self := l;
end;

File_Physician_ProviderName := Project(Ingenix_NatlProf.File_in_ProviderName.Physician,t_PhyProviderName(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderName.raw_srctype t_AHProviderName(Ingenix_NatlProf.File_in_ProviderName.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.Gender := '';
self.NameScore := l.RecSequenceNbr;
self := l;
end;

File_AH_ProviderName := Project(Ingenix_NatlProf.File_in_ProviderName.Allied_Health,t_AHProviderName(LEFT));


File_All_ProviderName := File_Dental_ProviderName + File_Physician_ProviderName + File_AH_ProviderName;

Out_ProviderName := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providerName', '~thor_data400::in::ingenix_natlprof_providerName_' + filedate) > 0,Output('providerName Logical File Already Added'),

             Sequential(
                           output(File_All_ProviderName,,'~thor_data400::in::ingenix_natlprof_providerName_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providerName', '~thor_data400::in::ingenix_natlprof_providerName_' + filedate)
                           ));
return Out_ProviderName;
end;
