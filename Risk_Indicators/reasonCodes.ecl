   export reasonCodes(layout, cnt, rc_settings) := 


MACRO


CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode32(layout.watchlist_table, layout.watchlist_record_number),DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	// note:  PO is in here twice because it changed priority for ciid v1
	IF(Risk_Indicators.rcSet.isCodePO(layout.addr_type) AND (rc_settings[1].IsInstantID AND rc_settings[1].IIDVersion=0), DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCodeDI(layout.DIDdeceased) AND (~risk_indicators.rcSet.isCode02(layout.decsflag) or rc_settings[1].isIdentifier2)  AND rc_settings[1].IIDVersion>=1,DATASET([{'DI',risk_indicators.getHRIDesc('DI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(layout.decsflag),DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(layout.socsdobflag),DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePO(layout.addr_type) AND (rc_settings[1].IsInstantID AND rc_settings[1].IIDVersion>=1), DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCA(layout.ADVODropIndicator, layout.hrisksic) AND rc_settings[1].IIDVersion>=1,DATASET([{'CA',risk_indicators.getHRIDesc('CA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodePA(layout.inputAddrNotMostRecent),DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(layout.hriskaddrflag, layout.hrisksic, layout.hriskphoneflag, layout.hrisksicphone),DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(layout.socsvalflag, layout.ssn),DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIS(layout.ssn, layout.socsvalflag, layout.socllowissue, layout.socsRCISflag),DATASET([{'IS',risk_indicators.getHRIDesc('IS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeEI(layout.DID, layout.socsverlevel, layout.socsvalid) AND (rc_settings[1].EnableEmergingID),DATASET([{'EI',risk_indicators.getHRIDesc('EI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIT(layout.ssn),DATASET([{'IT',risk_indicators.getHRIDesc('IT')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeWL(layout.watchlist_table, layout.watchlist_record_number),DATASET([{'WL',risk_indicators.getHRIDesc('WL')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode19(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode51(layout.lname, layout.ssn, layout.lastssnmatch2, layout.socsverlevel, layout.ssnExists),DATASET([{'51',risk_indicators.getHRIDesc('51')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode66(layout.lname, layout.fname, layout.ssn, layout.lastcount, layout.socscount, layout.firstcount),DATASET([{'66',risk_indicators.getHRIDesc('66')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode71(layout.ssnExists, layout.ssn, layout.socsvalflag) AND rc_settings[1].IsInstantID, DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72((string)layout.socsverlevel, layout.ssn, layout.ssnExists, layout.lastssnmatch2) AND rc_settings[1].IsInstantID,DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode04(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
				   layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount),
				   DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeMI(layout.adls_per_ssn_seen_18months),DATASET([{'MI',risk_indicators.getHRIDesc('MI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeMS(layout.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCL(layout.ssn, layout.bestssn, layout.socsverlevel, layout.combo_ssn), DATASET([{'CL',risk_indicators.getHRIDesc('CL')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode38(layout.altlast, layout.socscount, layout.lastcount, layout.altlast2, layout.correctlast<>''),DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	If((rc_settings[1].ischase and Risk_Indicators.rcSet.isCodeVerlast(rc_settings[1].verlast_chase))
			or (rc_settings[1].ischase and Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount)),
				DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc),
					IF(Risk_Indicators.rcSet.isCode37(layout.lname, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),
						DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc))) &
	
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &	   
	IF(Risk_Indicators.rcSet.isCode26(layout.ssn, layout.combo_lastcount, layout.combo_addrcount, layout.combo_ssncount, false, true, layout.combo_hphonecount),DATASET([{'26',risk_indicators.getHRIDesc('26')}],risk_indicators.Layout_Desc)) &			   
	IF(Risk_Indicators.rcSet.isCode29(layout.socsmiskeyflag),DATASET([{'29',risk_indicators.getHRIDesc('29')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_hphonecount),DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &			   
	IF(Risk_Indicators.rcSet.isCodeZI(layout.combo_zipscore, true, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, 
																		layout.combo_hphonecount, layout.combo_ssncount) AND rc_settings[1].IsInstantID,DATASET([{'ZI',risk_indicators.getHRIDesc('ZI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeDV(layout.dl_searched, layout.dl_exists, layout.verified_dl) AND rc_settings[1].IsInstantID,
																		DATASET([{'DV',risk_indicators.getHRIDesc('DV')}],risk_indicators.Layout_Desc))&																	
	IF(Risk_Indicators.rcSet.isCode77(layout.lname, layout.fname),DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(layout.ssn),DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.in_streetAddress),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &			
	IF(Risk_Indicators.rcSet.isCodeSR(layout.combo_sec_rangescore),DATASET([{'SR',risk_indicators.getHRIDesc('SR')}],risk_indicators.Layout_Desc)) &
  IF(Risk_Indicators.rcSet.isCodeCZ(layout.statezipflag, layout.cityzipflag) AND rc_settings[1].IsInstantID,DATASET([{'CZ',risk_indicators.getHRIDesc('CZ')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeSD(layout.in_state, map(layout.chronoaddr_isBest		=> layout.chronostate,
																												 layout.chronoaddr_isBest2	=> layout.chronostate2, 
																												 layout.chronoaddr_isBest3	=> layout.chronostate3,
																																											 layout.bestState)) AND 
		 rc_settings[1].IIDVersion>=1,DATASET([{'SD',risk_indicators.getHRIDesc('SD')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(layout.phonelastcount, layout.phoneaddrcount, layout.phonephonecount, layout.phonevalflag),DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	If((rc_settings[1].ischase and Risk_Indicators.rcSet.isCodeVerfirst(rc_settings[1].verfirst_chase)) 
			or (rc_settings[1].ischase and Risk_Indicators.rcSet.isCode48(layout.fname, layout.combo_firstcount, layout.combo_lastcount)),
				DATASET([{'48',risk_indicators.getHRIDesc('48')}],risk_indicators.Layout_Desc),
					IF(Risk_Indicators.rcSet.isCode48(layout.fname, layout.combo_firstcount, layout.combo_lastcount),
						DATASET([{'48',risk_indicators.getHRIDesc('48')}],risk_indicators.Layout_Desc))) &	
	IF(Risk_Indicators.rcSet.isCode28(layout.combo_dobcount, layout.dob),DATASET([{'28',risk_indicators.getHRIDesc('28')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeNB(layout.dob, layout.combo_DOB) AND rc_settings[1].IIDVersion>=1,DATASET([{'NB',risk_indicators.getHRIDesc('NB')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode52(layout.fname, layout.ssn, layout.firstssnmatch, layout.socsverlevel, layout.ssnExists),DATASET([{'52',risk_indicators.getHRIDesc('52')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) & 
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode41(layout.drlcvalflag),DATASET([{'41',risk_indicators.getHRIDesc('41')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(layout.zipclass),DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &	// COMMENTED OUT ON 9-20, THIS LOGIC IS INCORRECT
	IF(Risk_Indicators.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeVA(layout.ADVOAddressVacancyIndicator) AND rc_settings[1].IIDVersion>=1,DATASET([{'VA',risk_indicators.getHRIDesc('VA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode75(layout.publish_code),DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(layout.nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.phonezipflag),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode40(layout.zipclass) AND ~rc_settings[1].IsInstantID,DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCO(layout.zipclass) AND rc_settings[1].IsInstantID,DATASET([{'CO',risk_indicators.getHRIDesc('CO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeMO(layout.zipclass) AND rc_settings[1].IsInstantID,DATASET([{'MO',risk_indicators.getHRIDesc('MO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(layout.name_addr_phone, layout.phone10, layout.dirsaddr_lastscore),DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeDD(layout.dl_searched, layout.any_dl_found, layout.verified_dl) AND rc_settings[1].IsInstantID,
																		DATASET([{'DD',risk_indicators.getHRIDesc('DD')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode64(layout.name_addr_phone, layout.phone10, layout.dirsaddr_lastscore),DATASET([{'64',risk_indicators.getHRIDesc('64')}],risk_indicators.Layout_Desc)) &  // may need to check for 6 byte phones here if applicable
	IF(Risk_Indicators.rcSet.isCode81(layout.dob),DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeRS(layout.ssn, layout.socsvalflag, layout.socllowissue, layout.socsRCISflag), DATASET([{'RS',risk_indicators.getHRIDesc('RS')}],risk_indicators.Layout_Desc))&
	IF(Risk_Indicators.rcSet.isCode39(layout.socllowissue, layout.historyDate),DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode85(layout.ssn, layout.socllowissue),DATASET([{'85',risk_indicators.getHRIDesc('85')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode89(layout.socllowissue, layout.historyDate),DATASET([{'89',risk_indicators.getHRIDesc('89')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode90(layout.socllowissue, layout.dob),DATASET([{'90',risk_indicators.getHRIDesc('90')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeNF(layout.swappedNames, layout.did) AND rc_settings[1].IIDVersion>=1,DATASET([{'NF',risk_indicators.getHRIDesc('NF')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(layout.disthphoneaddr),DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode53(layout.disthphonewphone),DATASET([{'53',risk_indicators.getHRIDesc('53')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode44(layout.areacodesplitflag),DATASET([{'44',risk_indicators.getHRIDesc('44')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode55(layout.wphonevalflag),DATASET([{'55',risk_indicators.getHRIDesc('55')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode56(layout.wphonedissflag),DATASET([{'56',risk_indicators.getHRIDesc('56')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode57(layout.wphonetypeflag),DATASET([{'57',risk_indicators.getHRIDesc('57')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode46(layout.wphonetypeflag),DATASET([{'46',risk_indicators.getHRIDesc('46')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode76(layout.correctlast),DATASET([{'76',risk_indicators.getHRIDesc('76')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.phone10),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode83(layout.correctdob) AND rc_settings[1].IsInstantID,DATASET([{'83',risk_indicators.getHRIDesc('83')}],risk_indicators.Layout_Desc))&
	IF(Risk_Indicators.rcSet.isCodeDM(layout.dl_searched, layout.dl_score, layout.verified_dl) AND rc_settings[1].IsInstantID,
																		DATASET([{'DM',risk_indicators.getHRIDesc('DM')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCodeDF(layout.dl_searched, layout.dl_exists, layout.verified_dl, layout.drlcvalflag) AND rc_settings[1].IsInstantID,
																		DATASET([{'DF',risk_indicators.getHRIDesc(IF(rc_settings[1].IIDVersion>0,'DFN','DF'))}],risk_indicators.Layout_Desc)),	// call the new description for versions > 0
cnt)

ENDMACRO;