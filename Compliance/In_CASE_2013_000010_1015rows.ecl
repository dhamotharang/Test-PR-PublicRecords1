IMPORT COMPLIANCE, ut;


CASE_2013_000010_1015rows := DATASET('~thor400_92::in::compliance::CASE_2013_000010_1015rows',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	


EXPORT In_CASE_2013_000010_1015rows := CASE_2013_000010_1015rows;



