IMPORT BIPV2_COMPANY_NAMES, lib_StringLib,UT, STD, HealthCareFacility;
EXPORT clean_facility_name (STRING120 FNAME_RAW)  := FUNCTION

	FNAME := lib_StringLib.StringLib.StringFilterOut(FNAME_RAW,'&'); 
	Facility_Name_DS := DATASET ([{1,lib_StringLib.StringLib.StringCleanSpaces(FNAME),'','','','','','',0}],BIPV2_COMPANY_NAMES.layouts.layout_names);
	
	WORD_DS := NORMALIZE (Facility_Name_DS,ut.NoWords(LEFT.CNP_NAME, ' '),TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_words, 
			SELF.SEQ 				:= COUNTER; 
			WORD						:= ut.Word(LEFT.CNP_NAME,COUNTER, ' ');
			S_WORD					:= HealthCareFacility.ScrubCName (WORD,COUNTER);
			SELF.WORD				:= lib_StringLib.StringLib.StringCleanSpaces(S_WORD); 
			SELF						:= LEFT;));
	
	Remove_Blank_Word		:=	WORD_DS (WORD <> '');

	S1_WORD_DS := SORT (Remove_Blank_Word, SEQ);
	
	T1_WORD_DS	:=	PROJECT (S1_WORD_DS,TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_Names2, SELF.CNP_NAME := LEFT.WORD; SELF := LEFT;));
	
	DE1_WORD_DS := ROLLUP (T1_WORD_DS,LEFT.CNP_NAMEID = RIGHT.CNP_NAMEID, TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_Names2, SELF.CNP_NAME := TRIM(LEFT.CNP_NAME) + IF(LEFT.CNP_NAME <> '', ' ','') + TRIM(RIGHT.CNP_NAME); SELF := LEFT;), LOCAL);

	B_DATA	:= NORMALIZE (DE1_WORD_DS,ut.NoWords(LEFT.CNP_NAME, ' '),TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_words, 
			SELF.SEQ 				:= COUNTER; 
			WORD						:= ut.Word(LEFT.CNP_NAME,COUNTER, ' ');
			SELF.WORD				:= WORD; 
			SELF						:= LEFT;));
			
	Remove_Medical_Word	:=	JOIN (B_DATA,HealthCareFacility.Constants.MEDICAL_TITLES_DS, LEFT.WORD = RIGHT.MEDICAL_TITLE AND LEFT.SEQ > 2,
																		TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_words, SELF.WORD := IF(LEFT.WORD = RIGHT.MEDICAL_TITLE,'',LEFT.WORD); SELF := LEFT;),LEFT OUTER, LOOKUP);

	Remove_Noise_Word		:=	JOIN (Remove_Medical_Word,HealthCareFacility.Constants.Noise_Word_DS, LEFT.WORD = RIGHT.Noise_Word,
																		TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_words, SELF.WORD := IF(LEFT.WORD = RIGHT.Noise_Word,'',LEFT.WORD); SELF := LEFT;),LEFT OUTER, LOOKUP);

	Convert_Word				:=	JOIN (Remove_Noise_Word,HealthCareFacility.Constants.Conv_Table, LEFT.WORD = RIGHT.From_Word,
																		TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_words, SELF.WORD := IF(LEFT.WORD = RIGHT.From_Word,RIGHT.To_Word,LEFT.WORD); SELF := LEFT;),LEFT OUTER, ALL);																	
	
	S_WORD_DS := SORT (Convert_Word (WORD <> ''), CNP_NAMEID,SEQ,LOCAL);
	
	T_WORD_DS	:=	PROJECT (S_WORD_DS,TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_Names2, SELF.CNP_NAME := LEFT.WORD; SELF := LEFT;));
	
	DE_WORD_DS := ROLLUP (T_WORD_DS,LEFT.CNP_NAMEID = RIGHT.CNP_NAMEID, TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_Names2, SELF.CNP_NAME := TRIM(LEFT.CNP_NAME) + IF(LEFT.CNP_NAME <> '', ' ','') + TRIM(RIGHT.CNP_NAME); SELF := LEFT;), LOCAL);
	
	CLEANED_DS	:=	PROJECT (DE_WORD_DS,TRANSFORM(BIPV2_COMPANY_NAMES.layouts.layout_Names, SELF := LEFT;));
	
	STRING120	C_NAME	:=	(STRING) CLEANED_DS[1].cnp_name;
	
	T_NAME	:=	HealthCareFacility.TranslateName (C_NAME);
	
	Final_Clean	:=	lib_StringLib.StringLib.StringCleanSpaces(REGEXREPLACE (HealthCareFacility.Constants.Noise_Words,T_NAME,'',NOCASE));

	// OUTPUT (Remove_Blank_Word,NAMED('Remove_Blank_Word'));
	// OUTPUT (DE1_WORD_DS,NAMED('DE1_WORD_DS'));
	// OUTPUT (Remove_Medical_Word,NAMED('Remove_Medical_Word'));
	// OUTPUT (Convert_Word,NAMED('Convert_Word'));
	// OUTPUT (T_NAME,NAMED('T_NAME'));
	RETURN Final_Clean;
END;