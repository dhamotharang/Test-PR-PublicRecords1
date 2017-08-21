export Map_In_ProviderMedicareOptOut (string filedate) := function;


Layout_in_ProviderMedicareOptOut.raw_srctype t_DProviderMedicareOptOut(Ingenix_NatlProf.File_in_ProviderMedicareOptOut.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self := l;
end;

File_Dental_ProviderMedicareOptOut := Project(Ingenix_NatlProf.File_in_ProviderMedicareOptOut.DentalProf,t_DProviderMedicareOptOut(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderMedicareOptOut.raw_srctype t_PhyProviderMedicareOptOut(Ingenix_NatlProf.File_in_ProviderMedicareOptOut.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self := l;
end;

File_Physician_ProviderMedicareOptOut := Project(Ingenix_NatlProf.File_in_ProviderMedicareOptOut.Physician,t_PhyProviderMedicareOptOut(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderMedicareOptOut.raw_srctype t_AHProviderMedicareOptOut(Ingenix_NatlProf.File_in_ProviderMedicareOptOut.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self := l;
end;

File_AH_ProviderMedicareOptOut := Project(Ingenix_NatlProf.File_in_ProviderMedicareOptOut.Allied_Health,t_AHProviderMedicareOptOut(LEFT));


File_All_ProviderMedicareOptOut := File_Dental_ProviderMedicareOptOut + File_Physician_ProviderMedicareOptOut + File_AH_ProviderMedicareOptOut;
CreateSuper:=FileServices.CreateSuperFile('~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut');
								
		CreateSuperfileIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut'),CreateSuper); 
		
Out_ProviderMedicareOptOut :=Sequential(CreateSuperfileIfNotExist,if ( FileServices.FindSuperFileSubName( '~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut', '~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut_' + filedate) > 0,Output('providerMedicareOptOut Logical File Already Added'),
               Sequential(
                          output(File_All_ProviderMedicareOptOut,,'~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut', '~thor_data400::in::Ingenix_NatlProf_providerMedicareOptOut_' + filedate)
                           )));
return Out_ProviderMedicareOptOut;
end;
