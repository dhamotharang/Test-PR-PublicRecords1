import Risk_Indicators;

// criminal flag will toggle the inclusion of reason code 97
export fraudpoint_reasons(clam, ip, cnt, include_criminal = false, isFP1403_2_0=false ) := MACRO

CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeIA(clam.shell_input.ip_address, ip.ipaddr<>''),DATASET([{'IA',risk_indicators.getHRIDesc('IA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIF(ip.countrycode),DATASET([{'IF',risk_indicators.getHRIDesc('IF')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(clam.shell_input.lname, clam.shell_input.fname), DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(clam.shell_input.in_streetAddress), DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(clam.shell_input.ssn), DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(clam.shell_input.phone10), DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode81(clam.shell_input.dob), DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(clam.iid.decsflag), DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(clam.iid.socsdobflag), DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(clam.iid.hriskaddrflag, clam.iid.hrisksic, clam.iid.hriskphoneflag, clam.iid.hrisksicphone), DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
IF(include_criminal and Risk_Indicators.rcSet.isCode97(clam.bjl.felony_count), DATASET([{'97',risk_indicators.getHRIDesc('97')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode06(clam.iid.socsvalflag, clam.shell_input.ssn), DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode51(clam.shell_input.lname, clam.shell_input.ssn, clam.iid.lastssnmatch2, clam.iid.socsverlevel, clam.iid.ssnExists), DATASET([{'51',risk_indicators.getHRIDesc('51')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode66(clam.shell_input.lname, clam.shell_input.fname, clam.shell_input.ssn, clam.iid.lastcount, clam.iid.socscount, clam.iid.firstcount), DATASET([{'66',risk_indicators.getHRIDesc('66')}],risk_indicators.Layout_Desc)) &
	
IF(Risk_Indicators.rcSet.isCodeBO(clam.header_summary.ver_sources) and ~isFP1403_2_0, DATASET([{'BO',risk_indicators.getHRIDesc('BO')}],risk_indicators.Layout_Desc)) &
	
	IF(Risk_Indicators.rcSet.isCode71(clam.iid.ssnExists, clam.shell_input.ssn, clam.iid.socsvalflag), DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72((string)clam.iid.socsverlevel, clam.shell_input.ssn, clam.iid.ssnexists, clam.iid.lastssnmatch2), DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode39(clam.iid.socllowissue, clam.historydate), DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeMI(clam.velocity_counters.adls_per_ssn_seen_18months), DATASET([{'MI',risk_indicators.getHRIDesc('MI')}],risk_indicators.Layout_Desc)) &
IF(Risk_Indicators.rcSet.IsCodeFV(clam.advo_input_addr.address_vacancy_indicator), DATASET([{'FV',risk_indicators.getHRIDesc('FV')}],risk_indicators.Layout_Desc)) &
	
	IF(Risk_Indicators.rcSet.isCode38(clam.iid.altlast, clam.iid.socscount, clam.iid.lastcount, clam.iid.altlast2, clam.iid.correctlast != ''), DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeMS(clam.velocity_counters.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS')}],risk_indicators.Layout_Desc)) &
	
IF(Risk_Indicators.rcSet.IsCodeFQ(clam.acc_logs.inquiries.count12), DATASET([{'FQ',risk_indicators.getHRIDesc('FQ')}],risk_indicators.Layout_Desc)) &
IF(Risk_Indicators.rcSet.IsCode9K(clam.shell_input.addr_type) and ~isFP1403_2_0, DATASET([{'9K',risk_indicators.getHRIDesc('9K')}],risk_indicators.Layout_Desc)) &
	
	IF(Risk_Indicators.rcSet.isCode89(clam.iid.socllowissue, clam.historydate), DATASET([{'89',risk_indicators.getHRIDesc('89')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeMN(clam.iid.socllowissue, clam.historydate), DATASET([{'MN',risk_indicators.getHRIDesc('MN')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode52(clam.shell_input.fname, clam.shell_input.ssn, clam.iid.firstssnmatch, clam.iid.socsverlevel, clam.iid.ssnExists), DATASET([{'52',risk_indicators.getHRIDesc('52')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(clam.iid.phonelastcount, clam.iid.phoneaddrcount, clam.iid.phonephonecount, clam.iid.phonevalflag), DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(clam.shell_input.phone10, clam.iid.phonephonecount, clam.iid.combo_hphonecount), DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode34(clam.iid.combo_lastcount, clam.iid.combo_addrcount, clam.iid.combo_hphonecount, clam.iid.combo_ssncount, clam.shell_input.phone10, clam.shell_input.ssn),DATASET([{'34',risk_indicators.getHRIDesc('34')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(clam.iid.name_addr_phone, clam.shell_input.phone10, clam.iid.dirsaddr_lastscore), DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(clam.iid.disthphoneaddr), DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(clam.iid.hriskphoneflag), DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(clam.iid.phonetype, clam.shell_input.phone10), DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(clam.iid.hriskaddrflag), DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(clam.iid.hriskphoneflag), DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(clam.iid.phonezipflag), DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(clam.iid.addrvalflag, clam.shell_input.in_streetAddress, clam.shell_input.in_city, clam.shell_input.in_state, clam.shell_input.z5), DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIE(ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'IE',risk_indicators.getHRIDesc('IE')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeII(clam.shell_input.in_state, ip.state, ip.countrycode, ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'II',risk_indicators.getHRIDesc('II')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIK(ip.areacode, clam.shell_input.phone10, clam.shell_input.in_state, ip.state, ip.countrycode, ip.secondleveldomain, ip.ipaddr<>'',ip.iptype),DATASET([{'IK',risk_indicators.getHRIDesc('IK')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIJ(clam.shell_input.in_zipCode, ip.zip, ip.countrycode, ip.ipaddr<>'', clam.shell_input.in_state, ip.state, ip.secondleveldomain,ip.iptype, ip.areacode, clam.shell_input.phone10),DATASET([{'IJ',risk_indicators.getHRIDesc('IJ')}],risk_indicators.Layout_Desc)) &
  IF(Risk_Indicators.rcSet.isCodeIG(ip.iptype),DATASET([{'IG',risk_indicators.getHRIDesc('IG')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(clam.phone_verification.telcordia_type), DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(clam.iid.zipclass), DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(clam.phone_verification.telcordia_type), DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(clam.iid.zipclass), DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode64(clam.iid.name_addr_phone, clam.shell_input.phone10, clam.iid.dirsaddr_lastscore), DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode75(clam.iid.publish_code), DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode53(clam.iid.disthphonewphone), DATASET([{'53',risk_indicators.getHRIDesc('53')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode55(clam.iid.wphonevalflag), DATASET([{'55',risk_indicators.getHRIDesc('55')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode56(clam.iid.wphonedissflag), DATASET([{'56',risk_indicators.getHRIDesc('56')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode57(clam.iid.wphonetypeflag), DATASET([{'57',risk_indicators.getHRIDesc('57')}],risk_indicators.Layout_Desc)) &
IF(Risk_Indicators.rcSet.isCodeSR(clam.iid.combo_sec_rangescore), DATASET([{'SR',risk_indicators.getHRIDesc('SR')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode85(clam.shell_input.ssn, clam.iid.socllowissue), DATASET([{'85',risk_indicators.getHRIDesc('85')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode90(clam.iid.socllowissue, clam.shell_input.dob), DATASET([{'90',risk_indicators.getHRIDesc('90')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(clam.shell_input.addr_type), DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePA(clam.iid.inputAddrNotMostRecent), DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9D(clam.address_verification.input_address_information.date_first_seen, clam.address_verification.address_history_1.date_first_seen, clam.address_verification.address_history_2.date_first_seen, clam.historydate), DATASET([{'9D',risk_indicators.getHRIDesc('9D')}],risk_indicators.Layout_Desc)) &

	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)
endmacro;