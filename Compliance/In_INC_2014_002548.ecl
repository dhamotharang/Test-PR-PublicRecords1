IMPORT COMPLIANCE, ut;


INC_2014_002548 := DATASET('~thor5_241_10a::in::compliance::inc_2014_002548',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	

EXPORT In_INC_2014_002548 := INC_2014_002548;