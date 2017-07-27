import _Validate, lib_stringlib;
export Map_In_ProviderAddress(string filedate) := function

Layout_in_ProviderAddress.raw_srctype t_DProviderAddress(Ingenix_NatlProf.File_in_ProviderAddress.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.ProviderAddressVerificationStatusCode := L.VerificationStatusCode;
self.ProviderAddressVerificationDate := L.VerificationDate;
self := l;
end;

File_Dental_ProviderAddress := Project(Ingenix_NatlProf.File_in_ProviderAddress.DentalProf,t_DProviderAddress(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderAddress.raw_srctype t_PhyProviderAddress(Ingenix_NatlProf.File_in_ProviderAddress.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.ProviderAddressVerificationStatusCode := L.VerificationStatusCode;
self.ProviderAddressVerificationDate := L.VerificationDate;
self := l;
end;

File_Physician_ProviderAddress := Project(Ingenix_NatlProf.File_in_ProviderAddress.Physician,t_PhyProviderAddress(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderAddress.raw_srctype t_AHProviderAddress(Ingenix_NatlProf.File_in_ProviderAddress.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.ProviderAddressVerificationStatusCode := L.VerificationStatusCode;
self.ProviderAddressVerificationDate := L.VerificationDate;
self      := l;
end;

File_AH_ProviderAddress := Project(Ingenix_NatlProf.File_in_ProviderAddress.Allied_Health,t_AHProviderAddress(LEFT));

// The verification dates are in the format MM/DD/YYYY
reformatDate(STRING inDate) := FUNCTION
	RETURN inDate[7..10] + inDate[1..2] + indate[4..5];
END;

Layout_in_ProviderAddress.raw_srctype clean_verification_date(Layout_in_ProviderAddress.raw_srctype L) := TRANSFORM
  reformatted_date := reformatDate(L.ProviderAddressVerificationDate);

  SELF.ProviderAddressVerificationDate := IF(_Validate.Date.fIsValid(reformatted_date),
	                                           reformatted_date,
																						 '');
	
  SELF := L;
END;

File_All_ProviderAddress := PROJECT(File_Dental_ProviderAddress + File_Physician_ProviderAddress +
                                       File_AH_ProviderAddress,
																		clean_verification_date(LEFT));

Out_ProviderAddress := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_provideraddress', '~thor_data400::in::ingenix_natlprof_provideraddress_' + filedate) > 0,Output('ProviderAddress Logical File Already Added'),
                    Sequential(
                           output(File_All_ProviderAddress,,'~thor_data400::in::ingenix_natlprof_provideraddress_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_provideraddress', '~thor_data400::in::ingenix_natlprof_provideraddress_' + filedate)
                           ));
return Out_ProviderAddress;
end;


