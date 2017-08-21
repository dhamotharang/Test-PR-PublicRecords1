import ut
		 , cnld_remap
		 , lib_stringlib;

//Create a new layout to hold the Provider and Address IDs
layout_SanctionDBoutputIDed
	:=
		RECORD
			integer	ProviderID;
			integer	AddressID;
			cnld_remap.layouts.SanctionsDBoutput;
		END
;

//Create a transformation to store the ProviderID from the lookup file created by joining the Prover and Sanctions in Thor by DID
layout_SanctionDBoutputIDed lJoinProviderID(layouts.SanctionsDBoutput pInputL, cnld_remap.proc_create_prov_sanc_DID_lkp pInputR)
	:=
		TRANSFORM
			self.ProviderID	:=	(integer)pInputR.ProviderID;
			self.AddressID	:=	(integer)'';
			self						:=	pInputL;
		END
;

//Distribute the Sanction file and the Lookup file by SANC_ID
distfile_SanctionDBoutputSANCID	:=	DISTRIBUTE(files.SanctionsDBoutput, HASH(SANC_ID));
dist_SANC_ID_lkpSANCID					:=	DISTRIBUTE(cnld_remap.proc_create_prov_sanc_DID_lkp, HASH(SANC_ID));

//Join the Sanctions with the Lookup file on SANC_ID and only return records that exist in both
SanctionDBoutputProviderId
	:=
		JOIN(distfile_SanctionDBoutputSANCID, dist_SANC_ID_lkpSANCID,
			left.SANC_ID = right.SANC_ID,
  		lJoinProviderID(LEFT, RIGHT),
   		MANY, INNER, LOCAL
   	)
;

//Join the Sanctions with the Lookup file on SANC_ID and only return records that DO NOT EXIST
SanctionDBoutputMISSINGProviderId
	:=
		JOIN(distfile_SanctionDBoutputSANCID, dist_SANC_ID_lkpSANCID,
			left.SANC_ID = right.SANC_ID,
  		lJoinProviderID(LEFT, RIGHT),
   		MANY, LEFT ONLY, LOCAL
   	)
;

//Distribute the Sanction file and the Lookup file by UPIN
distfile_SanctionDBoutputUPIN		:=	DISTRIBUTE(SanctionDBoutputMISSINGProviderId(SANC_UPIN != ''), HASH(SANC_UPIN));
dist_SANC_ID_lkpUPIN						:=	DISTRIBUTE(cnld_remap.proc_create_prov_sanc_DID_lkp(upin != ''), HASH(upin));

//Create a transformation to store the ProviderID from the lookup file created by joining the Prover and Sanctions in Thor by DID
layout_SanctionDBoutputIDed lJoinProviderIDUPIN(distfile_SanctionDBoutputUPIN pInputL, dist_SANC_ID_lkpUPIN pInputR)
	:=
		TRANSFORM
			self.ProviderID	:=	(integer)pInputR.ProviderID;
			self.AddressID	:=	(integer)'';
			self						:=	pInputL;
		END
;

//Join the Sanctions with the Lookup file on UPIN and only return records that exist in both
SanctionDBoutputUpin
	:=
		JOIN(distfile_SanctionDBoutputUPIN, dist_SANC_ID_lkpUPIN,
			left.SANC_UPIN = right.upin,
  		lJoinProviderIDUPIN(LEFT, RIGHT),
   		MANY, INNER, LOCAL
   	)
;

//Join the Sanctions with the Lookup file on UPIN and only return records that DO NOT EXIST
SanctionDBoutputMISSING
	:=
		JOIN(distfile_SanctionDBoutputUPIN, dist_SANC_ID_lkpUPIN,
			left.SANC_UPIN = right.upin,
  		lJoinProviderIDUPIN(LEFT, RIGHT),
   		MANY, LEFT ONLY, LOCAL
   	)
;

//DEDUP and DISTRIBUTE the combined file to end up with records that match on either SANC_ID or UPIN
ddSanctionDBoutputJoin		:=	DEDUP(SanctionDBoutputProviderId + SanctionDBoutputUpin, ALL);
distSanctionDBoutputJoin	:=	DISTRIBUTE(ddSanctionDBoutputJoin, HASH(ProviderID));

