export Map_In_SpecialityGroup (string filedate) := function;


Layout_in_SpecialityGroup.raw_srctype t_DSpecialityGroup(Ingenix_NatlProf.File_in_SpecialityGroup.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.SpecialityGroupId := l.groupid;
self.SpecialityGroupName := l.groupname;
self := l;
end;

File_Dental_SpecialityGroup := Project(Ingenix_NatlProf.File_in_SpecialityGroup.DentalProf,t_DSpecialityGroup(LEFT));


//Physician Profession Provider Pre Process

Layout_in_SpecialityGroup.raw_srctype t_PhySpecialityGroup(Ingenix_NatlProf.File_in_SpecialityGroup.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.SpecialityGroupId := l.groupid;
self.SpecialityGroupName := l.groupname;
self := l;
end;

File_Physician_SpecialityGroup := Project(Ingenix_NatlProf.File_in_SpecialityGroup.Physician,t_PhySpecialityGroup(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_SpecialityGroup.raw_srctype t_AHSpecialityGroup(Ingenix_NatlProf.File_in_SpecialityGroup.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.SpecialityGroupId := l.groupid;
self.SpecialityGroupName := l.groupname;
self := l;
end;

File_AH_SpecialityGroup := Project(Ingenix_NatlProf.File_in_SpecialityGroup.Allied_Health,t_AHSpecialityGroup(LEFT));


File_All_SpecialityGroup := File_Dental_SpecialityGroup + File_Physician_SpecialityGroup + File_AH_SpecialityGroup;

Out_SpecialityGroup := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_SpecialityGroup', '~thor_data400::in::ingenix_natlprof_SpecialityGroup_' + filedate) > 0,Output('SanctionedProviders Logical File Already Added'),                           
            Sequential(
                           output(File_All_SpecialityGroup,,'~thor_data400::in::ingenix_natlprof_SpecialityGroup_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_SpecialityGroup', '~thor_data400::in::ingenix_natlprof_SpecialityGroup_' + filedate)
                           ));
return Out_SpecialityGroup;
end;
