export cbdoReasonCodes(layout, cnt) :=

MACRO

CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode50(layout.hriskaddrflag, layout.hrisksic, layout.hriskphoneflag, layout.hrisksicphone),DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode38(layout.altlast, layout.socscount, layout.lastcount, layout.altlast2, layout.correctlast<>''),DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode19(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode26(layout.ssn, layout.combo_lastcount, layout.combo_addrcount, layout.combo_ssncount, false),DATASET([{'26',risk_indicators.getHRIDesc('26')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(layout.decsflag),DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(layout.socsdobflag),DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode04(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
				   layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount),
				   DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(layout.socsvalflag, layout.ssn),DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &  // st. cloud checks the phonetype for this
	IF(Risk_Indicators.rcSet.isCode09(layout.nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_hphonecount),DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode28(layout.combo_dobcount, layout.dob),DATASET([{'28',risk_indicators.getHRIDesc('28')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode13,DATASET([{'13',risk_indicators.getHRIDesc('13')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(layout.zipclass),DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(layout.lname, layout.fname),DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.in_streetAddress),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.phone10),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(layout.name_addr_phone, layout.phone10, layout.dirsaddr_lastscore),DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.phonezipflag),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode39(layout.socllowissue, layout.historyDate),DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode75(layout.publish_code),DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode41(layout.drlcvalflag),DATASET([{'41',risk_indicators.getHRIDesc('41')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode42(layout.bansflag),DATASET([{'42',risk_indicators.getHRIDesc('42')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode43(layout.bansflag, layout.firstcount, layout.lastcount, layout.addrcount),DATASET([{'43',risk_indicators.getHRIDesc('43')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode29(layout.socsmiskeyflag),DATASET([{'29',risk_indicators.getHRIDesc('29')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode76(layout.correctlast),DATASET([{'76',risk_indicators.getHRIDesc('76')}],risk_indicators.Layout_Desc)) &
//	IF(Risk_Indicators.rcSet.isCode86(layout.employer_name, layout.combo_cmpy, output_layout.bestcompanyname), 	// not returning rc86 because it will not happen often in boca and I don't have a bestcmpyname
//			DATASET([{'86',risk_indicators.getHRIDesc('86')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(layout.ssn),DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode81(layout.dob),DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)

ENDMACRO;