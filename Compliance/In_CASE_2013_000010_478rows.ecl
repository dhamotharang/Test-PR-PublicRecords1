IMPORT COMPLIANCE, ut;


CASE_2013_000010_478rows := DATASET(ut.foreign_dataland+'~thor40_241_7::in::compliance::CASE_2013_000010_478rows',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	


EXPORT In_CASE_2013_000010_478rows := CASE_2013_000010_478rows;



