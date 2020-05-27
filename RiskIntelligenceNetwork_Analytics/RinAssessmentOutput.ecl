IMPORT RiskIntelligenceNetwork_Analytics;

RiskOutput := DATASET([{
	1,//  UNSIGNED8 record_id;
	3,//	INTEGER1 P1_IDRiskIndx;// 1
	1,//	INTEGER1 P15_SSNRiskIndx;// 15
	1,//	INTEGER1 P16_PhnRiskIndx;// 16
	1,//	INTEGER1 P17_EmailRiskIndx;// 17
	1,//	INTEGER1 P19_BnkAcctRiskIndx;// 19
	1,//	INTEGER1 P20_DLRiskIndx;// 20
	3,//	INTEGER1 P18_IPAddrRiskIndx;// 18
	1,// 	INTEGER1 P9_AddrRiskIndx;
	[
	 {
		1, //UNSIGNED entitytype;	
		'rule', //STRING100 rulename;
		'Identity is flagged as Known Risk', //STRING250 description;
		3 //INTEGER1 risklevel;
	 },
	 {
		9, //UNSIGNED entitytype;	
		'rule9', //STRING100 rulename;
		'Address is Vacant', //STRING250 description;
		3 //INTEGER1 risklevel;
	 }	 
	],
	[	
    {1,'p1_aotidkrstolidactflagev', '1', 'KR', 'Known Risk', 'Known Risk - Identity Theft', 3}, 
    {1,'t_evttype1statuscodeecho', '10000', 'KR', 'Known Risk', 'Identity theft: Confirmed stolen or compromised', 3}
	]
	}
	], FraudgovKELRoxie.Layouts.LayoutRiskScore);
	
	EXPORT RinAssessmentOutput := RiskOutput;
