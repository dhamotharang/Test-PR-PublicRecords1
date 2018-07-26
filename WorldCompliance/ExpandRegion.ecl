import std;
IsUSA(unicode countryName) := CountryName in 
	['U.S.A.', 'United States of America','United states of America','United States',
		'USA'];
		
AustralianRegions(unicode region) := CASE(region,
'ACT' => 'Australian Capital Territory',
'NSW' => 'New South Wales',
'NT' => 'Northern Territory',
'QLD' => 'Queensland',
'SA' => 'South Australia',
'TAS' => 'Tasmania',
'VIC' => 'Victoria',
'WA' => 'Western Australia',
region);
	
ItalianRegions(unicode region) := CASE(region,
'CR' => 'Cremona',
'CT' => 'Catania',
region);

BrazilianRegions(unicode region) := CASE(region,
'BA' => 'Bahia',
'RJ' => 'Rio de Janeiro',
'SP' => U'São Paulo',
region);

CanadianRegions(unicode region) := CASE(STD.Uni.FilterOut(region,'.'),
'ON' => 'Ontario',
'QC' => 'Quebec',
'NS' => 'Nova Scotia',
'NB' => 'New Brunswick',
'MB' => 'Manitoba',
'BC' => 'British Columbia',
'PE' => 'Prince Edward Island',
'PEI' => 'Prince Edward Island',
'SK' => 'Saskatchewan',
'AB' => 'ALberta',
'NL' => 'Newfoundland',
region);

UKRegions(unicode region) := MAP(
region in ['E1','E2','E3','E4','E5','E6','E7'] => 'London',
region in ['EN1','EN2','EN3'] => 'Enfield',
region in ['EN4','EN5'] => 'Barnet',
region = 'EN6' => 'Potters Bar',
region in ['W9','W10','W11','W12'] => 'London',
region);

SwissRegions(unicode region) := CASE(region,
'GE' => 'Geneva',
'ZH' => 'Zurich',
'VD' => 'Vaud',
region);

FilipinoRegions(unicode region) := CASE(region,
'NCR' => 'Metro Manila',
region);


EXPORT unicode ExpandRegion(unicode country, unicode region) := 

	MAP(
		IsUSA(Country) => St2Name(region),
		Country IN ['Australia','Austrila'] => AustralianRegions(region),
		Country='Canada' => CanadianRegions(region),
		Country='Italy' => ItalianRegions(region),
		Country='United Kingdom' => UKRegions(region),
		Country in ['Brazil','Brasil'] => BrazilianRegions(region),
		Country='Switzerland' => SwissRegions(region),
		Country in ['Phillipines','Philippines'] => FilipinoRegions(region),
		St2Name(region)
	);
