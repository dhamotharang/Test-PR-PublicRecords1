import	ut
			 ,cnld_remap
			 ,lib_stringlib;

layouts.cmlpvad	lTransformIngxPATToCnldCMLPVAD(layouts.ProviderAddressType pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	pInput.ProviderID;
			self.ADDRID			:=	pInput.AddressID;
			self.EFF_DATE		:=	'';
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.TELEPHONE	:=	''; //Comes from addrressPhone
			self.FAX_NUM		:=	''; //Comes from addrressPhone
			self.FAX_SECURE	:=	'""';
			self.OFFICENAME	:=	'""';
			self.SRCE_UPDT	:=	'"INGX"';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ADD_SRCE		:=	'""';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.VerificationDate) > 1, pInput.VerificationDate[7..10] + '-' + pInput.VerificationDate[1..2] + '-' + pInput.VerificationDate[4..5] + ' 00:00:00', '');
			self.MATCHCNT		:=	pInput.CompanyCount;
			self.NEW_ADDRID	:=	'""';
			self.BILLADDR		:=	IF(pInput.AddressTypeCode = 'A' OR pInput.AddressTypeCode = 'B' OR pInput.AddressTypeCode = 'C', 'True', 'False');
			self.PRACADDR		:=	IF(pInput.AddressTypeCode = 'C' OR pInput.AddressTypeCode = 'P', 'True', 'False');
			self.HOMEADDR		:=	IF(pInput.AddressTypeCode = 'C' OR pInput.AddressTypeCode = 'H', 'True', 'False');
			self.SANC				:=	'';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ABMSFLG		:=	'"F"';
			self.LADDRSTAT	:=	'';
			self.SADDRDATE	:=	'""';
			self.LADDRRATE	:=	'';
			self.SVERDATE		:=	'""';
			self.LBESTADDR	:=	'';
			self.LADDRDATE	:=	'';
		END
;

pCnldCmlpvadRec1	:=	PROJECT(files.ProviderAddressType, lTransformIngxPATToCnldCMLPVAD(left));

layouts.cmlpvad	lTransformIngxPAPToCnldCMLPVAD(pCnldCmlpvadRec1 pInputL, files.ProviderAddressPhone pInputR)
	:=
		TRANSFORM
			self.TELEPHONE	:=	IF(pInputR.PhoneType = 'Office Phone', '"' + pInputR.PhoneNumber + '"', '""');
			self.FAX_NUM		:=	IF(pInputR.PhoneType = 'Office Fax', '"' + pInputR.PhoneNumber + '"', '""');
			self						:=	pInputL;
		END
;

pCnldCmlpvadRec2
	:=
		JOIN(pCnldCmlpvadRec1, files.ProviderAddressPhone,
			left.GENNUM = right.ProviderID AND left.ADDRID = right.AddressID,
  		lTransformIngxPAPToCnldCMLPVAD(LEFT, RIGHT),
   		MANY, LEFT OUTER
   	)
;

sCnldCmlpvadRec	:=	SORT(pCnldCmlpvadRec2, GENNUM, ADDRID);

layouts.cmlpvad	RollUpTrans(sCnldCmlpvadRec L, sCnldCmlpvadRec R)
	:=
		TRANSFORM
			self.TELEPHONE	:=	MAP(L.TELEPHONE != '""' => L.TELEPHONE, R.TELEPHONE != '""' => R.TELEPHONE, '"0000000000"');
			self.FAX_NUM		:=	MAP(L.FAX_NUM != '""' => L.FAX_NUM, R.FAX_NUM != '""' => R.FAX_NUM, '"0000000000"');
			self						:= 	L;
		END
;

ruCnldCmlpvadRec
	:=
		ROLLUP(sCnldCmlpvadRec, left.GENNUM = right.GENNUM AND left.ADDRID = right.ADDRID, RollUpTrans(LEFT, RIGHT))
;

layouts.cmlpvad	lFormatGennumAddridCnldCMLPVAD(ruCnldCmlpvadRec pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"I' + INTFORMAT((INTEGER)pInput.GENNUM, 9, 1) + '"';
			self.ADDRID			:=	'"IA' + INTFORMAT((INTEGER)pInput.ADDRID, 8, 1) + '"';
			self.TELEPHONE	:=	IF(pInput.TELEPHONE = '""', '"0000000000"', pInput.TELEPHONE);
			self.FAX_NUM		:=	IF(pInput.FAX_NUM = '""', '"0000000000"', pInput.FAX_NUM);
			self						:=	pInput;
		END
;

pCnldCmlpvadRec	:=	PROJECT(ruCnldCmlpvadRec, lFormatGennumAddridCnldCMLPVAD(left));

ddCnldCmlpvadRec	:=	DEDUP(pCnldCmlpvadRec, ALL);


export mapping_cmlpvad := ddCnldCmlpvadRec;