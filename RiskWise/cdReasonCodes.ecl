import Risk_Indicators, NetAcuity;

export cdReasonCodes(ROW(Risk_Indicators.Layout_Output) layout, 
					unsigned cnt = 0, 
					row(RiskWise.Layout_IP2O ) ip, 
					boolean billTo = FALSE, 
					boolean IBICID = FALSE,
					boolean WantstoSeeBillToShipToDifferenceFlag = FALSE, 
					boolean WantsToSeeEA =FALSE, 
					//btst fields
					boolean getBTSTfields = FALSE, 
					integer btst_did_summary = 0, integer btst_cbd_inq_ver_count = 0,
					integer btst_economic_trajectory = 0, integer bt_inq_count_day = 0, integer st_inq_count_day = 0, 
					integer bt_inq_count_week = 0, integer st_inq_count_week = 0,
					string nf_seg_fraudpoint_3_0	= ''
					):= function

 ReasonCodes := CHOOSEN(
	IF(billTo and Risk_Indicators.rcSet.isCodeIA(layout.ip_address, ip.ipaddr<>''),DATASET([{'IA',risk_indicators.getHRIDesc('IA')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCodeIF(ip.countrycode),DATASET([{'IF',risk_indicators.getHRIDesc('IF')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(layout.hriskaddrflag, layout.hrisksic, layout.hriskphoneflag, layout.hrisksicphone),DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O2(bt_inq_count_day, st_inq_count_day),DATASET([{'O2',risk_indicators.getHRIDesc('O2')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O3(bt_inq_count_week, st_inq_count_week,bt_inq_count_day, st_inq_count_day),DATASET([{'O3',risk_indicators.getHRIDesc('O3')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O5(btst_did_summary),DATASET([{'O5',risk_indicators.getHRIDesc('O5')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O6(btst_did_summary),DATASET([{'O6',risk_indicators.getHRIDesc('O6')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O7(btst_did_summary),DATASET([{'O7',risk_indicators.getHRIDesc('O7')}],risk_indicators.Layout_Desc)) &	
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeS5(nf_seg_fraudpoint_3_0), DATASET([{'S5',risk_indicators.getHRIDesc('S5')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeS4(nf_seg_fraudpoint_3_0), DATASET([{'S4',risk_indicators.getHRIDesc('S4')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeS3(nf_seg_fraudpoint_3_0), DATASET([{'S3',risk_indicators.getHRIDesc('S3')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeS2(nf_seg_fraudpoint_3_0), DATASET([{'S2',risk_indicators.getHRIDesc('S2')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeS1(nf_seg_fraudpoint_3_0), DATASET([{'S1',risk_indicators.getHRIDesc('S1')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode19(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O4(btst_did_summary, btst_economic_trajectory),DATASET([{'O4',risk_indicators.getHRIDesc('O4')}],risk_indicators.Layout_Desc)) &
	IF(WantstoSeeBillToShipToDifferenceFlag and Risk_Indicators.rcSet.isCodeAS(layout.IsShiptoBilltoDifferent),DATASET([{'AS',risk_indicators.getHRIDesc('AS')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode04(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
				   layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount),
				   DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(layout.nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_hphonecount),DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode13,DATASET([{'13',risk_indicators.getHRIDesc('13')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(layout.zipclass),DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(getBTSTfields AND Risk_Indicators.rcSet.isCodeOS_O1(btst_did_summary, btst_cbd_inq_ver_count),DATASET([{'O1',risk_indicators.getHRIDesc('O1')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(layout.lname, layout.fname),DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.in_streetAddress),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.phone10),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(layout.name_addr_phone, layout.phone10, layout.dirsaddr_lastscore),DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCodeIE(ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'IE',risk_indicators.getHRIDesc('IE')}],risk_indicators.Layout_Desc)) &
	IF(billTo and IBICID and Risk_Indicators.rcSet.isCodeIB(layout.in_state, ip.state, ip.countrycode, ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'IB',risk_indicators.getHRIDesc('IB')}],risk_indicators.Layout_Desc)) &
	IF(billTo and IBICID and Risk_Indicators.rcSet.isCodeID(ip.areacode, layout.phone10, layout.in_state, ip.state, ip.countrycode, ip.secondleveldomain, ip.ipaddr<>'',
												ip.iptype),DATASET([{'ID',risk_indicators.getHRIDesc('ID')}],risk_indicators.Layout_Desc)) &
	IF(billTo and IBICID and Risk_Indicators.rcSet.isCodeIC(layout.in_zipCode, ip.zip, ip.countrycode, ip.ipaddr<>'', layout.in_state, ip.state, ip.secondleveldomain,
												 ip.iptype, ip.areacode, layout.phone10),DATASET([{'IC',risk_indicators.getHRIDesc('IC')}],risk_indicators.Layout_Desc)) &
	IF(billTo and Risk_Indicators.rcSet.isCodeIG(ip.iptype),DATASET([{'IG',risk_indicators.getHRIDesc('IG')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.phonezipflag),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode75(layout.publish_code),DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode43(layout.bansflag, layout.firstcount, layout.lastcount, layout.addrcount),DATASET([{'43',risk_indicators.getHRIDesc('43')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode76(layout.correctlast),DATASET([{'76',risk_indicators.getHRIDesc('76')}],risk_indicators.Layout_Desc)) &
	IF(billTo and WantsToSeeEA and Risk_Indicators.rcSet.isCodeEA(layout.email_verification),DATASET([{'EA',risk_indicators.getHRIDesc('EA')}],risk_indicators.Layout_Desc)) &

	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt);
RETURN ReasonCodes;
END;
