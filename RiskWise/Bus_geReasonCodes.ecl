export Bus_geReasonCodes(orig_input, output_layout, cnt, OFAC) := macro


CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(output_layout.repwatchlist_table, output_layout.repwatchlist_record_number),DATASET([{'32',risk_indicators.getHRIDesc('32')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode02(output_layout.repDeceasedSSN),DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode03(output_layout.rep_socsdobflag),DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(output_layout.rep_socsvalflag),DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode34(output_layout.rep_lastcount, output_layout.rep_addrcount, output_layout.rep_hphonecount, output_layout.rep_ssncount, orig_input.rep_phone, orig_input.rep_ssn),
														DATASET([{'34',risk_indicators.getHRIDesc('34')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(output_layout.rep_hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(output_layout.rep_phonetype, orig_input.rep_phone),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode09(output_layout.rep_hriskphoneflag),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(output_layout.rep_hriskphoneflag),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(output_layout.rep_addrvalflag, orig_input.rep_addr, orig_input.rep_city, orig_input.rep_state, orig_input.rep_zip),
								DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(output_layout.rep_zipclass),DATASET([{'12',risk_indicators.getHRIDesc(12)}],risk_indicators.Layout_Desc)) &
	// 13 would go here, but we can't get a 13 with ACE
	IF(Risk_Indicators.rcSet.isCode14(output_layout.rep_hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode15(output_layout.rep_hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(output_layout.rep_phonezipmismatch),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode01(orig_input.rep_fname, orig_input.rep_lname, orig_input.rep_ssn, orig_input.rep_phone, orig_input.rep_addr),
															DATASET([{'01',risk_indicators.getHRIDesc('01')}],risk_indicators.Layout_Desc)) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) ,
cnt)


endmacro;