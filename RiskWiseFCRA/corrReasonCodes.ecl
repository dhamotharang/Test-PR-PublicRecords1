export corrReasonCodes(flags, cnt) := 

MACRO

choosen(
	if(Risk_Indicators.rcSet.isCode91(flags.security_freeze),dataset([{'91',risk_indicators.getHRIDesc('91')}],risk_indicators.Layout_Desc)) &
	if(Risk_Indicators.rcSet.isCode92(flags.security_alert),dataset([{'92',risk_indicators.getHRIDesc('92')}],risk_indicators.Layout_Desc)) &
	if(Risk_Indicators.rcSet.isCode93(flags.id_theft_flag),dataset([{'93',risk_indicators.getHRIDesc('93')}],risk_indicators.Layout_Desc)) &
	if(Risk_Indicators.rcSet.isCode94(flags.dispute_flag),dataset([{'94',risk_indicators.getHRIDesc('94')}],risk_indicators.Layout_Desc)) &
	dataset([{'00',''}],risk_indicators.Layout_Desc) &
	dataset([{'00',''}],risk_indicators.Layout_Desc) &
	dataset([{'00',''}],risk_indicators.Layout_Desc) &
	dataset([{'00',''}],risk_indicators.Layout_Desc) &
	dataset([{'00',''}],risk_indicators.Layout_Desc) &
	dataset([{'00',''}],risk_indicators.Layout_Desc) ,	
cnt)
	
ENDMACRO;