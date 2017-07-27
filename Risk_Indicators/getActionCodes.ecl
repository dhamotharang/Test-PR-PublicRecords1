export getActionCodes(layout, cnt, nasL, NAP, OFAC = TRUE, ADTL_WATCHLISTS = TRUE, ac_settings ) := 

MACRO

CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(layout.watchlist_table, layout.watchlist_record_number),
	   DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(layout.addr_type) AND ac_settings[1].IsPOBoxCompliant,
	   DATASET([{'F',risk_indicators.getFUADesc('F')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(layout.decsflag) OR Risk_Indicators.rcSet.isCode03(layout.socsdobflag) OR Risk_Indicators.rcSet.isCode06(layout.socsvalflag, layout.ssn) OR 
	   Risk_Indicators.rcSet.isCode04(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
							    layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount) OR 
	   Risk_Indicators.rcSet.isCode45(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
				   layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount) OR 
	   Risk_Indicators.rcSet.isCode38(layout.altlast, layout.socscount, layout.lastcount, layout.altlast2, layout.correctlast<>'') OR Risk_Indicators.rcSet.isCode72((string)layout.socsverlevel, layout.ssn, layout.ssnExists, layout.lastssnmatch2) OR
	   nasL<=6 OR nasL=8 OR nasL=10,
	   DATASET([{'B',risk_indicators.getFUADesc('B')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIT(layout.ssn),
	   DATASET([{'G',risk_indicators.getFUADesc('G')}],risk_indicators.Layout_Desc)) &	 
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag) OR Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10) OR Risk_Indicators.rcSet.isCode09(layout.nxx_type) OR 
	   Risk_Indicators.rcSet.isCode10(layout.nxx_type) OR Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag) OR Risk_Indicators.rcSet.isCode41(layout.drlcvalflag) OR 
	   Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode) OR 
	   Risk_Indicators.rcSet.isCode45(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
							    layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount) OR
	   (nasL<=4 AND (NAP<=4 OR NAP IN [6,7,9,10])) OR (nasL=5 AND (NAP IN [9,10])) OR (nasL=6 AND (NAP<=4 OR NAP IN [6,7,9,10])) OR (nasL=7 AND (NAP<=4 OR NAP IN [6,7,9,10])) OR 
	   (nasL=8 AND (NAP IN [7,9])) OR (nasL=9 AND (NAP<=4 OR NAP IN [6,7,9,10])) OR (nasL=10 AND NAP<=4) OR (nasL=11 AND (NAP<=4 OR NAP IN [6,7,9,10])) OR
		 ( Risk_Indicators.rcSet.isCodePA(layout.inputAddrNotMostRecent) AND ac_settings[1].IsInstantID ) ,
	   DATASET([{'C',risk_indicators.getFUADesc('C')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag) OR Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10) OR Risk_Indicators.rcSet.isCode16(layout.phonezipflag) OR 
	   Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag) OR 
	   Risk_Indicators.rcSet.isCode45(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
							    layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount) OR 
	   (nasL IN [0,1,2,5,7,8,9,12] AND (NAP<=5 OR NAP=8)) OR (nasL IN [3,4] AND (NAP<=3 OR NAP IN [5,8])) OR (nasL IN [6,10] AND (NAP IN [5,8])),
	   DATASET([{'D',risk_indicators.getFUADesc('D')}],risk_indicators.Layout_Desc)) &
	IF(ADTL_WATCHLISTS AND Risk_Indicators.rcSet.isCodeWL(layout.watchlist_table, layout.watchlist_record_number),
	   DATASET([{'E',risk_indicators.getFUADesc('E')}],risk_indicators.Layout_Desc)),
cnt)

ENDMACRO;