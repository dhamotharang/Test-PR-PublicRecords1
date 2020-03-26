import FBNV2, Scrubs, Scrubs_FBNV2;

EXPORT RunScrubsOnInput(string source, string filedate, string leMailTarget) := FUNCTION

runScrubs := 																 
							map(trim(source,left,right) = 'ORANGE' => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_CA_Orange_Input', 'Input_CA_Orange', fileDate,leMailTarget),		
								trim(source,left,right) = 'SAN_DIEGO'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_CA_San_Diego_Input', 'Input_CA_San_Diego', fileDate,leMailTarget),
								trim(source,left,right) = 'SANTA_CLARA'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_CA_Santa_Clara_Input', 'Input_CA_Santa_Clara', fileDate,leMailTarget),		
								trim(source,left,right) = 'VENTURA'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_CA_Ventura_Input', 'Input_CA_Ventura', fileDate,leMailTarget),
								trim(source,left,right) = 'EVENT'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_FL_Event_Input', 'Input_FL_Event', fileDate,leMailTarget),		
								trim(source,left,right) = 'FILING'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_FL_Filing_Input', 'Input_FL_Filing', fileDate,leMailTarget),		
								trim(source,left,right) = 'HARRIS'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_TX_Harris_Input', 'Input_TX_Harris', fileDate,leMailTarget));	
																 
return runScrubs;																 
																 
END;