//Idaho Mortgage Lender Files for MARI Professional License
import Prof_License_Mari;

EXPORT spray_IDS0658 := MODULE

	#workunit('name','Spray IDS0658');
	SHARED STRING7 code						:= 'IDS0658';

	//  Spray All Files
	EXPORT S0658_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'Mari Mortgage List.csv', 'mortgage','comma'); 		
			              Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'MariICC List.csv', 'icc','comma'); 		
										);

	END;

END;
