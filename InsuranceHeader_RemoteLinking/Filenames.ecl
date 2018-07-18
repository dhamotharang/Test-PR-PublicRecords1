IMPORT ut;
EXPORT Filenames := MODULE

 EXPORT Suffix_Full    := 'full::';
 EXPORT Suffix_QA      := 'qa::';
 EXPORT Suffix_Publish := '::publish';

	// prefixes and key names
	EXPORT Prefix_Base							:= '~thor_data400::insuranceheader_remotelinking::did::word::';
 EXPORT Prefix_spec_SSN						      := Prefix_Base + 'SSN::';
 EXPORT Prefix_spec_DOB_YEAR							:= Prefix_Base + 'DOB_YEAR::';
 EXPORT Prefix_spec_DOB_MONTH						:= Prefix_Base + 'DOB_MONTH::';
 EXPORT Prefix_spec_DOB_DAY							 := Prefix_Base + 'DOB_DAY::';
 EXPORT Prefix_spec_DL_NBR							  := Prefix_Base + 'DL_NBR::';
 EXPORT Prefix_spec_SNAME							   := Prefix_Base + 'SNAME::';
 EXPORT Prefix_spec_FNAME							   := Prefix_Base + 'FNAME::';
 EXPORT Prefix_spec_MNAME							   := Prefix_Base + 'MNAME::';
 EXPORT Prefix_spec_LNAME							   := Prefix_Base + 'LNAME::';
 EXPORT Prefix_spec_GENDER							  := Prefix_Base + 'GENDER::';
 EXPORT Prefix_spec_DERIVED_GENDER	:= Prefix_Base + 'DERIVED_GENDER::';
 EXPORT Prefix_spec_PRIM_NAME						:= Prefix_Base + 'PRIM_NAME::';
 EXPORT Prefix_spec_PRIM_RANGE				 := Prefix_Base + 'PRIM_RANGE::';
 EXPORT Prefix_spec_SEC_RANGE					 := Prefix_Base + 'SEC_RANGE::';
 EXPORT Prefix_spec_CITY							    := Prefix_Base + 'CITY::';
 EXPORT Prefix_spec_ST							      := Prefix_Base + 'ST::';
 EXPORT Prefix_spec_ZIP							     := Prefix_Base + 'ZIP::';
 EXPORT Prefix_spec_POLICY_NUMBER	 := Prefix_Base + 'POLICY_NUMBER::';
 EXPORT Prefix_spec_CLAIM_NUMBER		 := Prefix_Base + 'CLAIM_NUMBER::';
 EXPORT Prefix_spec_MAINNAME							:= Prefix_Base + 'MAINNAME::';
 EXPORT Prefix_spec_ADDR1							   := Prefix_Base + 'ADDR1::';
 EXPORT Prefix_spec_LOCALE					    := Prefix_Base + 'LOCALE::';
 EXPORT Prefix_spec_ADDRESS						  := Prefix_Base + 'ADDRESS::';
 EXPORT Prefix_spec_FULLNAME							:= Prefix_Base + 'FULLNAME::';
 EXPORT Prefix_spec_DT_FIRST_SEEN	 := Prefix_Base + 'DT_FIRST_SEEN::';
 EXPORT Prefix_spec_DT_LAST_SEEN		 := Prefix_Base + 'DT_LAST_SEEN::';
 EXPORT Prefix_spec_SPECIFICITIES		:= Prefix_Base + 'Specificities::';

	// superfile names
 EXPORT spec_SSN_SF						      := mod_FileNames(Prefix_spec_SSN);
 EXPORT spec_DOB_YEAR_SF							:= mod_FileNames(Prefix_spec_DOB_YEAR);
 EXPORT spec_DOB_MONTH_SF						:= mod_FileNames(Prefix_spec_DOB_MONTH);
 EXPORT spec_DOB_DAY_SF							 := mod_FileNames(Prefix_spec_DOB_DAY);
 EXPORT spec_DL_NBR_SF							  := mod_FileNames(Prefix_spec_DL_NBR);
 EXPORT spec_SNAME_SF							   := mod_FileNames(Prefix_spec_SNAME);
 EXPORT spec_FNAME_SF							   := mod_FileNames(Prefix_spec_FNAME);
 EXPORT spec_MNAME_SF							   := mod_FileNames(Prefix_spec_MNAME);
 EXPORT spec_LNAME_SF							   := mod_FileNames(Prefix_spec_LNAME);
 EXPORT spec_GENDER_SF							  := mod_FileNames(Prefix_spec_GENDER);
 EXPORT spec_DERIVED_GENDER_SF	:= mod_FileNames(Prefix_spec_DERIVED_GENDER);
 EXPORT spec_PRIM_NAME_SF						:= mod_FileNames(Prefix_spec_PRIM_NAME);
 EXPORT spec_PRIM_RANGE_SF				 := mod_FileNames(Prefix_spec_PRIM_RANGE);
 EXPORT spec_SEC_RANGE_SF					 := mod_FileNames(Prefix_spec_SEC_RANGE);
 EXPORT spec_CITY_SF							    := mod_FileNames(Prefix_spec_CITY);
 EXPORT spec_ST_SF							      := mod_FileNames(Prefix_spec_ST);
 EXPORT spec_ZIP_SF							     := mod_FileNames(Prefix_spec_ZIP);
 EXPORT spec_POLICY_NUMBER_SF	 := mod_FileNames(Prefix_spec_POLICY_NUMBER);
 EXPORT spec_CLAIM_NUMBER_SF		 := mod_FileNames(Prefix_spec_CLAIM_NUMBER);
 EXPORT spec_MAINNAME_SF							:= mod_FileNames(Prefix_spec_MAINNAME);
 EXPORT spec_ADDR1_SF							   := mod_FileNames(Prefix_spec_ADDR1);
 EXPORT spec_LOCALE_SF					    := mod_FileNames(Prefix_spec_LOCALE);
 EXPORT spec_ADDRESS_SF						  := mod_FileNames(Prefix_spec_ADDRESS);
 EXPORT spec_FULLNAME_SF							:= mod_FileNames(Prefix_spec_FULLNAME);
 EXPORT spec_DT_FIRST_SEEN_SF	 := mod_FileNames(Prefix_spec_DT_FIRST_SEEN);
 EXPORT spec_DT_LAST_SEEN_SF			:= mod_FileNames(Prefix_spec_DT_LAST_SEEN);
 EXPORT spec_SPECIFICITIES_SF		:= mod_FileNames(Prefix_spec_SPECIFICITIES);
	
  //QA superfile names
 EXPORT spec_SSN_QA_SF						      := mod_FileNames(Prefix_spec_SSN + Suffix_QA);
 EXPORT spec_DOB_YEAR_QA_SF							:= mod_FileNames(Prefix_spec_DOB_YEAR + Suffix_QA);
 EXPORT spec_DOB_MONTH_QA_SF						:= mod_FileNames(Prefix_spec_DOB_MONTH + Suffix_QA);
 EXPORT spec_DOB_DAY_QA_SF							 := mod_FileNames(Prefix_spec_DOB_DAY + Suffix_QA);
 EXPORT spec_DL_NBR_QA_SF							  := mod_FileNames(Prefix_spec_DL_NBR + Suffix_QA);
 EXPORT spec_SNAME_QA_SF							   := mod_FileNames(Prefix_spec_SNAME + Suffix_QA);
 EXPORT spec_FNAME_QA_SF							   := mod_FileNames(Prefix_spec_FNAME + Suffix_QA);
 EXPORT spec_MNAME_QA_SF							   := mod_FileNames(Prefix_spec_MNAME + Suffix_QA);
 EXPORT spec_LNAME_QA_SF							   := mod_FileNames(Prefix_spec_LNAME + Suffix_QA);
 EXPORT spec_GENDER_QA_SF							  := mod_FileNames(Prefix_spec_GENDER + Suffix_QA);
 EXPORT spec_DERIVED_GENDER_QA_SF	:= mod_FileNames(Prefix_spec_DERIVED_GENDER + Suffix_QA);
 EXPORT spec_PRIM_NAME_QA_SF						:= mod_FileNames(Prefix_spec_PRIM_NAME + Suffix_QA);
 EXPORT spec_PRIM_RANGE_QA_SF				 := mod_FileNames(Prefix_spec_PRIM_RANGE + Suffix_QA);
 EXPORT spec_SEC_RANGE_QA_SF					 := mod_FileNames(Prefix_spec_SEC_RANGE + Suffix_QA);
 EXPORT spec_CITY_QA_SF							    := mod_FileNames(Prefix_spec_CITY + Suffix_QA);
 EXPORT spec_ST_QA_SF							      := mod_FileNames(Prefix_spec_ST + Suffix_QA);
 EXPORT spec_ZIP_QA_SF							     := mod_FileNames(Prefix_spec_ZIP + Suffix_QA);
 EXPORT spec_POLICY_NUMBER_QA_SF	 := mod_FileNames(Prefix_spec_POLICY_NUMBER + Suffix_QA);
 EXPORT spec_CLAIM_NUMBER_QA_SF		 := mod_FileNames(Prefix_spec_CLAIM_NUMBER + Suffix_QA);
 EXPORT spec_MAINNAME_QA_SF							:= mod_FileNames(Prefix_spec_MAINNAME + Suffix_QA);
 EXPORT spec_ADDR1_QA_SF							   := mod_FileNames(Prefix_spec_ADDR1 + Suffix_QA);
 EXPORT spec_LOCALE_QA_SF					    := mod_FileNames(Prefix_spec_LOCALE + Suffix_QA);
 EXPORT spec_ADDRESS_QA_SF						  := mod_FileNames(Prefix_spec_ADDRESS + Suffix_QA);
 EXPORT spec_FULLNAME_QA_SF							:= mod_FileNames(Prefix_spec_FULLNAME + Suffix_QA);
 EXPORT spec_DT_FIRST_SEEN_QA_SF	 := mod_FileNames(Prefix_spec_DT_FIRST_SEEN + Suffix_QA);
 EXPORT spec_DT_LAST_SEEN_QA_SF			:= mod_FileNames(Prefix_spec_DT_LAST_SEEN + Suffix_QA);
 EXPORT spec_SPECIFICITIES_QA_SF		:= mod_FileNames(Prefix_spec_SPECIFICITIES + Suffix_QA);

