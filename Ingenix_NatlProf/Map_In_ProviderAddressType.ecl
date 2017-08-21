import lib_stringlib;
export Map_In_ProviderAddresstype(string filedate) := function

Layout_in_ProviderAddresstype.raw_srctype t_DProviderAddresstype(Ingenix_NatlProf.File_in_ProviderAddresstype.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.ProviderAddressTypeCode := l.AddressTypeCode;
self := l;
end;

File_Dental_ProviderAddresstype := Project(Ingenix_NatlProf.File_in_ProviderAddresstype.DentalProf,t_DProviderAddresstype(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderAddresstype.raw_srctype t_PhyProviderAddresstype(Ingenix_NatlProf.File_in_ProviderAddresstype.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.ProviderAddressTypeCode := l.AddressTypeCode;
self := l;
end;

File_Physician_ProviderAddresstype := Project(Ingenix_NatlProf.File_in_ProviderAddresstype.Physician,t_PhyProviderAddresstype(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderAddresstype.raw_srctype t_AHProviderAddresstype(Ingenix_NatlProf.File_in_ProviderAddresstype.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.ProviderAddressTypeCode := l.AddressTypeCode;
self      := l;
end;

File_AH_ProviderAddresstype := Project(Ingenix_NatlProf.File_in_ProviderAddresstype.Allied_Health,t_AHProviderAddresstype(LEFT));


File_All_ProviderAddresstype := File_Dental_ProviderAddresstype + File_Physician_ProviderAddresstype + File_AH_ProviderAddresstype;

Out_ProviderAddresstype := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderAddresstype', '~thor_data400::in::ingenix_natlprof_ProviderAddresstype_' + filedate) > 0,Output('ProviderAddresstype Logical File Already Added'),
                    Sequential(
                           output(File_All_ProviderAddresstype,,'~thor_data400::in::ingenix_natlprof_ProviderAddresstype_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderAddresstype', '~thor_data400::in::ingenix_natlprof_ProviderAddresstype_' + filedate)
                           ));
return Out_ProviderAddresstype;
end;


