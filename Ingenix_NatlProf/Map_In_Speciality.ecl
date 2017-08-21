export Map_In_Speciality (string filedate) := function;


Layout_in_Speciality.raw_srctype t_DSpeciality(Ingenix_NatlProf.File_in_Speciality.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self := l;
end;

File_Dental_Speciality := Project(Ingenix_NatlProf.File_in_Speciality.DentalProf,t_DSpeciality(LEFT));


//Physician Profession Provider Pre Process

Layout_in_Speciality.raw_srctype t_PhySpeciality(Ingenix_NatlProf.File_in_Speciality.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self := l;
end;

File_Physician_Speciality := Project(Ingenix_NatlProf.File_in_Speciality.Physician,t_PhySpeciality(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_Speciality.raw_srctype t_AHSpeciality(Ingenix_NatlProf.File_in_Speciality.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self := l;
end;

File_AH_Speciality := Project(Ingenix_NatlProf.File_in_Speciality.Allied_Health,t_AHSpeciality(LEFT));


File_All_Speciality := File_Dental_Speciality + File_Physician_Speciality + File_AH_Speciality;

Out_Speciality := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_Speciality', '~thor_data400::in::ingenix_natlprof_Speciality_' + filedate) > 0,Output('SanctionedProviders Logical File Already Added'),                           
                 Sequential(
                          output(File_All_Speciality,,'~thor_data400::in::ingenix_natlprof_Speciality_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_Speciality', '~thor_data400::in::ingenix_natlprof_Speciality_' + filedate)
                           ));
return Out_Speciality;
end;
