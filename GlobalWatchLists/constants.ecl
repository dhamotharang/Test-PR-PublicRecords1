export	constants :=
MODULE
	
	export	string	Cluster	:=	'~thor_200::';
	
	export	unsigned1	MaxInputDataRows	:=	10;
	export	unsigned1	MaxOutputDataRows	:=	250;

	export	unsigned1	ThresholdAddressCandidate	:=	65;
	export	unsigned1	ThresholdAddressConflict	:=	65;
	export	unsigned1	ThresholdCountryScore			:=	85;
	export	unsigned1	ThresholdEntityScore			:=	85;
	export	unsigned1	ThresholdIDConflict				:=	80;
	export	unsigned1	ThresholdNameCandidate		:=	70;
	export	unsigned1	ThresholdPhoneConflict		:=	80;

	// OFAC Version 3 defines
	export	individual_code			:=	'I';
	export	non_individual_code	:=	'N';
	export	both_code						:=	'B';
	export	country_code				:=	'C';

	// Bridger Insight XG/Global Watch List V4 defines
	export	EntityTypeBusiness		:=	'B';
	export	EntityTypeIndividual	:=	'I';
	export	EntityTypeUnknown			:=	'U'; // for full name input entity could be a business or an individual
	export	EntityTypeVessel			:=	'V';
	
	export	GetEntityType(string1	sEntityType)	:=	FUNCTION
			return map( sEntityType	=	EntityTypeBusiness				=>	3,
									sEntityType	=	'C'	or	sEntityType	=	'V'	=>	3, 
									sEntityType	=	EntityTypeIndividual			=>	2,
									sEntityType	=	'P'												=>	2,
									1
								); // sEntityType	=	EntityTypeUnknown
	end;
	
	export	GetIDTypeCode(string	IDType)	:=	FUNCTION
		ucIDType	:=	trim(stringlib.stringtouppercase(IDType));
		return  (unsigned1) MAP(ucIDType	=	'ACCOUNT ID'						=>	1,
														ucIDType	=	'ABA ROUTING #'					=>	2,
														ucIDType	=	'ALIEN REGISTRATION #'	=>	3,
														ucIDType	=	'CEDULA'								=>	4,
														ucIDType	=	'CHIPS UID'							=>	5,
														ucIDType	=	'DRIVERS LICENSE'				=>	6,
														ucIDType	=	'DUNS #'								=>	7,
														ucIDType	=	'EFT CODE'							=>	8,
														ucIDType	=	'EIN'										=>	9,
														ucIDType	=	'IBAN'									=>	10,
														ucIDType	=	'MEMBER ID'							=>	11,
														ucIDType	=	'MILITARY ID'						=>	12,
														ucIDType	=	'NATIONAL ID'						=>	13,
														ucIDType	=	'NIT #'									=>	14,
														ucIDType	=	'OTHER ID'							=>	15,
														ucIDType	=	'PASSPORT'							=>	16,
														ucIDType	=	'SSN'										=>	17,
														ucIDType	=	'SWIFT BIC'							=>	18,
														ucIDType	=	'TAX ID'								=>	19,
														ucIDType	=	'VISA'									=>	20,
														0);
		END;

	export	GetIDTypeString(unsigned1	IDType)	:=	FUNCTION
		return 	MAP(IDType	=	1		=>	'Account ID',
								IDType	=	2		=>	'ABA Routing #',
								IDType	=	3		=>	'Alien Registration #',
								IDType	=	4		=>	'Cedula',
								IDType	=	5		=>	'CHIPS UID',
								IDType	=	6		=>	'Drivers License',
								IDType	=	7		=>	'DUNS #',
								IDType	=	8		=>	'EFT Code',
								IDType	=	9		=>	'EIN',
								IDType	=	10	=>	'IBAN',
								IDType	=	11	=>	'Member ID',
								IDType	=	12	=>	'Military ID',
								IDType	=	13	=>	'National ID',
								IDType	=	14	=>	'NIT #',
								IDType	=	15	=>	'Other ID',
								IDType	=	16	=>	'Passport',
								IDType	=	17	=>	'SSN',
								IDType	=	18	=>	'SWIFT BIC',
								IDType	=	19	=>	'Tax ID',
								IDType	=	20	=>	'Visa',
								'');
		END;
	
	export	InvalidVals	:=	['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];
	
END;