EXPORT V2_Constants := MODULE
//these are states allowed
EXPORT setWatercraftStates := [
													'AL','AR','AZ','CO','CT','GA','IA','ME',
													'MA','MN','MS','NE','NY','NC','OH','TN',
													'TX','WV','WI','WY'
													];

//these are states allowed
EXPORT setVehicleStates := [
													'NE'
													];

//these are states restricted
EXPORT setCriminalStatesRes := [
														'CONNECTICUT'
														];

//these are states restricted
EXPORT setProfLicStatesRes := [
													'ID','KS','NM','IL','SC','WA'
													];
	
//these are states restricted
EXPORT setPropertyStatesRes := [
													'ID','KS','NM','IL','SC','WA'
													];

EXPORT recType := ENUM(
											 Prospect = 1,
											 Household = 2,
											 Relative = 3);
											 
											 
EXPORT setValidAttributeVersionsV2 := ['PROFILEBOOSTERATTRV2'];

EXPORT Max5       := 5;
EXPORT Max10      := 10;
EXPORT Max99      := 99;
EXPORT Max99_9    := 99.9;
EXPORT Max100_0   := 100.0;
EXPORT Max255     := 255;
EXPORT Max900     := 900;
EXPORT Max960     := 960;
EXPORT Max999     := 999;
EXPORT Max9999    := 9999;
EXPORT Max99999   := 99999;
EXPORT Max100000  := 100000;
EXPORT Max999999  := 999999;
EXPORT Max9999999 := 9999999; //nines
EXPORT Max999999999 := 999999999;
EXPORT Max999999999999999 := 999999999999999;

END;
