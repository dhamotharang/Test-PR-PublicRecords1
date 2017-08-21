import	ut
			 ,cnld_remap
			 ,lib_stringlib;
			 
layouts.cmcprov	lTransformIngxToCnldCMCPROV(layouts.ProviderName pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	pInput.ProviderID;
			self.UPIN_NUM		:=	''; //Coming from ProviderUPIN.txt
			self.TYPE_CODE	:=	'"MD"';
			self.ORG_NAME		:=	'"' + TRIM(TRIM(pInput.LastName) + ' ' + TRIM(pInput.FirstName)) + '"';
			self.LAST_NAME	:=	'"' + TRIM(pInput.LastName) + '"';
			self.FIRST_NAME	:=	'"' + TRIM(pInput.FirstName) + '"';
			self.MID_NAME		:=	'"' + TRIM(pInput.MiddleName) + '"';
			self.NAME_PREFX	:=	'""';
			self.NAME_SUFX	:=	'"' + TRIM(pInput.Suffix) + '"';
			self.CREDENTIAL	:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGX"';
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.ORGKEY			:=	'""';
			self.MAILADDRID	:=	'""';
			self.PROVSTAT		:=	'""';
			self.GENDER			:=	''; //Coming from ProviderGender.txt
			self.DOBYEAR		:=	''; //Coming from ProviderBirthDate.txt
			self.DOBMONTH		:=	''; //Coming from ProviderBirthDate.txt
			self.DOBDAY			:=	''; //Coming from ProviderBirthDate.txt
			self.DISC				:=	'';
			self.OSTEO			:=	'';
			self.PRAEXPDATE	:=	'';
			self.ABMS				:=	'';
			self.SANC				:=	'';
			self.NEWGEN			:=	'""';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ABMSDOBFLG	:=	'';
			self.PROVID			:=	'';
		END
;

pCnldCmcprovRec1	:=	PROJECT(files.ProviderName(NameScore = '1'), lTransformIngxToCnldCMCPROV(left));

layouts.cmcprov	lAddUPINtoCnldCMCPROV(pCnldCmcprovRec1 pInputL, files.ProviderUPIN pInputR)
	:=
		TRANSFORM
			self.UPIN_NUM	:=	'"' + pInputR.UPIN + '"';
			self					:=	pInputL;
		END
;

pCnldCmcprovRec2
	:=
		JOIN(pCnldCmcprovRec1, files.ProviderUPIN,
			left.GENNUM = right.ProviderID,
  		lAddUPINtoCnldCMCPROV(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

layouts.cmcprov	lAddGendertoCnldCMCPROV(pCnldCmcprovRec2 pInputL, files.ProviderGender pInputR)
	:=
		TRANSFORM
			self.GENDER	:=	'"' + pInputR.Gender + '"';
			self					:=	pInputL;
		END
;

pCnldCmcprovRec3
	:=
		JOIN(pCnldCmcprovRec2, files.ProviderGender,
			left.GENNUM = right.ProviderID,
  		lAddGendertoCnldCMCPROV(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

layouts.cmcprov	lAddDOBtoCnldCMCPROV(pCnldCmcprovRec3 pInputL, files.ProviderBirthDate pInputR)
	:=
		TRANSFORM
			self.DOBYEAR	:=	IF((integer)pInputR.BirthDate[7..10] > 0, '"' + pInputR.BirthDate[7..10] + '"', '""');
			self.DOBMONTH	:=	IF((integer)pInputR.BirthDate[1..2] > 0, '"' + pInputR.BirthDate[1..2] + '"', '""');
			self.DOBDAY		:=	IF((integer)pInputR.BirthDate[4..5] > 0, '"' + pInputR.BirthDate[4..5] + '"', '""');
			self					:=	pInputL;
		END
;

pCnldCmcprovRec4
	:=
		JOIN(pCnldCmcprovRec3, files.ProviderBirthDate,
			left.GENNUM = right.ProviderID,
  		lAddDOBtoCnldCMCPROV(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

layouts.cmcprov	lFormatGennumCnldCMCPROV(pCnldCmcprovRec4 pInput)
	:=
		TRANSFORM
			self.GENNUM	:=	'"I' + INTFORMAT((INTEGER)pInput.GENNUM, 9, 1) + '"';
			self				:=	pInput;
		END
;

pCnldCmcprovRec	:=	PROJECT(pCnldCmcprovRec4, lFormatGennumCnldCMCPROV(left));

ddCnldCmcprovRec	:=	DEDUP(pCnldCmcprovRec, ALL);

export mapping_cmcprov := ddCnldCmcprovRec;