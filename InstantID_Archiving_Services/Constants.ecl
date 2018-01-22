IMPORT ut, Risk_Indicators;

EXPORT Constants := MODULE 
	EXPORT	MAX_COUNT_RECORDS								:=	1000;
	EXPORT	Max_RECORD_COUNT								:=	2;
	EXPORT	Max_RISK_COUNT									:=	40;// usually there is only 20 risk indicators returned with a transaction so no need to do a 1000 in the atmost
	EXPORT  Max_Error_COUNT 								:= 250000;//225000; //works
//	EXPORT	string	ServiceURL						:=	'http://delta_iidarch_dev:[PASSWORD_REDACTED]@espdev64.sc.seisint.com:8501/WsDeltaBase/preparedsql?ver_=1';
	EXPORT  ForAll													:=  'ALL';
	EXPORT  Flexid			 										:=  'FLEXID';
	EXPORT  InstantId				 								:=  'INSTANTID';
	EXPORT  Both			 											:=  'BOTH';
	EXPORT  InstantIdIntrnatl				 				:=  'INSTANTID INTERNATIONAL';
	EXPORT  InputInstantIdIntrnatl				 	:=  'INSTANTIDINTERNATIONAL';
	EXPORT	Australia												:=	'AU';
	EXPORT	Austria												  :=	'AT';
	EXPORT	Brazil  												:=	'BR';
	EXPORT	Canada  												:=	'CA';
	EXPORT	China												    :=	'CN';
	EXPORT	Germany												  :=	'DE';
	EXPORT	HongKong												:=	'HK';
	EXPORT	Ireland												  :=	'IE';
	EXPORT	Japan												    :=	'JP';
	EXPORT	Luxembourg											:=	'LU';
	EXPORT	Mexico												  :=	'MX';
	EXPORT	Netherlands											:=	'NL';
	EXPORT	NewZealand											:=	'NZ';
	EXPORT	Singapore												:=	'SG';
	EXPORT	SouthAfrica											:=	'ZA';
	EXPORT	Switzerland											:=	'CH';
	EXPORT	UnitedKingdom										:=	'GB';
	EXPORT  Redflags			 									:=  'REDFLAGS';
	EXPORT  FraudPoint			 								:=  'FRAUDPOINT';
	
	//if change the cvi type from 0 to 00, then the match will need to change in the records/raw for the stats
	EXPORT ScoreTypes := DATASET([{'300',2},{'< 400',3},{'400 - 499',4},{'500 -  599',5},{'600 - 699',6},{'> 699',7},{'ALL',1}], Layouts.ScoreInfo);	
	EXPORT ScoreTypes_50 := DATASET([{'10',2}, {'20',3}, {'30',4}, {'40',5}, {'50',6}, {'ALL',1}], Layouts.ScoreInfo);
	EXPORT ScoreTypes_90 := DATASET([{'10',2}, {'20',3}, {'30',4}, {'40',5}, {'50',6}, {'60',7}, {'70',8}, {'80',9}, {'90',10}, {'ALL',1}], Layouts.ScoreInfo);

	EXPORT cviTypes := DATASET([{'0',0,0,2},{'10',0,0, 3},{'20',0,0, 4},{'30',0,0,5},{'40',0,0,6},{'50',0,0,7},{'ALL',0,0,1}], Layouts.cviInfo);	
	
	EXPORT iviTypes := DATASET([{'0',0,0,2},{'10',0,0, 3},{'20',0,0, 4},{'30',0,0,5},{'40',0,0,6},{'50',0,0,7},{'ALL',0,0,1}], Layouts.iviInfo);	
		
	EXPORT NasElements := DATASET([{'0','0 = Nothing found for input criteria',2},
			{'1','1 = Input SSN is associated with a different name and address',3},
			{'2','2 = Input First Name and Last Name matched',4},
			{'3','3 = Input First Name and Address matched',5},
			{'4','4 = Input First Name and SSN matched',6},
			{'5','5 = Input Last Name and Address matched',7},
			{'6','6 = Input Address and SSN matched',8},
			{'7','7 = Input Last Name and SSN matched',9},
			{'8','8 = Input First Name, Last Name and Address matched',10},
			{'9','9 = Input First Name, Last Name and SSN matched',11},
			{'10','10 = Input First Name, Address and SSN matched',12},
			{'11','11 = Input Last Name, Address and SSN matched',13},
			{'12','12 = Input First Name, Last Name, Address and SSN matched',14},
			{'13','',1} // Note: '13' must be converted to 'ALL' for customer use. 
			], Layouts.ElementsWithOrder	);				
	
	export NapElements := DATASET([{'0','0 = Nothing found for input criteria'},
			{'1','1 = Input phone is associated with a different name and address'},
			{'2','2 = Input First Name and Last Name matched'},
			{'3','3 = Input First Name and Address matched'},
			{'4','4 = Input First Name and Phone matched'},
			{'5','5 = Input Last Name and Address matched'},
			{'6','6 = Input Address and Phone matched'},
			{'7','7 = Input Last Name and Phone matched'},
			{'8','8 = Input First Name, Last Name and Address matched'},
			{'9','9 = Input First Name, Last Name and Phone matched'},
			{'10','10 = Input First Name, Address and Phone matched'},
			{'11','11 = Input Last Name, Address and Phone matched'},
			{'12','12 = Input First Name, Last Name, Address and Phone matched'}], Layouts.Elements	);		
	//Risk_Indicators.getHRIDesc has the descriptions but I need to hard code a definite list so when db doesn't return them they still appear

	export RiskIndicatorElements := DATASET([
			{'01' , Risk_Indicators.getHRIDesc( '01' )},
			{'02' , Risk_Indicators.getHRIDesc( '02' )},  
			{'03' , Risk_Indicators.getHRIDesc( '03' )},
			{'04' , Risk_Indicators.getHRIDesc( '04' )},
			{'05' , Risk_Indicators.getHRIDesc( '05' )},
			{'06' , Risk_Indicators.getHRIDesc( '06' )},
			{'07' , Risk_Indicators.getHRIDesc( '07' )},
			{'08' , Risk_Indicators.getHRIDesc( '08' )},
			{'09' , Risk_Indicators.getHRIDesc( '09' )},
			{'10' , Risk_Indicators.getHRIDesc( '10' )},
			{'11' , Risk_Indicators.getHRIDesc( '11' )},
			{'12' , Risk_Indicators.getHRIDesc( '12' )},
			{'13' , Risk_Indicators.getHRIDesc( '13' )},
			{'14' , Risk_Indicators.getHRIDesc( '14' )},
			{'15' , Risk_Indicators.getHRIDesc( '15' )},
			{'16' , Risk_Indicators.getHRIDesc( '16' )},
			{'17' , Risk_Indicators.getHRIDesc( '17' )},
																							
			{'19' , Risk_Indicators.getHRIDesc( '19' )},
			{'20' , Risk_Indicators.getHRIDesc( '20' )},
			{'21' , Risk_Indicators.getHRIDesc( '21' )},
			{'22' , Risk_Indicators.getHRIDesc( '22' )},
			{'23' , Risk_Indicators.getHRIDesc( '23' )},
			{'24' , Risk_Indicators.getHRIDesc( '24' )},
			{'25' , Risk_Indicators.getHRIDesc( '25' )},
			{'26' , Risk_Indicators.getHRIDesc( '26' )},
			{'27' , Risk_Indicators.getHRIDesc( '27' )},
			{'28' , Risk_Indicators.getHRIDesc( '28' )},
			{'29' , Risk_Indicators.getHRIDesc( '29' )},
			{'30' , Risk_Indicators.getHRIDesc( '30' )},
			{'31' , Risk_Indicators.getHRIDesc( '31' )},
			{'32' , Risk_Indicators.getHRIDesc( '32' )},
			{'33' , Risk_Indicators.getHRIDesc( '33' )},
			{'34' , Risk_Indicators.getHRIDesc( '34' )},
			{'35' , Risk_Indicators.getHRIDesc( '35' )},
			{'36' , Risk_Indicators.getHRIDesc( '36' )},
			{'37' , Risk_Indicators.getHRIDesc( '37' )},
			{'38' , Risk_Indicators.getHRIDesc( '38' )},
			{'39' , Risk_Indicators.getHRIDesc( '39' )},
			{'40' , Risk_Indicators.getHRIDesc( '40' )},
			{'41' , Risk_Indicators.getHRIDesc( '41' )}, 
			{'42' , Risk_Indicators.getHRIDesc( '42' )},
			{'43' , Risk_Indicators.getHRIDesc( '43' )},
			{'44' , Risk_Indicators.getHRIDesc( '44' )},
			{'45' , Risk_Indicators.getHRIDesc( '45' )},
			{'46' , Risk_Indicators.getHRIDesc( '46' )},
			{'47' , Risk_Indicators.getHRIDesc( '47' )},
			{'48' , Risk_Indicators.getHRIDesc( '48' )},
			{'49' , Risk_Indicators.getHRIDesc( '49' )},
			{'50' , Risk_Indicators.getHRIDesc( '50' )},
			{'51' , Risk_Indicators.getHRIDesc( '51' )},
			{'52' , Risk_Indicators.getHRIDesc( '52' )},
			{'53' , Risk_Indicators.getHRIDesc( '53' )},
			{'54' , Risk_Indicators.getHRIDesc( '54' )},
			{'55' , Risk_Indicators.getHRIDesc( '55' )},
			{'56' , Risk_Indicators.getHRIDesc( '56' )},
			{'57' , Risk_Indicators.getHRIDesc( '57' )},
			{'58' , Risk_Indicators.getHRIDesc( '58' )},
			{'59' , Risk_Indicators.getHRIDesc( '59' )},
			{'60' , Risk_Indicators.getHRIDesc( '60' )},
			{'61' , Risk_Indicators.getHRIDesc( '61' )},
			{'62' , Risk_Indicators.getHRIDesc( '62' )},
			{'63' , Risk_Indicators.getHRIDesc( '63' )},
			{'64' , Risk_Indicators.getHRIDesc( '64' )},
			{'65' , Risk_Indicators.getHRIDesc( '65' )},
			{'66' , Risk_Indicators.getHRIDesc( '66' )},
			{'67' , Risk_Indicators.getHRIDesc( '67' )},
			{'68' , Risk_Indicators.getHRIDesc( '68' )},
			{'69' , Risk_Indicators.getHRIDesc( '69' )},
			{'70' , Risk_Indicators.getHRIDesc( '70' )},
			{'71' , Risk_Indicators.getHRIDesc( '71' )},
			{'72' , Risk_Indicators.getHRIDesc( '72' )},
			{'73' , Risk_Indicators.getHRIDesc( '73' )},
			{'74' , Risk_Indicators.getHRIDesc( '74' )},
			{'75' , Risk_Indicators.getHRIDesc( '75' )},
			{'76' , Risk_Indicators.getHRIDesc( '76' )},
			{'77' , Risk_Indicators.getHRIDesc( '77' )},
			{'78' , Risk_Indicators.getHRIDesc( '78' )},
			{'79' , Risk_Indicators.getHRIDesc( '79' )},
			{'80' , Risk_Indicators.getHRIDesc( '80' )},
			{'81' , Risk_Indicators.getHRIDesc( '81' )},
			{'82' , Risk_Indicators.getHRIDesc( '82' )},
			{'83' , Risk_Indicators.getHRIDesc( '83' )},
			{'84' , Risk_Indicators.getHRIDesc( '84' )},
			{'85' , Risk_Indicators.getHRIDesc( '85' )},
			{'86' , Risk_Indicators.getHRIDesc( '86' )},
			{'87' , Risk_Indicators.getHRIDesc( '87' )},
			{'88' , Risk_Indicators.getHRIDesc( '88' )},
			{'89' , Risk_Indicators.getHRIDesc( '89' )},
			{'90' , Risk_Indicators.getHRIDesc( '90' )},
																							
			{'WL' , Risk_Indicators.getHRIDesc( 'WL' )},
			{'PO' , Risk_Indicators.getHRIDesc( 'PO' )},
			{'PA' , Risk_Indicators.getHRIDesc( 'PA' )},
			{'IT' , Risk_Indicators.getHRIDesc( 'IT' )},
			{'MI' , Risk_Indicators.getHRIDesc( 'MI' )},
																							
			{'CR' , Risk_Indicators.getHRIDesc( 'CR' )},
			{'MS' , Risk_Indicators.getHRIDesc( 'MS' )},
			{'MN' , Risk_Indicators.getHRIDesc( 'MN' )},
			{'PV' , Risk_Indicators.getHRIDesc( 'PV' )},
			{'EV' , Risk_Indicators.getHRIDesc( 'EV' )},
			{'SR' , Risk_Indicators.getHRIDesc( 'SR' )},
																							
			{'B0' , Risk_Indicators.getHRIDesc( 'B0' )},
			{'BO' , Risk_Indicators.getHRIDesc( 'BO' )},
																							
			{'CO' , Risk_Indicators.getHRIDesc( 'CO' )},
			{'MO' , Risk_Indicators.getHRIDesc( 'MO' )},
			{'ZI' , Risk_Indicators.getHRIDesc( 'ZI' )},
			{'CZ' , Risk_Indicators.getHRIDesc( 'CZ' )},
			{'DV' , Risk_Indicators.getHRIDesc( 'DV' )},
			{'DF' , Risk_Indicators.getHRIDesc( 'DF' )},
			{'DM' , Risk_Indicators.getHRIDesc( 'DM' )},
			{'DD' , Risk_Indicators.getHRIDesc( 'DD' )},
			{'RS' , Risk_Indicators.getHRIDesc( 'RS' )},
			{'IS' , Risk_Indicators.getHRIDesc( 'IS' )},
			{'CL' , Risk_Indicators.getHRIDesc( 'CL' )}
			], Layouts.Elements	);		

	EXPORT VerifiedElements := DATASET([{'0','First Name verified',0},
			{'1','Last Name verified',0},
			{'2','State verified',0},
			{'3','SSN verified',0},
			{'4','Zip verified',0},
			{'5','Street Address verified',0},
			{'6','City verified',0},
			{'7','DOB verified',0},
			{'8','Home phone verified',0},
			{'9','dl verified',0}], 
			Layouts.layout_cvi_element	);

	EXPORT DOBVerifiedElements := DATASET([{'0','N'},{'1','Y'}], Layouts.Elements	);

	EXPORT FraudAlertElement:= DATASET ([{'93' , Risk_Indicators.getHRIDesc( '93' ), '0'}], 
		Layouts.ElementsWithRF_id	);
			
	EXPORT CreditFreezeElement:= DATASET ([	{'91' , Risk_Indicators.getHRIDesc( '91' ), '1'}],
		Layouts.ElementsWithRF_id	);
	
	EXPORT AddressDiscrepancyElement := DATASET ([{'04' , Risk_Indicators.getHRIDesc( '04' ), '2'},
			{'25' , Risk_Indicators.getHRIDesc( '25' ), '2'},
			{'11' , Risk_Indicators.getHRIDesc( '11' ), '2'},
			{'30' , Risk_Indicators.getHRIDesc( '30' ), '2'},
			{'PA' , Risk_Indicators.getHRIDesc( 'PA' ), '2'},
			{'SR' , Risk_Indicators.getHRIDesc( 'SR' ), '2'},
			{'CZ' , Risk_Indicators.getHRIDesc( 'CZ' ), '2'},
			{'ZI' , Risk_Indicators.getHRIDesc( 'ZI' ), '2'}],
		Layouts.ElementsWithRF_id	);
		
	EXPORT SuspiciousDocsElement := DATASET ([{'06' , Risk_Indicators.getHRIDesc( '06' ), '3'},
			{'41' , Risk_Indicators.getHRIDesc( '41' ), '3'},
			{'DD' , Risk_Indicators.getHRIDesc( 'DD' ), '3'},
			{'DF' , Risk_Indicators.getHRIDesc( 'DF' ), '3'},
			{'DM' , Risk_Indicators.getHRIDesc( 'DM' ), '3'},
			{'DV' , Risk_Indicators.getHRIDesc( 'DV' ), '3'}],
		Layouts.ElementsWithRF_id	);
		
	EXPORT SuspiciousAddressElement := DATASET ([{'19' , Risk_Indicators.getHRIDesc( '19' ), '4'},
			{'04' , Risk_Indicators.getHRIDesc( '04' ), '4'},
			{'25' , Risk_Indicators.getHRIDesc( '25' ), '4'},
			{'30' , Risk_Indicators.getHRIDesc( '30' ), '4'},
			{'PA' , Risk_Indicators.getHRIDesc( 'PA' ), '4'},
			{'SR' , Risk_Indicators.getHRIDesc( 'SR' ), '4'},
			{'CZ' , Risk_Indicators.getHRIDesc( 'CZ' ), '4'},
			{'ZI' , Risk_Indicators.getHRIDesc( 'ZI' ), '4'}],
		Layouts.ElementsWithRF_id	);
	
	EXPORT SuspiciousSSNElement := DATASET ([{'02' , Risk_Indicators.getHRIDesc( '02' ), '5'},
			{'06' , Risk_Indicators.getHRIDesc( '06' ), '5'},
			{'29' , Risk_Indicators.getHRIDesc( '29' ), '5'},
			{'39' , Risk_Indicators.getHRIDesc( '39' ), '5'},
			{'71' , Risk_Indicators.getHRIDesc( '71' ), '5'},
			{'89' , Risk_Indicators.getHRIDesc( '89' ), '5'},
			{'90' , Risk_Indicators.getHRIDesc( '90' ), '5'},
			{'IT' , Risk_Indicators.getHRIDesc( 'IT' ), '5'},
			{'MS' , Risk_Indicators.getHRIDesc( 'MS' ), '5'}],
				Layouts.ElementsWithRF_id	);
	
		EXPORT SuspiciousDOBElement := DATASET ([{'03' , Risk_Indicators.getHRIDesc( '03' ), '6'},
			{'28' , Risk_Indicators.getHRIDesc( '28' ), '6'},
			{'83' , Risk_Indicators.getHRIDesc( '83' ), '6'}],
				Layouts.ElementsWithRF_id	);
	
		EXPORT HighRiskAddressElement := DATASET ([{'11' , Risk_Indicators.getHRIDesc( '11' ), '7'},
			{'12' , Risk_Indicators.getHRIDesc( '12' ), '7'},
			{'14' , Risk_Indicators.getHRIDesc( '14' ), '7'},
			{'50' , Risk_Indicators.getHRIDesc( '50' ), '7'},				
			{'CO' , Risk_Indicators.getHRIDesc( 'CO' ), '7'},
			{'MO' , Risk_Indicators.getHRIDesc( 'MO' ), '7'},
			{'PO' , Risk_Indicators.getHRIDesc( 'PO' ), '7'}],
				Layouts.ElementsWithRF_id	);
						
		EXPORT SuspiciousPhoneElement := DATASET ([{'07' , Risk_Indicators.getHRIDesc( '07' ), '8'},
			{'08' , Risk_Indicators.getHRIDesc( '08' ), '8'},
			{'09' , Risk_Indicators.getHRIDesc( '09' ), '8'},
			{'10' , Risk_Indicators.getHRIDesc( '10' ), '8'},
			{'15' , Risk_Indicators.getHRIDesc( '15' ), '8'},
			{'16' , Risk_Indicators.getHRIDesc( '16' ), '8'},
			{'27' , Risk_Indicators.getHRIDesc( '27' ), '8'},
			{'31' , Risk_Indicators.getHRIDesc( '31' ), '8'},
			{'49' , Risk_Indicators.getHRIDesc( '49' ), '8'},
			{'73' , Risk_Indicators.getHRIDesc( '73' ), '8'},
			{'74' , Risk_Indicators.getHRIDesc( '74' ), '8'}],
				Layouts.ElementsWithRF_id	);
		EXPORT SSNMultipleLastElement := DATASET ([	{'38' , Risk_Indicators.getHRIDesc( '38' ), '9'},
			{'66' , Risk_Indicators.getHRIDesc( '66' ), '9'},
			{'72' , Risk_Indicators.getHRIDesc( '72' ), '9'},
			{'MI' , Risk_Indicators.getHRIDesc( 'MI' ), '9'}],
					Layouts.ElementsWithRF_id	);
	
	EXPORT MIssingInputElement := DATASET ([{'77' , Risk_Indicators.getHRIDesc( '77' ), '10'},
			{'78' , Risk_Indicators.getHRIDesc( '78' ), '10'},
			{'79' , Risk_Indicators.getHRIDesc( '79' ), '10'},
			{'80' , Risk_Indicators.getHRIDesc( '80' ), '10'},
			{'81' , Risk_Indicators.getHRIDesc( '81' ), '10'}], 
				Layouts.ElementsWithRF_id	);
	
	EXPORT IdentityTheftElement:= DATASET ([{'93' , Risk_Indicators.getHRIDesc( '93' ), '11'}], 
		Layouts.ElementsWithRF_id	);

	EXPORT RedFlagElements := FraudAlertElement + 
					CreditFreezeElement + 
					AddressDiscrepancyElement + 
					SuspiciousDocsElement + 
					SuspiciousAddressElement + 	
					SuspiciousSSNElement + 
					SuspiciousDOBElement + 
					HighRiskAddressElement +
					SuspiciousPhoneElement + 
					SSNMultipleLastElement + 
					MIssingInputElement + 
					IdentityTheftElement;

	EXPORT RedFlagsNames := DATASET([{'0' , 'Fraud Alert'},
			{'1' , 'Credit Freeze'},
			{'2' , 'Address Discrepancy'},
			{'3' , 'Suspicious Documents'},
			{'4' , 'Suspicious Address'},
			{'5' , 'Suspicious SSN'},
			{'6' , 'Suspicious DOB'},
			{'7' , 'High Risk Address'},
			{'8' , 'Suspicious Phone'},
			{'9' , 'SSN Multiple Last'},
			{'10' , 'Missing input'},
			{'11' , 'Identity Theft'}], 
				Layouts.Elements	);

 EXPORT FraudRiskIndexes := DATASET([{'1', 'StolenIdentityIndex'},
		{'2', 'SyntheticIdentityIndex'},
		{'3', 'ManipulatedIdentityIndex'},
		{'4', 'VulnerableVictimIndex'},
		{'5', 'FriendlyFraudIndex'},
		{'6', 'SuspiciousActivityIndex'}],
			Layouts.Elements	); 
 
	EXPORT FraudRiskIndexTypes := DATASET([{'ALL', 'ALL'},{'1','1= Condition not triggered'},
		{'2','2= Lowest risk of fraud condition'},{'3','3'},{'4','4'},{'5','5'},
		{'6','6'},{'7','7'},{'8','8'},{'9','9= Highest risk of fraud condition'},
		{'99','99=Insufficent input data'}],
		Layouts.Elements);	

	EXPORT iidi_verifiedElements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','FullStreet'},
		{'4','UnitNumber'},
		{'5','StreetNumber'},
		{'6','StreetName'},
		{'7','StreetType'},
		{'8','PostalCode'},
		{'9','PhoneNumber'},//DateOfBirth
		{'10','DOB'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Australia_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','StreetNumber'},
		{'8','StreetName'},
		{'9','StreetType'},
		{'10','UnitNumber'},
		{'11','Suburb'},
		{'12','State'},
		{'13','PostalCode'},
		{'14','Telephone'},
		{'15','RTACardNumber'},
		{'16','DriverLicenceNumber'},
		{'17','DriverLicenceState'},
		{'18','YearOfExpiry'},
		{'19','MonthOfExpiry'},
		{'20','DayOfExpiry'},
		{'21','PassportNumber'},
		{'22','CountryOfBirth'},
		{'23','PlaceOfBirth'},
		{'24','FamilyNameAtBirth'},
		{'25','PassportYearOfExpiry'},
		{'26','PassportMonthOfExpiry'},
		{'27','PassportDayOfExpiry'}],
		Layouts.Elements);
		
	EXPORT iidi2_Austria_Elements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','HouseNumber'},
		{'7','StreetName'},
		{'8','City'},
		{'9','PostalCode'},
		{'10','Telephone'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Brazil_Elements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','Address1'},
		{'7','StreetNumber'},
		{'8','StreetName'},
		{'9','UnitNumber'},
		{'10','Suburb'},
		{'11','City'},
		{'12','State'},
		{'13','PostalCode'},
		{'14','Telephone'},
		{'15','NationalIDNumber'},
		{'16','Gender'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Canada_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','CivicNumber'},
		{'8','StreetName'},
		{'9','StreetType'},
		{'10','UnitNumber'},
		{'11','Municipality'},
		{'12','Province'},
		{'13','PostalCode'},
		{'14','Telephone'},
		{'15','SocialInsuranceNumber'}],
		Layouts.Elements);	
		 
	EXPORT iidi2_China_Elements := DATASET([
		{'1','GivenNames'},
		{'2','Surname'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','StreetNumber'},
		{'7','StreetName'},
		{'8','StreetType'},
		{'9','BuildingName'},
		{'10','BuildingNumber'},
		{'11','RoomNumber'},
		{'12','District'},
		{'13','County'},
		{'14','City'},
		{'15','Province'},
		{'16','Telephone'},
		{'17','NationalIDNumber'},
		{'18','CityofIssue'},
		{'19','DistrictofIssue'},
		{'20','CountyofIssue'},
		{'21','ProvinceofIssue'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Germany_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','MaidenName'},
		{'5','YearOfBirth'},
		{'6','MonthOfBirth'},
		{'7','DayOfBirth'},
		{'8','HouseNumber'},
		{'9','StreetName'},
		{'10','City'},
		{'11','Telephone'},
		{'12','PhoneNumber'},
		{'13','Gender'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Hong_Kong_Elements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','StreetName'},
		{'7','BuildingName'},
		{'8','BuildingNumber'},
		{'9','UnitNumber'},
		{'10','FloorNumber'},
		{'11','District'},
		{'12','City'},
		{'13','Telephone'},
		{'14','HongKongIDNumber'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Ireland_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','Address1'},
		{'8','City'},
		{'9','County'},
		{'10','Telephone'},
		{'11','PersonalPublicServiceNumber'}],
		Layouts.Elements);
		
	EXPORT iidi2_Japan_Elements := DATASET([
		{'1','FirstName'},
		{'2','Surname'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','AreaNumbers'},
		{'7','BuildingName'},
		{'8','AZA'},
		{'9','Municipality'},
		{'10','Prefecture'},
		{'11','PostalCode'},
		{'12','Telephone'},
		{'13','Gender'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Luxembourg_Elements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','HouseNumber'},
		{'7','StreetName'},
		{'8','City'},
		{'9','PostalCode'},
		{'10','Telephone'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Mexico_Elements := DATASET([
		{'1','FirstName'},
		{'2','FirstSurname'},
		{'3','SecondSurname'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','Address1'},
		{'8','City'},
		{'9','State'},
		{'10','PostalCode'},
		{'11','Telephone'},
		{'12','CURPIDNumber'},
		{'13','Gender'}],
		Layouts.Elements);	
		
	EXPORT iidi2_Netherlands_Elements := DATASET([
		{'1','GivenNames'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','HouseNumber'},
		{'8','StreetName'},
		{'9','HouseExtention'},
		{'10','City'},
		{'11','PostalCode'},
		{'12','Telephone'}],
		Layouts.Elements);	
		
	EXPORT iidi2_New_Zealand_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','HouseNumber'},
		{'8','StreetName'},
		{'9','StreetType'},
		{'10','UnitNumber'},
		{'11','Suburb'},
		{'12','City'},
		{'13','PostalCode'},
		{'14','Telephone'},
		{'15','DriverLicenceNumber'},
		{'16','DriverLicenceVersionNumber'}],
		Layouts.Elements);	

	EXPORT iidi2_Singapore_Elements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','StreetNumber'},
		{'7','StreetName'},
		{'8','StreetType'},
		{'9','BuildingName'},
		{'10','BlockNumber'},
		{'11','City'},
		{'12','PostalCode'},
		{'13','Telephone'},
		{'14','NRICNumber'}],
		Layouts.Elements);
		
	EXPORT iidi2_South_Africa_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','Address1'},
		{'8','Address2'},
		{'9','Suburb'},
		{'10','City'},
		{'11','Province'},
		{'12','PostalCode'},
		{'13','Telephone'},
		{'14','CellNumber'},
		{'15','WorkTelephone'},
		{'16','NationalIDNumber'}],
		Layouts.Elements);
		
	EXPORT iidi2_Switzerland_Elements := DATASET([
		{'1','FirstName'},
		{'2','LastName'},
		{'3','YearOfBirth'},
		{'4','MonthOfBirth'},
		{'5','DayOfBirth'},
		{'6','StreetName'},
		{'7','BuildingNumber'},
		{'8','UnitNumber'},
		{'9','City'},
		{'10','PostalCode'},
		{'11','Telephone'},
		{'12','Gender'}],
		Layouts.Elements);
		
	EXPORT iidi2_United_Kingdom_Elements := DATASET([
		{'1','FirstName'},
		{'2','MiddleName'},
		{'3','LastName'},
		{'4','YearOfBirth'},
		{'5','MonthOfBirth'},
		{'6','DayOfBirth'},
		{'7','StreetName'},
		{'8','StreetType'},
		{'9','BuildingName'},
		{'10','BuildingNumber'},
		{'11','UnitNumber'},
		{'12','City'},
		{'13','PostalCode'},
		{'14','Telephone'}],
		Layouts.Elements);

	EXPORT iidi_Matching_sources := DATASET([
		{'1','% Matching one or more sources'},
		{'2','% Matching one source'},
		{'3','% Matching two sources'},
		{'4','% Matching three or more sources'}],
				Layouts.Elements);	
	//get all possibilities needed for the index report
	EXPORT ds_Fraud_index_Possiblities := JOIN(FraudRiskIndexes, FraudRiskIndexTypes,
				TRUE,
				TRANSFORM(Layouts.risk_name_cnts, 
					SELF.Idx := RIGHT.Value,
					SELF.Name := LEFT.Description,
					SELF := []),
					LEFT OUTER, ALL, KEEP(MAX_COUNT_RECORDS));	
	//GET ALL possibilities for the NAS/NAP report and populate just the values we have
	EXPORT 	ds_nasnap_categories := JOIN(NasElements, NapElements,
					TRUE,
					TRANSFORM( Layouts.rec_NASNAPSummary_flat,
						SELF.NameAddressSSN := LEFT.value,
						SELF.NumberOfCases  := 0,
						SELF.NASPercent     := 0,
						SELF.Value          := RIGHT.value,
						SELF.NAPPercent     := 0,
						SELF.order 					:= LEFT.order
					),
					LEFT OUTER, ALL, KEEP(MAX_COUNT_RECORDS)
				);
				
	// First, associate all RedFlags categories to cvi values. We're using a join having no join
	// criteria to produce a Cartesian result.			
	EXPORT	ds_cvis_and_redflags := JOIN(cviTypes, RedFlagsNames,
				TRUE,
				TRANSFORM(Layouts.redflags_flat,
					SELF.cvi := LEFT.cvi,
					SELF.redflag_id := RIGHT.value,
					SELF.redflag_desc := RIGHT.description,
					SELF := []
				),
				LEFT OUTER, ALL, KEEP(MAX_COUNT_RECORDS)
			);	
			
		// Now, join the two datasets together. Note: rf = "RedFlag"; ri = "Risk Indicator".	
	EXPORT 	ds_all_categories := JOIN(
				ds_cvis_and_redflags, RedFlagElements,
				StringLib.StringToUppercase(LEFT.redflag_id) = StringLib.StringToUppercase(RIGHT.rf_id),
				TRANSFORM( Layouts.redflags_flat,
					SELF.value := RIGHT.value,
					SELF.description := RIGHT.description,
					SELF := LEFT
				),
				LEFT OUTER
			);
END;