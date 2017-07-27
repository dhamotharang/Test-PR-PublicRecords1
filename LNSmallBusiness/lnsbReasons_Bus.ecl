import risk_indicators, riskwise, business_risk, address, iesp;

makeRC( string2 num ) := DATASET([{num,risk_indicators.getHRIDesc(num)}],iesp.share.t_RiskIndicator);

export lnsbReasons_Bus(
	business_risk.Layout_Business_Shell br,
	INTEGER cnt=4
) := FUNCTION


	rcs := choosen(
		IF(Risk_Indicators.rcSet.isCodeA4(br.biid.bdid, br.biid.goodstanding),   makeRC('A4')) &
		IF(Risk_Indicators.rcSet.isCodeA6(br.biid.bdid, br.biid.goodstanding),   makeRC('A6')) &
		IF(Risk_Indicators.rcSet.isCodeA7(br.biid.vernotrecentflag),             makeRC('A7')) &
		IF(Risk_Indicators.rcSet.isCodeA0(br.biid.FEINMatchCompany1,
				br.biid.FEINMatchAddr1,
				br.biid.bestaddr),                                               makeRC('A0')) &
		IF(Risk_Indicators.rcSet.isCode50(br.biid.hriskaddrflag,
				br.biid.hrisksic,
				br.biid.hriskphoneflag,
				br.biid.hrisksic),                                               makeRC('50')) &
		IF(Risk_Indicators.rcSet.isCodeA2(if(br.biid.bkbdidflag, 1, 0),
				br.biid.UnreleasedLienCount),                                    makeRC('A2')) &
		IF(Risk_Indicators.rcSet.isCodeA5(br.biid.lienbdidflag),                 makeRC('A5')) &
		IF(Risk_Indicators.rcSet.isCodeA8(br.biid.ar2bi,
				br.biid.rep_fname,
				br.biid.rep_lname,
				br.biid.company_name),                                           makeRC('A8')) &
		IF(Risk_Indicators.rcSet.isCodeA1(br.biid.BVI),                          makeRC('A1')) &
		IF(Risk_Indicators.rcSet.isCodeA3(br.biid.BNAP_Indicator,
				br.biid.company_name,
				br.biid.addr1,
				br.biid.phone10),                                                makeRC('A3')) &	
		IF(Risk_Indicators.rcSet.isCode60(br.biid.cmpycount,
				br.biid.addrcount,
				br.biid.wphonecount,
				br.biid.company_name,
				br.biid.addr1,
				br.biid.phone10),                                                makeRC('60')) &
		IF(Risk_Indicators.rcSet.isCode62(br.biid.cmpycount,
				br.biid.addrcount,
				br.biid.wphonecount,
				br.biid.company_name,
				br.biid.addr1,
				br.biid.phone10),                                                makeRC('62')) &
		IF(Risk_Indicators.rcSet.isCode65(br.biid.addrcount,
				br.biid.addr1, br.biid.cmpycount),                               makeRC('65')) &
		IF(Risk_Indicators.rcSet.isCode86(br.biid.company_name,
				br.biid.vercmpy,
				br.biid.bestcompanyname),                                        makeRC('86')) &
		IF(Risk_Indicators.rcSet.isCode70(br.biid.resAddrFlag),                  makeRC('70')) &
		IF(Risk_Indicators.rcSet.isCode69(br.biid.phonevalidflag),               makeRC('69')) &

		// this logic is suspect:
		IF(Risk_Indicators.rcSet.isCode74(br.biid.phonecmpycount,
				br.biid.phoneaddrcount,
				br.biid.phonecmpyaddrcount,
				br.biid.phonevalidflag),                                         makeRC('74')) &
		IF(Risk_Indicators.rcSet.isCode54(br.biid.fein,br.biid.bestfein),        makeRC('54')) &
		IF(Risk_Indicators.rcSet.isCodePO(br.biid.addr_type),                    makeRC('PO')) &
		IF(Risk_Indicators.rcSet.isCode61(br.biid.cmpycount,
				br.biid.addrcount,
				br.biid.wphonecount,
				br.biid.company_name,
				br.biid.addr1,
				br.biid.phone10),                                                makeRC('61')) &
		IF(Risk_Indicators.rcSet.isCode67(br.biid.wphonecount,
				br.biid.phone10,
				br.biid.cmpycount),                                              makeRC('67')) &
		IF(Risk_Indicators.rcSet.isCode59(br.biid.company_name),                 makeRC('59')) &
		IF(Risk_Indicators.rcSet.isCode78(                       
				Risk_Indicators.MOD_AddressClean.street_address('', br.biid.prim_range,
					br.biid.predir,
					br.biid.prim_name,
					br.biid.addr_suffix,
					br.biid.postdir,
					br.biid.unit_desig,
					br.biid.sec_range)
				),                                                               makeRC('78')) &
		IF(Risk_Indicators.rcSet.isCode58(br.biid.fein),                         makeRC('58')) &
		IF(Risk_Indicators.rcSet.isCode80(br.biid.phone10),                      makeRC('80')) &
		IF(Risk_Indicators.rcSet.isCode11(br.biid.addrvalidflag,
				br.biid.addr1,
				br.biid.p_city_name,
				br.biid.st,
				br.biid.z5),                                                     makeRC('11')) &
		IF(Risk_Indicators.rcSet.isCode12(br.biid.zipclass),                     makeRC('12')) &
		IF(Risk_Indicators.rcSet.isCode07(br.biid.hriskphoneflag),               makeRC('07')) &
		IF(Risk_Indicators.rcSet.isCode08(br.biid.TelcordiaPhoneType,
				br.biid.phone10),                                                makeRC('08')) &

		// this is the same as used in Business_Risk.InstantID_Function:
		IF(LENGTH(TRIM(br.biid.fein)) = 9 and br.biid.feinmatchflag = 'N',       makeRC('26')) &
		
		IF(Risk_Indicators.rcSet.isCodePA(br.biid.inputBusAddrNotMostRecent),    makeRC('PA')) &
		IF(Risk_Indicators.rcSet.isCode09(br.biid.nxx_type),               makeRC('09')) &
		IF(Risk_Indicators.rcSet.isCode10(br.biid.nxx_type),               makeRC('10')) &
		IF(Risk_Indicators.rcSet.isCode16(if(br.biid.phonezipmismatch,'1','0')), makeRC('16')) &
		IF(Risk_Indicators.rcSet.isCodeA9(br.biid.dt_first_seen_min,
																			(unsigned)br.history_date),            makeRC('A9')) &
		IF(Risk_Indicators.rcSet.isCode82(br.biid.CmpyPhoneFromAddr,
				br.biid.phone10,
				0 /* dirsaddr_lastscore isn't used in 82. ??? */),               makeRC('82')) &
		IF(Risk_Indicators.rcSet.isCode64(br.biid.CmpyPhoneFromAddr,
				br.biid.phone10,
				business_risk.cnamescore(br.biid.company_name, br.biid.phonematchcompany) ),  makeRC('64')) &
		IF(Risk_Indicators.rcSet.isCode49(br.biid.dist_BusPhone_BusAddr),        makeRC('49')) &
		IF(Risk_Indicators.rcSet.isCode53(br.biid.dist_HomePhone_BusPhone),      makeRC('53')) &
		IF(Risk_Indicators.rcSet.isCode44(br.biid.areacodesplitflag),            makeRC('44')) &
		IF(Risk_Indicators.rcSet.isCode88( br.biid.company_name,
			br.biid.alt_company_name,
			br.biid.vercmpy),                                                    makeRC('88')) &
		IF(Risk_Indicators.rcSet.isCode63(br.biid.cmpymiskeyflag),               makeRC('63')) &
		IF(Risk_Indicators.rcSet.isCode29(br.biid.feinmiskeyflag),               makeRC('29')) &
		IF(Risk_Indicators.rcSet.isCode30(br.biid.addrmiskeyflag),               makeRC('30')) &
		IF(Risk_Indicators.rcSet.isCode31(br.biid.phonemiskeyflag),              makeRC('31')),
		cnt
	);
	
	withB0 := if( Risk_Indicators.rcSet.isCodeB0( rcs[1].riskcode ), makeRC('B0'), rcs );

	return withB0;
END;

