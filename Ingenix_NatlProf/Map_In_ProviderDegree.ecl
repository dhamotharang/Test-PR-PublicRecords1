

export Map_In_ProviderDegree (string filedate) := function;


Layout_in_ProviderDegree.raw_srctype t_DProviderDegree(Ingenix_NatlProf.File_in_ProviderDegree.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.DegreeCompanyCount := l.ProviderDegreeCompanyCount;
self.DegreeTierTypeID := l.ProviderDegreeTierTypeID;
self := l;
end;

File_Dental_ProviderDegree := Project(Ingenix_NatlProf.File_in_ProviderDegree.DentalProf,t_DProviderDegree(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderDegree.raw_srctype t_PhyProviderDegree(Ingenix_NatlProf.File_in_ProviderDegree.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.DegreeCompanyCount := l.ProviderDegreeCompanyCount;
self.DegreeTierTypeID := l.ProviderDegreeTierTypeID;
self := l;
end;

File_Physician_ProviderDegree := Project(Ingenix_NatlProf.File_in_ProviderDegree.Physician,t_PhyProviderDegree(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderDegree.raw_srctype t_AHProviderDegree(Ingenix_NatlProf.File_in_ProviderDegree.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.DegreeCompanyCount := l.ProviderDegreeCompanyCount;
self.DegreeTierTypeID := l.ProviderDegreeTierTypeID;
self := l;
end;

File_AH_ProviderDegree := Project(Ingenix_NatlProf.File_in_ProviderDegree.Allied_Health,t_AHProviderDegree(LEFT));


File_All_ProviderDegree := File_Dental_ProviderDegree + File_Physician_ProviderDegree + File_AH_ProviderDegree;

Out_ProviderDegree := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderDegree', '~thor_data400::in::ingenix_natlprof_ProviderDegree_' + filedate) > 0,Output('ProviderDegree Logical File Already Added'),
               Sequential(
                          output(File_All_ProviderDegree,,'~thor_data400::in::ingenix_natlprof_ProviderDegree_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderDegree', '~thor_data400::in::ingenix_natlprof_ProviderDegree_' + filedate)
                           ));
return Out_ProviderDegree;
end;