//Distribute the ProviderName file to determine with ProviderID are in the current update
dist_file_ProviderName		:=	DISTRIBUTE(cnld_remap.files.ProviderName, HASH((integer)ProviderID));

layout_SanctionDBoutputIDed lProvExistsOrNot(distSanctionDBoutputJoin pInputL, dist_file_ProviderName pInputR)
	:=
		TRANSFORM
			self						:=	pInputL;
		END
;

//Determine if the provider from the sanction exists in this update
ProvExists
	:=
		JOIN(distSanctionDBoutputJoin, dist_file_ProviderName,
			left.ProviderID = (integer)right.ProviderID,
  		lProvExistsOrNot(LEFT, RIGHT),
   		MANY, INNER, LOCAL
   	)
;

//Determine if the provider from the sanction DOES NOT exist in this update
ProvDoesNotExist
	:=
		JOIN(distSanctionDBoutputJoin, dist_file_ProviderName,
			left.ProviderID = (integer)right.ProviderID,
  		lProvExistsOrNot(LEFT, RIGHT),
   		MANY, LEFT ONLY, LOCAL
   	)
;

//Now combine and dedup with the records that DID NOT match the DID lookup
MissingProvRecs		:=	ProvDoesNotExist + SanctionDBoutputMISSING;
ddMissingProvRecs	:=	DEDUP(MissingProvRecs, ALL);

//Get the maximum Adderss and Provider ID for the purpose of creating new ID's
AddrIDCnt			:=	MAX(cnld_remap.files.ProviderAddress, (integer)AddressID);
ProviderIDCnt	:=	MAX(cnld_remap.files.ProviderName, (integer)ProviderID);

//Transformation to create new ProviderID's for records that do not exist in this update
layout_SanctionDBoutputIDed lCreateNewProviderID(ddMissingProvRecs pInput, ProviderIDCounter)
	:=
		TRANSFORM
			self.ProviderID	:=	(ProviderIDCounter + ProviderIDCnt);
			self						:=	pInput;
		END
;

//Now project them with new ProviderID's
NewProvRecs 	:= PROJECT(ddMissingProvRecs, lCreateNewProviderID(LEFT,COUNTER));

//Now combine them with the existing records that already contain ProviderID's
AllProvRecs	:=	ProvExists + NewProvRecs;

//Define the file with which to lookup the PROV type descriptions
SancProfLkp	:=	cnld_remap.files.SancFileProfs;

//A transform to map the resulting prof code to the prov type description
layout_SanctionDBoutputIDed lAddProfCode(AllProvRecs pInputL, SancProfLkp pInputR)
	:=
		TRANSFORM
			self.SANC_PROVTYPE	:=	'"' + pInputR.PROFCODE + '"';
			self								:=	pInputL;
		END
;

//Join the records based on the Provider type description
AllProvRecsProfed
	:=
		JOIN(AllProvRecs, SancProfLkp,
			TRIM(left.SANC_PROVTYPE) = TRIM(right.ProvType),
  		lAddProfCode(LEFT, RIGHT),
   		INNER, LOOKUP
   	)
;

//Transformation to create new AddressID's for records that do not exist in this update and fix some format problems
layout_SanctionDBoutputIDed lCreateNewAddressID(AllProvRecsProfed pInput, AddressIDCounter)
	:=
		TRANSFORM
			self.AddressID			:=	(AddressIDCounter+ AddrIDCnt);
			self.SANC_LNME			:=	StringLib.StringFilterOut(pInput.SANC_LNME, '*^');
			self.SANC_FNME			:=	StringLib.StringFilterOut(pInput.SANC_FNME, '*^');
			self.SANC_MID_I_NM	:=	StringLib.StringFilterOut(pInput.SANC_MID_I_NM, '*^');
			self								:=	pInput;
		END
;

AllProvRecsIDed 		:= PROJECT(AllProvRecsProfed, lCreateNewAddressID(LEFT,COUNTER));

