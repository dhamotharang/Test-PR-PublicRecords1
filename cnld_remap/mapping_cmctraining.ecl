import	ut
			 ,cnld_remap
			 ,lib_stringlib;

//Get records from ProviderMedSchool that do not have a description in cmvschool
rsInstituteJoinMissing
 	:=
 		JOIN(files.ProviderResidency, files.cmvinstitute,
 				 TRIM(StringLib.StringToUpperCase(left.ResidencyName), LEFT, RIGHT) = TRIM(right.INSTITUTE, LEFT, RIGHT),
 				 LEFT ONLY
 		)
;

//dedupe joined records on the school
ddInstituteJoinMissing	:=	DEDUP(rsInstituteJoinMissing, TRIM(StringLib.StringToUpperCase(ResidencyName), LEFT, RIGHT));

layout_cmvinstituteTMP
	:=
		RECORD
			integer	INSTITUTE,
			string	INSTNAME,
			string	CONFIRMED,
			string	CREATE_DT,
			string	ADDRESS1,
			string	ADDRESS2,
			string	CITY,
			string	STATE,
			string	ZIP5,
			string	COUNTRY,
			string	ORGKEY,
			string	INSTITUTEPK
		END
;

layout_cmvinstituteTMP AddNewCodes(ddInstituteJoinMissing pInput, InstituteCodeCount)
	:=
		TRANSFORM
			self.INSTITUTE		:=	(InstituteCodeCount + 10778);
			self.INSTNAME			:=	TRIM(StringLib.StringToUpperCase(pInput.ResidencyName), LEFT, RIGHT);
			self.CONFIRMED		:=	'""';
			self.CREATE_DT		:=	'';
			self.ADDRESS1			:=	'""';
			self.ADDRESS2			:=	'""';
			self.CITY					:=	'""';
			self.STATE				:=	'""';
			self.ZIP5					:=	'""';
			self.COUNTRY			:=	'""';
			self.ORGKEY				:=	'""';
			self.INSTITUTEPK	:=	'';
		END
;

NewCodeRecs := PROJECT(ddInstituteJoinMissing, AddNewCodes(LEFT,COUNTER));

layouts.cmvinstitute ConvertToString(NewCodeRecs pInput)
	:=
		TRANSFORM
			self.INSTITUTE		:=	'"' + INTFORMAT(pInput.INSTITUTE, 5, 1) + '"';
			self.INSTNAME			:=	'"' + TRIM(pInput.INSTNAME, LEFT, RIGHT) + '"';
			self							:=	pInput;
		END
;

NewCodeRecsStr := PROJECT(NewCodeRecs, ConvertToString(left));

layouts.cmvinstitute	AddDoubleQuotes(files.cmvinstitute pInput)
	:=
		TRANSFORM
			self.INSTITUTE		:=	'"' + pInput.INSTITUTE + '"';
			self.INSTNAME			:=	'"' + TRIM(StringLib.StringToUpperCase(pInput.INSTNAME)) + '"';
			self.CONFIRMED		:=	'"' + pInput.CONFIRMED + '"';
			self.CREATE_DT		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ADDRESS1			:=	'"' + pInput.ADDRESS1 + '"';
			self.ADDRESS2			:=	'"' + pInput.ADDRESS2 + '"';
			self.CITY					:=	'"' + pInput.CITY + '"';
			self.STATE				:=	'"' + pInput.STATE + '"';
			self.ZIP5					:=	'"' + pInput.ZIP5 + '"';
			self.COUNTRY			:=	'"' + pInput.COUNTRY + '"';
			self.ORGKEY				:=	'"' + pInput.ORGKEY + '"';
			self.INSTITUTEPK	:=	pInput.INSTITUTEPK;
		END
;

ExistingCodeRecsStr	:=	PROJECT(files.cmvinstitute, AddDoubleQuotes(left));

cmvinstitute_lkp	:=	ExistingCodeRecsStr + NewCodeRecsStr:PERSIST('~thor_200::persist::cmvinstitute_lkp');


///////
layouts.cmctraining lTransformIngxToCnldCMCTRAINING(layouts.ProviderResidency pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.STATE			:=	'""';
			self.SPECIALTY1	:=	'""';
			self.SPECIALTY2	:=	'""';
			self.INSTITUTE	:=	'"' + TRIM(StringLib.StringToUpperCase(pInput.ResidencyName)) + '"';
			self.CATEGORY		:=	'"R"';
			self.STARTDATE	:=	'1800-01-01 00:00:00';
			self.ENDDATE		:=	'1800-01-01 00:00:00';
			self.CONFIRMED	:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGX"';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.TRAININGPK	:=	'""';
		END
;

pCnldCmcTrainingRec1	:=	PROJECT(files.ProviderResidency, lTransformIngxToCnldCMCTRAINING(left));

layouts.cmctraining lAddSchoolCodetoCnldCMCTRAINING(pCnldCmcTrainingRec1 pInputL, cmvinstitute_lkp pInputR)
	:=
		TRANSFORM
			self.INSTITUTE	:=	pInputR.INSTITUTE;
			self						:=	pInputL;
		END
;

pCnldCmcTrainingRec2
	:=
		JOIN(pCnldCmcTrainingRec1, cmvinstitute_lkp,
			left.INSTITUTE = right.INSTNAME,
  		lAddSchoolCodetoCnldCMCTRAINING(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

ddCnldCmcTrainingRec	:=	DEDUP(pCnldCmcTrainingRec2, ALL);

OUTPUT(cmvinstitute_lkp, ,'~thor_200::out::cnld::cmvinstitute.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcTrainingRec, ,'~thor_200::out::cnld::cmctraining.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);

export mapping_cmctraining := '';