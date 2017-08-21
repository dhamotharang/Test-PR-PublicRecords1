import	ut
			 ,cnld_remap
			 ,lib_stringlib;

layouts.cmcdea	lTransformIngxToCnldCMCDEA(layouts.ProviderAddressDEANumber pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.DEANBR			:=	'"' + pInput.DEANumber + '"';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.EXPDATE		:=	'';
			self.SRCE_UPDT	:=	'"INGX"';
			self.SCHEDULE1	:=	'';
			self.SCHEDULE2	:=	'';
			self.SCHEDULE2N	:=	'';
			self.SCHEDULE3	:=	'';
			self.SCHEDULE4	:=	'';
			self.SCHEDULE5	:=	'';
			self.SCHEDULEL1	:=	'';
			self.ADDRID			:=	'""';
			self.BUS_CODE		:=	'""';
			self.DEAPK			:=	'';
		END
;

pCnldCmcdeaRec	:=	PROJECT(files.ProviderAddressDEANumber, lTransformIngxToCnldCMCDEA(left));

ddCnldCmcaddRec	:=	DEDUP(pCnldCmcdeaRec, ALL);

export mapping_cmcdea := ddCnldCmcaddRec;