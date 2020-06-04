import Drivers, Address, ut, lib_stringlib, _Validate, std;

export Cleaned_DL_CT(string processDate, string fileDate)  := function

	  in_file     := DriversV2.File_DL_CT_Update(fileDate);
		
		TrimUpper(STRING s):= FUNCTION
		 RETURN std.str.touppercase(std.str.cleanspaces(s));
    END;

	  Drivers.Layout_CT_Full mapClean(DriversV2.Layouts_DL_CT_In.Layout_CT_Update l):= transform
	  
		string73 tempName 				    := Address.CleanPerson73(TrimUpper(TrimUpper(l.FirstName)+' '+ TrimUpper(l.MiddleInitial)+' '+ 
																												             TrimUpper(l.LastName)+' '+ TrimUpper(l.Suffix)
																																		 ));
    self.clean_name_prefix        := tempName[1..5];
		self.clean_name_first         := tempName[6..25];
		self.clean_name_middle        := tempName[26..45];
		self.clean_name_last          := tempName[46..65];
		self.clean_name_suffix	      := tempName[66..70];
		self.clean_name_score         := tempName[71..73];
		self.append_process_date      := if(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		self.CredentialState          := TrimUpper(l.CredentialState);
		self.CredentialNumber         := trim(l.CredentialNumber,left,right);
		self.LastName                 := TrimUpper(l.LastName);
		self.FirstName                := TrimUpper(l.FirstName);
		self.MiddleInitial            := TrimUpper(l.MiddleInitial);
		self.Suffix                   := TrimUpper(l.Suffix);
		self.Gender                   := TrimUpper(l.Gender);
		self.Height                   := trim(l.Height,left,right);
		self.EyeColor                 := TrimUpper(l.EyeColor);
		self.Date_Birth               := IF(_Validate.Date.fIsValid(l.Date_Birth),l.Date_Birth,'');
		self.ResiAddrStreet           := TrimUpper(l.ResiAddrStreet);
		self.ResidencyCity            := TrimUpper(l.ResidencyCity);
		self.ResidencyState           := TrimUpper(l.ResidencyState);
		self.ResidencyZip             := if((INTEGER)stringlib.stringfilter(l.ResidencyZip,'0123456789')<>0,stringlib.stringfilter(l.ResidencyZip,'0123456789'),''); 
		self.MailAddrStreet           := TrimUpper(l.MailAddrStreet);
		self.MailingCity              := TrimUpper(l.MailingCity);
		self.MailingState             := TrimUpper(l.MailingState);
		self.MailingZip               := if((INTEGER)stringlib.stringfilter(l.MailingZip,'0123456789')<>0,stringlib.stringfilter(l.MailingZip,'0123456789'),''); 
		self.CredentialType           := TrimUpper(l.CredentialType);
		self.Credential_Class         := TrimUpper(l.Credential_Class);
		self.Endorsements             := TrimUpper(l.Endorsements);
		self.Restrictions             := TrimUpper(l.Restrictions);
		self.ExpDate                  := if(_Validate.Date.fIsValid(l.ExpDate),l.ExpDate,'');
		self.LastIssueRenewalDate     := if(_Validate.Date.fIsValid(l.LastIssueRenewalDate),l.LastIssueRenewalDate,'');
		self.Date_NonCDL              := if(_Validate.Date.fIsValid(l.Date_NonCDL),l.Date_NonCDL,'');
		self.OriginalDate_CDL         := if(_Validate.Date.fIsValid(l.OriginalDate_CDL),l.OriginalDate_CDL,'');
		self.StatusNONCDL             := TrimUpper(l.StatusNONCDL);
		self.LicenseStatusCDL         := TrimUpper(l.LicenseStatusCDL);
		self.OriginalDate_LP          := if(_Validate.Date.fIsValid(l.OriginalDate_LP),l.OriginalDate_LP,'');
		self.OriginalDate_ID          := if(_Validate.Date.fIsValid(l.OriginalDate_ID),l.OriginalDate_ID,'');
		self.CancelState              := TrimUpper(l.CancelState);
		self.CancelDate               := if(_Validate.Date.fIsValid(l.CancelDate),l.CancelDate,'');
		self.CDLMediCertIssueDate     := if(_Validate.Date.fIsValid(l.CDLMediCertIssueDate),l.CDLMediCertIssueDate,'');
		self.CDLMediCertExpDate       := if(_Validate.Date.fIsValid(l.CDLMediCertExpDate),l.CDLMediCertExpDate,'');
		self                          := l;
				
	end;

	Cleaned_CT_File   						  := project(in_file, mapClean(left));
	
	return Cleaned_CT_File;
	
end;
