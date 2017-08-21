IMPORT Drivers, Address, ut, lib_stringlib,_Validate,NID;

EXPORT Cleaned_DL_TN_Update(STRING processDate, STRING fileDate) := FUNCTION

	in_file := DriversV2.File_DL_TN_Update2_Raw(fileDate);

	layout_out := DriversV2.Layouts_DL_TN_In.Layout_TN_Update2_Cleaned;
					
	layout_out mapClean(in_file l) := TRANSFORM
		SELF.Process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,'');
		SELF.orig_LAST_NAME        := stringlib.StringToUpperCase(TRIM(l.orig_LAST_NAME,LEFT,RIGHT));
		SELF.orig_FIRST_NAME       := stringlib.StringToUpperCase(TRIM(l.orig_FIRST_NAME,LEFT,RIGHT));
		SELF.orig_MIDDLE_NAME      := stringlib.StringToUpperCase(TRIM(l.orig_MIDDLE_NAME,LEFT,RIGHT));
		SELF.orig_NAME_SUFFIX      := stringlib.StringToUpperCase(TRIM(l.orig_NAME_SUFFIX,LEFT,RIGHT));
		SELF.orig_STREET_ADDRESS1  := stringlib.StringToUpperCase(TRIM(l.orig_STREET_ADDRESS1,LEFT,RIGHT));
		SELF.orig_STREET_ADDRESS2  := stringlib.StringToUpperCase(TRIM(l.orig_STREET_ADDRESS2,LEFT,RIGHT));
		SELF.orig_CITY             := stringlib.StringToUpperCase(TRIM(l.orig_CITY,LEFT,RIGHT));
		SELF.orig_STATE            := stringlib.StringToUpperCase(TRIM(l.orig_STATE,LEFT,RIGHT));
		SELF.orig_ZIP_CODE         := lib_stringlib.stringlib.stringfilter(l.orig_ZIP_CODE,'0123456789');
		SELF.orig_DL_NUMBER        := stringlib.StringToUpperCase(TRIM(l.orig_DL_NUMBER,LEFT,RIGHT));
		SELF.orig_DOB              := IF(_Validate.Date.fIsValid(l.orig_DOB) AND
	                                   _Validate.Date.fIsValid(l.orig_DOB,_Validate.Date.Rules.DateInPast),l.orig_DOB,'');
		SELF.orig_LICENSE_TYPE     := stringlib.StringToUpperCase(TRIM(l.orig_LICENSE_TYPE,LEFT,RIGHT));
		SELF.orig_SEX              := stringlib.StringToUpperCase(TRIM(l.orig_SEX,LEFT,RIGHT));
		SELF.orig_HEIGHT_FT        := lib_stringlib.stringlib.stringfilter(l.orig_HEIGHT_FT,'0123456789');
		SELF.orig_HEIGHT_IN        := IF(LENGTH(lib_stringlib.stringlib.stringfilter(l.orig_HEIGHT_IN,'0123456789'))=1,
		                              '0'+lib_stringlib.stringlib.stringfilter(l.orig_HEIGHT_IN,'0123456789'),lib_stringlib.stringlib.stringfilter(l.orig_HEIGHT_IN,'0123456789'));
		SELF.orig_WEIGHT           := lib_stringlib.stringlib.stringfilter(l.orig_WEIGHT,'0123456789');
		SELF.orig_EYE_COLOR        := stringlib.StringToUpperCase(TRIM(l.orig_EYE_COLOR,LEFT,RIGHT));
		SELF.orig_HAIR_COLOR       := stringlib.StringToUpperCase(TRIM(l.orig_HAIR_COLOR,LEFT,RIGHT));
		SELF.orig_RESTRICTIONS1    := stringlib.StringToUpperCase(TRIM(l.orig_RESTRICTIONS1,LEFT,RIGHT));
		SELF.orig_RESTRICTIONS2    := stringlib.StringToUpperCase(TRIM(l.orig_RESTRICTIONS2,LEFT,RIGHT));
		SELF.orig_RESTRICTIONS3    := stringlib.StringToUpperCase(TRIM(l.orig_RESTRICTIONS3,LEFT,RIGHT));
		SELF.orig_RESTRICTIONS4    := stringlib.StringToUpperCase(TRIM(l.orig_RESTRICTIONS4,LEFT,RIGHT));
		SELF.orig_RESTRICTIONS5    := stringlib.StringToUpperCase(TRIM(l.orig_RESTRICTIONS5,LEFT,RIGHT));
		SELF.orig_ENDORSEMENTS1    := stringlib.StringToUpperCase(TRIM(l.orig_ENDORSEMENTS1,LEFT,RIGHT));
		SELF.orig_ENDORSEMENTS2    := stringlib.StringToUpperCase(TRIM(l.orig_ENDORSEMENTS2,LEFT,RIGHT));
		SELF.orig_ENDORSEMENTS3    := stringlib.StringToUpperCase(TRIM(l.orig_ENDORSEMENTS3,LEFT,RIGHT));
		SELF.orig_ENDORSEMENTS4    := stringlib.StringToUpperCase(TRIM(l.orig_ENDORSEMENTS4,LEFT,RIGHT));
		SELF.orig_ENDORSEMENTS5    := stringlib.StringToUpperCase(TRIM(l.orig_ENDORSEMENTS5,LEFT,RIGHT));
		SELF.orig_EXPIRE_DATE      := IF(_Validate.Date.fIsValid(l.orig_EXPIRE_DATE),l.orig_EXPIRE_DATE,'');
		SELF.orig_ISSUE_DATE       := IF(_Validate.Date.fIsValid(l.orig_ISSUE_DATE) AND
	                                  _Validate.Date.fIsValid(l.orig_ISSUE_DATE,_Validate.Date.Rules.DateInPast),l.orig_ISSUE_DATE,'');
		SELF.orig_NON_CDL_STATUS   := stringlib.StringToUpperCase(TRIM(l.orig_NON_CDL_STATUS,LEFT,RIGHT));
		SELF.orig_CDL_STATUS       := stringlib.StringToUpperCase(TRIM(l.orig_CDL_STATUS,LEFT,RIGHT));
		SELF.orig_RACE             := stringlib.StringToUpperCase(TRIM(l.orig_RACE,LEFT,RIGHT));
		SELF.clean_name_prefix     := '';
		SELF.clean_name_first      := stringlib.StringToUpperCase(TRIM(l.orig_FIRST_NAME,LEFT,RIGHT));
		SELF.clean_name_middle     := stringlib.StringToUpperCase(TRIM(l.orig_MIDDLE_NAME,LEFT,RIGHT));
		SELF.clean_name_last       := stringlib.StringToUpperCase(TRIM(l.orig_LAST_NAME,LEFT,RIGHT));
		SELF.clean_name_suffix	   := ut.fgetsuffix(stringlib.StringToUpperCase(TRIM(l.orig_NAME_SUFFIX,LEFT,RIGHT)));
		SELF                       := l;		
		SELF                       := [];
	END;

	Cleaned_TN_File := project(in_file, mapClean(LEFT));
	
	RETURN Cleaned_TN_File;
END;
