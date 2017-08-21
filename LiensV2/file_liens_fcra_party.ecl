IMPORT	LiensV2,	BIPV2,	FCRA,	STD,	lib_date;
// Remove requested records from FCRA. -- bug #132111
rmv_filing		:=	'(VACATE|TERMINATION|LIS PENDENS WITHDRAWAL|FORECLOSURE DISMISSED|FILED IN ERROR|FEDERAL COURT DISMISSAL|ERRONEOUS TERMINATION|'+
									'FEDERAL COURT CHANGE OF VENUE|DISMISSED JUDGMENT|COURT ORDER NO CHANGE|CIVIL DISMISSAL|'+
									'HOSPITAL LIEN|HOSPITAL RELEASE|HOSPITAL WITHDRAWAL)';

//	Filter Main by Filing Types
dMainVacated	:=	LiensV2.file_liens_main(REGEXFIND(rmv_filing, filing_type_desc)	OR 
																					REGEXFIND(rmv_filing, filing_status[1].filing_status_desc)	OR 
																					REGEXFIND(rmv_filing, orig_filing_type));
//	Filter Main by Source Types (Hogan and Massachusetts Only)
dMainSourceFiltered	:=	dMainVacated(	
															tmsid[..2]	IN	['HG','MA']
														);

//	Filter Party by Source Types (Hogan and Massachusetts Only)
dPartySourceFilter	:=	LiensV2.File_Liens_Party_BIPV2_with_Linkflags(
													tmsid[..2]	IN	['HG','MA']
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

//	Remove Party Records that match Main records that have been filtered.
EXPORT	file_liens_fcra_party	:=	JOIN(
																		DISTRIBUTE(dPartyFCRALexIDFilter,HASH(tmsid)),
																		DISTRIBUTE(dMainSourceFiltered,HASH(tmsid))  , 
																			LEFT.tmsid	=	RIGHT.tmsid,
																		TRANSFORM(
																			{LiensV2.file_liens_party,BIPV2.IDlayouts.l_xlink_ids}, 
																			SELF	:=	LEFT
																		),
																		LEFT ONLY,
																		LOCAL
																	):PERSIST('~thor_data400::persist::file_liens_fcra_party');
									
