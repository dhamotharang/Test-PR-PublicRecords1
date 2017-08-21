import	ut
			 ,cnld_remap
			 ,lib_stringlib;
			 
layouts.cmcalias	lTransformIngxToCnldCMCALIAS(layouts.ProviderName pInput)
	:=
		TRANSFORM
			self.GENNUM				:=	'"I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.ORG_NAME			:=	'"' + TRIM(TRIM(pInput.LastName) + ' ' + TRIM(pInput.FirstName)) + '"';
			self.LAST_NAME		:=	'"' + pInput.LastName + '"';
			self.FIRST_NAME		:=	'"' + pInput.FirstName + '"';
			self.MID_NAME			:=	'"' + pInput.MiddleName + '"';
			self.NAME_PREFIX	:=	'""';
			self.NAME_SUFX		:=	'"' + pInput.Suffix + '"';
			self.DTSTAMP			:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT		:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT		:=	'"INGX"';
			self.MATCHCNT			:=	pInput.CompanyCount;
			self.CREATE_DT		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ALIASPK			:=	'';
		END
;		

pCnldCmcAliasRec	:=	PROJECT(files.ProviderName(NameScore != '1'), lTransformIngxToCnldCMCALIAS(left));

ddCnldCmcAliasRec	:=	DEDUP(pCnldCmcAliasRec, ALL);

export mapping_cmcalias := ddCnldCmcAliasRec;