distAllProvRecsIDed	:=	DISTRIBUTE(AllProvRecsIDed, HASH(ProviderID));
ddAllProvRecsIDed		:=	DEDUP(distAllProvRecsIDed, ALL, LOCAL);

layouts.cmcadd	lTransformToCnldCMCADD(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.ADDRID			:=	'"IA' + INTFORMAT(pInput.AddressID, 8, 1) + '"';
			self.ADDRESS1		:=	'"' + pInput.SANC_STREET + '"';
			self.ADDRESS2		:=	'""';
			self.CITY				:=	'"' + pInput.SANC_CITY + '"';
			self.STATE			:=	'"' + pInput.SANC_STATE + '"';
			self.ZIP5				:=	'"' + pInput.SANC_ZIP + '"';
			self.ZIP4				:=	'""';
			self.CARRT			:=	'""';
			self.DPBC				:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT	:=	'';
			self.SRCE_UPDT	:=	'"INGXS"';
			self.COUNTY			:=	'""';
			self.FLAGOOC		:=	'';
			self.COUNTRY		:=	'"' + pInput.SANC_CNTRY + '"';
			self.ADDKEY			:=	'""';
			self.SUDKEY			:=	'""';
			self.MATCHCNT		:=	'';
			self.RESULTCODE	:=	'""';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ADDRESSPK	:=	'';
		END
;

pCnldCmcaddSancRec	:=	PROJECT(ddAllProvRecsIDed, lTransformToCnldCMCADD(left));
ddCnldCmcaddSancRec	:=	DEDUP(pCnldCmcaddSancRec, ALL);

layouts.cmcdiscp lTransformToCnldCMCDISCP(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.GENNUM				:=	'"I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.PROFCODE			:=	pInput.SANC_PROVTYPE; //This needs to be looked up.
			self.ACTSTATE			:=	'"' + pInput.SANC_SANCST + '"';
			self.ACTDATE			:=	pInput.SANC_SANCDTE[7..10] + '-' + pInput.SANC_SANCDTE[1..2] + '-' + pInput.SANC_SANCDTE[4..5] + ' 00:00:00';
			self.DOCTITLE			:=	'"' + pInput.SANC_SRC_DESC + '"';
			self.JUDGEMENT		:=	'';
			self.CASENBR			:=	'""';
			self.COMPLAINT		:=	'"' + pInput.SANC_REAS + '"';
			self.ACTIONDESC		:=	'"' + pInput.SANC_TYPE + ', ' + pInput.SANC_COND + ', ' + pInput.SANC_FINES + '"';
			self.SRCE_UPDT		:=	'"INGXS"';
			self.ENTRYDATE		:=	'';
			self.ENTRYSTAFF		:=	'""';
			self.ADDLDATACD		:=	'""';
			self.VERIFIED			:=	'';
			self.VERDATE			:=	'';
			self.VERSTAFFF		:=	'""';
			self.REPORTABLE		:=	'';
			self.LICREINDT		:=	IF(LENGTH(pInput.SANC_REINDTE) > 1, pInput.SANC_REINDTE[7..10] + '-' + pInput.SANC_REINDTE[1..2] + '-' + pInput.SANC_REINDTE[4..5] + ' 00:00:00', '');
			self.DOCID				:=	'""';
			self.SANCID				:=	'1' + INTFORMAT((INTEGER)pInput.SANC_ID, 9, 1);
			self.ADDLINFO			:=	'';
			self.DTSTAMP			:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDATE	:=	IF(LENGTH(pInput.SANC_UPDTE) > 1, pInput.SANC_UPDTE[7..10] + '-' + pInput.SANC_UPDTE[1..2] + '-' + pInput.SANC_UPDTE[4..5] + ' 00:00:00', '');
			self.MATCHCNT			:=	'';
			self.TERM_DATE		:=	'2900-01-01 00:00:00';
			self.CREATE_DT		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
		END
;

pCnldCmcdiscpSancRec	:=	PROJECT(ddAllProvRecsIDed, lTransformToCnldCMCDISCP(left));
ddCnldCmcdiscpSancRec	:=	DEDUP(pCnldCmcdiscpSancRec, ALL);

layouts.cmcfed	lTransformToCnldCMCFED(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.FED_TAXID	:=	'"' + StringLib.StringFilterOut(pInput.SANC_TIN, '+') + '"';
			self.ADDRID			:=	'"IA' + INTFORMAT(pInput.AddressID, 8, 1) + '"';
			self.TAX_TYPE		:=	'"E"';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.SANC_UPDTE) > 1, pInput.SANC_UPDTE[7..10] + '-' + pInput.SANC_UPDTE[1..2] + '-' + pInput.SANC_UPDTE[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGXS"';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.MATCHCNT		:=	'';
			self.PROV_TYPE	:=	'';
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.SANC				:=	'';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.FEDPK			:=	'';
		END
;

pCnldCmcfedSancRec	:=	PROJECT(ddAllProvRecsIDed(SANC_TIN != '' AND LENGTH(TRIM(SANC_TIN)) = 9 AND ut.isNumeric(SANC_TIN)), lTransformToCnldCMCFED(left));
ddCnldCmcfedSancRec	:=	DEDUP(pCnldCmcfedSancRec, ALL);

layouts.cmcprov	lTransformToCnldCMCPROV(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.UPIN_NUM		:=	pInput.SANC_UPIN;
			self.TYPE_CODE	:=	'"MD"';
			self.ORG_NAME		:=	'"' + TRIM(TRIM(pInput.SANC_LNME) + ' ' + TRIM(pInput.SANC_FNME)) + '"';
			self.LAST_NAME	:=	'"' + pInput.SANC_LNME + '"';
			self.FIRST_NAME	:=	'"' + pInput.SANC_FNME + '"';
			self.MID_NAME		:=	'"' + pInput.SANC_MID_I_NM + '"';
			self.NAME_PREFX	:=	'""';
			self.NAME_SUFX	:=	'""';
			self.CREDENTIAL	:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.SANC_UPDTE) > 1, pInput.SANC_UPDTE[7..10] + '-' + pInput.SANC_UPDTE[1..2] + '-' + pInput.SANC_UPDTE[4..5] + ' 00:00:00', '');
			self.SRCE_UPDT	:=	'"INGXS"';
			self.MATCHCNT		:=	'';
			self.ORGKEY			:=	'""';
			self.MAILADDRID	:=	'""';
			self.PROVSTAT		:=	'""';
			self.GENDER			:=	'';
			self.DOBYEAR		:=	IF((integer)pInput.SANC_DOB[8..9] > 0, '"19' + pInput.SANC_DOB[8..9] + '"', '""');
			self.DOBMONTH		:=	CASE(pInput.SANC_DOB[4..6], 
																					 'JAN' => '"01"',
																					 'FEB' => '"02"',
																					 'MAR' => '"03"',
																					 'APR' => '"04"',
																					 'MAY' => '"05"',
																					 'JUN' => '"06"',
																					 'JUL' => '"07"',
																					 'AUG' => '"08"',
																					 'SEP' => '"09"',
																					 'OCT' => '"10"',
																					 'NOV' => '"11"',
																					 'DEC' => '"12"',
																					 '""'
																					);
			self.DOBDAY			:=	IF((integer)pInput.SANC_DOB[1..2] > 0, '"' + pInput.SANC_DOB[1..2] + '"', '""');
			self.DISC				:=	'';
			self.OSTEO			:=	'';
			self.PRAEXPDATE	:=	'';
			self.ABMS				:=	'';
			self.SANC				:=	'1';
			self.NEWGEN			:=	'""';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ABMSDOBFLG	:=	'';
			self.PROVID			:=	'';
		END
;

// pCnldCmcprovSancRec		:=	PROJECT(ddAllProvRecsIDed, lTransformToCnldCMCPROV(left));
pCnldCmcprovSancRec		:=	PROJECT(NewProvRecs, lTransformToCnldCMCPROV(left));
ddCnldCmcprovSancRec	:=	DEDUP(pCnldCmcprovSancRec, ALL);

layouts.cmcsl	lTransformToCnldCMCSL(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.LIC_STATE	:=	'" "';
			self.SLNUM			:=	'"' + pInput.SANC_LICNBR	+	'"';
			self.LIC_TYPE		:=	'""';
			self.SRCE_UPDT	:=	'"INGXS"';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.SANC_UPDTE) > 1, pInput.SANC_UPDTE[7..10] + '-' + pInput.SANC_UPDTE[1..2] + '-' + pInput.SANC_UPDTE[4..5] + ' 00:00:00', '');
			self.ISSUEDATE	:=	'';
			self.EXPDATE		:=	'';
			self.CONTHRSREQ	:=	'';
			self.CONTHRSCMP	:=	'';
			self.SUPERVISOR	:=	'';
			self.ORIGINCODE	:=	'""';
			self.LIC_STATUS	:=	'""'; //Should something be here?
			self.DISPTYPE		:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.MATCHCNT		:=	'';
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

pCnldCmcslSancRec	:=	PROJECT(ddAllProvRecsIDed(SANC_LICNBR != ''), lTransformToCnldCMCSL(left));
ddCnldCmcslSancRec	:=	DEDUP(pCnldCmcslSancRec, ALL);

layouts.cmcprof lTransformToCnldCMCPROF(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.PROFCODE		:=	pInput.SANC_PROVTYPE;
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.CREATE_DT	:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.PROFSTAT		:=	'""';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.PROFPK			:=	'""';
		END
;

pCnldCmcprofSancRec		:=	PROJECT(ddAllProvRecsIDed, lTransformToCnldCMCPROF(left));
ddCnldCmcprofSancRec	:=	DEDUP(pCnldCmcprofSancRec, ALL);

layouts.cmlpvad	lTransformIngxToCnldCMLPVAD(layout_SanctionDBoutputIDed pInput)
	:=
		TRANSFORM
			self.GENNUM			:=	'"' + 'I' + INTFORMAT((INTEGER)pInput.ProviderID, 9, 1) + '"';
			self.ADDRID			:=	'"IA' + INTFORMAT(pInput.AddressID, 8, 1) + '"';
			self.EFF_DATE		:=	'';
			self.TERM_DATE	:=	'2900-01-01 00:00:00';
			self.TELEPHONE	:=	'0000000000';
			self.FAX_NUM		:=	'0000000000';
			self.FAX_SECURE	:=	'""';
			self.OFFICENAME	:=	'""';
			self.SRCE_UPDT	:=	'"INGXS"';
			self.DTSTAMP		:=	StringLib.GetDateYYYYMMDD()[1..4] + '-' + StringLib.GetDateYYYYMMDD()[5..6] + '-' + StringLib.GetDateYYYYMMDD()[7..8] + ' ' + '00:00:00';
			self.ADD_SRCE		:=	'""';
			self.LAST_UPDT	:=	IF(LENGTH(pInput.SANC_UPDTE) > 1, pInput.SANC_UPDTE[7..10] + '-' + pInput.SANC_UPDTE[1..2] + '-' + pInput.SANC_UPDTE[4..5] + ' 00:00:00', '');
			self.MATCHCNT		:=	'';
			self.NEW_ADDRID	:=	'""';
			self.BILLADDR		:=	'False';
			self.PRACADDR		:=	'False';
			self.HOMEADDR		:=	'False';
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

pCnldCmlpvadSancRec		:=	PROJECT(ddAllProvRecsIDed, lTransformIngxToCnldCMLPVAD(left));
ddCnldCmlpvadSancRec	:=	DEDUP(pCnldCmlpvadSancRec, ALL);

OUTPUT(ddCnldCmcaddSancRec, ,'~thor_200::out::cnld::cmcaddSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcdiscpSancRec, ,'~thor_200::out::cnld::cmcdiscpSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcfedSancRec, ,'~thor_200::out::cnld::cmcfedSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcprovSancRec, ,'~thor_200::out::cnld::cmcprovSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcslSancRec, ,'~thor_200::out::cnld::cmcslSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmcprofSancRec, ,'~thor_200::out::cnld::cmcprofSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
OUTPUT(ddCnldCmlpvadSancRec, ,'~thor_200::out::cnld::cmlpvadSanc.csv', CSV(SEPARATOR(','), TERMINATOR('\n')), OVERWRITE);
export mapping_cnldSanctions := '';