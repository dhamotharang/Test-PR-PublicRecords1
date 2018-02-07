IMPORT	LiensV2_SrcInfoRpt,	FCRA, STD, lib_date;
// Remove requested records from FCRA. -- bug #132111
rmv_filing	:=	LiensV2.FCRAFilingTypeDescFilter;

//	Filter Main by Filing Types
dMainVacated	:=	LiensV2.file_liens_main(tmsid not in Liensv2.Suppress_TMSID(TRUE)	AND 
																																								(
																																									REGEXFIND(rmv_filing, filing_type_desc)	OR 
																																									REGEXFIND(rmv_filing, filing_status[1].filing_status_desc)	OR 
																																									REGEXFIND(rmv_filing, orig_filing_type)
																																								)
																																							);
//	Filter Main Vacated by Source Types (Hogan Only)
dMainVacatedFiltered	:=	dMainVacated(	
																									tmsid[..2]	IN	['HG']
																								);
//	Filter Main by Source Types (Hogan Only)
dMainSourceFiltered		:=	LiensV2.file_liens_main(tmsid not in Liensv2.Suppress_TMSID(true) and 
																									tmsid[..2]	IN	['HG']
																								);

//	Remove Main Records that have been Vacated
dMainVacatedRemoved		:=	JOIN(
																									DISTRIBUTE(dMainSourceFiltered,HASH(tmsid)),
																									DISTRIBUTE(dMainVacatedFiltered,HASH(tmsid)), 
																										LEFT.tmsid	=	RIGHT.tmsid, 
																									TRANSFORM(
																										liensv2.Layout_liens_main_module.layout_liens_main, 
																										SELF	:=	LEFT
																									),
																									LEFT ONLY,
																									LOCAL
																								):PERSIST('~thor_data400::persist::file_liens_fcra_main');


//	Set Medical Term Flag for Party records (orig_name contains a Medical Term in the field)
LiensV2.MAC_Remove_Medical_Terms(	
																																	LiensV2.File_Liens_Party_BIPV2_with_Linkflags(
																																		tmsid[..2]	IN	['HG']	AND
																																		name_type	IN	['C']
																																	),
																																	orig_name,
																																	dPartyHasMedicalTerms
																																);

//	Remove Main records by TMSID where the Party is associated with a Medical Term									
dMainRemoveMedicalTerms	:=	JOIN(
																												SORT(DISTRIBUTE(dMainVacatedRemoved,
																													HASH(	TMSID)),
																																TMSID,LOCAL),
																												DEDUP(SORT(DISTRIBUTE(dPartyHasMedicalTerms(bHasMedicalTerm),
																													HASH(	TMSID)),
																																TMSID,LOCAL),
																																TMSID,LOCAL),
																													LEFT.tmsid	=	RIGHT.tmsid,
																												TRANSFORM(LEFT),
																												LEFT ONLY,
																												LOCAL
																											);

//	Remove Main records by TMSID/RMSID from Jurisdictions are non-updating 				
dMainRemoveSuppressedJurisdictions	:=	JOIN(
																																							SORT(DISTRIBUTE(dMainRemoveMedicalTerms,
																																								HASH(	TMSID, RMSID)),
																																											TMSID, RMSID,LOCAL),
																																							SORT(DISTRIBUTE(LiensV2_SrcInfoRpt.fn_SuppressedFCRALiensMain,
																																								HASH(	TMSID, RMSID)),
																																											TMSID, RMSID,LOCAL),
																																								LEFT.tmsid	=	RIGHT.tmsid	AND
																																								LEFT.rmsid	=	RIGHT.rmsid,
																																							TRANSFORM(LEFT),
																																							LEFT ONLY,
																																							LOCAL
																																						);

//	Set bCBFlag for FCRA
dFillbCBFlag	:=	JOIN(
																	SORT(DISTRIBUTE(dMainRemoveSuppressedJurisdictions,
																		HASH(	TMSID,RMSID)),
																					TMSID,RMSID,LOCAL),
																	DEDUP(SORT(DISTRIBUTE(LiensV2.file_Hogan_party,
																		HASH(	TMSID,RMSID)),
																					TMSID,RMSID,bCBFlag,LOCAL), // We want any FALSE records at the top
																					TMSID,RMSID,LOCAL),
																		LEFT.tmsid	=	RIGHT.tmsid	AND
																		LEFT.rmsid	=	RIGHT.rmsid,
																	TRANSFORM(
																		RECORDOF(LEFT),
																		SELF.bCBFlag	:=	IF(RIGHT.tmsid<>'',RIGHT.bCBFlag,FALSE);
																		SELF					:=	LEFT;
																	),
																	LEFT OUTER,
																	LOCAL
																);

EXPORT	file_liens_fcra_main	:=	dFillbCBFlag;

