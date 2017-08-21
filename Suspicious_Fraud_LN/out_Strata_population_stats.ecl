import STRATA, suspicious_fraud_LN;

export out_STRATA_population_stats(string filedate) := function

pSSN := Suspicious_Fraud_LN.files.extract_SSN;
pAddress := Suspicious_Fraud_LN.files.extract_addr;
pPHONE := Suspicious_Fraud_LN.files.extract_phone;

rPopulationStats_pSSN
 :=
  record
    
	integer file_cnt := count(group);

cnt_S01 := COUNT(group, regexfind('S01',pSSN.suspicious_risk_code));
cnt_S02 := COUNT(group, regexfind('S02',pSSN.suspicious_risk_code));
cnt_S03 := COUNT(group, regexfind('S03',pSSN.suspicious_risk_code));
cnt_S04 := COUNT(group, regexfind('S04',pSSN.suspicious_risk_code));
cnt_S05 := COUNT(group, regexfind('S05',pSSN.suspicious_risk_code));
cnt_S06 := COUNT(group, regexfind('S06',pSSN.suspicious_risk_code));
cnt_S07 := COUNT(group, regexfind('S07',pSSN.suspicious_risk_code));
cnt_S10 := COUNT(group, regexfind('S10',pSSN.suspicious_risk_code));
cnt_S11 := COUNT(group, regexfind('S11',pSSN.suspicious_risk_code));
cnt_S12 := COUNT(group, regexfind('S12',pSSN.suspicious_risk_code));
cnt_S13 := COUNT(group, regexfind('S13',pSSN.suspicious_risk_code));

   
  end;
    
rPopulationStats_pAddress
 := record

integer file_cnt := count(group);

cnt_A01 := COUNT(group, regexfind('A01',pAddress.suspicious_risk_code));
cnt_A02 := COUNT(group, regexfind('A02',pAddress.suspicious_risk_code));
cnt_A03 := COUNT(group, regexfind('A03',pAddress.suspicious_risk_code));
cnt_A04 := COUNT(group, regexfind('A04',pAddress.suspicious_risk_code));
cnt_A07 := COUNT(group, regexfind('A07',pAddress.suspicious_risk_code));
cnt_A08 := COUNT(group, regexfind('A08',pAddress.suspicious_risk_code));
cnt_A09 := COUNT(group, regexfind('A09',pAddress.suspicious_risk_code));
cnt_A10 := COUNT(group, regexfind('A10',pAddress.suspicious_risk_code));
cnt_A11 := COUNT(group, regexfind('A11',pAddress.suspicious_risk_code));
cnt_A17 := COUNT(group, regexfind('A17',pAddress.suspicious_risk_code));
cnt_A18 := COUNT(group, regexfind('A18',pAddress.suspicious_risk_code));

end;

rPopulationStats_pPhone
 :=
  record  
	integer file_cnt := count(group);

cnt_P01 := COUNT(group, regexfind('P01',pPHONE.suspicious_risk_code));
cnt_P02 := COUNT(group, regexfind('P02',pPHONE.suspicious_risk_code));
cnt_P03 := COUNT(group, regexfind('P03',pPHONE.suspicious_risk_code));
cnt_P04 := COUNT(group, regexfind('P04',pPHONE.suspicious_risk_code));
cnt_P07 := COUNT(group, regexfind('P07',pPHONE.suspicious_risk_code));
cnt_P08 := COUNT(group, regexfind('P08',pPHONE.suspicious_risk_code));
cnt_P09 := COUNT(group, regexfind('P09',pPHONE.suspicious_risk_code));

  end;

//output SSN stats
	dPopulationStats_pSSN := table(pSSN,rPopulationStats_pSSN,few);

	STRATA.createXMLStats(dPopulationStats_pSSN
	                     ,'SuspiciousFraudLN'
						 ,'SSN'
						 ,filedate
						 ,''
						 ,zSSNStats
						 ,'view'
						 ,'Population');

//output Address stats
	dPopulationStats_pAddress := table(pAddress,rPopulationStats_pAddress,few);
	STRATA.createXMLStats(dPopulationStats_pAddress
	                     ,'SuspiciousFraudLN'
						 ,'Address'
						 ,filedate
						 ,''
						 ,zAddressStats
						 ,'view'
					 ,'Population');
					 
//output PHONE stats	
				 
dPopulationStats_pPHONE := table(pPHONE,rPopulationStats_pPHONE,few);
	STRATA.createXMLStats(dPopulationStats_pPHONE
	                     ,'SuspiciousFraudLN'
						 ,'PHONE'
						 ,filedate
						 ,''
						 ,zPHONEStats
						 ,'view'
					 ,'Population');

zOut := parallel(zSSNStats,zAddressStats,zPHONEStats);

return zOut;

end;