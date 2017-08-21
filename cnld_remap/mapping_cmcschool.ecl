import	ut
			 ,cnld_remap
			 ,lib_stringlib;
			 

layouts.cmvschool lTransformCmvschoolToCmvschool(layouts.cmvschool pInput)
	:=
		TRANSFORM
			self.SCHOOLCODE		:=	pInput.SCHOOLCODE;
			self.SCHOOLNAME		:=	TRIM(pInput.SCHOOLNAME, LEFT, RIGHT);
			self.CONFIRMED		:=	pInput.CONFIRMED;
			self.CREATE_DT		:=	pInput.CREATE_DT;
			self.ORGKEY				:=	pInput.ORGKEY;
			self.CMVSCHOOLPK	:=	pInput.CMVSCHOOLPK;
		END
;

rsCmvschool	:=	PROJECT(files.cmvschool, lTransformCmvschoolToCmvschool(left));

layouts.ProviderMedSchool lTransformProviderMedSchoolToProviderMedSchool(layouts.ProviderMedSchool pInput)
	:=
		TRANSFORM
			self.ProviderID							:=	pInput.ProviderID;
			self.MedSchoolName					:=	TRIM(StringLib.StringToUpperCase(pInput.MedSchoolName), LEFT, RIGHT);
			self.GraduationYear					:=	pInput.GraduationYear;
			self.CompanyCount						:=	pInput.CompanyCount;
			self.TierTypeID							:=	pInput.TierTypeID;
			self.VerificationStatusCode	:=	pInput.VerificationStatusCode;
			self.VerificationDate				:=	pInput.VerificationDate;
		END
;

rsProviderMedSchool	:=	PROJECT(files.ProviderMedSchool, lTransformProviderMedSchoolToProviderMedSchool(left));

//Get records from ProviderMedSchool that do not have a description in cmvschool
rsSchoolJoinMissing
 	:=
 		JOIN(files.ProviderMedSchool, files.cmvschool,
 				 TRIM(StringLib.StringToUpperCase(left.MedSchoolName), LEFT, RIGHT) = TRIM(right.SCHOOLNAME, LEFT, RIGHT),
 				 LEFT ONLY
 		)
;

//dedupe joined records on the school
ddSchoolJoinMissing	:=	DEDUP(rsSchoolJoinMissing, MedSchoolName);

layout_cmvschoolNew
	:=
		RECORD
			integer		SCHOOLCODE;
			string		SCHOOLNAME;
			string		CONFIRMED;
			string		CREATE_DT;
			string		ORGKEY;
			string		CMVSCHOOLPK;
		END
;

layout_cmvschoolNew AddNewCodes(ddSchoolJoinMissing pInput, SchoolCodeCount)
	:=
		TRANSFORM
			self.SCHOOLCODE		:=	(SchoolCodeCount + 18574);
			self.SCHOOLNAME		:=	StringLib.StringToUpperCase(pInput.MedSchoolName);
			self.CONFIRMED		:=	'';
			self.CREATE_DT		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ORGKEY				:=	'';
			self.CMVSCHOOLPK	:=	'';	
		END
;

NewCodeRecs := PROJECT(ddSchoolJoinMissing, AddNewCodes(LEFT,COUNTER));

layouts.cmvschool ConvertToString(NewCodeRecs pInput)
	:=
		TRANSFORM
			self.SCHOOLCODE	:=	'"' + INTFORMAT(pInput.SCHOOLCODE, 5, 1) + '"';
			self.SCHOOLNAME	:=	'"' + TRIM(pInput.SCHOOLNAME, LEFT, RIGHT) + '"';
			self.CONFIRMED		:=	'""';
			self.CREATE_DT		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ORGKEY				:=	'""';
			self.CMVSCHOOLPK	:=	'""';
		END
;

NewCodeRecsStr := PROJECT(NewCodeRecs, ConvertToString(left));

layouts.cmvschool	AddDoubleQuotes(files.cmvschool pInput)
	:=
		TRANSFORM
			self.SCHOOLCODE		:=	'"'	+ pInput.SCHOOLCODE + '"';
			self.SCHOOLNAME		:=	'"' + TRIM(pInput.SCHOOLNAME, LEFT, RIGHT) + '"';
			self.CONFIRMED		:=	'"' + pInput.CONFIRMED + '"';
			self.CREATE_DT		:=	'"' + pInput.CREATE_DT + '"';
			self.ORGKEY				:=	'"' + pInput.ORGKEY + '"';
			self.CMVSCHOOLPK	:=	'"' + pInput.CMVSCHOOLPK + '"';
		END
