IMPORT COMPLIANCE, ut;


CASE_2014_000002B := DATASET('~thor400_92::in::compliance::case_2014_000002B',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	

EXPORT In_CASE_2014_000002B := CASE_2014_000002B;