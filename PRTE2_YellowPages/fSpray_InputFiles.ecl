IMPORT prte2;

EXPORT fSpray_InputFiles := function

	RETURN PARALLEL(
										prte2.SprayFiles.Spray_Raw_Data('yellowpages__boca_', '', 'yellowpages'),
										prte2.SprayFiles.Spray_Raw_Data('yellowpages__INS_', '', 'yellowpages_ins')
									);

END;