// superfile names
 EXPORT spec_SSN_Full_SF						      := mod_FileNames(Prefix_spec_SSN + Suffix_Full);
 EXPORT spec_DOB_YEAR_Full_SF							:= mod_FileNames(Prefix_spec_DOB_YEAR + Suffix_Full);
 EXPORT spec_DOB_MONTH_Full_SF						:= mod_FileNames(Prefix_spec_DOB_MONTH + Suffix_Full);
 EXPORT spec_DOB_DAY_Full_SF							 := mod_FileNames(Prefix_spec_DOB_DAY + Suffix_Full);
 EXPORT spec_DL_NBR_Full_SF							  := mod_FileNames(Prefix_spec_DL_NBR + Suffix_Full);
 EXPORT spec_SNAME_Full_SF							   := mod_FileNames(Prefix_spec_SNAME + Suffix_Full);
 EXPORT spec_FNAME_Full_SF							   := mod_FileNames(Prefix_spec_FNAME + Suffix_Full);
 EXPORT spec_MNAME_Full_SF							   := mod_FileNames(Prefix_spec_MNAME + Suffix_Full);
 EXPORT spec_LNAME_Full_SF							   := mod_FileNames(Prefix_spec_LNAME + Suffix_Full);
 EXPORT spec_GENDER_Full_SF							  := mod_FileNames(Prefix_spec_GENDER + Suffix_Full);
 EXPORT spec_DERIVED_GENDER_Full_SF	:= mod_FileNames(Prefix_spec_DERIVED_GENDER + Suffix_Full);
 EXPORT spec_PRIM_NAME_Full_SF						:= mod_FileNames(Prefix_spec_PRIM_NAME + Suffix_Full);
 EXPORT spec_PRIM_RANGE_Full_SF				 := mod_FileNames(Prefix_spec_PRIM_RANGE + Suffix_Full);
 EXPORT spec_SEC_RANGE_Full_SF					 := mod_FileNames(Prefix_spec_SEC_RANGE + Suffix_Full);
 EXPORT spec_CITY_Full_SF							    := mod_FileNames(Prefix_spec_CITY + Suffix_Full);
 EXPORT spec_ST_Full_SF							      := mod_FileNames(Prefix_spec_ST + Suffix_Full);
 EXPORT spec_ZIP_Full_SF							     := mod_FileNames(Prefix_spec_ZIP + Suffix_Full);
 EXPORT spec_POLICY_NUMBER_Full_SF	 := mod_FileNames(Prefix_spec_POLICY_NUMBER + Suffix_Full);
 EXPORT spec_CLAIM_NUMBER_Full_SF		 := mod_FileNames(Prefix_spec_CLAIM_NUMBER + Suffix_Full);
 EXPORT spec_MAINNAME_Full_SF							:= mod_FileNames(Prefix_spec_MAINNAME + Suffix_Full);
 EXPORT spec_ADDR1_Full_SF							   := mod_FileNames(Prefix_spec_ADDR1 + Suffix_Full);
 EXPORT spec_LOCALE_Full_SF					    := mod_FileNames(Prefix_spec_LOCALE + Suffix_Full);
 EXPORT spec_ADDRESS_Full_SF						  := mod_FileNames(Prefix_spec_ADDRESS + Suffix_Full);
 EXPORT spec_FULLNAME_Full_SF							:= mod_FileNames(Prefix_spec_FULLNAME + Suffix_Full);
 EXPORT spec_DT_FIRST_SEEN_Full_SF	 := mod_FileNames(Prefix_spec_DT_FIRST_SEEN + Suffix_Full);
 EXPORT spec_DT_LAST_SEEN_Full_SF			:= mod_FileNames(Prefix_spec_DT_LAST_SEEN + Suffix_Full);
 EXPORT spec_SPECIFICITIES_Full_SF		:= mod_FileNames(Prefix_spec_SPECIFICITIES + Suffix_Full);

 // logical file names
	EXPORT spec_SSN_LF(STRING version)						          := mod_FileNames(Prefix_spec_SSN).logical(version);
	EXPORT spec_DOB_YEAR_LF(STRING version)						     := mod_FileNames(Prefix_spec_DOB_YEAR).logical(version);
	EXPORT spec_DOB_MONTH_LF(STRING version)									 := mod_FileNames(Prefix_spec_DOB_MONTH).logical(version);
	EXPORT spec_DOB_DAY_LF(STRING version)								    := mod_FileNames(Prefix_spec_DOB_DAY).logical(version);
	EXPORT spec_DL_NBR_LF(STRING version)					        := mod_FileNames(Prefix_spec_DL_NBR).logical(version);
	EXPORT spec_SNAME_LF(STRING version)				          := mod_FileNames(Prefix_spec_SNAME).logical(version);
	EXPORT spec_FNAME_LF(STRING version)	             := mod_FileNames(Prefix_spec_FNAME).logical(version);
	EXPORT spec_MNAME_LF(STRING version)	             := mod_FileNames(Prefix_spec_MNAME).logical(version);
	EXPORT spec_LNAME_LF(STRING version)					         := mod_FileNames(Prefix_spec_LNAME).logical(version);
	EXPORT spec_GENDER_LF(STRING version)							      := mod_FileNames(Prefix_spec_GENDER).logical(version);
	EXPORT spec_DERIVED_GENDER_LF(STRING version)				 := mod_FileNames(Prefix_spec_DERIVED_GENDER).logical(version);
	EXPORT spec_PRIM_NAME_LF(STRING version)					     := mod_FileNames(Prefix_spec_PRIM_NAME).logical(version);
	EXPORT spec_PRIM_RANGE_LF(STRING version)							  := mod_FileNames(Prefix_spec_PRIM_RANGE).logical(version);
 EXPORT spec_SEC_RANGE_LF(STRING version)							   := mod_FileNames(Prefix_spec_SEC_RANGE).logical(version);
	EXPORT spec_CITY_LF(STRING version)							        := mod_FileNames(Prefix_spec_CITY).logical(version);
	EXPORT spec_ST_LF(STRING version)	                := mod_FileNames(Prefix_spec_ST).logical(version);
	EXPORT spec_ZIP_LF(STRING version)				            := mod_FileNames(Prefix_spec_ZIP).logical(version);
	EXPORT spec_POLICY_NUMBER_LF(STRING version)				  := mod_FileNames(Prefix_spec_POLICY_NUMBER).logical(version);
	EXPORT spec_CLAIM_NUMBER_LF(STRING version)				   := mod_FileNames(Prefix_spec_CLAIM_NUMBER).logical(version);
	EXPORT spec_MAINNAME_LF(STRING version)				       := mod_FileNames(Prefix_spec_MAINNAME).logical(version);
	EXPORT spec_ADDR1_LF(STRING version)				          := mod_FileNames(Prefix_spec_ADDR1).logical(version);
	EXPORT spec_LOCALE_LF(STRING version)				         := mod_FileNames(Prefix_spec_LOCALE).logical(version);
	EXPORT spec_ADDRESS_LF(STRING version)				        := mod_FileNames(Prefix_spec_ADDRESS).logical(version);
	EXPORT spec_FULLNAME_LF(STRING version)				       := mod_FileNames(Prefix_spec_FULLNAME).logical(version);
	EXPORT spec_DT_FIRST_SEEN_LF(STRING version)				  := mod_FileNames(Prefix_spec_DT_FIRST_SEEN).logical(version);
	EXPORT spec_DT_LAST_SEEN_LF(STRING version)				   := mod_FileNames(Prefix_spec_DT_LAST_SEEN).logical(version);
	EXPORT spec_SPECIFICITIES_LF(STRING version)				  := mod_FileNames(Prefix_spec_SPECIFICITIES).logical(version);

	// workman files
	EXPORT Prefix_Workman						:= '~thor_data400::workman::insuranceheader_remotelinking::';
	EXPORT MasterWorkmanOutputSF  	:= Prefix_Workman + 'WUInfo';
	
END;
