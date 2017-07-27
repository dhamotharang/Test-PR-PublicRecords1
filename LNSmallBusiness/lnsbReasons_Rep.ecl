import risk_indicators, iesp;

makeRC( string2 num ) := DATASET([{num,risk_indicators.getHRIDesc(num)}],iesp.share.t_RiskIndicator);

export lnsbReasons_Rep( Risk_Indicators.Layout_Boca_Shell bs, integer cnt=4 ) := choosen(
	IF(Risk_Indicators.rcSet.isCode77(bs.shell_input.lname,
			bs.shell_input.fname),                                             makeRC('77')) &
	IF(Risk_Indicators.rcSet.isCode78(bs.shell_input.in_streetAddress),        makeRC('78')) &
	IF(Risk_Indicators.rcSet.isCode79(bs.shell_input.ssn),                     makeRC('79')) &
	IF(Risk_Indicators.rcSet.isCode80(bs.shell_input.phone10),                 makeRC('80')) &
	IF(Risk_Indicators.rcSet.isCode81(bs.shell_input.dob),                     makeRC('81')) &
	IF(Risk_Indicators.rcSet.isCode02(bs.iid.decsflag),                        makeRC('02')) &
	IF(Risk_Indicators.rcSet.isCode03(bs.iid.socsdobflag),                     makeRC('03')) &
	IF(Risk_Indicators.rcSet.isCode50(bs.iid.hriskaddrflag,
			bs.iid.hrisksic,
			bs.iid.hriskphoneflag,
			bs.iid.hrisksicphone),                                             makeRC('50')) &
	IF(Risk_Indicators.rcSet.isCode97(bs.bjl.felony_count),                    makeRC('97')) &
	IF(Risk_Indicators.rcSet.isCode42(bs.iid.bansflag),                        makeRC('42')) &
	IF(Risk_Indicators.rcSet.isCode43(bs.iid.bansflag,
			bs.iid.firstcount,
			bs.iid.lastcount,
			bs.iid.addrcount),                                                 makeRC('43')) &
	IF(Risk_Indicators.rcSet.isCode98(bs.bjl.liens_recent_unreleased_count,
			bs.bjl.liens_historical_unreleased_count),                         makeRC('98')) &
	IF(Risk_Indicators.rcSet.isCode06(bs.iid.socsvalflag, bs.shell_input.ssn),                     makeRC('06')) &
	IF(Risk_Indicators.rcSet.isCode51(bs.shell_input.lname,
			bs.shell_input.ssn,
			bs.iid.lastssnmatch2,
			bs.iid.socsverlevel,
			bs.iid.ssnExists),                                              makeRC('51')) &
	IF(Risk_Indicators.rcSet.isCode66(bs.shell_input.lname,
			bs.shell_input.fname,
			bs.shell_input.ssn,
			bs.iid.lastcount,
			bs.iid.socscount,
			bs.iid.firstcount),                                                makeRC('66')) &
	IF(Risk_Indicators.rcSet.isCode71(bs.iid.ssnExists, 
			bs.shell_input.ssn,
			bs.iid.socsvalflag),																							 makeRC('71')) &
	IF(Risk_Indicators.rcSet.isCode72((string)bs.iid.socsverlevel,
			bs.shell_input.ssn,
			bs.iid.ssnExists,
			bs.iid.lastssnmatch2),                                             makeRC('72')) &
	IF(Risk_Indicators.rcSet.isCode39(bs.iid.socllowissue,
																		bs.historydate),                makeRC('39')) &
	IF(Risk_Indicators.rcSet.isCode38(bs.iid.altlast,
			bs.iid.socscount,
			bs.iid.lastcount,
			bs.iid.altlast2,
			bs.iid.correctlast<>''),                                           makeRC('38')) &
	IF(Risk_Indicators.rcSet.isCode89(bs.iid.socllowissue, 
																		bs.historydate),                    makeRC('89')) &
	IF(Risk_Indicators.rcSet.isCode52(bs.shell_input.fname,
			bs.shell_input.ssn,
			bs.iid.firstssnmatch,
			bs.iid.socsverlevel,
			bs.iid.ssnExists),                                              makeRC('52')) &
	IF(Risk_Indicators.rcSet.isCode74(bs.iid.phonelastcount,
			bs.iid.phoneaddrcount,
			bs.iid.phonephonecount,
			bs.iid.phonevalflag),                                              makeRC('74')) &
	IF(Risk_Indicators.rcSet.isCode73(bs.shell_input.phone10,
			bs.iid.phonephonecount,
			bs.iid.combo_hphonecount),                                         makeRC('73')) &
	IF(Risk_Indicators.rcSet.isCode34(bs.iid.combo_lastcount,
			bs.iid.combo_addrcount,
			bs.iid.combo_hphonecount,
			bs.iid.combo_ssncount,
			bs.shell_input.phone10,
			bs.shell_input.ssn),                                               makeRC('34')) &
	IF(Risk_Indicators.rcSet.isCode82(bs.iid.name_addr_phone,
			bs.shell_input.phone10,
			bs.iid.dirsaddr_lastscore),                                        makeRC('82')) &
	IF(Risk_Indicators.rcSet.isCode49(bs.iid.disthphoneaddr),                  makeRC('49')) &
	IF(Risk_Indicators.rcSet.isCode07(bs.iid.hriskphoneflag),                  makeRC('07')) &
	IF(Risk_Indicators.rcSet.isCode08(bs.iid.phonetype,
			bs.shell_input.phone10),                                           makeRC('08')) &
	IF(Risk_Indicators.rcSet.isCode14(bs.iid.hriskaddrflag),                   makeRC('14')) &
	IF(Risk_Indicators.rcSet.isCode15(bs.iid.hriskphoneflag),                  makeRC('15')) &
	IF(Risk_Indicators.rcSet.isCode16(bs.iid.phonezipflag),                    makeRC('16')) &
	IF(Risk_Indicators.rcSet.isCode11(bs.iid.addrvalflag,
			bs.shell_input.in_streetAddress,
			bs.shell_input.in_city,
			bs.shell_input.in_state,
			bs.shell_input.in_zipCode),                                        makeRC('11')) &
	IF(Risk_Indicators.rcSet.isCode09(bs.phone_verification.telcordia_type),                  makeRC('09')) &
	IF(Risk_Indicators.rcSet.isCode12(bs.iid.zipclass),                        makeRC('12')) &
	IF(Risk_Indicators.rcSet.isCode10(bs.phone_verification.telcordia_type),                  makeRC('10')) &
	IF(Risk_Indicators.rcSet.isCode40(bs.iid.zipclass),                        makeRC('40')) &
	IF(Risk_Indicators.rcSet.isCode64(bs.iid.name_addr_phone,
			bs.shell_input.phone10,
			bs.iid.dirsaddr_lastscore),                                        makeRC('64')) &

	IF(Risk_Indicators.rcSet.isCode75(bs.iid.publish_code),                    makeRC('75')) &
	IF(Risk_Indicators.rcSet.isCode41(bs.iid.drlcvalflag),                     makeRC('41')) &
	IF(Risk_Indicators.rcSet.isCode53(bs.iid.disthphonewphone),                makeRC('53')) &
	IF(Risk_Indicators.rcSet.isCode55(bs.iid.wphonevalflag),                   makeRC('55')) &
	IF(Risk_Indicators.rcSet.isCode56(bs.iid.wphonedissflag),                  makeRC('56')) &
	IF(Risk_Indicators.rcSet.isCode57(bs.iid.wphonetypeflag),                  makeRC('57')) &
	IF(Risk_Indicators.rcSet.isCode85(bs.shell_input.ssn, bs.iid.socllowissue), makeRC('85')) &
	IF(Risk_Indicators.rcSet.isCode90(bs.iid.socllowissue,
			bs.shell_input.dob),                                               makeRC('90')) &
	IF(Risk_Indicators.rcSet.isCodePO(bs.shell_input.addr_type),               makeRC('PO')) &
	IF(Risk_Indicators.rcSet.isCodePA(bs.iid.inputAddrNotMostRecent),          makeRC('PA')),

	cnt
);