// file_liens_fcra_main
IMPORT	LiensV2;
EXPORT	MAC_Remove_Medical_Terms(dInfile, medical_term_field, dOutfile)	:=	MACRO

	#UNIQUENAME(ws1);
	#UNIQUENAME(ws);
	#UNIQUENAME(ruleHasMedicalTerm);
	#UNIQUENAME(rInfileWithMedText);
	#UNIQUENAME(parsedInfile);
	#UNIQUENAME(dParsedInfile);
	#UNIQUENAME(rOutfile);

	PATTERN	%ws1%									:=	[' ','\\','\'',',','.','-'];	//	Whitespace characters
	PATTERN	%ws%									:=	%ws1% %ws1%?;							//	Whitespace strings
	RULE		%ruleHasMedicalTerm%	:=	(	
																			FIRST	LiensV2.MedicalTerms.ExactMatch	%ws%	|	//	Term is at the begining of the string
																			FIRST LiensV2.MedicalTerms.ExactMatch	LAST	|	//	Term is only word in the string
																			%ws%	LiensV2.MedicalTerms.ExactMatch	LAST	|	//	Term is at the end of the string
																			%ws%	LiensV2.MedicalTerms.ExactMatch	%ws%	|	//	Term is standalone within the string
																			LiensV2.MedicalTerms.SubString								//	Term is a substring anywhere in the string
																		);	// Medical Terms surrounded by Whitespace

	%rInfileWithMedText% := RECORD
		dInfile;
		STRING100	medTextExactMatch	:=	MATCHTEXT(LiensV2.MedicalTerms.ExactMatch);
		STRING100	medTextSubString	:=	MATCHTEXT(LiensV2.MedicalTerms.SubString);
	END;
	//	Put whitespace around the medical term so that we have an exact match and not just a substring
	//	Ex.  ENT vs. ENTERTAINMENT
	%dParsedInfile%	:=	PARSE(dInfile, medical_term_field, %ruleHasMedicalTerm%, %rInfileWithMedText%, BEST, NOCASE, NOT MATCHED);

	%rOutfile%	:=	RECORD
		dInfile;
		bHasMedicalTerm									:=	FALSE;
		STRING MedicalStringExactMatch	:=	'';
		STRING MedicalStringSubString		:=	'';
	END;

	dOutfile			:=	PROJECT(%dParsedInfile%,
											TRANSFORM(
												%rOutfile%,
												SELF.bHasMedicalTerm	:=	LEFT.medTextExactMatch <>	'' OR LEFT.medTextSubString	<>	'';
												SELF.MedicalStringExactMatch	:=	LEFT.medTextExactMatch;
												SELF.MedicalStringSubString		:=	LEFT.medTextSubString;
												SELF									:=	LEFT
											)
										);

ENDMACRO;
