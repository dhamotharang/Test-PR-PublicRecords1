IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                  prte2.SprayFiles.Spray_Raw_Data('UtilityDailyKeys__','utilitydaily','utility');
								  prte2.SprayFiles.Spray_Raw_Data('UtilityDailyKeysIns__','utilitydailyins','utility');
									);
								
END;



