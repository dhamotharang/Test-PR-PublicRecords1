EXPORT Constants := MODULE
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
											 
											 
EXPORT setValidAttributeVersions := ['PBATTRV1', 'PBATTRV1HHEIR'];

EXPORT TeamEmailList			  := 'a&rdata.engineering.support@lexisnexisrisk.com';
EXPORT QC_email_target			  := 'InsDataOps@lexisnexis.com, a&rdata.engineering.support@lexisnexisrisk.com,Todd.Steil@lexisnexisrisk.com,Michele.Walklin@lexisnexisrisk.com,David.Schlangen@lexisnexisrisk.com,Kevin.Huls@lexisnexisrisk.com';

EXPORT ECL_Developers_Slim :=  
										'Todd.Steil@lexisnexisrisk.com,' + 
										'Michele.Walklin@lexisnexisrisk.com,' + 
										'David.Schlangen@lexisnexisrisk.com,' + 
										'Kevin.Huls@lexisnexisrisk.com,' +
                    'Matthew.Ludewig@lexisnexisrisk.com,' +
										'';	

END;
