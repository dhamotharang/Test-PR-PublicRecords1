import Risk_Indicators;

export cdReasonCodesCon2( /*Risk_Indicators.Layout_Output*/ layout, cnt, ip_eddo, billTo, IBICID ) := MACRO


CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode09(layout.nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode22(layout.lname, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount),DATASET([{'22',risk_indicators.getHRIDesc('22')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode21(layout.lname, layout.phone10, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount),DATASET([{'21',risk_indicators.getHRIDesc('21')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCode05((UNSIGNED3)ip_eddo.eddo.distaddraddr2),DATASET([{'05',risk_indicators.getHRIDesc('05')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeZI(layout.combo_zipscore, true, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, 
																		layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'ZI',risk_indicators.getHRIDesc('ZI')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCodeIE(ip_eddo.ip.ipaddr<>'', ip_eddo.ip.secondleveldomain, ip_eddo.ip.iptype),DATASET([{'IE',risk_indicators.getHRIDesc('IE')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(layout.disthphoneaddr),DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.phonezipflag),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode48(layout.fname, layout.combo_firstcount, layout.combo_lastcount),DATASET([{'48',risk_indicators.getHRIDesc('48')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode64(layout.name_addr_phone, layout.phone10, layout.dirsaddr_lastscore ),DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode76(layout.correctlast),DATASET([{'76',risk_indicators.getHRIDesc('76')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.in_streetAddress),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeMS(layout.ssns_per_adl_seen_18months), DATASET([{'MS', Risk_Indicators.getHRIDesc('MS')}], Risk_Indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCode17((UNSIGNED3)ip_eddo.eddo.distphonephone2),DATASET([{'17',risk_indicators.getHRIDesc('17')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(billTo and IBICID and Risk_Indicators.rcSet.isCodeIB(layout.in_state, ip_eddo.ip.state, ip_eddo.ip.countrycode, ip_eddo.ip.ipaddr<>'', ip_eddo.ip.secondleveldomain, ip_eddo.ip.iptype),DATASET([{'IB',risk_indicators.getHRIDesc('IB')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCZ(layout.statezipflag, layout.cityzipflag), DATASET([{'CZ', Risk_Indicators.getHRIDesc('CZ')}], Risk_Indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode32(layout.watchlist_table, layout.watchlist_record_number), DATASET([{'32', Risk_Indicators.getHRIDesc('32')}], Risk_Indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeSR(layout.combo_sec_rangescore),DATASET([{'SR',risk_indicators.getHRIDesc('SR')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCO(layout.zipclass),DATASET([{'CO',risk_indicators.getHRIDesc('CO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(layout.phone10, layout.phonephonecount, layout.combo_hphonecount),DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode44(layout.areacodesplitflag),DATASET([{'44',risk_indicators.getHRIDesc('44')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_hphonecount),DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode82(layout.name_addr_phone, layout.phone10, layout.dirsaddr_lastscore),DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(layout.addr_type),DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePA(layout.inputAddrNotMostRecent),DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.phone10),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(billTo and IBICID and Risk_Indicators.rcSet.isCodeID(ip_eddo.ip.areacode, layout.phone10, layout.in_state, ip_eddo.ip.state, ip_eddo.ip.countrycode, ip_eddo.ip.secondleveldomain, ip_eddo.ip.ipaddr<>'',
												ip_eddo.ip.iptype),DATASET([{'ID',risk_indicators.getHRIDesc('ID')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeMO(layout.zipclass),DATASET([{'MO',risk_indicators.getHRIDesc('MO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(layout.phonelastcount, layout.phoneaddrcount, layout.phonephonecount, layout.phonevalflag ),DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(billTo and IBICID and Risk_Indicators.rcSet.isCodeIC(layout.in_zipCode, ip_eddo.ip.zip, ip_eddo.ip.countrycode, ip_eddo.ip.ipaddr<>'', layout.in_state, ip_eddo.ip.state, ip_eddo.ip.secondleveldomain,
												 ip_eddo.ip.iptype, ip_eddo.ip.areacode, layout.phone10),DATASET([{'IC',risk_indicators.getHRIDesc('IC')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode75(layout.publish_code),DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(layout.lname, layout.fname),DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCodeIG(ip_eddo.ip.iptype),DATASET([{'IG',risk_indicators.getHRIDesc('IG')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(layout.hriskaddrflag, layout.hrisksic, layout.hriskphoneflag, layout.hrisksicphone),DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCodeIA(layout.ip_address, ip_eddo.ip.ipaddr<>''),DATASET([{'IA',risk_indicators.getHRIDesc('IA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode20(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'20',risk_indicators.getHRIDesc('20')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode43(layout.bansflag, layout.firstcount, layout.lastcount, layout.addrcount),DATASET([{'43',risk_indicators.getHRIDesc('43')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode53(layout.disthphonewphone),DATASET([{'53',risk_indicators.getHRIDesc('53')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode55(layout.wphonevalflag),DATASET([{'55',risk_indicators.getHRIDesc('55')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode56(layout.wphonedissflag),DATASET([{'56',risk_indicators.getHRIDesc('56')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode46(layout.wphonetypeflag),DATASET([{'46',risk_indicators.getHRIDesc('46')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode57(layout.wphonetypeflag),DATASET([{'57',risk_indicators.getHRIDesc('57')}],risk_indicators.Layout_Desc)) & 

	
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)

ENDMACRO;


