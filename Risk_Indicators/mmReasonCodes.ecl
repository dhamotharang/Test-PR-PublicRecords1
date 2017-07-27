export mmReasonCodes(layout, cnt, OFAC, inCalif) :=

MACRO

CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(layout.watchlist_table),DATASET([{'32',risk_indicators.getHRIDesc(32)}],risk_indicators.Layout_Desc)) &
	IF(inCalif,DATASET([{'35',risk_indicators.getHRIDesc(35)}],risk_indicators.Layout_Desc)) &
	IF(inCalif,DATASET([{'00',''}],risk_indicators.Layout_Desc)) &
	IF(inCalif,DATASET([{'00',''}],risk_indicators.Layout_Desc)) &
	IF(inCalif,DATASET([{'00',''}],risk_indicators.Layout_Desc)) &
	IF(inCalif,DATASET([{'00',''}],risk_indicators.Layout_Desc)) &
	IF(inCalif,DATASET([{'00',''}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(layout.decsflag),DATASET([{'02',risk_indicators.getHRIDesc(2)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(layout.socsdobflag),DATASET([{'03',risk_indicators.getHRIDesc(3)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode19(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'19',risk_indicators.getHRIDesc(19)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode20(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'20',risk_indicators.getHRIDesc(20)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode21(layout.lname, layout.phone10, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount),DATASET([{'21',risk_indicators.getHRIDesc(21)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode22(layout.lname, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount),DATASET([{'22',risk_indicators.getHRIDesc(22)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode23(layout.ssn, layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'23',risk_indicators.getHRIDesc(23)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode24(layout.in_streetAddress, layout.ssn, layout.combo_lastcount, layout.combo_addrcount, layout.combo_ssncount),DATASET([{'24',risk_indicators.getHRIDesc(24)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc(25)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode26(layout.ssn, layout.combo_lastcount, layout.combo_addrcount, layout.combo_ssncount),DATASET([{'26',risk_indicators.getHRIDesc(26)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'27',risk_indicators.getHRIDesc(27)}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode06(layout.socsvalflag),DATASET([{'06',risk_indicators.getHRIDesc(6)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc(7)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.phonevalflag),DATASET([{'08',risk_indicators.getHRIDesc(8)}],risk_indicators.Layout_Desc)) &  // st. cloud checks the phonetype for this
	IF(Risk_Indicators.rcSet.isCode09(layout.hriskphoneflag),DATASET([{'09',risk_indicators.getHRIDesc(9)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.hriskphoneflag),DATASET([{'10',risk_indicators.getHRIDesc(10)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc(11)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12,DATASET([{'12',risk_indicators.getHRIDesc(12)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode13,DATASET([{'13',risk_indicators.getHRIDesc(13)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc(14)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc(15)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.phonezipflag),DATASET([{'16',risk_indicators.getHRIDesc(16)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode01(layout.fname, layout.lname, layout.ssn, layout.phone10, layout.in_streetAddress),DATASET([{'01',risk_indicators.getHRIDesc(1)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode29(layout.socsmiskeyflag),DATASET([{'29',risk_indicators.getHRIDesc(29)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc(30)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc(31)}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'37',risk_indicators.getHRIDesc(37)}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,	
cnt)
	
ENDMACRO;