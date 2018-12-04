import Drivers, Address, ut, lib_stringlib, NID, _Validate, std;

export Cleaned_DL_MA(string passedIn_process_date, string fileDate) := function

CommercialSet	:=	['A','B','C','AM','BM','CM'];

in_file		 := DriversV2.File_DL_MA_Update(fileDate);

 TrimUpper(string s):= function
		return trim(stringlib.StringToUppercase(s),left,right);
 end; 
 
 TranslateStatus(string s):= function
		uc_s	:=	std.str.touppercase(std.str.cleanspaces(s));					 
		
		RETURN map(	uc_s = 'VAL - ACTIVE'								=> 'ACT',
								uc_s = 'NONE - NONE'								=> '',
								uc_s = 'EXP - EXPIRED'							=> 'EXP',
								uc_s = 'ACTNRN - ACTIVE NON-RENEW'	=> 'ACT/NRE',
								uc_s = 'SUS - SUSPENDED'						=> 'SUS',
								uc_s = 'EXPNRN - EXPIRED NON-RENEW'	=> 'EXP/NRE',
								uc_s = 'REV - REVOKED'							=> 'REV',
								uc_s = 'NRN - NON-RENEW'						=> 'NRE',
								uc_s = 'INA - INACTIVE'							=> 'EXP/RXX',
								uc_s = 'IIDREQ - ACTIVE'						=> 'ACT',
								uc_s = 'IIDREG - ACTIVE'						=> 'ACT',
								uc_s = 'SUAHSP - ACTIVE'						=> 'ACT',
								uc_s = 'SUSHSP - LIMITED'						=> '',
								uc_s = 'SUR - SURRENDERED'					=> 'CAN',
								uc_s = 'EXPHSP - EXPIRED'						=> 'EXP',
								uc_s = 'FRCVAL - ACTIVE'						=> 'ACT',
								uc_s = 'CAN - CANCELED'							=> 'CAN',
								uc_s = 'IIAHSP - ACTIVE'						=> 'ACT',
								uc_s = 'IIDHSP - LIMITED'						=> '',
								uc_s = 'MERGED - MERGED'						=> 'CAN',
								uc_s = 'INSHSP - LIMITED'						=> 'ACT',
								uc_s[1..3] = 'DEC'									=> 'CAN',
								uc_s[1..3] = 'DSQ'									=> 'DSQ',
								uc_s[1..6] = 'DSQELG'								=> 'RSU',
								uc_s[1..6] = 'IEXHSP'								=> 'EXP',
								'');
		END;
 
/* Only keeping records with valid drivers license class.  
   Filtering out blank license class records and liquor license records. 
	 Also filtering out old data with expiration dates before 2013. */
 inFiltered := in_file(trimUpper(licenseClass) in ['A','B','C','AM','BM','CM','M','D','DM','IM', 'I', 'M'] 
										 	and ((integer)LicenseExpirationDate[1..4] > 2012 or trimUpper(LicenseExpirationDate)=''));

