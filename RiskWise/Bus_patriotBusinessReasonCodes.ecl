export Bus_patriotBusinessReasonCodes(orig_input, output_layout, cnt, OFAC) := MACRO

CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(output_layout.watchlist_table, output_layout.watchlist_record_number),DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode84(output_layout.cmpycount, output_layout.addrcount, output_layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, output_layout.phone10),
			DATASET([{'84',risk_indicators.getHRIDesc('84')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode86(orig_input.orig_cmpy, output_layout.vercmpy, output_layout.bestcompanyname), 
			DATASET([{'86',risk_indicators.getHRIDesc('86')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode87(output_layout.phone10, output_layout.CmpyPhoneFromAddr),DATASET([{'87',risk_indicators.getHRIDesc('87')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(output_layout.hriskaddrflag, output_layout.hrisksic, output_layout.hriskphoneflag, output_layout.hrisksic),DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(output_layout.addrvalidflag, orig_input.orig_addr, orig_input.orig_city, orig_input.orig_state, orig_input.orig_zip),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(output_layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode59(orig_input.orig_cmpy),DATASET([{'59',risk_indicators.getHRIDesc('59')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode63(output_layout.cmpyMiskeyFlag),DATASET([{'63',risk_indicators.getHRIDesc('63')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(output_layout.phonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(output_layout.addrMiskeyFlag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(output_layout.phone10),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(orig_input.orig_addr),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(if(output_layout.phonezipmismatch,'1','0')),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode58(output_layout.fein),DATASET([{'58',risk_indicators.getHRIDesc('58')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode88(orig_input.orig_cmpy, orig_input.orig_dba, output_layout.vercmpy),
			DATASET([{'88',risk_indicators.getHRIDesc('88')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode33(output_layout.addrcount, output_layout.cmpycount, output_layout.wphonecount, orig_input.orig_addr, orig_input.orig_cmpy, output_layout.phone10),
			DATASET([{'33',risk_indicators.getHRIDesc('33')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode47(output_layout.phonematchaddr, output_layout.veraddr, output_layout.PhoneMatchCompany, output_layout.vercmpy),
			DATASET([{'47',risk_indicators.getHRIDesc('47')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)


endmacro;

