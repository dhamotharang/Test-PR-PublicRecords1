export verReasonCodes(layout, cnt, OFAC, soc) :=

MACRO

CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(layout.watchlist_table, layout.watchlist_record_number),DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(soc AND Risk_Indicators.rcSet.isCode19(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode20(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'20',risk_indicators.getHRIDesc('20')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode21(layout.lname, layout.phone10, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount),DATASET([{'21',risk_indicators.getHRIDesc('21')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode22(layout.lname, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount),DATASET([{'22',risk_indicators.getHRIDesc('22')}],risk_indicators.Layout_Desc)) &
	IF(soc AND Risk_Indicators.rcSet.isCode23(layout.ssn, layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'23',risk_indicators.getHRIDesc('23')}],risk_indicators.Layout_Desc)) &
	IF(soc AND Risk_Indicators.rcSet.isCode24(layout.in_streetAddress, layout.ssn, layout.combo_lastcount, layout.combo_addrcount, layout.combo_ssncount),DATASET([{'24',risk_indicators.getHRIDesc('24')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &
	IF(soc AND Risk_Indicators.rcSet.isCode26(layout.ssn, layout.combo_lastcount, layout.combo_addrcount, layout.combo_ssncount, true),DATASET([{'26',risk_indicators.getHRIDesc('26')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_hphonecount),DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &	
	IF(soc AND Risk_Indicators.rcSet.isCode01(layout.fname, layout.lname, layout.ssn, layout.phone10, layout.in_streetAddress),DATASET([{'01',risk_indicators.getHRIDesc('01')}],risk_indicators.Layout_Desc)) &
	IF(~soc AND Risk_Indicators.rcSet.isCode01a(layout.fname, layout.lname, layout.phone10, layout.in_streetAddress),DATASET([{'01',risk_indicators.getHRIDesc('01')}],risk_indicators.Layout_Desc)) &
	IF(soc AND Risk_Indicators.rcSet.isCode28(layout.combo_dobcount, layout.dob),DATASET([{'28',risk_indicators.getHRIDesc('28')}],risk_indicators.Layout_Desc)) &
	IF(soc AND Risk_Indicators.rcSet.isCode29(layout.socsmiskeyflag),DATASET([{'29',risk_indicators.getHRIDesc('29')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,	
cnt)
	
ENDMACRO;