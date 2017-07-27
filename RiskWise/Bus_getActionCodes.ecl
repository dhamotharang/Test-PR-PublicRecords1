export Bus_getActionCodes(orig_input, output_layout, cnt, OFAC, nas, nap) := MACRO

CHOOSEN(
	IF(OFAC AND Risk_Indicators.rcSet.isCode32(output_layout.repwatchlist_table, output_layout.repwatchlist_record_number),DATASET([{'A',risk_indicators.getFUADesc('A')}],risk_indicators.Layout_Desc)) &
	
	IF(	Risk_Indicators.rcSet.isCode02(output_layout.repDeceasedSSN) or 
		Risk_Indicators.rcSet.isCode03(output_layout.rep_socsdobflag) or
		Risk_Indicators.rcSet.isCode06(output_layout.rep_socsvalflag, output_layout.rep_ssn) or 
		Risk_Indicators.rcSet.isCode04(output_layout.rep_header_lastcount, output_layout.rep_header_ssncount, output_layout.rep_header_addrcount, 
								'P', output_layout.rep_lastcount, output_layout.rep_hphonecount, output_layout.rep_addrcount, 0, 0, 0, 0, 0, 0) or
		Risk_Indicators.rcSet.isCode45(output_layout.rep_header_lastcount, output_layout.rep_header_ssncount, output_layout.rep_header_addrcount, 
								'P', output_layout.rep_lastcount, output_layout.rep_hphonecount, output_layout.rep_addrcount, 0, 0, 0, 0, 0, 0) or						
		Risk_Indicators.rcSet.isCode38(output_layout.alt_lname_1, output_layout.rep_ssncount, output_layout.rep_lastcount, output_layout.alt_lname_2,
								 output_layout.rep_correctlast<>'') or
		Risk_Indicators.rcSet.isCode72(output_layout.RepNAS_Score, output_layout.rep_ssn, output_layout.repssnissuestate<>'', false/*output_layout.???*/) or
		nas<=6 or nas=8 or nas=10,
		DATASET([{'B',risk_indicators.getFUADesc('B')}],risk_indicators.Layout_Desc)) &
	
	IF(	Risk_Indicators.rcSet.isCode07(output_layout.rep_hriskphoneflag) or
		Risk_Indicators.rcSet.isCode08(output_layout.rep_phonetype, output_layout.rep_phone) or
		Risk_Indicators.rcSet.isCode09(output_layout.rep_nxx_type) or
		Risk_Indicators.rcSet.isCode10(output_layout.rep_nxx_type) or
		Risk_Indicators.rcSet.isCode15(output_layout.rep_hriskphoneflag) or
		Risk_Indicators.rcSet.isCode41(output_layout.rep_drlcvalflag) or
		Risk_Indicators.rcSet.isCode11(output_layout.rep_addrvalflag, orig_input.orig_rep_addr, orig_input.orig_rep_city, orig_input.orig_rep_state, orig_input.orig_rep_zip) or
		Risk_Indicators.rcSet.isCode45(output_layout.rep_header_lastcount, output_layout.rep_header_ssncount, output_layout.rep_header_addrcount, 
								'P', output_layout.rep_lastcount, output_layout.rep_hphonecount, output_layout.rep_addrcount, 0, 0, 0, 0, 0, 0) or
		(nas<=4 and (nap<=4 or nap IN [6,7,9,10])) or
		(nas=5 and nap IN [9,10]) or
		(nas=6 and (nap<=4 or nap IN [6,7,9,10])) or
		(nas=7 and (nap<=4 or nap IN [6,7,9,10])) or
		(nas=8 and nap IN [7,9]) or
		(nas=9 and (nap<=4 or nap IN [6,7,9,10])) or
		(nas=10 and nap<=4) or
		(nas=11 and (nap<=4 or nap IN [6,7,9,10])),
		DATASET([{'C',risk_indicators.getFUADesc('C')}],risk_indicators.Layout_Desc)) &
	   
	
	IF(	Risk_Indicators.rcSet.isCode07(output_layout.rep_hriskphoneflag) or
		Risk_Indicators.rcSet.isCode08(output_layout.rep_phonetype, output_layout.rep_phone) or
		Risk_Indicators.rcSet.isCode16(output_layout.rep_phonezipmismatch) or
		Risk_Indicators.rcSet.isCode15(output_layout.rep_hriskphoneflag) or
		Risk_Indicators.rcSet.isCode45(output_layout.rep_header_lastcount, output_layout.rep_header_ssncount, output_layout.rep_header_addrcount, 
								'P', output_layout.rep_lastcount, output_layout.rep_hphonecount, output_layout.rep_addrcount, 0, 0, 0, 0, 0, 0) or
		(nas in [0,1,2,5,7,8,9,12] and (nap<=5 or nap=8)) or
		(nas in [3,4] and (nap<=3 or nap in [5,8])) or
		(nas in [6,10] and (nap in [5,8])),
		DATASET([{'D',risk_indicators.getFUADesc('D')}],risk_indicators.Layout_Desc)),
cnt)


ENDMACRO;

