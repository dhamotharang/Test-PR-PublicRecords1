import	PropertyCharacteristics; 

export	Code_Translations	:=
module

	// Common category code mapping
	export	CommonCategoryCode(string	pFieldName)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pFieldName),
																													'AIR_CONDITIONING_TYPE'	=>	'001',
																													'APPLIANCES_BUILT_IN'		=>	'004',
																													'BALCONY'								=>	'009',
																													'BASECOST'							=>	'017',
																													'BASEMENT_FINISH'				=>	'013',
																													'BATHROOM'							=>	'015',
																													'CONSTRUCTION_TYPE'			=>	'022',
																													'DECKS_PATIOS'					=>	'010',
																													'EXTERIOR_WALL'					=>	'005',
																													'FIREPLACE_TYPE'				=>	'008',
																													'FLOOR_COVER'						=>	'003',
																													'FOUNDATION_TYPE'				=>	'007',
																													'FRAME'									=>	'025',
																													'FUEL_TYPE'							=>	'020',
																													'GARAGE_TYPE'						=>	'021',
																													'HEATING_TYPE'					=>	'024',
																													'KITCHEN'								=>	'014',
																													'PARKING_TYPE'					=>	'012',
																													'PLUMBING'							=>	'018',
																													'POOL_TYPE'							=>	'027',
																													'PORCH'									=>	'011',
																													'ROOF_COVER_TYPE'				=>	'006',
																													'SEWER_TYPE'						=>	'026',
																													'STYLE_TYPE'						=>	'019',
																													'WALLS_CEILINGS'				=>	'002',
																													'WATER_TYPE'						=>	'016',
																													'ROOF_TYPE'							=>  '028',
																													''
																												);
	
	// Common category desc mapping
	export	CommonCategoryDesc(string	pCode)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pCode),
																											'002'	=>	'WALLS AND CEILINGS',
																											'004'	=>	'APPLIANCES, BUILT-IN',
																											'009'	=>	'BALCONY',
																											'010'	=>	'DECKS AND PATIOS',
																											'011'	=>	'PORCH',
																											'014'	=>	'KITCHEN',
																											'015'	=>	'BATHROOM',
																											'017'	=>	'BASECOST',
																											'018'	=>	'PLUMBING',
																											'022'	=>	'CONSTRUCTION TYPE',
																											'007'	=>	'FOUNDATION',
																											'005'	=>	'EXTERIOR WALL',
																											'003'	=>	'FLOORING',
																											'006'	=>	'ROOFING',
																											'025'	=>	'FRAME',
																											'019'	=>	'STYLE',
																											'013'	=>	'BASEMENT',
																											'021'	=>	'GARAGE',
																											'008'	=>	'FIREPLACE',
																											'024'	=>	'HEATING',
																											'020'	=>	'FUEL',
																											'001'	=>	'AIR CONDITIONING',
																											'027'	=>	'POOL',
																											'016'	=>	'WATER',
																											'026'	=>	'SEWER',
																											'012'	=>	'PARKING',
																											'028' =>  'ROOF TYPE',
																											''
																										);
	
	// Insurbase category code mapping
	export	IBCategoryCode(string	pCommonCategory)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pCommonCategory),
																														'016'	=>	'',
																														'019'	=>	'',
																														'020'	=>	'001',
																														'021'	=>	'012',
																														'022'	=>	'005',
																														'024'	=>	'001',
																														'025'	=>	'',
																														'026'	=>	'',
																														'027'	=>	'',
																														pCommonCategory
																													);
	
	// CodesV3 field name for common category
	export	CodesV3FieldName(string	pCommonCategory)	:=	case(	pCommonCategory,
																															'001'	=>	'AIR_CONDITIONING_TYPE',
																															'002'	=>	'WALLS_CEILINGS',
																															'003'	=>	'FLOOR_COVER',
																															'004'	=>	'APPLIANCES_BUILT_IN',
																															'005'	=>	'EXTERIOR_WALL',
																															'006'	=>	'ROOF_COVER_TYPE',
																															'007'	=>	'FOUNDATION_TYPE',
																															'008'	=>	'FIREPLACE_TYPE',
																															'009'	=>	'BALCONY',
																															'010'	=>	'DECKS_PATIOS',
																															'011'	=>	'PORCH',
																															'012'	=>	'PARKING_TYPE',
																															'013'	=>	'BASEMENT_FINISH',
																															'014'	=>	'KITCHEN',
																															'015'	=>	'BATHROOM',
																															'016'	=>	'WATER_TYPE',
																															'017'	=>	'BASECOST',
																															'018'	=>	'PLUMBING',
																															'019'	=>	'STYLE_TYPE',
																															'020'	=>	'FUEL_TYPE',
																															'021'	=>	'GARAGE_TYPE',
																															'022'	=>	'CONSTRUCTION_TYPE',
																															'024'	=>	'HEATING_TYPE',
																															'025'	=>	'FRAME',
																															'026'	=>	'SEWER_TYPE',
																															'027'	=>	'POOL_TYPE',
																															'028' =>  'ROOF_TYPE',
																															''
																														);
	
	// Condition code mapping
	export	Condition(string	pCondition)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pCondition),
																									'EXCELLENT'	=>	'1',
																									'GOOD'			=>	'2',
																									'AVERAGE'		=>	'3',
																									'FAIR'			=>	'4',
																									'POOR'			=>	'5',
																									'N/A'				=>	'0',
																									''
																								);
	
	// Condition description mapping
	export	ConditionDesc(string1	pCondition)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pCondition),
																											'1'	=>	'EXCELLENT',
																											'2'	=>	'GOOD',
																											'3'	=>	'AVERAGE',
																											'4'	=>	'FAIR',
																											'5'	=>	'POOR',
																											'0'	=>	'N/A',
																											''
																										);
	
	// Quality code mapping
	export	Quality(string	pQuality)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pQuality),
																							'BASIC'			=>	'1',
																							'BUILDER'		=>	'2',
																							'CUSTOM'		=>	'3',
																							'DESIGNER'	=>	'4',
																							''
																						);
	
	// Quality description mapping
	export	QualityDesc(string1	pQuality)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pQuality),
																									'1'	=>	'BASIC',
																									'2'	=>	'BUILDER',
																									'3'	=>	'CUSTOM',
																									'4'	=>	'DESIGNER',
																									''
																								);
	
	// Slope desc mapping
	export	SlopeDesc(string1	pSlope)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pSlope),
																							'1'	=>	'FLAT SURFACE',
																							'2'	=>	'MODERATE SLOPE',
																							'3'	=>	'STEEP SLOPE',
																							''
																						);
	
		
	// Function to populate the confidence factors
	export	unsigned	SetConfidenceFactor(string	pSource)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pSource),
																																		'FARES'	=>	300,
																																		'OKCTY'	=>	200,
																																		'MLS' 	=>	100,
																																		'MLS1'	=>	100,
																																		'MLS2'	=>	100,
																																		'MLS3'	=>	100,
																																		'MLS4'	=>	100,
																																		'INS1'	=>	100,
																																		'INS2'	=>	100,
																																		'APPR'	=>	100,
																																		'DEFLT'	=>	900,
																																		0
																																	);
	
	// Function to populate the source codes in the intermediate logs
	export	string	SetIntermediateSourceID(string	pSource)	:=	case(	PropertyCharacteristics_Services.Functions.fnClean2Upper(pSource),
																																			'FARES'	=>	'301',
																																			'OKCTY'	=>	'201',
																																			'MLS' 	=>	'101',
																																			'MLS1'	=>	'101',
																																			'MLS2'	=>	'102',
																																			'MLS3'	=>	'103',
																																			'MLS4'	=>	'104',
																																			'INS1'	=>	'105',
																																			'INS2'	=>	'106',
																																			'APPR'	=>	'107',
																																			'DEFLT'	=>	'901',
																																			''
																																		);

end;