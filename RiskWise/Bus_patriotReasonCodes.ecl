export Bus_patriotReasonCodes(orig_input, output_layout, cnt, OFAC) := MACRO


CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(output_layout.repwatchlist_table, output_layout.repwatchlist_record_number),DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(output_layout.repDeceasedSSN),DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(output_layout.rep_socsdobflag),DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(output_layout.rep_socsvalflag, output_layout.rep_ssn),DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode19(output_layout.rep_lastcount, output_layout.rep_addrcount, output_layout.rep_hphonecount, output_layout.rep_ssncount),
														DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode71(output_layout.RepSSNExists, output_layout.rep_ssn, output_layout.rep_socsvalflag),DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72(output_layout.RepNAS_Score, output_layout.rep_ssn, output_layout.repssnissuestate<>'', false/*output_layout.????*/),DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode38(output_layout.alt_lname_1, output_layout.rep_ssncount, output_layout.rep_lastcount, output_layout.alt_lname_2,
							    output_layout.rep_correctlast<>''),
														DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode04(output_layout.rep_header_lastcount, output_layout.rep_header_ssncount, output_layout.rep_header_addrcount, 
								'P', output_layout.rep_lastcount, output_layout.rep_hphonecount, output_layout.rep_addrcount, 0, 0, 0, 0, 0, 0),
								DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode37(orig_input.orig_rep_addr, output_layout.rep_lastcount, output_layout.rep_addrcount, output_layout.rep_hphonecount, output_layout.rep_ssncount),
								DATASET([{'37',risk_indicators.getHRIDesc('37')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(orig_input.orig_rep_addr, output_layout.rep_lastcount, output_layout.rep_addrcount, output_layout.rep_hphonecount, output_layout.rep_ssncount),
								DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode77(output_layout.rep_lname, output_layout.rep_fname),DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(output_layout.rep_ssn),DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(output_layout.rep_phone),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(orig_input.orig_rep_addr),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode45(output_layout.rep_header_lastcount, output_layout.rep_header_ssncount, output_layout.rep_header_addrcount, 
								'P', output_layout.rep_lastcount, output_layout.rep_hphonecount, output_layout.rep_addrcount, 0, 0, 0, 0, 0, 0),
								DATASET([{'45',risk_indicators.getHRIDesc('45')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(output_layout.rep_phone, output_layout.rep_hphonecount, (integer)(output_layout.RepPhoneAddr1<>'')),DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode74(output_layout.rep_lastcount, output_layout.rep_addrcount, output_layout.rep_hphonecount, output_layout.rep_phonevalflag),
								DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode28(output_layout.rep_dobcount, output_layout.rep_dob),DATASET([{'28',risk_indicators.getHRIDesc('28')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(output_layout.rep_hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(output_layout.rep_phonetype, output_layout.rep_phone),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(output_layout.rep_addrvalflag, orig_input.orig_rep_addr, orig_input.orig_rep_city, orig_input.orig_rep_state, orig_input.orig_rep_zip),
								DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode41(output_layout.rep_drlcvalflag),DATASET([{'41',risk_indicators.getHRIDesc('41')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode76(output_layout.rep_correctlast),DATASET([{'76',risk_indicators.getHRIDesc('76')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode29(output_layout.rep_socsmiskeyflag),DATASET([{'29',risk_indicators.getHRIDesc('29')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(output_layout.rep_addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(output_layout.rep_phonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(output_layout.rep_zipclass),DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode75(output_layout.rep_publish_code),DATASET([{'75',risk_indicators.getHRIDesc('75')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(output_layout.rep_nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(output_layout.rep_nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(output_layout.rep_phonezipmismatch),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(output_layout.rep_zipclass),DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode82(output_layout.repphonefromaddr, output_layout.rep_phone, output_layout.rep_dirsaddr_lastscore),
								DATASET([{'82',risk_indicators.getHRIDesc('82')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode81(output_layout.rep_dob),DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode83(output_layout.rep_correctdob),DATASET([{'83',risk_indicators.getHRIDesc('83')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)


endmacro;