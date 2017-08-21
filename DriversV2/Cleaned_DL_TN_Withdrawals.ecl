IMPORT Drivers, DriversV2, ut, lib_stringlib, _Validate, NID, Address;

EXPORT Cleaned_DL_TN_Withdrawals(STRING processDate, STRING fileDate) := FUNCTION
  
  Wdl_file     := DriversV2.File_DL_TN_Wdl_Raw(fileDate);

  TrimUpper(STRING s):= FUNCTION
		RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
  END;
   
	layout_all_cln  := DriversV2.Layouts_DL_TN_In.Layout_TN_WDL_All_Cleaned;
	
  layout_all_cln mapCleanWdl(Wdl_file l) := TRANSFORM,SKIP(l.dl_number = '')
		SELF.Process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		SELF.last_name             := TrimUpper(l.last_name);
		SELF.first_name            := TrimUpper(l.first_name);
		SELF.middle_name           := TrimUpper(l.middle_name);
		SELF.suffix_name           := TrimUpper(l.suffix_name);
		SELF.street1               := TrimUpper(l.street1);
		SELF.street2               := TrimUpper(l.street2);
		SELF.city                  := TrimUpper(l.city);
		SELF.st                    := TrimUpper(l.st);
		SELF.zip5                  := lib_stringlib.stringlib.stringfilter(l.zip5,'0123456789');
		SELF.birthdate             := IF(_Validate.Date.fIsValid(l.birthdate) AND
	                                   _Validate.Date.fIsValid(l.birthdate,_Validate.Date.Rules.DateInPast),l.birthdate,'');
		SELF.race                  := IF(TrimUpper(l.race) IN DriversV2.Tables_CP_TN.Race_Cd,TrimUpper(l.race),'');
		SELF.gender                := IF(TrimUpper(l.gender) IN DriversV2.Tables_CP_TN.Gender_Cd, TrimUpper(l.gender),'');
		SELF.height_ft             := lib_stringlib.stringlib.stringfilter(l.height_ft,'0123456789');
		SELF.height_in             := IF(LENGTH(lib_stringlib.stringlib.stringfilter(l.height_in,'0123456789'))=1,
		                              '0'+lib_stringlib.stringlib.stringfilter(l.height_in,'0123456789'),lib_stringlib.stringlib.stringfilter(l.height_in,'0123456789'));
		SELF.weight                := lib_stringlib.stringlib.stringfilter(l.weight,'0123456789');
		SELF.eye_color             := IF(TrimUpper(l.eye_color)  IN DriversV2.Tables_CP_TN.Eye_Color_Cd,TrimUpper(l.eye_color),'');
		SELF.hair_color            := IF(TrimUpper(l.hair_color) IN DriversV2.Tables_CP_TN.Hair_Color_Cd,TrimUpper(l.hair_color),'');
		SELF.dl_number             := TrimUpper(l.dl_number);
		SELF.dl_issue_date         := IF(_Validate.Date.fIsValid(l.dl_issue_date) AND
	                                  _Validate.Date.fIsValid(l.dl_issue_date,_Validate.Date.Rules.DateInPast),l.dl_issue_date,'');
		SELF.exp_date              := IF(_Validate.Date.fIsValid(l.exp_date),l.exp_date,'');
		SELF.lkup_consent_flag     := IF(l.lkup_consent_flag IN ['Y','N'],l.lkup_consent_flag,'');
		SELF.rls_consent_flag      := IF(l.rls_consent_flag IN ['Y','N'],l.rls_consent_flag,'');
		SELF.county_code           := TrimUpper(l.county_code);
		SELF.event_date            := IF(_Validate.Date.fIsValid(l.event_date) AND
	                                   _Validate.Date.fIsValid(l.event_date,_Validate.Date.Rules.DateInPast),l.event_date,'');
		SELF.post_date             := IF(_Validate.Date.fIsValid(l.post_date) AND
	                                   _Validate.Date.fIsValid(l.post_date,_Validate.Date.Rules.DateInPast),l.post_date,'');
		SELF.clean_name_prefix     := '';
		SELF.clean_name_first      := TrimUpper(l.first_name);
		SELF.clean_name_middle     := TrimUpper(l.middle_name);
		SELF.clean_name_last       := TrimUpper(l.last_name);
		SELF.clean_name_suffix     := TrimUpper(l.suffix_name);
		SELF                       := [];
  END;

	Cleaned_TN_Wdl := PROJECT(Wdl_file, mapCleanWdl(LEFT));
			
	Cleaned_TN_DL_WDL_All  := SEQUENTIAL(
	            OUTPUT(Cleaned_TN_Wdl,,DriversV2.Constants.cluster+'in::dl2::TN_WDL_CP_Clean_Update::'+ fileDate,OVERWRITE),
	            FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::TN_WDL_CP_Clean_updates::superfile', 
											  DriversV2.Constants.cluster +'in::dl2::TN_WDL_CP_Clean_Update::'+fileDate), 
							FileServices.FinishSuperFileTransaction());
                  
	RETURN Cleaned_TN_DL_WDL_All;
END;