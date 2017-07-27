import Risk_Indicators;

export bdReasonCodesConsumer2( /*bocashell*/ layout, ip, cnt, nugen = false, criminal = false ) := MACRO

CHOOSEN(
	/**/IF(Risk_Indicators.rcSet.isCodeIA(layout.shell_input.ip_address, ip.ipaddr<>''),DATASET([{'IA',risk_indicators.getHRIDesc('IA')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.isCodeIF(ip.countrycode),DATASET([{'IF',risk_indicators.getHRIDesc('IF')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(layout.shell_input.lname, layout.shell_input.fname), DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.shell_input.in_streetAddress), DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(layout.shell_input.ssn), DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.shell_input.phone10), DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode81(layout.shell_input.dob), DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(layout.iid.decsflag), DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(layout.iid.socsdobflag), DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(layout.iid.hriskaddrflag, layout.iid.hrisksic, layout.iid.hriskphoneflag, layout.iid.hrisksicphone), DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
  IF(Risk_Indicators.rcSet.isCode97(layout.bjl.felony_count) AND criminal, DATASET([{'97',risk_indicators.getHRIDesc('97')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode06(layout.iid.socsvalflag, layout.shell_input.ssn), DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode51(layout.shell_input.lname, layout.shell_input.ssn, layout.iid.lastssnmatch2, layout.iid.socsverlevel, layout.iid.ssnExists), DATASET([{'51',risk_indicators.getHRIDesc('51')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode66(layout.shell_input.lname, layout.shell_input.fname, layout.shell_input.ssn, layout.iid.lastcount, layout.iid.socscount, layout.iid.firstcount), DATASET([{'66',risk_indicators.getHRIDesc('66')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode71(layout.iid.ssnExists, layout.shell_input.ssn, layout.iid.socsvalflag), DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72((string)layout.iid.socsverlevel, layout.shell_input.ssn, layout.iid.ssnexists, layout.iid.lastssnmatch2), DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode39(layout.iid.socllowissue, layout.historydate), DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.IsCodeMI(layout.velocity_counters.adls_per_ssn_seen_18months), DATASET([{'MI',risk_indicators.getHRIDesc('MI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode38(layout.iid.altlast, layout.iid.socscount, layout.iid.lastcount, layout.iid.altlast2, layout.iid.correctlast != ''), DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.IsCodeMS(layout.velocity_counters.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode89(layout.iid.socllowissue, layout.historydate), DATASET([{'89',risk_indicators.getHRIDesc('89')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.IsCodeMN(layout.iid.socllowissue, layout.historydate), DATASET([{'MN',risk_indicators.getHRIDesc('MN')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode52(layout.shell_input.fname, layout.shell_input.ssn, layout.iid.firstssnmatch, layout.iid.socsverlevel, layout.iid.ssnExists), DATASET([{'52',risk_indicators.getHRIDesc('52')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(layout.iid.phonelastcount, layout.iid.phoneaddrcount, layout.iid.phonephonecount, layout.iid.phonevalflag), DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(layout.shell_input.phone10, layout.iid.phonephonecount, layout.iid.combo_hphonecount), DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode34(layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount, layout.iid.combo_ssncount, layout.shell_input.phone10, layout.shell_input.ssn),DATASET([{'34',risk_indicators.getHRIDesc('34')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(layout.iid.name_addr_phone, layout.shell_input.phone10, layout.iid.dirsaddr_lastscore), DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(layout.iid.disthphoneaddr), DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.iid.hriskphoneflag), DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.iid.phonetype, layout.shell_input.phone10), DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.iid.hriskaddrflag), DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.iid.hriskphoneflag), DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.iid.phonezipflag), DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.iid.addrvalflag, layout.shell_input.in_streetAddress, layout.shell_input.in_city, layout.shell_input.in_state, layout.shell_input.z5), DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
  IF(Risk_Indicators.rcSet.isCodeCR(layout.relatives.relative_felony_count) AND criminal, DATASET([{'CR',risk_indicators.getHRIDesc('CR')}],risk_indicators.Layout_Desc)) &	
	/**/IF(Risk_Indicators.rcSet.isCodeIE(ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'IE',risk_indicators.getHRIDesc('IE')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.isCodeII(layout.shell_input.in_state, ip.state, ip.countrycode, ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'II',risk_indicators.getHRIDesc('II')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.isCodeIK(ip.areacode, layout.shell_input.phone10, layout.shell_input.in_state, ip.state, ip.countrycode, ip.secondleveldomain, ip.ipaddr<>'',ip.iptype),DATASET([{'IK',risk_indicators.getHRIDesc('IK')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.isCodeIJ(layout.shell_input.in_zipCode, ip.zip, ip.countrycode, ip.ipaddr<>'', layout.shell_input.in_state, ip.state, ip.secondleveldomain,ip.iptype, ip.areacode, layout.shell_input.phone10),DATASET([{'IJ',risk_indicators.getHRIDesc('IJ')}],risk_indicators.Layout_Desc)) &
    /**/IF(Risk_Indicators.rcSet.isCodeIG(ip.iptype),DATASET([{'IG',risk_indicators.getHRIDesc('IG')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(layout.phone_verification.telcordia_type), DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(layout.iid.zipclass), DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.phone_verification.telcordia_type), DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(layout.iid.zipclass), DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode64(layout.iid.name_addr_phone, layout.shell_input.phone10, layout.iid.dirsaddr_lastscore), DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode75(layout.iid.publish_code), DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode53(layout.iid.disthphonewphone), DATASET([{'53',risk_indicators.getHRIDesc('53')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode55(layout.iid.wphonevalflag), DATASET([{'55',risk_indicators.getHRIDesc('55')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode56(layout.iid.wphonedissflag), DATASET([{'56',risk_indicators.getHRIDesc('56')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode57(layout.iid.wphonetypeflag), DATASET([{'57',risk_indicators.getHRIDesc('57')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode13, DATASET([{'13',risk_indicators.getHRIDesc('13')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode85(layout.shell_input.ssn, layout.iid.socllowissue), DATASET([{'85',risk_indicators.getHRIDesc('85')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode90(layout.iid.socllowissue, layout.shell_input.dob), DATASET([{'90',risk_indicators.getHRIDesc('90')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(layout.shell_input.addr_type) AND nugen, DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePA(layout.iid.inputAddrNotMostRecent) AND nugen, DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
	/**/IF(Risk_Indicators.rcSet.isCode9D(layout.address_verification.input_address_information.date_first_seen, layout.address_verification.address_history_1.date_first_seen, layout.address_verification.address_history_2.date_first_seen, layout.historydate), DATASET([{'9D',risk_indicators.getHRIDesc('9D')}],risk_indicators.Layout_Desc)) &


	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)
endmacro;