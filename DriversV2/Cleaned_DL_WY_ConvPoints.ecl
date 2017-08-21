IMPORT Drivers, Address, ut, lib_stringlib, NID, _Validate;

EXPORT Cleaned_DL_WY_ConvPoints(STRING processDate, STRING fileDate) := FUNCTION

	in_file := DriversV2.File_DL_WY_ConvPoints_Raw(fileDate);

  layout_out := DriversV2.Layouts_DL_WY_In.Layout_WY_CP_Cln;

  layout_out mapClean(in_file l) := TRANSFORM,SKIP(l.DL_NUMBER = '*NO-WY-DLN' OR (l.LAST_NAME = 'TEST' AND l.FIRST_NAME = 'ARE NOT'))

	   STRING73 tempName := stringlib.StringToUpperCase(IF(TRIM(TRIM(l.FIRST_NAME,LEFT,RIGHT) + ' ' +
										                         TRIM(l.LAST_NAME,LEFT,RIGHT),LEFT,RIGHT) <> '',
															Address.CleanPersonFML73(TRIM(TRIM(l.FIRST_NAME,LEFT,RIGHT)  + ' ' +
																				          TRIM(l.MIDDLE_NAME,LEFT,RIGHT) + ' ' +
																						  TRIM(l.LAST_NAME,LEFT,RIGHT),LEFT,RIGHT)),
															''));
		SELF.clean_name_prefix     := tempName[1..5];
		SELF.clean_name_first      := tempName[6..25];
		SELF.clean_name_middle     := tempName[26..45];
		SELF.clean_name_last       := tempName[46..65];
		SELF.clean_name_suffix	   := ut.fGetSuffix(tempName[66..70]);
		SELF.process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		SELF.DL_NUMBER             := stringlib.StringToUpperCase(TRIM(l.DL_NUMBER,LEFT,RIGHT));
		SELF.LAST_NAME             := stringlib.StringToUpperCase(TRIM(l.LAST_NAME,LEFT,RIGHT));
		SELF.FIRST_NAME            := stringlib.StringToUpperCase(TRIM(l.FIRST_NAME,LEFT,RIGHT));
		SELF.MIDDLE_NAME           := stringlib.StringToUpperCase(TRIM(l.MIDDLE_NAME,LEFT,RIGHT));
		SELF.DOB                   := IF(_Validate.Date.fIsValid(stringlib.stringfilter(l.DOB,'0123456789')) AND
	                                   _Validate.Date.fIsValid(stringlib.stringfilter(l.DOB,'0123456789'),_Validate.Date.Rules.DateInPast),
																		 stringlib.stringfilter(l.DOB,'0123456789'),'');
		SELF.ACD_Code              := stringlib.StringToUpperCase(TRIM(l.ACD_Code,LEFT,RIGHT));
		SELF.Conv_Code             := stringlib.StringToUpperCase(TRIM(l.Conv_Code,LEFT,RIGHT));
		SELF.Conv_Desc             := stringlib.StringToUpperCase(TRIM(l.Conv_Desc,LEFT,RIGHT));
		SELF.Entrd_Sys_Date        := IF(_validate.date.fIsValid(stringlib.stringfilter(l.Entrd_Sys_Date,'0123456789') + '01'),
		                                 (stringlib.stringfilter(l.Entrd_Sys_Date,'0123456789')),'');
		SELF.Offense_Date          := IF(_Validate.Date.fIsValid(stringlib.stringfilter(l.Offense_Date,'0123456789')) AND
	                                   _Validate.Date.fIsValid(stringlib.stringfilter(l.Offense_Date,'0123456789'),_Validate.Date.Rules.DateInPast),
																		 stringlib.stringfilter(l.Offense_Date,'0123456789'),'');
		SELF.Conviction_Date       := IF(_Validate.Date.fIsValid(stringlib.stringfilter(l.Conviction_Date,'0123456789')) AND
	                                   _Validate.Date.fIsValid(stringlib.stringfilter(l.Conviction_Date,'0123456789'),_Validate.Date.Rules.DateInPast),
																		 stringlib.stringfilter(l.Conviction_Date,'0123456789'),'');
		SELF.Advrse_Actn_Str_Date  := IF(_Validate.Date.fIsValid(stringlib.stringfilter(l.Advrse_Actn_Str_Date,'0123456789')),stringlib.stringfilter(l.Advrse_Actn_Str_Date,'0123456789'),'');
		SELF.Advrse_Actn_End_Date  := IF(_Validate.Date.fIsValid(stringlib.stringfilter(l.Advrse_Actn_End_Date,'0123456789')),stringlib.stringfilter(l.Advrse_Actn_End_Date,'0123456789'),'');
		SELF.Record_Type           := stringlib.StringToUpperCase(TRIM(l.Record_Type,LEFT,RIGHT));
		SELF                       := l;		
		SELF                       := [];
	END;

	Cleaned_WY_ConvPoints_File := PROJECT(in_file, mapClean(left));
	
	Cleaned_WY_DL_CP_All  := SEQUENTIAL(
	            OUTPUT(Cleaned_WY_ConvPoints_File,,DriversV2.Constants.cluster+'in::dl2::WY_CP_Clean_Update::'+ fileDate,OVERWRITE),
	            FileServices.StartSuperFileTransaction(),
							FileServices.AddSuperFile(DriversV2.Constants.cluster + 'in::dl2::WY_CP_Clean_Updates::superfile', 
											  DriversV2.Constants.cluster +'in::dl2::WY_CP_Clean_Update::'+fileDate), 
							FileServices.FinishSuperFileTransaction());
	
	RETURN Cleaned_WY_DL_CP_All;
END;