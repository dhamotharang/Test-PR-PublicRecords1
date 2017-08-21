IMPORT COMPLIANCE, ut;


Incident_037430_SD_5A := DATASET('~thor400_92::in::compliance::Incident_037430_SD_5A',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	
EXPORT In_Incident_037430_SD_5A := Incident_037430_SD_5A;
