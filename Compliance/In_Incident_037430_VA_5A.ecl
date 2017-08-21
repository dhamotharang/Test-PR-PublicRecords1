IMPORT COMPLIANCE, ut;


Incident_037430_VA_5A := DATASET(ut.foreign_dataland+'~thor40_241_7::in::compliance::Incident_037430_VA_5A',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	
EXPORT In_Incident_037430_VA_5A := Incident_037430_VA_5A;