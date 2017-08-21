export  Map_In_ProviderDeceased (string filedate) := function;


Layout_in_providerdeceased.raw_srctype t_DproviderDeceaseddata(Ingenix_NatlProf.File_in_ProviderDeceased.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self := l;
end;

File_Dental_providerDeceaseddata := Project(Ingenix_NatlProf.File_in_ProviderDeceased.DentalProf,t_DproviderDeceaseddata(LEFT));


//Physician Profession Provider Pre Process

Layout_in_providerdeceased.raw_srctype t_PhyproviderDeceaseddata(Ingenix_NatlProf.File_in_ProviderDeceased.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self := l;
end;

File_Physician_providerDeceaseddata := Project(Ingenix_NatlProf.File_in_ProviderDeceased.Physician,t_PhyproviderDeceaseddata(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_providerdeceased.raw_srctype t_AHproviderDeceaseddata(Ingenix_NatlProf.File_in_ProviderDeceased.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self := l;
end;

File_AH_providerDeceaseddata := Project(Ingenix_NatlProf.File_in_ProviderDeceased.Allied_Health,t_AHproviderDeceaseddata(LEFT));


File_All_providerDeceaseddata := File_Dental_providerDeceaseddata + File_Physician_providerDeceaseddata + File_AH_providerDeceaseddata;
CreateSuper:=FileServices.CreateSuperFile('~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata');
								
		CreateSuperfileIfNotExist := if(NOT FileServices.SuperFileExists('~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata'),CreateSuper); 
		
Out_providerDeceaseddata :=Sequential(CreateSuperfileIfNotExist,if ( FileServices.FindSuperFileSubName( '~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata', '~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata_' + filedate) > 0,Output('providerDeceaseddata Logical File Already Added'),
               Sequential(
                          output(File_All_providerDeceaseddata,,'~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata', '~thor_data400::in::Ingenix_NatlProf_providerDeceaseddata_' + filedate)
                           )));
return Out_providerDeceaseddata;
end;
