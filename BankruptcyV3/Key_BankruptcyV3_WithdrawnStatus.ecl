﻿IMPORT	BankruptcyV3,	BankruptcyV2,	FCRA,	STD, vault, _control;


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
EXPORT	Key_BankruptcyV3_WithdrawnStatus(	STRING	pVersion	=	(STRING8)Std.Date.Today(),
																					BOOLEAN	pUseProd	=	FALSE,
																					BOOLEAN	isFCRA		=	FALSE)	:=	vault.BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(pversion,pUseProd, isFCRA);
#ELSE
																					
EXPORT	Key_BankruptcyV3_WithdrawnStatus(	STRING	pVersion	=	(STRING8)Std.Date.Today(),
																					BOOLEAN	pUseProd	=	FALSE,
																					BOOLEAN	isFCRA		=	FALSE)	:=	FUNCTION
	//	Only include records that have been WITHDRAWN
	dWithdrawnStatus					:=	File_BankruptcyV3_WithdrawnStatus(,pUseProd).wsBase(WithdrawnID<>'');
	dWithdrawnStatusDedup			:=	DEDUP(SORT(DISTRIBUTE(dWithdrawnStatus,
																	HASH(	TMSID,CaseID,DefendantID)),
																				TMSID,CaseID,DefendantID,-LastUpdatedDate,LOCAL),
																				TMSID,CaseID,DefendantID,LOCAL);
																		
	dWithdrawnStatusSlim			:=	PROJECT(dWithdrawnStatusDedup,Layout_BankruptcyV3_WithdrawnStatus.wsKey);
  pTodaysDate						:=	(STRING8)Std.Date.Today();
	dBKSearchLinkIDs			:=	BankruptcyV2.file_bankruptcy_search_v3_bip(~IsFCRA OR FCRA.bankrupt_is_ok(pTodaysDate,process_date));
	dBKSearchLinkIDsDist	:=	DEDUP(SORT(DISTRIBUTE(dBKSearchLinkIDs(name_type='D' AND debtor_type='P'),	// D=Debtor, P=Primary
																	HASH(	TMSID,CaseID,DefendantID)),
																				TMSID,CaseID,DefendantID,-(UNSIGNED)did,LOCAL),
																				TMSID,CaseID,DefendantID,LOCAL);
	dWSWithLinkIDs		:=	JOIN(
													dBKSearchLinkIDsDist,
													dWithdrawnStatusSlim,
														LEFT.TMSID				=	RIGHT.TMSID		AND
														LEFT.CaseID				=	RIGHT.CaseID	AND
														LEFT.DefendantID	=	RIGHT.DefendantID,
													TRANSFORM(
														RECORDOF(RIGHT),
														SELF.did	:=	(UNSIGNED6)LEFT.did;
														SELF			:=	RIGHT;
													),
													RIGHT OUTER,
													LOCAL
												);
																
	dWSWithLinkIDsDist	:=	SORT(DISTRIBUTE(dWSWithLinkIDs,HASH(TMSID,CaseID,DefendantID)),TMSID,CaseID,DefendantID,LOCAL);
	key_name						:=	Keynames(pVersion,pUseProd,isFCRA).WithdrawnStatus.QA;

	RETURN	INDEX(dWSWithLinkIDsDist,{TMSID,CaseID,DefendantID},{dWSWithLinkIDsDist},key_name);
END;

#END;