export Map_In_ProvIDSanctions (string filedate) := function;


Layout_in_ProviderSanctions.raw_srctype t_DProviderSanctions(Ingenix_NatlProf.File_in_ProviderSanctions.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self := l;
end;

File_Dental_ProviderSanctions := Project(Ingenix_NatlProf.File_in_ProviderSanctions.DentalProf,t_DProviderSanctions(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderSanctions.raw_srctype t_PhyProviderSanctions(Ingenix_NatlProf.File_in_ProviderSanctions.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self := l;
end;

File_Physician_ProviderSanctions := Project(Ingenix_NatlProf.File_in_ProviderSanctions.Physician,t_PhyProviderSanctions(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderSanctions.raw_srctype t_AHProviderSanctions(Ingenix_NatlProf.File_in_ProviderSanctions.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self := l;
end;

File_AH_ProviderSanctions := Project(Ingenix_NatlProf.File_in_ProviderSanctions.Allied_Health,t_AHProviderSanctions(LEFT));


File_All_ProviderSanctions := File_Dental_ProviderSanctions + File_Physician_ProviderSanctions + File_AH_ProviderSanctions;
CreateSuper:=FileServices.CreateSuperFile('~thor_data400::in::Ingenix_NatlProf_ProviderSanctions');
								
		CreateSuperfileIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::in::Ingenix_NatlProf_ProviderSanctions'),CreateSuper); 
		
Out_ProviderSanctions :=Sequential(CreateSuperfileIfNotExist,if ( FileServices.FindSuperFileSubName( '~thor_data400::in::Ingenix_NatlProf_ProviderSanctions', '~thor_data400::in::Ingenix_NatlProf_ProviderSanctions_' + filedate) > 0,Output('NewProviderSanctions Logical File Already Added'),
               Sequential(
                          output(File_All_ProviderSanctions,,'~thor_data400::in::Ingenix_NatlProf_ProviderSanctions_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::Ingenix_NatlProf_ProviderSanctions', '~thor_data400::in::Ingenix_NatlProf_ProviderSanctions_' + filedate)
                           )));
return Out_ProviderSanctions;
end;
