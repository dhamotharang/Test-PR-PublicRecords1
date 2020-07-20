export reasonCodes(layout, cnt, rc_settings) := 
MACRO
CHOOSEN(
	IF(memberpoint.rcSet.isCode12(layout.addr_type) or memberpoint.rcSet.isCodePO(layout.zipclass), DATASET([{'PB',memberpoint.getHRIDesc('PB')}],memberpoint.layouts.Layout_Desc)) &	
  IF(Risk_Indicators.rcSet.isCodeCA(layout.ADVODropIndicator, layout.hrisksic) AND rc_settings[1].IIDVersion>=1,DATASET([{'CA',risk_indicators.getHRIDesc('CA')}],risk_indicators.Layout_Desc)) &
	IF(memberpoint.rcSet.isCode50(layout.hriskaddrflag, layout.hrisksic, layout.hriskphoneflag, layout.hrisksicphone),DATASET([{'50',memberpoint.getHRIDesc('50')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCodeZI(layout.combo_zipscore, true, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, 
																		layout.combo_hphonecount, layout.combo_ssncount) AND rc_settings[1].IsInstantID,DATASET([{'ZI',memberpoint.getHRIDesc('ZI')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCodeCZ(layout.statezipflag, layout.cityzipflag) AND rc_settings[1].IsInstantID,DATASET([{'CZ',memberpoint.getHRIDesc('CZ')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',memberpoint.getHRIDesc('11')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCode12(layout.zipclass),DATASET([{'12',memberpoint.getHRIDesc('12')}],memberpoint.layouts.Layout_Desc)) &	// COMMENTED OUT ON 9-20, THIS LOGIC IS INCORRECT
	IF(memberpoint.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',memberpoint.getHRIDesc('14')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCodeVA(layout.ADVOAddressVacancyIndicator) AND rc_settings[1].IIDVersion>=1,DATASET([{'VA',memberpoint.getHRIDesc('VA')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCodeCO(layout.zipclass) AND rc_settings[1].IsInstantID,DATASET([{'CO',memberpoint.getHRIDesc('CO')}],memberpoint.layouts.Layout_Desc)) &
	IF(memberpoint.rcSet.isCodeMO(layout.zipclass) AND rc_settings[1].IsInstantID,DATASET([{'MO',memberpoint.getHRIDesc('MO')}],memberpoint.layouts.Layout_Desc)) ,
cnt)
  




ENDMACRO;
