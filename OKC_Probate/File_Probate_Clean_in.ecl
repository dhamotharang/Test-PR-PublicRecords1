IMPORT OKC_Probate, ut, VersionControl, STD;
EXPORT File_Probate_Clean_in(STRING pVersion	=	(STRING)STD.Date.Today()) := function

	file_name	:=	OKC_Probate.Filenames().Input.Raw.Using;
	file_date := IF(VersionControl.fGetFilenameVersion(file_name)>0,
															(STRING)VersionControl.fGetFilenameVersion(file_name)
														,pVersion
														);

	// Input file 
	in_file := OKC_Probate.Files(file_name).file_in(	ut.CleanSpacesAndUpper(DebtorFirstName) NOT IN ['', 'DEBTORFIRSTNAME', 'FIRSTNAME'] AND
																																																		ut.CleanSpacesAndUpper(DebtorLastName)		NOT IN ['', 'DEBTORLASTNAME', 'LASTNAME']
																																																);

	//Clean Sprayed File
	Layout.raw_v2	Clnfile(Layout.raw pInput)	:=	TRANSFORM
		SELF.filedate    := (string10)file_date;
		self.MasterID    := ut.CleanSpacesAndUpper(pInput.MasterID);	
		self.DebtorFirstName  := ut.CleanSpacesAndUpper(pInput.DebtorFirstName);	
		self.DebtorLastName  := ut.CleanSpacesAndUpper(pInput.DebtorLastName);	
		self.DebtorAddress1  := ut.CleanSpacesAndUpper(pInput.DebtorAddress1);	
		self.DebtorAddress2  := ut.CleanSpacesAndUpper(pInput.DebtorAddress2);	
		self.DebtorAddressCity  := ut.CleanSpacesAndUpper(pInput.DebtorAddressCity);	
		self.DebtorAddressState := ut.CleanSpacesAndUpper(pInput.DebtorAddressState);	
		self.DebtorAddressZipCode := IF(length(trim(pInput.DebtorAddressZipCode)) = 4, '0'+StringLib.StringCleanSpaces(pInput.DebtorAddressZipCode),
																		StringLib.StringCleanSpaces(pInput.DebtorAddressZipCode));
		//Reformatting date from MM/DD/YYY to YYYMMDD																
		TrimDod  := StringLib.StringCleanSpaces(pInput.DateOfDeath);
		self.dod := REGEXFIND('(.*)/(.*)/(.*)',TrimDod,3) + 
												 IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimDod,1)) = 1, '0'+REGEXFIND('(.*)/(.*)/(.*)',TrimDod,1),REGEXFIND('(.*)/(.*)/(.*)',TrimDod,1)) +
																			IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimDod,2)) = 1, '0'+ REGEXFIND('(.*)/(.*)/(.*)',TrimDod,2),REGEXFIND('(.*)/(.*)/(.*)',TrimDod,2));	

		TrimDob  := StringLib.StringCleanSpaces(pInput.DateOfBirth);
		self.dob := REGEXFIND('(.*)/(.*)/(.*)',TrimDob,3) + 
												 IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimDob,1)) = 1, '0'+REGEXFIND('(.*)/(.*)/(.*)',TrimDob,1),REGEXFIND('(.*)/(.*)/(.*)',TrimDob,1)) +
																			IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimDob,2)) = 1, '0'+ REGEXFIND('(.*)/(.*)/(.*)',TrimDob,2),REGEXFIND('(.*)/(.*)/(.*)',TrimDob,2));	

		self.IsProbateLocated := ut.CleanSpacesAndUpper(pInput.IsProbateLocated);	
		self.CaseNumber := ut.CleanSpacesAndUpper(pInput.CaseNumber);	
		TrimFilingDte   := StringLib.StringCleanSpaces(pInput.FilingDate);
		self.FilingDate := REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,3) + 
												 IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,1)) = 1, '0'+REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,1),REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,1)) +
																			IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,2)) = 1, '0'+ REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,2),REGEXFIND('(.*)/(.*)/(.*)',TrimFilingDte,2));	

		TrimFCDte       := StringLib.StringCleanSpaces(pInput.LastDateToFileClaim);
		self.LastDateToFileClaim := REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,3) + 
												 IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,1)) = 1, '0'+REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,1),REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,1)) +
																			IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,2)) = 1, '0'+ REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,2),REGEXFIND('(.*)/(.*)/(.*)',TrimFCDte,2));	

		self.IsSubjectToCreditorsClaim := ut.CleanSpacesAndUpper(pInput.IsSubjectToCreditorsClaim);	

		TrimPubDte       := StringLib.StringCleanSpaces(pInput.PublicationStartDate);
		self.PublicationStartDate := REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,3) + 
												 IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,1)) = 1, '0'+REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,1),REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,1)) +
																			IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,2)) = 1, '0'+ REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,2),REGEXFIND('(.*)/(.*)/(.*)',TrimPubDte,2));	

		self.IsEstateOpen  := ut.CleanSpacesAndUpper(pInput.IsEstateOpen);	
		self.DocumentTypes := ut.CleanSpacesAndUpper(pInput.DocumentTypes);	
		TrimCorr_DateOfDeath       := StringLib.StringCleanSpaces(pInput.Corr_DateOfDeath);

		self.Corr_DateOfDeath := REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,3) + 
												 IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,1)) = 1, '0'+REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,1),REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,1)) +
																			IF(length(REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,2)) = 1, '0'+ REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,2),REGEXFIND('(.*)/(.*)/(.*)',TrimCorr_DateOfDeath,2));	
		SELF := pInput;
		SELF := [];
	END;

	d_ClnFile	:=	PROJECT(in_file,Clnfile(LEFT));
	return d_ClnFile;
	 
end;