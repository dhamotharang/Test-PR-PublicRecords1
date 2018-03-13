// Remove requested records from FCRA. -- bug #132111
IMPORT	FCRA, STD, lib_date;
rmv_filing		:=	'(VACATE|TERMINATION|LIS PENDENS WITHDRAWAL|FORECLOSURE DISMISSED|FILED IN ERROR|FEDERAL COURT DISMISSAL|ERRONEOUS TERMINATION|'+
									'FEDERAL COURT CHANGE OF VENUE|DISMISSED JUDGMENT|COURT ORDER NO CHANGE|CIVIL DISMISSAL)';

dMainVacated	:=	LiensV2.file_liens_main(REGEXFIND(rmv_filing, filing_type_desc)	OR 
																					REGEXFIND(rmv_filing, filing_status[1].filing_status_desc)	OR 
																					REGEXFIND(rmv_filing, orig_filing_type));
dMainVacatedFiltered		:=	dMainVacated(	
															tmsid[..2]	IN	['HG','MA']	AND
															Orig_Filing_Date	<>	''		AND
															FCRA.lien_is_ok((STRING)STD.Date.Today(),Orig_Filing_Date)
														);
dFileLiensMainFiltered	:=	LiensV2.file_liens_main(
															tmsid[..2]	IN	['HG','MA']	AND
															Orig_Filing_Date	<>	''		AND
															FCRA.lien_is_ok((STRING)STD.Date.Today(),Orig_Filing_Date)
														);


EXPORT	file_liens_fcra_main	:=	JOIN(
																		DISTRIBUTE(dFileLiensMainFiltered,HASH(tmsid)),
																		DISTRIBUTE(dMainVacatedFiltered,HASH(tmsid)), 
																			LEFT.tmsid	=	RIGHT.tmsid, 
																		TRANSFORM(
																			liensv2.Layout_liens_main_module.layout_liens_main, 
																			SELF	:=	LEFT
																		),
																		LEFT ONLY,
																		LOCAL
																	):PERSIST('~thor_data400::persist::file_liens_fcra_main');