;

ExistingCodeRecsStr	:=	PROJECT(files.cmvschool, AddDoubleQuotes(left));

cmvschool_lkp	:=	ExistingCodeRecsStr + NewCodeRecsStr:PERSIST('~thor_200::persist::cmvschool_lkp');

layouts.cmcschool lTransformIngxToCnldCMCSCHOOL(layouts.ProviderMedSchool pInput)
	:=
		TRANSFORM
			self.GENNUM					:=	pInput.ProviderID;
			self.SCHOOLCODE			:=	'"' + TRIM(StringLib.StringToUpperCase(pInput.MedSchoolName), LEFT, RIGHT) + '"';
			self.SCHOOLYEAR			:=	'"' + pInput.GraduationYear + '"';
			self.DEGREE					:=	''; //Get records from ProviderDegreee
			self.PROFCODE				:=	'';
			self.DTSTAMP				:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT			:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT			:=	'"INGX"';
			self.MATCHCNT				:=	pInput.CompanyCount;
			self.TERM_DATE			:=	'2900-01-01 00:00:00';
			self.CREATE_DT			:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ABMSSCHOOLFLG	:=	'';
			self.SCHOOLPK				:=	'';
		END
;

pCnldCmcSchoolRec1	:=	PROJECT(files.ProviderMedSchool, lTransformIngxToCnldCMCSCHOOL(left));

layouts.cmcschool lAddSchoolCodetoCnldCMCSCHOOL(pCnldCmcSchoolRec1 pInputL, cmvschool_lkp pInputR)
	:=
		TRANSFORM
			self.SCHOOLCODE	:=	pInputR.SCHOOLCODE;
			self						:=	pInputL;
		END
;

pCnldCmcSchoolRec2
	:=
		JOIN(pCnldCmcSchoolRec1, cmvschool_lkp,
			left.SCHOOLCODE = right.SCHOOLNAME,
  		lAddSchoolCodetoCnldCMCSCHOOL(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

layouts.cmcschool lAddDegreetoCnldCMCSCHOOL(pCnldCmcSchoolRec2 pInputL, files.ProviderDegree pInputR)
	:=
		TRANSFORM
			self.DEGREE		:=	'"' + pInputR.Degree + '"';
			self					:=	pInputL;
		END
;

pCnldCmcSchoolRec3
	:=
		JOIN(pCnldCmcSchoolRec2, files.ProviderDegree,
			left.GENNUM = right.ProviderID,
  		lAddDegreetoCnldCMCSCHOOL(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

SpecProfLkp	:=	DATASET('~thor_200::in::ingenix_remap::providspecprofcode', cnld_remap.layouts.ProvIDSpecProfCode, THOR);

layouts.cmcschool lAddProfCodeCnldCMCSCHOOL(pCnldCmcSchoolRec3 pInputL, SpecProfLkp pInputR)
	:=
		TRANSFORM
			self.PROFCODE	:=	'"' + pInputR.PROFCODE + '"';
			self					:=	pInputL;
		END
;

pCnldCmcSchoolRec4
	:=
		JOIN(pCnldCmcSchoolRec3, SpecProfLkp,
			left.GENNUM = right.ProviderID,
  		lAddProfCodeCnldCMCSCHOOL(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

layouts.cmcschool	lFormatGennumCnldCMCSCHOOL(pCnldCmcSchoolRec4 pInput)
	:=
		TRANSFORM
			self.GENNUM	:=	'"I' + INTFORMAT((INTEGER)pInput.GENNUM, 9, 1) + '"';
			self				:=	pInput;
		END
;

pCnldCmcschoolRec	:=	PROJECT(pCnldCmcSchoolRec4, lFormatGennumCnldCMCSCHOOL(left));

ddCnldCmcschoolRec	:=	DEDUP(pCnldCmcschoolRec, ALL);

OUTPUT(cmvschool_lkp, ,'~thor_200::out::cnld::cmvschool.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcschoolRec, ,'~thor_200::out::cnld::cmcschool.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);

export mapping_cmcschool := '';