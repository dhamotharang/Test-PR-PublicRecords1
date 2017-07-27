import Risk_Indicators, riskwise;

export fp_avenger_reasons(ROW(risk_indicators.Layout_Boca_Shell) clam, 
													 UNSIGNED1 cnt, 
													 BOOLEAN iv_rv5_deceased=false,
													 INTEGER iv_unverified_addr_count=0,
													 INTEGER nf_fp_srchunvrfdaddrcount=0,
													 INTEGER nf_fp_srchunvrfdphonecount=0,
													 INTEGER nf_fp_vardobcountnew=0,
													 INTEGER nf_M_Bureau_ADL_FS_noTU=0,
													 STRING  nf_seg_fraudpoint_3_0='', 
													 INTEGER r_C10_M_Hdr_FS_d=0,
													 INTEGER rv_C16_Inv_SSN_Per_ADL=0,
													 INTEGER rv_I62_inq_addrs_per_adl=0
													 ) := Function

Avenger_Reasons := (
	IF(Risk_Indicators.rcSet.isCodeDC(iv_rv5_deceased), DATASET([{'DC',risk_indicators.getHRIDesc('DC')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeF6(clam.virtual_fraud.hi_risk_ct), DATASET([{'F6',risk_indicators.getHRIDesc('F6')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeVX(clam.truedid, clam.fdattributesv2.variationrisklevel), DATASET([{'VX',risk_indicators.getHRIDesc('VX')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeAI(iv_unverified_addr_count), DATASET([{'AI',risk_indicators.getHRIDesc('AI')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeMD(rv_C16_Inv_SSN_Per_ADL), DATASET([{'MD',risk_indicators.getHRIDesc('MD')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeMS(clam.velocity_counters.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIR(clam.truedid, clam.fdattributesv2.identityrisklevel), DATASET([{'IR',risk_indicators.getHRIDesc('IR')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeQO(nf_fp_srchunvrfdaddrcount), DATASET([{'QO',risk_indicators.getHRIDesc('QO')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeBO(clam.header_summary.ver_sources), DATASET([{'BO',risk_indicators.getHRIDesc('BO')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeHA(clam.truedid, r_C10_M_Hdr_FS_d), DATASET([{'HA',risk_indicators.getHRIDesc('HA')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeBT(nf_M_Bureau_ADL_FS_noTU), DATASET([{'BT',risk_indicators.getHRIDesc('BT')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeVV(clam.inferred_age), DATASET([{'VV',risk_indicators.getHRIDesc('VV')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeVE(clam.truedid, clam.fdattributesv2.searchvelocityrisklevel), DATASET([{'VE',risk_indicators.getHRIDesc('VE')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode9D(clam.address_verification.input_address_information.date_first_seen, clam.address_verification.address_history_1.date_first_seen, clam.address_verification.address_history_2.date_first_seen, clam.historydate), DATASET([{'9D',risk_indicators.getHRIDesc('9D')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeRC(clam.truedid, clam.fdattributesv2.sourcerisklevel), DATASET([{'RC',risk_indicators.getHRIDesc('RC')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeQN(rv_I62_inq_addrs_per_adl), DATASET([{'QN',risk_indicators.getHRIDesc('QN')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeQP(nf_fp_srchunvrfdphonecount), DATASET([{'QP',risk_indicators.getHRIDesc('QP')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeQR(nf_fp_vardobcountnew), DATASET([{'QR',risk_indicators.getHRIDesc('QR')}], risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeQL(clam.truedid, clam.acc_logs.inquiryemailsperadl), DATASET([{'QL',risk_indicators.getHRIDesc('QL')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeFQ(clam.acc_logs.inquiries.count12), DATASET([{'FQ',risk_indicators.getHRIDesc('FQ')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeS5(nf_seg_fraudpoint_3_0), DATASET([{'S5',risk_indicators.getHRIDesc('S5')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeS4(nf_seg_fraudpoint_3_0), DATASET([{'S4',risk_indicators.getHRIDesc('S4')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeS3(nf_seg_fraudpoint_3_0), DATASET([{'S3',risk_indicators.getHRIDesc('S3')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeS2(nf_seg_fraudpoint_3_0), DATASET([{'S2',risk_indicators.getHRIDesc('S2')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeS1(nf_seg_fraudpoint_3_0), DATASET([{'S1',risk_indicators.getHRIDesc('S1')}],risk_indicators.Layout_Desc))
	);

emptyReasons := 
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc) &
	DATASET([{'00',''}],risk_indicators.Layout_Desc);

Avenger_RCs_plus_blanks := choosen(Avenger_Reasons + emptyReasons, 
																	 cnt);

Return Avenger_RCs_plus_blanks;

end;