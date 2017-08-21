import	ut
			 ,cnld_remap
			 ,lib_stringlib;

rsProviderNPISlim								:=	PROJECT(files.ProviderNPI(LENGTH(TRIM(NPI)) = 10 AND ut.isNumeric(NPI)), layouts.ProviderNPISlim);
//rsProviderNPISlimDist						:=	DISTRIBUTE(rsProviderNPISlim,HASH(ProviderID));

rsProviderAddressTaxIDSlim			:=	PROJECT(files.ProviderAddressTaxID(LENGTH(TRIM(TaxID)) = 9 AND ut.isNumeric(TaxID)), layouts.ProviderAddressTaxIDSlim);
//rsProviderAddressTaxIDSlimDist	:=	DISTRIBUTE(rsProviderAddressTaxIDSlim,HASH(ProviderID));

layouts.cmcfed	lTransformIngxNPIToCnldCMCFED(layouts.ProviderNPISlim pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.FED_TAXID	:=	'"' + StringLib.StringFilterOut(pInput.NPI, '+') + '"';
			self.ADDRID			:=	'""';
			self.TAX_TYPE		:=	'"N"';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGX"';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.PROV_TYPE	:=	'';
			self.TERM_DATE	:=	'';
			self.SANC				:=	'';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.FEDPK			:=	'';
		END
;

layouts.cmcfed	lTransformIngxTIDToCnldCMCFED(layouts.ProviderAddressTaxIDSlim pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.FED_TAXID	:=	'"' + StringLib.StringFilterOut(pInput.TaxID, '+') + '"';
			self.ADDRID			:=	'"IA' + INTFORMAT((INTEGER)pInput.AddressID, 8, 1) + '"';
			self.TAX_TYPE		:=	'"E"';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGX"';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.PROV_TYPE	:=	'';
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.SANC				:=	'';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.FEDPK			:=	'';
		END
;

pCnldCmcfedNPIRecs	:=	PROJECT(rsProviderNPISlim, lTransformIngxNPIToCnldCMCFED(left));
pCnldCmcfedTIDRecs	:=	PROJECT(rsProviderAddressTaxIDSlim, lTransformIngxTIDToCnldCMCFED(left));

ddCnldCmcfedNPIRecs	:=	DEDUP(pCnldCmcfedNPIRecs, ALL);
ddCnldCmcfedTIDRecs	:=	DEDUP(pCnldCmcfedTIDRecs, ALL);

export mapping_cmcfed := ddCnldCmcfedNPIRecs + ddCnldCmcfedTIDRecs;