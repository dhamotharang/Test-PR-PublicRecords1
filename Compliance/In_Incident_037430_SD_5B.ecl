IMPORT COMPLIANCE, ut;


Incident_037430_SD_5B := DATASET('~thor400_92::in::compliance::Incident_037430_SD_5B',
																		Compliance.Layout_In,
																		CSV(HEADING(1)
																				,SEPARATOR(['|'])
																				,TERMINATOR(['\r\n'])
																				,QUOTE(['\"'])
																				,MAXLENGTH(50000)
																	));
																	
EXPORT In_Incident_037430_SD_5B := Incident_037430_SD_5B;