Layout_DL_MA_In.Layout_MA_With_Clean mapClean(inFiltered l) 	 	:= transform
		self.PERS_SURROGATE         := if((integer)l.RMVPersonSurrogate<>0,trim(l.RMVPersonSurrogate,left,right),'');    
		self.LICENSE_HEIGHT					:= if((integer)stringlib.stringfilter(l.HeightFeet + l.HeightInches,'0123456789')<>0, stringlib.stringfilter(l.HeightFeet + l.HeightInches,'0123456789'), '');
		self.LICENSE_SEX 						:= trimUpper(l.Gender[1]);
		self.LICENSE_LICNO 					:= trimUpper(l.LicenseNumber);	
		self.LICENSE_BDATE_YYYYMMDD := if(_Validate.Date.fIsValid(l.DateOfBirth) and l.DateOfBirth <> '18500414', l.DateOfBirth, '');
		self.LICENSE_EDATE_YYYYMMDD := if(_Validate.Date.fIsValid(l.LicenseExpirationDate) and l.LicenseExpirationDate <> '18500414', l.LicenseExpirationDate, '');
		self.LICENSE_LIC_CLASS 			:= trimUpper(l.LicenseClass);
		self.LICENSE_LAST_NAME 			:= trimUpper(l.LastName);	
		self.LICENSE_FIRST_NAME			:= trimUpper(l.FirstName);
		self.LICENSE_MIDDLE_NAME 		:= trimUpper(l.MiddleName);
		self.LICMAIL_STREET1 				:= trimUpper(l.MailingStreet1); 
		self.LICMAIL_STREET2 				:= trimUpper(l.MailingStreet2);
		self.LICMAIL_CITY 					:= trimUpper(l.MailingCity);	 
		self.LICMAIL_STATE 					:= trimUpper(l.MailingState);	 
		self.LICMAIL_ZIP 						:= trimUpper(l.MailingZipCode); 
		self.LICRESI_STREET1        := if(trimUpper(l.ResidentialStreet1) in ['0', 'D/L SERVICE', 'RI RESIDENT', 'RMV','SAME'], '', trimUpper(l.ResidentialStreet1));
		self.LICRESI_STREET2        := if(trimUpper(l.ResidentialStreet2) in ['0', 'D/L SERVICE', 'RI RESIDENT', 'RMV','SAME'], '', trimUpper(l.ResidentialStreet2));	 
		self.LICRESI_CITY 					:= trimUpper(l.ResidentialCity);	 
		self.LICRESI_STATE					:= trimUpper(l.ResidentialState);	 
		self.LICRESI_ZIP						:= trimUpper(l.ResidentialZipCode);
		self.ISSUE_DATE_YYYYMMDD		:= if(_Validate.Date.fIsValid(l.LicenseIssueDate) and l.LicenseIssueDate <> '18500414', l.LicenseIssueDate, '');
		self.LICENSE_STATUS					:= if(l.LicenseClass in commercialSet, TranslateStatus(l.CurrentCommercialLicenseStatus), TranslateStatus(l.CurrentPassengerLicenseStatus));
		self.PERMIT_CLASS1          := trimUpper(l.FirstLicensePermitClass);
		self.PERMIT_EXP_DATE1       := if(_Validate.Date.fIsValid(l.FirstLicensePermitExpirationDate),l.FirstLicensePermitExpirationDate,''); 
		self.PERMIT_CLASS2          := trimUpper(l.SecondLicensePermitClass);
		self.PERMIT_EXP_DATE2       := if(_Validate.Date.fIsValid(l.SecondLicensePermitExpirationDate),l.SecondLicensePermitExpirationDate,'');
		self.PERMIT_CLASS3          := trimUpper(l.ThirdLicensePermitClass);
		self.PERMIT_EXP_DATE3       := if(_Validate.Date.fIsValid(l.ThirdLicensePermitExpirationDate),l.ThirdLicensePermitExpirationDate,'');
		self.PERMIT_CLASS4          := trimUpper(l.FourthLicensePermitClass);
		self.PERMIT_EXP_DATE4       := if(_Validate.Date.fIsValid(l.FourthLicensePermitExpirationDate),l.FourthLicensePermitExpirationDate,'');
		self.PERMIT_CLASS5          := trimUpper(l.FifthLicensePermitClass);
		self.PERMIT_EXP_DATE5       := if(_Validate.Date.fIsValid(l.FifthLicensePermitExpirationDate),l.FifthLicensePermitExpirationDate,'');	
		self.clean_status						:= if(trimUpper(self.LICENSE_STATUS[1..3]) in ['ACT','CAN','DEN','EXP','REV','SUS'], trimUpper(self.LICENSE_STATUS[1..3]), '');	
		self.process_date    		    := if(_Validate.Date.fIsValid(passedIn_process_Date),passedIn_process_Date,'');
		self                 			  := l;		
		self												:= [];
	end;

	Cleaned_MA_File 							:= project(inFiltered, mapClean(left)); 
	
	return Cleaned_MA_File;
	
end;