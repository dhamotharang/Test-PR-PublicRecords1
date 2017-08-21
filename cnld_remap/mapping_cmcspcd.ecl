import	ut
			 ,cnld_remap
			 ,lib_stringlib;

layout_cmcspcdTMP
	:=
		RECORD
			string	GENNUM,
			string	SpecialtyID,
			string	SpecialtyGroupID,
			string	SPEC_CODE,
			string	SRCE_UPDT,
			string	DTSTAMP,
			string	LAST_UPDT,
			string	MATCHCNT,
			string	UPIN,
			string	SL,
			string	TERM_DATE,
			string	CREATE_DT,
			string	SPCDPK
		END
;

layout_cmcspcdTMP lTransformIngxToCnldCMCSPCD1(layouts.ProviderSpecialty pInput)
	:=
		TRANSFORM
			self.GENNUM						:=	'"I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.SpecialtyID			:=	pInput.SpecialtyID;
			self.SpecialtyGroupID	:=	'';
			self.SPEC_CODE				:=	'';
			self.SRCE_UPDT				:=	'"INGX"';
			self.DTSTAMP					:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT				:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.MATCHCNT					:=	pInput.CompanyCount;
			self.UPIN							:=	'';
			self.SL								:=	'';
			self.TERM_DATE				:=	'2900-01-01 00:00:00';
			self.CREATE_DT				:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.SPCDPK						:=	'';
		END
;

pCnldCmcspcdRec1	:=	PROJECT(files.ProviderSpecialty, lTransformIngxToCnldCMCSPCD1(left));

layout_cmcspcdTMP	lAddSGIDtoCnldCMCSPCD(pCnldCmcspcdRec1 pInputL, files.Specialty pInputR)
	:=
		TRANSFORM
			self.SpecialtyGroupID	:=	pInputR.SpecialtyGroupID;
			self									:=	pInputL;
		END
;

pCnldCmcspcdRec2
	:=
		JOIN(pCnldCmcspcdRec1, files.Specialty,
			left.SpecialtyID = right.SpecialtyID,
  		lAddSGIDtoCnldCMCSPCD(LEFT, RIGHT),
   		MANY LOOKUP, INNER
   	)
;

layout_cmcspcdTMP	lAddSPECCODEtoCnldCMCSPCD(pCnldCmcspcdRec2 pInputL, files.SpecialtyToProfCode pInputR)
	:=
		TRANSFORM
			self.SPEC_CODE	:=	pInputR.SpecCode;
			self						:=	pInputL;
		END
;

pCnldCmcspcdRec3
	:=
		JOIN(pCnldCmcspcdRec2, files.SpecialtyToProfCode,
			left.SpecialtyID = right.SpecialtyID AND left.SpecialtyGroupID = right.SpecialtyGroupID,
  		lAddSPECCODEtoCnldCMCSPCD(LEFT, RIGHT),
   		MANY LOOKUP, INNER
   	)
;

layouts.cmcspcd lTransformIngxToCnldCMCSPCD(pCnldCmcspcdRec3 pInput)
	:=
	TRANSFORM
		self	:=	pInput;
	END
;

pCnldCmcspcdRec	:=	PROJECT(pCnldCmcspcdRec3, lTransformIngxToCnldCMCSPCD(left));

ddCnldCmcspcdRec	:=	DEDUP(pCnldCmcspcdRec(SPEC_CODE != ''), ALL);
	
export mapping_cmcspcd := ddCnldCmcspcdRec;