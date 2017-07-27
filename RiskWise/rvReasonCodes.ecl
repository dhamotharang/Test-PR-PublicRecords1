export rvReasonCodes(layout, cnt, inCalif, useBS2 = false) :=
MACRO

CHOOSEN(
	IF(inCalif, DATASET([{'35',risk_indicators.getHRIDesc('35')},{'00',''},{'00',''},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc)) &
	// 32 is not in this list because it's not something that is correctable
	IF(Risk_Indicators.rcSet.isCode02(layout.iid.decsflag), DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(layout.iid.socsdobflag), DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode97(layout.bjl.felony_count), DATASET([{'97',risk_indicators.getHRIDesc('97')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(layout.iid.hriskaddrflag, layout.iid.hrisksic, layout.iid.hriskphoneflag, layout.iid.hrisksicphone), DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode42(layout.iid.bansflag), DATASET([{'42',risk_indicators.getHRIDesc('42')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode43(layout.iid.bansflag, layout.iid.firstcount, layout.iid.lastcount, layout.iid.addrcount), DATASET([{'43',risk_indicators.getHRIDesc('43')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode98(layout.bjl.liens_recent_unreleased_count, layout.bjl.liens_historical_unreleased_count), DATASET([{'98',risk_indicators.getHRIDesc('98')}],risk_indicators.Layout_Desc)) &
	IF(useBS2 AND Risk_Indicators.rcSet.IsCodeEV(layout.bjl.eviction_recent_unreleased_count,layout.bjl.eviction_recent_released_count,layout.bjl.eviction_historical_unreleased_count,layout.bjl.eviction_historical_released_count), DATASET([{'EV',risk_indicators.getHRIDesc('EV')}],risk_indicators.layout_desc)) &
	IF(Risk_Indicators.rcSet.isCode19(layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount, layout.iid.combo_ssncount), DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode20(layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount, layout.iid.combo_ssncount), DATASET([{'20',risk_indicators.getHRIDesc('20')}],risk_indicators.Layout_Desc)) &
	// IF(Risk_Indicators.rcSet.isCode21(layout.shell_input.lname, layout.shell_input.phone10, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount), DATASET([{'21',risk_indicators.getHRIDesc('21')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode22(layout.shell_input.lname, layout.shell_input.in_streetAddress, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount), DATASET([{'22',risk_indicators.getHRIDesc('22')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode23(layout.shell_input.ssn, layout.shell_input.lname, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount, layout.iid.combo_ssncount), DATASET([{'23',risk_indicators.getHRIDesc('23')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode24(layout.shell_input.in_streetAddress, layout.shell_input.ssn, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_ssncount), DATASET([{'24',risk_indicators.getHRIDesc('24')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.shell_input.in_streetAddress, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount, layout.iid.combo_ssncount), DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode26(layout.shell_input.ssn, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_ssncount, true), DATASET([{'26',risk_indicators.getHRIDesc('26')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode27(layout.shell_input.phone10, layout.iid.combo_lastcount, layout.iid.combo_hphonecount), DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode28(layout.iid.combo_dobcount, layout.shell_input.dob), DATASET([{'28',risk_indicators.getHRIDesc('28')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(layout.shell_input.lname, layout.shell_input.fname), DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.shell_input.in_streetAddress), DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(layout.shell_input.ssn), DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.shell_input.phone10), DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode81(layout.shell_input.dob), DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(layout.iid.socsvalflag, layout.shell_input.ssn), DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.iid.hriskphoneflag), DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.iid.phonetype, layout.shell_input.phone10), DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(layout.phone_verification.telcordia_type), DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.iid.addrvalflag, layout.shell_input.in_streetAddress, layout.shell_input.in_city, layout.shell_input.in_state, layout.shell_input.in_zipCode), DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(layout.iid.zipclass), DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	//IF(Risk_Indicators.rcSet.isCode13, DATASET([{'13',risk_indicators.getHRIDesc('13')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.iid.hriskaddrflag), DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(layout.iid.hriskphoneflag), DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.iid.phonezipflag), DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72((string)layout.iid.socsverlevel, layout.shell_input.ssn, layout.iid.ssnExists, layout.iid.lastssnmatch2), DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode04(layout.iid.lastcount, layout.iid.socscount, layout.iid.addrcount, layout.iid.phonever_type, layout.iid.phonelastcount, layout.iid.phonephonecount, 
							    layout.iid.phoneaddrcount, layout.iid.phoneaddr_lastcount, layout.iid.phoneaddr_phonecount, layout.iid.phoneaddr_addrcount, layout.iid.utiliaddr_lastcount, 
							    layout.iid.utiliaddr_phonecount, layout.iid.utiliaddr_addrcount), DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode45(layout.iid.lastcount, layout.iid.socscount, layout.iid.addrcount, layout.iid.phonever_type, layout.iid.phonelastcount, layout.iid.phonephonecount, 
							    layout.iid.phoneaddrcount, layout.iid.phoneaddr_lastcount, layout.iid.phoneaddr_phonecount, layout.iid.phoneaddr_addrcount, layout.iid.utiliaddr_lastcount, 
							    layout.iid.utiliaddr_phonecount, layout.iid.utiliaddr_addrcount), DATASET([{'45',risk_indicators.getHRIDesc('45')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9E(layout.name_verification.source_count, layout.address_verification.input_address_information.source_count), DATASET([{'9E',risk_indicators.getHRIDesc('9E')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode37(layout.shell_input.lname, layout.iid.combo_lastcount, layout.iid.combo_addrcount, layout.iid.combo_hphonecount, layout.iid.combo_ssncount), DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode48(layout.shell_input.fname, layout.iid.combo_firstcount, layout.iid.combo_lastcount), DATASET([{'48',risk_indicators.getHRIDesc('48')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode49(layout.iid.disthphoneaddr), DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode99(layout.address_verification.input_address_information.source_count, layout.address_verification.input_address_information.isbestmatch), DATASET([{'99',risk_indicators.getHRIDesc('99')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9C(layout.address_verification.input_address_information.date_first_seen, layout.historydate), DATASET([{'9C',risk_indicators.getHRIDesc('9C')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9D(layout.address_verification.input_address_information.date_first_seen, layout.address_verification.address_history_1.date_first_seen, 
							    layout.address_verification.address_history_2.date_first_seen, layout.historydate), DATASET([{'9D',risk_indicators.getHRIDesc('9D')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.phone_verification.telcordia_type), DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode71(layout.iid.ssnExists, layout.shell_input.ssn, layout.iid.socsvalflag), DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)) &

	IF(useBS2 AND Risk_Indicators.rcSet.IsCodeMI(layout.velocity_counters.adls_per_ssn_seen_18months), DATASET([{'MI',risk_indicators.getHRIDesc('MI')}],risk_indicators.Layout_Desc)) &
	// IF(NOT (useBS2 AND Risk_Indicators.rcSet.IsCodeMI(layout.velocity_counters.adls_per_ssn_created_6months))
		// AND Risk_Indicators.rcSet.isCode38(layout.iid.altlast, layout.iid.socscount, layout.iid.lastcount, layout.iid.altlast2, layout.iid.correctlast<>''), DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	IF(useBS2 AND Risk_Indicators.rcSet.IsCodeMS(layout.velocity_counters.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode51(layout.shell_input.lname, layout.shell_input.ssn, layout.iid.lastssnmatch2, layout.iid.socsverlevel, layout.iid.ssnExists), DATASET([{'51',risk_indicators.getHRIDesc('51')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode52(layout.shell_input.fname, layout.shell_input.ssn, layout.iid.firstssnmatch, layout.iid.socsverlevel, layout.iid.ssnExists), DATASET([{'52',risk_indicators.getHRIDesc('52')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(layout.shell_input.phone10, layout.iid.phonephonecount, layout.iid.combo_hphonecount), DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(layout.iid.phonelastcount, layout.iid.phoneaddrcount, layout.iid.phonephonecount, layout.iid.phonevalflag), DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(layout.iid.name_addr_phone, layout.shell_input.phone10, layout.iid.dirsaddr_lastscore), DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode39(layout.iid.socllowissue, layout.historydate), DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode89(layout.iid.socllowissue, layout.historydate), DATASET([{'89',risk_indicators.getHRIDesc('89')}],risk_indicators.Layout_Desc)) &
	IF(useBS2 AND NOT Risk_Indicators.rcSet.isCode89(layout.iid.socllowissue, layout.historydate)
		AND Risk_Indicators.rcSet.IsCodeMN(layout.iid.socllowissue, layout.historydate), DATASET([{'MN',risk_indicators.getHRIDesc('MN')}],risk_indicators.Layout_Desc)) &

	IF(Risk_Indicators.rcSet.isCode90(layout.iid.socllowissue, layout.shell_input.dob), DATASET([{'90',risk_indicators.getHRIDesc('90')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9A(layout.address_verification.input_address_information.naprop, layout.address_verification.address_history_1.naprop, 
							    layout.address_verification.address_history_2.naprop, layout.address_verification.input_address_information.applicant_owned, 
							    layout.address_verification.input_address_information.family_owned, layout.address_verification.input_address_information.family_sold, 
							    layout.address_verification.input_address_information.applicant_sold, layout.address_verification.address_history_1.applicant_owned, 
							    layout.address_verification.address_history_1.family_owned, layout.address_verification.address_history_1.family_sold, 
							    layout.address_verification.address_history_1.applicant_sold, layout.address_verification.address_history_2.applicant_owned, 
							    layout.address_verification.address_history_2.family_owned, layout.address_verification.address_history_2.family_sold, 
							    layout.address_verification.address_history_2.applicant_sold, layout.address_verification.owned.property_total, layout.address_verification.sold.property_total, 
							    layout.address_verification.ambiguous.property_total), DATASET([{'9A',risk_indicators.getHRIDesc('9A')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9B(layout.address_verification.input_address_information.naprop, layout.address_verification.owned.property_total, 
							    layout.address_verification.address_history_1.naprop, layout.address_verification.address_history_2.naprop, layout.address_verification.sold.property_total), 
							    DATASET([{'9B',risk_indicators.getHRIDesc('9B')}],risk_indicators.Layout_Desc)) &
	IF(useBS2 AND Risk_Indicators.rcSet.isCodePV(layout.iid.dwelltype,  layout.address_verification.input_address_information.assessed_amount, layout.avm.input_address_information, (unsigned)layout.address_verification.input_address_information.census_home_value),
		DATASET([{'PV',Risk_Indicators.getHRIDesc('PV')}], risk_indicators.layout_desc)) &
	IF(Risk_Indicators.rcSet.isCode9F(layout.address_verification.input_address_information.date_last_seen, layout.address_verification.address_history_1.date_last_seen, 
							    layout.ssn_verification.credit_last_seen, layout.ssn_verification.header_last_seen, layout.historydate), DATASET([{'9F',risk_indicators.getHRIDesc('9F')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9G(layout.name_verification.age, layout.shell_input.dob, layout.historydate), DATASET([{'9G',risk_indicators.getHRIDesc('9G')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode29(layout.iid.socsmiskeyflag), DATASET([{'29',risk_indicators.getHRIDesc('29')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.iid.addrmiskeyflag), DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.iid.hphonemiskeyflag), DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode83(layout.iid.correctdob), DATASET([{'83',risk_indicators.getHRIDesc('83')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''},{'00',''},{'00',''},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc) ,	
cnt)
ENDMACRO;