IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN 				Parallel(prte2.SprayFiles.Spray_Raw_Data('EmailV2Event_Eventbase_','','emailevent');

						  prte2.SprayFiles.Spray_Raw_Data('EmailV2Event_Domainbase_','','emaildomain');
							);
END;