
export Map_In_GroupAffiliation (string filedate) := function;


Layout_in_GroupAffiliation.raw_srctype t_DGroupAffiliation(Ingenix_NatlProf.File_in_GroupAffiliation.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.GroupName := l.Name;
self := l;
end;

File_Dental_GroupAffiliation := Project(Ingenix_NatlProf.File_in_GroupAffiliation.DentalProf,t_DGroupAffiliation(LEFT));


//Physician Profession Provider Pre Process

Layout_in_GroupAffiliation.raw_srctype t_PhyGroupAffiliation(Ingenix_NatlProf.File_in_GroupAffiliation.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.GroupName := l.Name;
self := l;
end;

File_Physician_GroupAffiliation := Project(Ingenix_NatlProf.File_in_GroupAffiliation.Physician,t_PhyGroupAffiliation(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_GroupAffiliation.raw_srctype t_AHGroupAffiliation(Ingenix_NatlProf.File_in_GroupAffiliation.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.GroupName := l.Name;
self := l;
end;

File_AH_GroupAffiliation := Project(Ingenix_NatlProf.File_in_GroupAffiliation.Allied_Health,t_AHGroupAffiliation(LEFT));


File_All_GroupAffiliation := File_Dental_GroupAffiliation + File_Physician_GroupAffiliation + File_AH_GroupAffiliation;

Out_GroupAffiliation := if( FileServices.FindSuperFileSubName('~thor_data400::in::ingenix_natlprof_GroupAffiliation','~thor_data400::in::ingenix_natlprof_groupaffiliation_' + filedate) > 0,Output('GroupAffilaition_Logical_File_Already_Added'),
                     Sequential(
                          output(File_All_GroupAffiliation,,'~thor_data400::in::ingenix_natlprof_GroupAffiliation_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_GroupAffiliation', '~thor_data400::in::ingenix_natlprof_GroupAffiliation_' + filedate)
                           ));
return Out_GroupAffiliation;
end;
