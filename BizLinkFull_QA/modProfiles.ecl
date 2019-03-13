EXPORT modProfiles := MODULE
  EXPORT dProfiles := DATASET([
		{'BC','SBFE',	0,	0,	75,	1}
 // , 	{'BC','SBFE',	0,	0,	75,	2}
 ,	{'RR','CORTERA',	0,	0,	75,	1}
 // ,	{'RR','CORTERA',	0,	0,	75,	2}
 ,	{'D','Dunn Bradstreet',	0, 0,	75,	1}
 // ,	{'D','Dunn Bradstreet',	0, 0,	75,	2}
 ,  {'SOS','CorpV2',	0,	0,	75,	1} //[CN, C*, CP, C0, CB, C8, CN, C_ and so on]
 // ,  {'SOS','CorpV2',	0,	0,	75,	2}
 ,  {'ER','Experian Business Reports',	0,	0,	75,	1}
 // ,  {'ER','Experian Business Reports',	0,	0,	75,	2}
 ,	{'Z1','Equifax Business Marketing File',	0,	0,	75,	1}
 // ,	{'Z1','Equifax Business Marketing File',	0,	0,	75,	2}
 ,	{'BA','Bankruptcy',	0,	0,	75,	1}
 // ,	{'BA','Bankruptcy',	0,	0,	75,	2}
 ,	{'L2','Judgement and Liens',	0,	0,	75,	1}
 // ,	{'L2','Judgement and Liens',	0,	0,	75,	2}
 ,	{'RP','Real Property',	0,	0,	75,	1} //[LA, LP, FA, FP]
 // ,	{'RP','Real Property',	0,	0,	75,	2}
 ,	{'BR','Business Registrations',	0,	0,	75,	1}
 // ,	{'BR','Business Registrations',	0,	0,	75,	2}
 ,	{'DN','Duns and Bradstreet FEIN',	0,	0,	75,	1}
 // ,	{'DN','Duns and Bradstreet FEIN',	0,	0,	75,	2}
 ,	{'E6','Experian FEIN Unrestricted',	0,	0,	75,	1}
 // ,	{'E6','Experian FEIN Unrestricted',	0,	0,	75,	2}
 ,	{'E5','Experian FEIN Restricted',	0,	0,	75,	1}
 // ,	{'E5','Experian FEIN Restricted',	0,	0,	75,	2}
 // ,	{'T1','BUSINESSCREDITREPORT',	0,	0,	75,	1}
 ,  {'T1','BUSINESSCREDITREPORT',	0,	0,	75,	2}
 // ,	{'T2','SMALLBUSINESSANALYTICS',	0,	0,	75,	1}
 ,  {'T2','SMALLBUSINESSANALYTICS',	0,	0,	75,	2}
 // ,  {'T3','SMALLBUSINESSBIPCOMBINEDREPORT',	0,	0,	75,	1}
 ,  {'T3','SMALLBUSINESSBIPCOMBINEDREPORT',	0,	0,	75,	2}
 // ,	{'T4','SMALLBUSINESSRISK',	0,	0,	75,	1}
 ,	{'T4','SMALLBUSINESSRISK',	0,	0,	75,	2}
 // ,	{'T5','BUSINESSINSTANTID2',	0,	0,	75,	1}
 ,	{'T5','BUSINESSINSTANTID2',	0,	0,	75,	2}
 // ,	{'T','TOPBUSINESS',	0,	0,	75,	1}
 ,	{'T','TOPBUSINESS',	0,	0,	75,	2}
 ,	{'T','TOPBUSINESS',	0,	0,	75,	3}
 // ,	{'P','PREFILL',	0,	0,	75,	1}
 ,	{'P','PREFILL',	0,	0,	75,	2}
 // ,	{'B#','BATCH',	0,	0,	75,	1}
 ,	{'B#','BATCH',	0,	0,	75,	2}
    ], modLayouts.profileRec);
END;
