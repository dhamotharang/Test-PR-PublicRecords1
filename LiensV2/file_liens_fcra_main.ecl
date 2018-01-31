IMPORT	LiensV2_SrcInfoRpt,	FCRA, STD, lib_date;
// Remove requested records from FCRA. -- bug #132111
rmv_filing		:=	'(VACATE|TERMINATION|LIS PENDENS WITHDRAWAL|FORECLOSURE DISMISSED|FILED IN ERROR|FEDERAL COURT DISMISSAL|ERRONEOUS TERMINATION|'+
									'FEDERAL COURT CHANGE OF VENUE|DISMISSED JUDGMENT|COURT ORDER NO CHANGE|CIVIL DISMISSAL|'+
									'HOSPITAL LIEN|HOSPITAL RELEASE|HOSPITAL WITHDRAWAL)';

//	Filter Main by Filing Types
dMainVacated	:=	LiensV2.file_liens_main(tmsid not in Liensv2.Suppress_TMSID(true) and 
																					(REGEXFIND(rmv_filing, filing_type_desc)	OR 
																					 REGEXFIND(rmv_filing, filing_status[1].filing_status_desc)	OR 
																					 REGEXFIND(rmv_filing, orig_filing_type)
																					 ));
//	Filter Main Vacated by Source Types (Hogan and Massachusetts Only)
dMainVacatedFiltered	:=	dMainVacated(	
														tmsid[..2]	IN	['HG','MA']
													);
//	Filter Main by Source Types (Hogan and Massachusetts Only)
dMainSourceFiltered		:=	LiensV2.file_liens_main(tmsid not in Liensv2.Suppress_TMSID(true) and
														tmsid[..2]	IN	['HG','MA']
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
																		tmsid[..2]	IN	['HG','MA']	AND
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


EXPORT	file_liens_fcra_main	:=	dMainRemoveSuppressedJurisdictions;

