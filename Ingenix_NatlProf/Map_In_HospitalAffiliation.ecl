

export Map_In_HospitalAffiliation (string filedate) := function;


Layout_in_HospitalAffiliation.raw_srctype t_DHospitalAffiliation(Ingenix_NatlProf.File_in_HospitalAffiliation.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.HospitalName := l.Name;
self := l;
end;

File_Dental_HospitalAffiliation := Project(Ingenix_NatlProf.File_in_HospitalAffiliation.DentalProf,t_DHospitalAffiliation(LEFT));


//Physician Profession Provider Pre Process

Layout_in_HospitalAffiliation.raw_srctype t_PhyHospitalAffiliation(Ingenix_NatlProf.File_in_HospitalAffiliation.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.HospitalName := l.Name;
self := l;
end;

File_Physician_HospitalAffiliation := Project(Ingenix_NatlProf.File_in_HospitalAffiliation.Physician,t_PhyHospitalAffiliation(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_HospitalAffiliation.raw_srctype t_AHHospitalAffiliation(Ingenix_NatlProf.File_in_HospitalAffiliation.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.HospitalName := l.Name;
self := l;
end;

File_AH_HospitalAffiliation := Project(Ingenix_NatlProf.File_in_HospitalAffiliation.Allied_Health,t_AHHospitalAffiliation(LEFT));


File_All_HospitalAffiliation := File_Dental_HospitalAffiliation + File_Physician_HospitalAffiliation + File_AH_HospitalAffiliation;

Out_HospitalAffiliation := if( FileServices.FindSuperFileSubName('~thor_data400::in::ingenix_natlprof_HospitalAffiliation', '~thor_data400::in::ingenix_natlprof_HospitalAffiliation_' + filedate) > 0,Output('HospitalAffiliation Logical File Already Added'),
                  Sequential(
                           output(File_All_HospitalAffiliation,,'~thor_data400::in::ingenix_natlprof_HospitalAffiliation_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_HospitalAffiliation', '~thor_data400::in::ingenix_natlprof_HospitalAffiliation_' + filedate)
                           ));
return Out_HospitalAffiliation;
end;
