IMPORT	LiensV2,	LiensV2_SrcInfoRpt,	BIPV2,	FCRA,	STD,	lib_date;
// Remove requested records from FCRA. -- bug #132111
rmv_filing		:=	LiensV2.FCRAFilingTypeDescFilter;

//	Filter Main by Filing Types
dMainVacated	:=	LiensV2.file_liens_main(tmsid not in Liensv2.Suppress_TMSID(true) and 
																																								(
																																									REGEXFIND(rmv_filing, filing_type_desc)	OR 
																																									REGEXFIND(rmv_filing, filing_status[1].filing_status_desc)	OR 
																																									REGEXFIND(rmv_filing, orig_filing_type)
																																								)
																																							);
//	Filter Main by Source Types (Hogan Only)
dMainSourceFiltered	:=	dMainVacated(	
																																				tmsid[..2]	IN	['HG']
																																			);

//	Filter Party by Source Types (Hogan Only)
dPartySourceFilter	:=	LiensV2.File_Liens_Party_BIPV2_with_Linkflags(tmsid not in Liensv2.Suppress_TMSID(true) and
																																																																				tmsid[..2]	IN	['HG']
																																																																			);
														
//	Set Medical Term Flag for Party records (orig_name contains a Medical Term in the field)
LiensV2.MAC_Remove_Medical_Terms(	
																																	dPartySourceFilter(name_type	IN	['C']),
																																	orig_name,
																																	dSetMedicalTermFlag
																																);

//	Remove Party records by TMSID where the case is associated with a Medical Term									
dRemoveMedicalTermsByTMSID	:=	JOIN(
																															SORT(DISTRIBUTE(dPartySourceFilter,
																																HASH(	TMSID)),
																																			TMSID,LOCAL),
																															DEDUP(SORT(DISTRIBUTE(dSetMedicalTermFlag(bHasMedicalTerm),
																																HASH(	TMSID)),
																																			TMSID,LOCAL),
																																			TMSID,LOCAL),
																																LEFT.tmsid	=	RIGHT.tmsid,
																															TRANSFORM(LEFT),
																															LEFT ONLY,
																															LOCAL
																														);

//	Set LexID=0 for Party records that don't meet the Weight threshold.
dPartyFCRALexIDFilter	:=	PROJECT(	
																										dRemoveMedicalTermsByTMSID,
																										TRANSFORM(
																											RECORDOF(LEFT),
																											SELF.did	:=	IF((UNSIGNED)LEFT.did	>	0 AND 
																																				(	LEFT.xadl2_weight >=	32 AND (LEFT.xadl2_distance	>=	9 OR LEFT.xadl2_distance	=	0)	OR
																																					LEFT.xadl2_weight	=	0	)
																																			,LEFT.did
																																			,INTFORMAT(0,LENGTH(LEFT.did),1)
																																		);
																											SELF	:=	LEFT;
																										)
																								);

//	Remove Main records by TMSID/RMSID from Jurisdictions are non-updating 				
dPartyRemoveSuppressedJurisdictions	:=	JOIN(
																																								SORT(DISTRIBUTE(dPartyFCRALexIDFilter,
																																									HASH(	TMSID, RMSID)),
																																												TMSID, RMSID,LOCAL),
																																								SORT(DISTRIBUTE(LiensV2_SrcInfoRpt.fn_SuppressedFCRALiensMain,
																																									HASH(	TMSID, RMSID)),
																																												TMSID, RMSID,LOCAL),
																																									LEFT.tmsid	=	RIGHT.tmsid	AND
																																									LEFT.rmsid	=	RIGHT.rmsid,
																																								TRANSFORM(
																																									{LiensV2.file_liens_party,BIPV2.IDlayouts.l_xlink_ids}, 
																																									SELF	:=	LEFT
																																								),
																																								LEFT ONLY,
																																								LOCAL
																																							);

//	Remove Party Records that match Main records that have been filtered.
dPartyRemoveMainSourceFiltered	:=	JOIN(
																																			DISTRIBUTE(dPartyRemoveSuppressedJurisdictions,HASH(tmsid)),
																																			DISTRIBUTE(dMainSourceFiltered,HASH(tmsid)), 
																																				LEFT.tmsid	=	RIGHT.tmsid,
																																			TRANSFORM(LEFT),
																																			LEFT ONLY,
																																			LOCAL
																																		):PERSIST('~thor_data400::persist::file_liens_fcra_party');
									
EXPORT	file_liens_fcra_party	:=	dPartyRemoveMainSourceFiltered;