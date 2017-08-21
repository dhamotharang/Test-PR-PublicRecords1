IMPORT COMPLIANCE, ut;


CASE_2014_000002B_origLexID := DATASET(ut.foreign_dataland+'thor5_241_10a::in::compliance::case_2014_000002b_origlexid',
																		Compliance.Layout_raw,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	
EXPORT In_CASE_2014_000002B_origLexID := CASE_2014_000002B_origLexID;