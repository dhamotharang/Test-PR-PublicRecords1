import FBNV2, Scrubs, Scrubs_FBNV2;

EXPORT RunScrubsOnInput(string source, string filedate, string leMailTarget) := FUNCTION

runScrubs := 																 
							map(trim(source,left,right) = 'ORANGE' => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Orange', 'Input_CA_Orange', fileDate,leMailTarget),		
								trim(source,left,right) = 'SAN_DIEGO'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_San_Diego', 'Input_CA_San_Diego', fileDate,leMailTarget),
								trim(source,left,right) = 'SANTA_CLARA'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Santa_Clara', 'Input_CA_Santa_Clara', fileDate,leMailTarget),		
								trim(source,left,right) = 'VENTURA'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Ventura', 'Input_CA_Ventura', fileDate,leMailTarget),
								trim(source,left,right) = 'EVENT'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_FL_Event', 'Input_FL_Event', fileDate,leMailTarget),		
								trim(source,left,right) = 'FILING'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_FL_Filing', 'Input_FL_Filing', fileDate,leMailTarget),		
								trim(source,left,right) = 'HARRIS'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_TX_Harris', 'Input_TX_Harris', fileDate,leMailTarget));	
																 
return runScrubs;																 
																 
END;