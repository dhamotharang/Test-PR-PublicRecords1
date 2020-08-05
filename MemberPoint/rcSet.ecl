﻿import ut, models,risk_indicators;

todays_date := (string) risk_indicators.iid_constants.todaydate;

export rcSet := MODULE

export isCode11(STRING addrvalflag, STRING inStreetAddr, STRING inCity, STRING inState, STRING inZip) := addrvalflag='N' and ((inStreetAddr<>'' and inCity<>'' and inState<>'') or 
																									(inStreetAddr<>'' and inZip<>''));
export isCode12(STRING zipclass) := zipclass='P'; 
export isCode14(STRING hriskaddrflag) := hriskaddrflag = '4';
export isCode25(STRING inAddr, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := inAddr<>'' and comboaddrcount=0 and 
																					~(combolastcount=0 and comboaddrcount=0 and combohphonecount=0 and combossncount=0);// not rc19
export isCode50(STRING hriskaddrflag, STRING hrisksic, STRING hriskphoneflag, STRING hrisksicphone) := (hriskaddrflag='4' AND hrisksic = '2225') /*OR (hriskphoneflag='6' AND hrisksicphone = '2225')*/;													  
export isCodePO(string addrtype) := trim(StringLib.StringToUpperCase(addrtype)) = 'P';
export isCodeMI(unsigned adls_per_ssn_seen_18months ) := adls_per_ssn_seen_18months >= 3;
export isCodeCA(STRING ADVODropIndicator, STRING SIC) := ADVODropIndicator='C' or SIC in risk_indicators.iid_constants.setCRMA;
export isCodeCO(STRING zipclass) := zipclass = 'U';
export isCodeMO(STRING zipclass) := zipclass = 'M';
export isCodeCZ(string statezipflag, string cityzipflag) := statezipflag='1' or cityzipflag='1';  // if either state or city are mismatch, trigger the code
export isCodeVA(BOOLEAN ADVOAddressVacancyIndicator) := ADVOAddressVacancyIndicator=TRUE;
export isCodeZI(integer zip_score, boolean with25, STRING inAddr, UNSIGNED1 combolastcount, UNSIGNED1 comboaddrcount, UNSIGNED1 combohphonecount, UNSIGNED1 combossncount) := function
	               zip_unverified := zip_score < 100;
	// if ZI reason code is in the same set as 25, don't trigger ZI if 25 is already returned
	               zipcheck := if(with25, 
								 zip_unverified and ~isCode25(inAddr, combolastcount, comboaddrcount, combohphonecount, combossncount), 
							   zip_unverified);
	return zipcheck;
end;																							
END;
