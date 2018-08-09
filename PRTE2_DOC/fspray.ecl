IMPORT prte2;

EXPORT fSpray := FUNCTION

//Verify that the file names for the logical file, the second parameter, matches your IN superfile name.  It should be blank
//if you only have one input file to spray.
return parallel(
																prte2.SprayFiles.Spray_Raw_Data('DOCKeysOffenses', 'offenses', 'corrections'),

																prte2.SprayFiles.Spray_Raw_Data('DOCKeysCourtOffenses', 'CourtOffenses', 'corrections'),

																prte2.SprayFiles.Spray_Raw_Data('DOCKeysOffenders', 'offenders', 'corrections'),

																prte2.SprayFiles.Spray_Raw_Data('DOCKeysPunishment', 'punishment', 'corrections'),

																prte2.SprayFiles.Spray_Raw_Data('DOCKeysActivity', 'activity', 'corrections')
															);	

END;