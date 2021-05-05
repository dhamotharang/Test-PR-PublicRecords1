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
EXPORT setValidAttributeVersionsV2 := ['PROFILEBOOSTERATTRV2'];

EXPORT setAttributesForUnscorableRollup := ['HHTEENAGERMMBRCNT',
'HHYOUNGADULTMMBRCNT',
'HHMIDDLEAGEMMBRCNT',
'HHSENIORMMBRCNT',
'HHELDERLYMMBRCNT',
'HHMMBRAGEMED',
'HHMMBRAGEAVG',
'HHCOMPLEXTOTALCNT',
'HHUNITSINCOMPLEXCNT',
'HHMMBRCNT',
'HHMMBRWEDUCOLLCNT',
'HHMMBRWEDUCOLLEVIDEVCNT',
'HHMMBRWEDUCOLL2YRCNT',
'HHMMBRWEDUCOLL4YRCNT',
'HHMMBRWEDUCOLLGRADCNT',
'HHMMBRWCOLLPVTCNT',
// 'HHMMBRCOLLTIERHIGHEST',
'HHMMBRCOLLTIERAVG',
'HHMMBRWASTPROPCURRCNT',
'HHASTPROPCURRCNT',
// 'HHMMBRPROPAVMMAX',
'HHMMBRPROPAVMAVG',
'HHMMBRPROPAVMTOT',
'HHMMBRPROPAVMTOT1Y',
'HHMMBRPROPAVMTOT5Y',
'HHVEHICLEOWNEDCNT',
'HHAUTOOWNEDCNT',
'HHMOTORCYCLEOWNEDCNT',
'HHAIRCRAFTOWNEDCNT',
'HHWATERCRAFTOWNEDCNT',
'HHMMBRWINTSPORTCNT',
'HHPURCHNEWAMT',
'HHPURCHTOTEV',
'HHPURCHCNTEV',
'HHPURCHNEWMSNC',
'HHPURCHOLDMSNC',
'HHPURCHITEMCNTEV',
'HHPURCHAMTAVG'];

END;
