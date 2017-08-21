import	ut
			 ,cnld_remap
			 ,lib_stringlib;
			 
layouts.cmcsl	lTransformIngxToCnldCMCSL(layouts.ProviderLicense pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	pInput.ProviderID;
			self.LIC_STATE	:=	'"' + pInput.State	+	'"';
			self.SLNUM			:=	'"' + pInput.LicenseNumber	+	'"';
			self.LIC_TYPE		:=	'" "';
			self.SRCE_UPDT	:=	'"INGX"';
			self.LAST_UPDT	:=	IF(pInput.VerificationDate != '', pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.ISSUEDATE	:=	IF(pInput.EffectiveDate != '', pInput.EffectiveDate[7..10] + '-' + pInput.EffectiveDate[1..2] + '-' + pInput.EffectiveDate[4..5] + ' 00:00:00', '');
			self.EXPDATE		:=	IF(pInput.TerminationDate != '', pInput.TerminationDate[7..10] + '-' + pInput.TerminationDate[1..2] + '-' + pInput.TerminationDate[4..5] + ' 00:00:00', '');
			self.CONTHRSREQ	:=	'';
			self.CONTHRSCMP	:=	'';
			self.SUPERVISOR	:=	'';
			self.ORIGINCODE	:=	'""';
			self.LIC_STATUS	:=	'"A"';
			self.DISPTYPE		:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.SANC				:=	'""';
			self.PTHERAPY		:=	'""';
			self.ULTRASND		:=	'""';
			self.ACCUPUNCT	:=	'""';
			self.PROFCODE		:=	'';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ADDRID			:=	'';
			self.SLPK				:=	'""';
		END
;

pCnldCmcslRec	:=	PROJECT(files.ProviderLicense, lTransformIngxToCnldCMCSL(left));

ddCnldCmcslRec	:=	DEDUP(pCnldCmcslRec, ALL);

SpecProfLkp	:=	DATASET('~thor_200::in::ingenix_remap::providspecprofcode', cnld_remap.layouts.ProvIDSpecProfCode, THOR);

layouts.cmcsl lAddProfCodeCnldCMCSL(ddCnldCmcslRec pInputL, SpecProfLkp pInputR)
	:=
		TRANSFORM
			self.GENNUM		:=	'"I' + INTFORMAT((INTEGER)pInputL.GENNUM, 9, 1) + '"';
			self.PROFCODE	:=	pInputR.PROFCODE;
			self					:=	pInputL;
		END
;

CnldCmcslRec
	:=
		JOIN(ddCnldCmcslRec, SpecProfLkp,
			left.GENNUM = right.ProviderID,
  		lAddProfCodeCnldCMCSL(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

export mapping_cmcsl := CnldCmcslRec;