import Risk_Indicators;


export bdReasonCodesConsumer( /*Risk_Indicators.Layout_Output*/ output_layout, /*INTEGER*/ cnt, /*BOOLEAN*/ OFAC, /*BOOLEAN*/ other_watchlists = false, nugen = false ) := MACRO


CHOOSEN(
	IF(OFAC and Risk_Indicators.rcSet.isCode32(output_layout.watchlist_table, output_layout.watchlist_record_number), DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(other_watchlists and Risk_Indicators.rcSet.isCodeWL(output_layout.watchlist_table, output_layout.watchlist_record_number), DATASET([{'WL',risk_indicators.getHRIDesc('WL')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(output_layout.lname, output_layout.fname), DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(output_layout.in_streetAddress), DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(output_layout.ssn), DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(output_layout.phone10), DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode81(output_layout.dob), DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(output_layout.decsflag), DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(output_layout.socsdobflag), DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(output_layout.hriskaddrflag, output_layout.hrisksic, output_layout.hriskphoneflag, output_layout.hrisksicphone), DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(output_layout.socsvalflag, output_layout.ssn), DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode51(output_layout.lname, output_layout.ssn, output_layout.lastssnmatch2, output_layout.socsverlevel, output_layout.ssnExists), DATASET([{'51',risk_indicators.getHRIDesc('51')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode66(output_layout.lname, output_layout.fname, output_layout.ssn, output_layout.lastcount, output_layout.socscount, output_layout.firstcount), DATASET([{'66',risk_indicators.getHRIDesc('66')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode71(output_layout.ssnExists, output_layout.ssn, output_layout.socsvalflag), DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72((string)output_layout.socsverlevel, output_layout.ssn, output_layout.ssnexists, output_layout.lastssnmatch2), DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode39(output_layout.socllowissue, output_layout.historyDate), DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode38(output_layout.altlast, output_layout.socscount, output_layout.lastcount, output_layout.altlast2, output_layout.correctlast != ''), DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode89(output_layout.socllowissue, output_layout.historyDate), DATASET([{'89',risk_indicators.getHRIDesc('89')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode52(output_layout.fname, output_layout.ssn, output_layout.firstssnmatch, output_layout.socsverlevel, output_layout.ssnExists), DATASET([{'52',risk_indicators.getHRIDesc('52')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(output_layout.phonelastcount, output_layout.phoneaddrcount, output_layout.phonephonecount, output_layout.phonevalflag), DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(output_layout.phone10, output_layout.phonephonecount, output_layout.combo_hphonecount), DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode34(output_layout.combo_lastcount, output_layout.combo_addrcount, output_layout.combo_hphonecount, output_layout.combo_ssncount, output_layout.phone10, output_layout.ssn),DATASET([{'34',risk_indicators.getHRIDesc('34')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(output_layout.name_addr_phone, output_layout.phone10, output_layout.dirsaddr_lastscore), DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(output_layout.disthphoneaddr), DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(output_layout.hriskphoneflag), DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(output_layout.phonetype, output_layout.phone10), DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(output_layout.hriskaddrflag), DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(output_layout.hriskphoneflag), DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(output_layout.phonezipflag), DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(output_layout.addrvalflag, output_layout.in_streetAddress, output_layout.in_city, output_layout.in_state, output_layout.z5), DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(output_layout.nxx_type), DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(output_layout.zipclass), DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(output_layout.nxx_type), DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(output_layout.zipclass), DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode64(output_layout.name_addr_phone, output_layout.phone10, output_layout.dirsaddr_lastscore), DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode75(output_layout.publish_code), DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode41(output_layout.drlcvalflag), DATASET([{'41',risk_indicators.getHRIDesc('41')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode53(output_layout.disthphonewphone), DATASET([{'53',risk_indicators.getHRIDesc('53')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode55(output_layout.wphonevalflag), DATASET([{'55',risk_indicators.getHRIDesc('55')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode56(output_layout.wphonedissflag), DATASET([{'56',risk_indicators.getHRIDesc('56')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode57(output_layout.wphonetypeflag), DATASET([{'57',risk_indicators.getHRIDesc('57')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode13, DATASET([{'13',risk_indicators.getHRIDesc('13')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode85(output_layout.ssn, output_layout.socllowissue), DATASET([{'85',risk_indicators.getHRIDesc('85')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode90(output_layout.socllowissue, output_layout.dob), DATASET([{'90',risk_indicators.getHRIDesc('90')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(output_layout.addr_type) AND nugen, DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePA(output_layout.inputAddrNotMostRecent) AND nugen, DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &

	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)

endmacro;