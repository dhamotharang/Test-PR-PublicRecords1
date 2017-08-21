
export Map_In_ProviderNPITaxonomy (string filedate) := function;


Layout_in_ProviderNPITaxonomy.raw_srctype t_DProviderNPITaxonomy(Ingenix_NatlProf.File_in_ProviderNPITaxonomy.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self := l;
end;

File_Dental_ProviderNPITaxonomy := Project(Ingenix_NatlProf.File_in_ProviderNPITaxonomy.DentalProf,t_DProviderNPITaxonomy(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderNPITaxonomy.raw_srctype t_PhyProviderNPITaxonomy(Ingenix_NatlProf.File_in_ProviderNPITaxonomy.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self := l;
end;

File_Physician_ProviderNPITaxonomy := Project(Ingenix_NatlProf.File_in_ProviderNPITaxonomy.Physician,t_PhyProviderNPITaxonomy(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderNPITaxonomy.raw_srctype t_AHProviderNPITaxonomy(Ingenix_NatlProf.File_in_ProviderNPITaxonomy.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self := l;
end;

File_AH_ProviderNPITaxonomy := Project(Ingenix_NatlProf.File_in_ProviderNPITaxonomy.Allied_Health,t_AHProviderNPITaxonomy(LEFT));


File_All_ProviderNPITaxonomy := File_Dental_ProviderNPITaxonomy + File_Physician_ProviderNPITaxonomy + File_AH_ProviderNPITaxonomy;

Out_ProviderNPITaxonomy := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_providernpitaxonomy', '~thor_data400::in::ingenix_natlprof_providernpitaxonomy_' + filedate) > 0,Output('ProviderNPITaxonomy Logical File Already Added'),            

               Sequential(
                          output(File_All_ProviderNPITaxonomy,,'~thor_data400::in::ingenix_natlprof_providernpitaxonomy_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_providernpitaxonomy', '~thor_data400::in::ingenix_natlprof_providernpitaxonomy_' + filedate)
                           ));
return Out_ProviderNPITaxonomy;
end;
