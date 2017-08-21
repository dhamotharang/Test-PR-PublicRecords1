import	ut
			 ,cnld_remap
			 ,lib_stringlib;
			 
layouts.cmvlang lTransformCmvlangToCmvlang(layouts.cmvlang pInput)
	:=
		TRANSFORM
			self.LANGCODE		:=	pInput.LANGCODE;
			self.LANGDESC		:=	TRIM(pInput.LANGDESC, LEFT, RIGHT);
			self.CMVLANGPK	:=	pInput.CMVLANGPK;
		END
;

rsCmvlang	:=	PROJECT(files.cmvlang, lTransformCmvlangToCmvlang(left));

layouts.ProviderLanguage lTransformProviderLanguageToProviderLanguage(layouts.ProviderLanguage pInput)
	:=
		TRANSFORM
			self.ProviderID							:=	pInput.ProviderID;
			self.Language								:=	TRIM(StringLib.StringToUpperCase(pInput.Language), LEFT, RIGHT);
			self.CompanyCount						:=	pInput.CompanyCount;
			self.TierTypeID							:=	pInput.TierTypeID;
			self.VerificationStatusCode	:=	pInput.VerificationStatusCode;
			self.VerificationDate				:=	pInput.VerificationDate;
		END
;

rsProviderLanguage	:=	PROJECT(files.ProviderLanguage, lTransformProviderLanguageToProviderLanguage(left));

//Get records from ProviderLanguage that do not have a description in cmvlang
rsLangJoinMissing
 	:=
 		JOIN(files.ProviderLanguage, files.cmvlang,
 				 TRIM(StringLib.StringToUpperCase(left.Language), LEFT, RIGHT) = TRIM(right.LANGDESC, LEFT, RIGHT),
 				 LEFT ONLY
 		)
;

//dedupe joined records on the language
ddLangJoinMissing	:=	DEDUP(rsLangJoinMissing, Language);

layout_cmvlangNew
	:=
		RECORD
			integer		LANGCODE;
			string		LANGDESC;
			string		CMVLANGPK;
		END
;

layout_cmvlangNew AddNewCodes(ddLangJoinMissing pInput, LangCodeCount)
	:=
		TRANSFORM
			self.LANGCODE 	:=	(LangCodeCount + 141);
			self.LANGDESC 	:=	StringLib.StringToUpperCase(pInput.Language);
			self.CMVLANGPK	:=	'';	
		END
;

NewCodeRecs := PROJECT(ddLangJoinMissing, AddNewCodes(LEFT,COUNTER));

layouts.cmvlang ConvertToString(NewCodeRecs pInput)
	:=
		TRANSFORM
			self.LANGCODE 	:=	'"' + INTFORMAT(pInput.LANGCODE, 3, 1) + '"';
			self.LANGDESC 	:=	'"' + TRIM(pInput.LANGDESC, LEFT, RIGHT) + '"';
			self.CMVLANGPK	:=	pInput.CMVLANGPK;	
		END
;

NewCodeRecsStr := PROJECT(NewCodeRecs, ConvertToString(left));

layouts.cmvlang	AddDoubleQuotes(files.cmvlang pInput)
	:=
		TRANSFORM
			self.LANGCODE		:=	'"'	+ pInput.LANGCODE + '"';
			self.LANGDESC 	:=	'"' + TRIM(pInput.LANGDESC, LEFT, RIGHT) + '"';
			self.CMVLANGPK	:=	pInput.CMVLANGPK;
		END
;

ExistingCodeRecsStr	:=	PROJECT(files.cmvlang, AddDoubleQuotes(left));

cmvlang_lkp	:=	ExistingCodeRecsStr + NewCodeRecsStr:PERSIST('~thor_200::persist::cmvlang_lkp');

layouts.cmclang	lTransformIngxToCnldCMCLANG(layouts.ProviderLanguage pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.LANGCODE		:=	'"' + TRIM(StringLib.StringToUpperCase(pInput.Language), LEFT, RIGHT) + '"';
			self.SRCE_UPDT	:=	'"INGX"';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LANGPK			:=	'';
		END
;

pCnldCmclangRec	:=	PROJECT(files.ProviderLanguage, lTransformIngxToCnldCMCLANG(left));

layouts.cmclang	lAddCodestoCnldCMCLANG(layouts.cmclang pInputL, layouts.cmvlang pInputR)
	:=
		TRANSFORM
			self.LANGCODE	:=	pInputR.LANGCODE;
			self					:=	pInputL;
		END
;

rsLangJoinLangCode
	:=
		JOIN(pCnldCmclangRec, cmvlang_lkp,
			left.LANGCODE = right.LANGDESC,
  		lAddCodestoCnldCMCLANG(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

ddCnldCmclangRec	:=	DEDUP(rsLangJoinLangCode, ALL);

OUTPUT(cmvlang_lkp, ,'~thor_200::out::cnld::cmvlang.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmclangRec, ,'~thor_200::out::cnld::cmclang.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);

// export mapping_cmvlang :=	cmvlang_lkp;
// export mapping_cmclang := ddCnldCmclangRec;

export mapping_cmclang := '';

