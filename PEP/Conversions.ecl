export Conversions := module
//////////////////////////////////////////////////////////////////////////
export string SourceCodeToName(string code) := 
case(TRIM(code,ALL),
	'USP1021' =>	'US PEP',
	'PEP1020' =>	'PEP List',
	// due diligence
	'EUL1098' => 'EDD United States State Legal',
	'EUA1100' => 'EDD United States Agencies',
	'EDC1102' => 'EDD Canada',
	'EDE1104' => 'EDD Europe Middle East Africa',
	'EDA1106' => 'EDD Asia Pacific Australia',
	'ESA1108' => 'EDD South America Central America',
	'EDI1110' => 'EDD International',
	'EUK1112' => 'EDD United Kingdom',
	code
);

//////////////////////////////////////////////////////////////////////////
export string SourceCodetoDescr(string code) := 
case(TRIM(code,ALL),
	'PEP1020' =>	'PEP List powered by WorldCompliance',
	'USP1021' =>	'US PEP List powered by WorldCompliance',
	// due diligence
	'EUL1098' => 'EDD United States State Legal',
	'EUA1100' => 'EDD United States Agencies',
	'EDC1102' => 'EDD Canada',
	'EDE1104' => 'EDD Europe Middle East Africa',
	'EDA1106' => 'EDD Asia Pacific Australia',
	'ESA1108' => 'EDD South America Central America',
	'EDI1110' => 'EDD International',
	'EUK1112' => 'EDD United Kingdom',
	code
);

//////////////////////////////////////////////////////////////////////////
export string SourceCodetoBridgerSourceID(string code) := 
case(code,
	'PEP1020' =>	'90A1422B-0367-4687-8D2D-558625C8A438',
	'USP1021' =>	'57BBA373-EE5C-4792-9337-27CCB231DA99',
	// due diligence
	'EUL1098' => 'DE9E5C64-E254-42A2-8A92-00F8612E2489',
	'EUA1100' => 'F0520FCF-78AC-44B8-ACC7-D4546F46C131',
	'EDC1102' => '6FE2FD16-7B0C-4801-85F6-780C53B22AD9',
	'EDE1104' => 'D92E87BF-B610-469D-B780-A3E828074269',
	'EDA1106' => '6AB3729F-36FD-475E-8F83-487C05B7B51F',
	'ESA1108' => 'A3315680-5313-45A2-AD86-7C72CE2882E3',
	'EDI1110' => 'BF607088-EDBB-427E-8ACB-6EBE195AFBD7',
	'EUK1112' => '84CF1844-2D06-4B40-B861-7FE4DA9DD4B9',
								'00000000-0000-0000-0000-000000000000'
	);

end;
