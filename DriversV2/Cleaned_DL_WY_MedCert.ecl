IMPORT Drivers, Address, ut, lib_stringlib, _Validate;

EXPORT Cleaned_DL_WY_MedCert(STRING processDate, STRING fileDate) := FUNCTION

	in_file := DriversV2.File_DL_WY_MedCert_Raw(fileDate);

  layout_out := DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Cleaned;
		
	layout_out mapClean(in_file l) := TRANSFORM
	
	  STRING73 tempName := stringlib.StringToUpperCase(IF(TRIM(TRIM(l.orig_FIRST_NAME,LEFT,RIGHT) + ' ' +
										                         TRIM(l.orig_LAST_NAME,LEFT,RIGHT),LEFT,RIGHT) <> '',
															Address.CleanPersonFML73(TRIM(TRIM(l.orig_FIRST_NAME,LEFT,RIGHT)  + ' ' +
																				          TRIM(l.orig_MIDDLE_NAME,LEFT,RIGHT) + ' ' +
																						  TRIM(l.orig_LAST_NAME,LEFT,RIGHT),LEFT,RIGHT)),
															''));
		SELF.clean_name_prefix     := tempName[1..5];
		SELF.clean_name_first      := tempName[6..25];
		SELF.clean_name_middle     := tempName[26..45];
		SELF.clean_name_last       := tempName[46..65];
		SELF.clean_name_suffix	   := tempName[66..70];
		SELF.clean_name_score      := tempName[71..73];
		SELF.append_process_date   := IF(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		SELF.orig_LAST_NAME        := stringlib.StringToUpperCase(TRIM(l.orig_LAST_NAME,LEFT,RIGHT));
		SELF.orig_FIRST_NAME       := stringlib.StringToUpperCase(TRIM(l.orig_FIRST_NAME,LEFT,RIGHT));
		SELF.orig_MIDDLE_NAME      := stringlib.StringToUpperCase(TRIM(l.orig_MIDDLE_NAME,LEFT,RIGHT));
		SELF.mailing_STREET_ADDR_1 := stringlib.StringToUpperCase(TRIM(l.mailing_STREET_ADDR_1,LEFT,RIGHT));
		SELF.mailing_CITY_1        := stringlib.StringToUpperCase(TRIM(l.mailing_CITY_1,LEFT,RIGHT));
		SELF.mailing_STATE_1       := stringlib.StringToUpperCase(TRIM(l.mailing_STATE_1,LEFT,RIGHT));
		SELF.mailing_ZIP_CODE_1    := IF((INTEGER)stringlib.stringfilter(l.mailing_ZIP_CODE_1,'0123456789')<>0,stringlib.stringfilter(l.mailing_ZIP_CODE_1,'0123456789'),''); 
		SELF.orig_DOB              := IF(_Validate.Date.fIsValid(l.orig_DOB) AND
	                                   _Validate.Date.fIsValid(l.orig_DOB,_Validate.Date.Rules.DateInPast),l.orig_DOB,'');
		SELF.phys_STREET_ADDR_2    := stringlib.StringToUpperCase(TRIM(l.phys_STREET_ADDR_2,LEFT,RIGHT));
		SELF.phys_CITY_2           := stringlib.StringToUpperCase(TRIM(l.phys_CITY_2,LEFT,RIGHT));
		SELF.phys_STATE_2          := stringlib.StringToUpperCase(TRIM(l.phys_STATE_2,LEFT,RIGHT));
		SELF.phys_ZIP_CODE_2       := IF((INTEGER)stringlib.stringfilter(l.phys_ZIP_CODE_2,'0123456789')<>0,stringlib.stringfilter(l.phys_ZIP_CODE_2,'0123456789'),''); 
		SELF.orig_DL_NUMBER        := stringlib.StringToUpperCase(TRIM(l.orig_DL_NUMBER,LEFT,RIGHT));
		SELF.orig_CODE_1           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_1,LEFT,RIGHT));
		SELF.orig_CODE_2           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_2,LEFT,RIGHT));
		SELF.orig_CODE_3           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_3,LEFT,RIGHT));
		SELF.orig_CODE_4           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_4,LEFT,RIGHT));
		SELF.orig_CODE_5           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_5,LEFT,RIGHT));
		SELF.orig_CODE_6           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_6,LEFT,RIGHT));
		SELF.orig_CODE_7           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_7,LEFT,RIGHT));
		SELF.orig_CODE_8           := stringlib.StringToUpperCase(TRIM(l.orig_CODE_8,LEFT,RIGHT));
		SELF.orig_EXPIRE_DATE      := IF(_Validate.Date.fIsValid(l.orig_EXPIRE_DATE),l.orig_EXPIRE_DATE,'');
		SELF.orig_ISSUE_DATE       := IF(_Validate.Date.fIsValid(l.orig_ISSUE_DATE) AND
	                                  _Validate.Date.fIsValid(l.orig_ISSUE_DATE,_Validate.Date.Rules.DateInPast),l.orig_ISSUE_DATE,'');
		SELF.Med_Cert_Status       := stringlib.StringToUpperCase(TRIM(l.Med_Cert_Status,LEFT,RIGHT));
		SELF.Med_Cert_Type         := stringlib.StringToUpperCase(TRIM(l.Med_Cert_Type,LEFT,RIGHT));
		SELF.Med_Cert_Expire_Date  := IF(_Validate.Date.fIsValid(l.Med_Cert_Expire_Date),l.Med_Cert_Expire_Date,'');
		SELF                       := l;		
		SELF                       := [];
	END;

	Cleaned_WY_MedCert_File := PROJECT(in_file, mapClean(left));
	
	RETURN Cleaned_WY_MedCert_File;
END;