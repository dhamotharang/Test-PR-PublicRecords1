
export Map_In_ProviderPhone (string filedate) := function;


Layout_in_ProviderAddressPhone.raw_srctype t_DProviderPhone(Ingenix_NatlProf.File_in_ProviderAddressPhone.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.PhoneNumberCompanyCount := l.ProviderPhoneCompanyCount;
self.PhoneNumberTierTypeID := l.ProviderPhoneTierTypeID;
self := l;
end;

File_Dental_ProviderPhone := Project(Ingenix_NatlProf.File_in_ProviderAddressPhone.DentalProf,t_DProviderPhone(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderAddressPhone.raw_srctype t_PhyProviderPhone(Ingenix_NatlProf.File_in_ProviderAddressPhone.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.PhoneNumberCompanyCount := l.ProviderPhoneCompanyCount;
self.PhoneNumberTierTypeID := l.ProviderPhoneTierTypeID;
self := l;
end;

File_Physician_ProviderPhone := Project(Ingenix_NatlProf.File_in_ProviderAddressPhone.Physician,t_PhyProviderPhone(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderAddressPhone.raw_srctype t_AHProviderPhone(Ingenix_NatlProf.File_in_ProviderAddressPhone.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.PhoneNumberCompanyCount := l.ProviderPhoneCompanyCount;
self.PhoneNumberTierTypeID := l.ProviderPhoneTierTypeID;
self := l;
end;

File_AH_ProviderPhone := Project(Ingenix_NatlProf.File_in_ProviderAddressPhone.Allied_Health,t_AHProviderPhone(LEFT));


File_All_ProviderPhone := File_Dental_ProviderPhone + File_Physician_ProviderPhone + File_AH_ProviderPhone;

Out_ProviderPhone := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderPhone', '~thor_data400::in::ingenix_natlprof_ProviderPhone_' + filedate) > 0,Output('ProviderPhone Logical File Already Added'),            

              Sequential(
                           output(File_All_ProviderPhone,,'~thor_data400::in::ingenix_natlprof_ProviderPhone_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
													 
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderPhone', '~thor_data400::in::ingenix_natlprof_ProviderPhone_' + filedate)
                           ));
return Out_ProviderPhone;
end;
