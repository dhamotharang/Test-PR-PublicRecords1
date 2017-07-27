export Bus_reasonCodes(orig_input, output_layout, cnt, OFAC, tribcode) := MACRO

CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(output_layout.watchlist_table, output_layout.watchlist_record_number),DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode60(output_layout.cmpycount, output_layout.addrcount, output_layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone),
														DATASET([{'60',risk_indicators.getHRIDesc('60')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode61(output_layout.cmpycount, output_layout.addrcount, output_layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone),
														DATASET([{'61',risk_indicators.getHRIDesc('61')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode62(output_layout.cmpycount, output_layout.addrcount, output_layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone),
														DATASET([{'62',risk_indicators.getHRIDesc('62')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode65(output_layout.addrcount, orig_input.orig_addr, output_layout.cmpycount),DATASET([{'65',risk_indicators.getHRIDesc('65')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode67(output_layout.wphonecount, orig_input.orig_wphone, output_layout.cmpycount),DATASET([{'67',risk_indicators.getHRIDesc('67')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(output_layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(orig_input.telcophonetype, orig_input.orig_wphone),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &  
	IF(Risk_Indicators.rcSet.isCode11(output_layout.addrvalidflag, orig_input.orig_addr, orig_input.orig_city, orig_input.orig_state, orig_input.orig_zip),
														DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(if(output_layout.phonezipmismatch, '1', '0')),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode01b(orig_input.orig_cmpy, orig_input.orig_wphone, orig_input.orig_addr),DATASET([{'01',risk_indicators.getHRIDesc('01')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode42(orig_input.cmpy_bans),DATASET([{'42',risk_indicators.getHRIDesc('42')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode69(output_layout.phonevalidflag),DATASET([{'69',risk_indicators.getHRIDesc('69')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode70(output_layout.resAddrFlag),DATASET([{'70',risk_indicators.getHRIDesc('70')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(output_layout.nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(output_layout.nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(output_layout.zipclass),DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode43b(orig_input.cmpy_bans, output_layout.cmpycount, output_layout.addrcount),DATASET([{'43',risk_indicators.getHRIDesc('43')}],risk_indicators.Layout_Desc)) &
	IF(tribcode!='' and Risk_Indicators.rcSet.isCode68(if(output_layout.repphoneverflag='Y', 1, 0), orig_input.orig_fax),DATASET([{'68',risk_indicators.getHRIDesc('68')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(output_layout.addrMiskeyFlag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(output_layout.phoneMiskeyFlag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)


endmacro;