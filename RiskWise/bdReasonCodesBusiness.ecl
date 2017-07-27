import Risk_Indicators;

export bdReasonCodesBusiness( /*riskwise.Layout_BusReasons_Input*/ orig_input, /*Business_Risk.Layout_Output*/ output_layout, /*INTEGER*/ cnt, /*BOOLEAN*/ OFAC, /*BOOLEAN*/ other_watchlists = false, nugen = false ) := MACRO

CHOOSEN(
	IF(OFAC and Risk_Indicators.rcSet.IsCode32(output_layout.watchlist_table, output_layout.watchlist_record_number), DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(other_watchlists and Risk_Indicators.rcSet.IsCodeWL(output_layout.watchlist_table, output_layout.watchlist_record_number), DATASET([{'WL',risk_indicators.getHRIDesc('WL')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA1(output_layout.BVI), DATASET([{'A1',risk_indicators.getHRIDesc('A1')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA4(output_layout.bdid, output_layout.goodstanding), DATASET([{'A4',risk_indicators.getHRIDesc('A4')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA8(output_layout.ar2bi, output_layout.rep_fname, output_layout.rep_lname, output_layout.company_name), DATASET([{'A8',risk_indicators.getHRIDesc('A8')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(output_layout.hriskaddrflag, output_layout.hrisksic, output_layout.hriskphoneflag, output_layout.hrisksic), DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA5(Output_Layout.lienbdidflag), DATASET([{'A5',risk_indicators.getHRIDesc('A5')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA6(output_layout.bdid, output_layout.goodstanding), DATASET([{'A6',risk_indicators.getHRIDesc('A6')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA3(output_layout.BNAP_Indicator, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone), DATASET([{'A3',risk_indicators.getHRIDesc('A3')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA7(Output_Layout.vernotrecentflag), DATASET([{'A7',risk_indicators.getHRIDesc('A7')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode69(Output_Layout.phonevalidflag), DATASET([{'69',risk_indicators.getHRIDesc('69')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode70(Output_Layout.resAddrFlag), DATASET([{'70',risk_indicators.getHRIDesc('70')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode60(Output_Layout.cmpycount, Output_Layout.addrcount, Output_Layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone), DATASET([{'60',risk_indicators.getHRIDesc('60')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode62(Output_Layout.cmpycount, Output_Layout.addrcount, Output_Layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone), DATASET([{'62',risk_indicators.getHRIDesc('62')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeA0(output_layout.FEINMatchCompany1, output_layout.FEINMatchAddr1, output_layout.bestaddr), DATASET([{'A0',risk_indicators.getHRIDesc('A0')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode33(output_layout.addrcount, output_layout.cmpycount, output_layout.wphonecount, orig_input.orig_addr, orig_input.orig_cmpy, output_layout.phone10), DATASET([{'33',risk_indicators.getHRIDesc('33')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode47(output_layout.phonematchaddr, output_layout.veraddr, output_layout.PhoneMatchCompany, output_layout.vercmpy), DATASET([{'47',risk_indicators.getHRIDesc('47')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(output_layout.dist_BusPhone_BusAddr), DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode54(Output_Layout.fein,Output_Layout.bestfein), DATASET([{'54',risk_indicators.getHRIDesc('54')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode61(Output_Layout.cmpycount, Output_Layout.addrcount, Output_Layout.wphonecount, orig_input.orig_cmpy, orig_input.orig_addr, orig_input.orig_wphone), DATASET([{'61',risk_indicators.getHRIDesc('61')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode65(output_layout.addrcount, orig_input.orig_addr, output_layout.cmpycount), DATASET([{'65',risk_indicators.getHRIDesc('65')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode67(output_layout.wphonecount, orig_input.orig_wphone, output_layout.cmpycount), DATASET([{'67',risk_indicators.getHRIDesc('67')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode87(output_layout.phone10, output_layout.CmpyPhoneFromAddr), DATASET([{'87',risk_indicators.getHRIDesc('87')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode64(output_layout.RepNAP_Score, orig_input.orig_wphone, output_layout.Rep_dirsaddr_lastscore), DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(Output_Layout.hriskphoneflag), DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(orig_input.telcophonetype, orig_input.orig_wphone), DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(output_layout.addrvalidflag, orig_input.orig_addr, orig_input.orig_city, orig_input.orig_state, orig_input.orig_zip), DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(output_layout.zipclass), DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(if(output_layout.phonezipmismatch,'1','0')), DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(Output_Layout.nxx_type), DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(Output_Layout.nxx_type), DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(output_layout.addr_type) AND nugen, DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePA(output_layout.inputBusAddrNotMostRecent) AND nugen, DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
	
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)


endmacro;

