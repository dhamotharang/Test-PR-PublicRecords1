import iesp;
export Constants := module
	export NamePartType := 
		ENUM(unsigned1, 
				 FirstName,
				 MiddleName,
				 Patronymic, 
				 Matronymic, 				 
				 Title,
				 Suffix,
				 Unknown);
				 
	export SET OF STRING20 NamePartTypeText := [
			'FirstName', 'MiddleName', 'Patronymic', 'Matronymic', 'Title','Suffix', 'Unknown'
			];
			
	export SET OF unicode NameSuffixes  := [ u'JR',u'II',u'III',u'IV'];		
	export SET OF unicode NameTitles 		:= [ u'MR', u'MS'];		
	
	export STRING	 NPConnectorRegexStr := '(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |DAS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DEL NINO |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA |Y )';
	export UNICODE NPConnectorRegex := u'(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |DAS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DEL NIÃ‘O |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA |Y )';
	export PATTERN NPConnector 			:= PATTERN(u'(ET |SAN |SANTA |LOS |DE DI |VON DER |DON |DOS |DAS |ZUM |DALLA |DE DE LOS |DE DE LA |DE LA |DE DE |DE DEL |D LA |VON |DE LE |DE S C |DE DE LA |DE A LA |A LA |DE LA DE LA |DA LA |DE SC |DEL LA |DE LAS |DE LOS |DEL LOS |DE SAN |DEL SAN |DE S |DEL PERPETUO |DE LOS TRES |DE J Y |DEL SAGRADO CORAZON DE |DEL SAGRADO |DEL NUESTRA |DE NUESTRA |DEL NIÃ‘O |DE |BAS |BEN |DEL |LES |LEZ |LA |EL |DA |DI |WIDOW OF |VIUDA |Y )');
	export PATTERN NPalphaend 			:= PATTERN('[A-Z]+');
	export PATTERN NPalphamiddle 		:= PATTERN('[A-Z\\-\']+');

	export PATTERN NPalphans := NPalphaend OPT( NPalphamiddle NPalphaend) ;
	export PATTERN NPName :=OPT(NPConnector) NPalphans;
	export rule NPPossibleNames := NPName;			
	
	// ****************************************
  // SEARCH KEYS			
	// ****************************************
	
	// Search type defined as: 
	// 	FLM=FIRST, LAST (PATERNAL), MATERNAL
	// 	LMX=LAST(PATERNAL), MATERNAL, DONT CARE
	// 	FMX=FIRST, MATERNAL, DONT CARE
	export SearchType := ENUM(unsigned1, FLM, LMX, FMX);	

	// ****************************************
  // SEARCH FILTERS			
	// ****************************************	
	export NatureType := ENUM(unsigned1, PENAL, CONSTRUCTIVE_PENAL, AMBIDEXTROUS, CIVIL, Q, X, UNKNOWN);	
	
	export NatureTypeDesc := dataset([
		{NatureType.PENAL, 							'CRIMINAL PENAL'},	
		{NatureType.CONSTRUCTIVE_PENAL, 'CONSTRUCTIVE PENAL'},	
		{NatureType.AMBIDEXTROUS, 			'AMBIDEXTROUS'},	
		{NatureType.CIVIL, 							'CIVIL'},	
		{NatureType.Q, 									'Q'},	
		{NatureType.X, 									'X'},	
		{NatureType.UNKNOWN, 						'UNKNOWN'}
		],{unsigned1 type; string20 desc;});
	
	export MapToNatureType(string20 nature) := function
		return map(
				nature='PENAL' 		=> NatureType.PENAL,
				nature='CRIMINAL' => NatureType.PENAL,
				nature='CIVIL' 		=> NatureType.CIVIL,
				0
			);	
	end;
	
	export MXStates := dataset([
				{'AGUASCALIENTES', 			'AGU'},
				{'BAJA CALIFORNIA', 		'BCN'},
				{'BAJA CALIFORNIA SUR', 'BCS'},
				{'CAMPECHE', 						'CAM'},
				{'CHIAPAS', 						'CHP'},
				{'CHIHUAHUA',						'CHH'},
				{'COAHUILA',						'COA'},
				{'COLIMA',							'COL'},
				{'DISTRITO FEDERAL',		'DIF'},
				{'DURANGO',							'DUR'},
				{'GUANAJUATO',					'GUA'},
				{'GUERRERO',						'GRO'},
				{'HIDALGO',							'HID'},
				{'JALISCO',							'JAL'},
				{'MEXICO',							'MEX'},
				{'MICHOACAN',						'MIC'},
				{'MORELOS',							'MOR'},
				{'NAYARIT',							'NAY'},
				{'NUEVO LEON',					'NLE'},
				{'OAXACA',							'OAX'},
				{'PUEBLA',							'PUE'},
				{'QUERETARO',						'QUE'},
				{'QUINTANA ROO',				'ROO'},
				{'SAN LUIS POTOSI',			'SLP'},
				{'SINALOA',							'SIN'},
				{'SONORA',							'SON'},
				{'TABASCO',							'TAB'},
				{'TAMAULIPAS',					'TAM'},
				{'TLAXCALA',						'TLA'},
				{'VERACRUZ',						'VER'},
				{'YUCATAN',							'YUC'},
				{'ZACATECAS',						'ZAC'}
				],{string50 name; string3 code});
	
	export ProfCategories := ENUM(unsigned1, ADMINISTRATION, CPA, DENTAL, IT, LEGAL, MEDICAL, NURSING, ENGINEERING, EDUCATION, FINANCIAL, MARKETING, UNKNOWN);

	export CategoryTypeDesc := dataset([
		{ProfCategories.ADMINISTRATION, 'ADMINISTRATION'},	
		{ProfCategories.CPA, 						'CPA'},	
		{ProfCategories.DENTAL, 				'DENTAL PROFESSIONS'},	
		{ProfCategories.IT, 						'INFORMATION TECH'},	
		{ProfCategories.LEGAL, 					'LEGAL PROFESSIONS'},	
		{ProfCategories.MEDICAL, 				'MEDICAL PROFESSIONS'},	
		{ProfCategories.NURSING, 				'NURSING PROFESSIONS'},
		{ProfCategories.ENGINEERING, 		'ENGINEERING'},
		{ProfCategories.EDUCATION, 			'EDUCATIONAL'},
		{ProfCategories.FINANCIAL, 			'FINANCIAL'},
		{ProfCategories.MARKETING, 			'MARKETING'},
		{ProfCategories.UNKNOWN, 				'UNKNOWN'}
		],{unsigned1 type; string20 desc;});
		
	export MapToCategoryType(string20 category) := function
		return map(
			category='ADMINISTRATION' 	=> ProfCategories.ADMINISTRATION,
			category='CPA'							=> ProfCategories.CPA,
			category='DENTAL'						=> ProfCategories.DENTAL,
			category='IT'								=> ProfCategories.IT,
			category='LEGAL'						=> ProfCategories.LEGAL,
			category='MEDICAL'					=> ProfCategories.MEDICAL,
			category='NURSING'					=> ProfCategories.NURSING,
			category='ENGINEERING'			=> ProfCategories.ENGINEERING,
			category='EDUCATION'				=> ProfCategories.EDUCATION,
			category='FINANCIAL'				=> ProfCategories.FINANCIAL,
			category='MARKETING'				=> ProfCategories.MARKETING,
			0	
			);
	end;
	
	export Limits := module
		export unsigned4 MAX_FETCH 	 						 := 2000;
		export unsigned4 MAX_RESULTS 					 	 := iesp.Constants.INTERNATIONALDOCKET_MAX_COUNT_SEARCH_RESPONSE_RECORDS;		
		export unsigned4 MAX_AKAS_PER_ENTITY 		 := iesp.Constants.INTERNATIONALDOCKET_MAX_COUNT_AKAS;
		export unsigned4 MAX_DOCKETS_PER_ENTITY	 := iesp.Constants.INTERNATIONALDOCKET_MAX_COUNT_DOCKETS;
		export unsigned4 MAX_CERT_PER_ENTITY 	 	:= iesp.Constants.INTERNATIONALPROFCERT_MAX_COUNT_CERTIFICATIONS;
	end;
	
end;
