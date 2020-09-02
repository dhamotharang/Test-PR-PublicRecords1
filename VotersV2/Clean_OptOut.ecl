Import ut, VotersV2, _Validate;

EXPORT Clean_OptOut(STRING  pVersion) := FUNCTION

	OptOutInput:=  VotersV2.File_OptOut_In(pVersion);

	VotersV2.Layout_Emerges_OptOut getCleanOptOut(VotersV2.Layout_Emerges_OptOut l) := transform
		self.first_name    					 := ut.CleanSpacesAndUpper(l.first_name);
		self.last_name     					 := ut.CleanSpacesAndUpper(l.last_name);
		self.middle_name	 					 := ut.CleanSpacesAndUpper(l.middle_name);
		self.name_suffix   					 := ut.CleanSpacesAndUpper(l.name_suffix);
		self.maiden_prior  					 := ut.CleanSpacesAndUpper(l.maiden_prior);
		self.streetaddress 					 := ut.CleanSpacesAndUpper(l.streetaddress);
		self.city 				 					 := ut.CleanSpacesAndUpper(l.city);
		self.state 				 					 := if(length(ut.CleanSpacesAndUpper(l.state)) > 2
																			 ,ut.st2abbrev(ut.CleanSpacesAndUpper(l.state))
																			 ,ut.CleanSpacesAndUpper(l.state));
		self.zip 					 					 := StringLib.StringFilter(l.zip, '0123456789');
		self.dob                     := if(_Validate.Date.fIsValid(ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.dob), , true, true),
																		 ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.dob),
																		 '');
		self.Cell_Phone 	 					 := StringLib.StringFilter(l.Cell_Phone, '0123456789');
		self.email         					 := ut.CleanSpacesAndUpper(l.email);
		self.Reason_for_Your_Request := ut.CleanSpacesAndUpper(l.Reason_for_Your_Request);
		self.Info_Relates_To         := ut.CleanSpacesAndUpper(l.Info_Relates_To);
		self               					 := l;
		self               					 := [];
	end;

	Cleaned_optOut := project(OptOutInput, getCleanOptOut(left))(dob <> '');

	RETURN Cleaned_optOut;	

END;  
	