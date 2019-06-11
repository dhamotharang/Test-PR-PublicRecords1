
IMPORT Strata, tools;

EXPORT Strata_Population_Stats(STRING pVersion,
															 BOOLEAN pIsTesting	= FALSE ) := FUNCTION //to post strata to orbit, 
															                                          //set pIsTesting = FALSE. 
																																				//Then down stream code will post to strata.
	
	Strata.mac_Pops(Infutor_NARC3.Files.base,	dostats);
		
  Strata.mac_CreateXMLStats(dostats, _Dataset().Name, 'consumer', pVersion, Email_Notification_Lists().Stats,
	                             poststats, 'View', 'Population', , pIsTesting);		
		
	RETURN poststats;	
	
	END;
	
	