import	ut
			 ,cnld_remap
			 ,lib_stringlib;

layouts.cmcadd	lTransformIngxToCnldCMCADD(layouts.ProviderAddress pInput)
	:=
		TRANSFORM
			self.ADDRID			:=	'"IA' + INTFORMAT((INTEGER)pInput.AddressID, 8, 1) + '"';
			self.ADDRESS1		:=	'"' + pInput.Address + '"';
			self.ADDRESS2		:=	'"' + pInput.Address2 + '"';
			self.CITY				:=	'"' + pInput.City + '"';
			self.STATE			:=	'"' + pInput.State + '"';
			self.ZIP5				:=	'"' + pInput.Zip + '"';
			self.ZIP4				:=	'"' + pInput.ExtZip + '"';
			self.CARRT			:=	'""';
			self.DPBC				:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGX"';
			self.COUNTY			:=	'"' + pInput.County + '"';
			self.FLAGOOC		:=	'';
			self.COUNTRY		:=	'""';
			self.ADDKEY			:=	'""';
			self.SUDKEY			:=	'""';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.RESULTCODE	:=	'""';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ADDRESSPK	:=	'';
		END
;

pCnldCmcaddRec	:=	PROJECT(files.ProviderAddress, lTransformIngxToCnldCMCADD(left));

ddCnldCmcaddRec	:=	DEDUP(pCnldCmcaddRec, ALL);

export mapping_cmcadd := ddCnldCmcaddRec;