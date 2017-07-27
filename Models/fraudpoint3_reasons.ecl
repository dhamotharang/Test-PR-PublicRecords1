//copy of fraudpoint3_reasons before changing to be a macro
/*For Fraudpoint 3.0, a new method of calculating reason codes was created by the Modeling team. All potential reason codes
  (initially 98 in all) have been assigned an overall "priority of importance" and have also been categorized into 12 groups. 
  To avoid redundancy across the set of reason codes returned, no group will return more than 1 or 2. After the reason codes
  from all 12 groups have been chosen, a final 'sort' by priority and a 'choosen' is done to establish the final set of reason
  code to return. 
*/

import Risk_Indicators, riskwise;

// criminal flag will toggle the inclusion of reason code 97
export fraudpoint3_reasons(ROW(risk_indicators.Layout_Boca_Shell) clam, 
													 ROW(riskwise.Layout_IP2O) ip, 
													 UNSIGNED1 cnt, 
													 BOOLEAN include_criminal = false, 
													 BOOLEAN include_FDN = false, 
													 STRING nf_seg_fraudpoint_3_0 = '', 
													 INTEGER r_C10_M_Hdr_FS_d = 0,
													 BOOLEAN isFP1510_2_0=false) := Function



layout_FP3_reasons := record 
	risk_indicators.Layout_Desc;
	unsigned1	rc_priority;
end;

unsigned1	count2	:= 2;
unsigned1 count1	:= 1;
reqInputCB    		:= clam.shell_input.lname <> '' and clam.shell_input.in_streetaddress <> '' and 
										(clam.shell_input.ssn <> '' or clam.shell_input.phone10 <> '');

//For Fraudpoint 3.0, reason codes are categorized into 12 groups which were set by the Modeling team  
groupAReasons := CHOOSEN(
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF7(clam.test_fraud.tf_lexid_count, clam.contributory_fraud.cf_lexid_count),DATASET([{'F7',risk_indicators.getHRIDesc('F7'),risk_indicators.getHRIPriority('F7')}],layout_FP3_reasons)) &
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF3(clam.test_fraud.tf_ssn_count, clam.contributory_fraud.cf_ssn_count),DATASET([{'F3',risk_indicators.getHRIDesc('F3'),risk_indicators.getHRIPriority('F3')}],layout_FP3_reasons)) &
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF5(clam.test_fraud.tf_addr_count, clam.contributory_fraud.cf_addr_count),DATASET([{'F5',risk_indicators.getHRIDesc('F5'),risk_indicators.getHRIPriority('F5')}],layout_FP3_reasons)) &
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF1(clam.test_fraud.tf_phone_count, clam.contributory_fraud.cf_phone_count),DATASET([{'F1',risk_indicators.getHRIDesc('F1'),risk_indicators.getHRIPriority('F1')}],layout_FP3_reasons)),
	count2);

groupBReasons := CHOOSEN(
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF6(clam.virtual_fraud.hi_risk_ct),DATASET([{'F6',risk_indicators.getHRIDesc('F6'),risk_indicators.getHRIPriority('F6')}],layout_FP3_reasons)) &
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF2(clam.virtual_fraud.lexid_ssn_hi_risk_ct, clam.virtual_fraud.altlexid_ssn_hi_risk_ct),DATASET([{'F2',risk_indicators.getHRIDesc('F2'),risk_indicators.getHRIPriority('F2')}],layout_FP3_reasons)) &
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF4(clam.virtual_fraud.lexid_addr_hi_risk_ct, clam.virtual_fraud.altlexid_addr_hi_risk_ct),DATASET([{'F4',risk_indicators.getHRIDesc('F4'),risk_indicators.getHRIPriority('F4')}],layout_FP3_reasons)) &
	IF(include_FDN and Risk_Indicators.rcSet.isCodeF0(clam.virtual_fraud.lexid_phone_hi_risk_ct, clam.virtual_fraud.altlexid_phone_hi_risk_ct),DATASET([{'F0',risk_indicators.getHRIDesc('F0'),risk_indicators.getHRIPriority('F0')}],layout_FP3_reasons)),
	count2);

groupCReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeIA(clam.shell_input.ip_address, ip.ipaddr<>''),DATASET([{'IA',risk_indicators.getHRIDesc('IA'),risk_indicators.getHRIPriority('IA')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeIF(ip.countrycode),DATASET([{'IF',risk_indicators.getHRIDesc('IF'),risk_indicators.getHRIPriority('IF')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeIE(ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'IE',risk_indicators.getHRIDesc('IE'),risk_indicators.getHRIPriority('IE')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeII(clam.shell_input.in_state, ip.state, ip.countrycode, ip.ipaddr<>'', ip.secondleveldomain, ip.iptype),DATASET([{'II',risk_indicators.getHRIDesc('II'),risk_indicators.getHRIPriority('II')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeIK(ip.areacode, clam.shell_input.phone10, clam.shell_input.in_state, ip.state, ip.countrycode, ip.secondleveldomain, ip.ipaddr<>'',ip.iptype),DATASET([{'IK',risk_indicators.getHRIDesc('IK'),risk_indicators.getHRIPriority('IK')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeIJ(clam.shell_input.in_zipCode, ip.zip, ip.countrycode, ip.ipaddr<>'', clam.shell_input.in_state, ip.state, ip.secondleveldomain,ip.iptype, ip.areacode, clam.shell_input.phone10),DATASET([{'IJ',risk_indicators.getHRIDesc('IJ'),risk_indicators.getHRIPriority('IJ')}],layout_FP3_reasons)) &
  IF(Risk_Indicators.rcSet.isCodeIG(ip.iptype),DATASET([{'IG',risk_indicators.getHRIDesc('IG'),risk_indicators.getHRIPriority('IG')}],layout_FP3_reasons)),
	count2);

groupEReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.IsCodeMS(clam.velocity_counters.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS'),risk_indicators.getHRIPriority('MS')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.IsCodeMI(clam.velocity_counters.adls_per_ssn_seen_18months), DATASET([{'MI',risk_indicators.getHRIDesc('MI'),risk_indicators.getHRIPriority('MI')}],layout_FP3_reasons)),
	count1);

groupFReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode90(clam.iid.socllowissue, clam.shell_input.dob), DATASET([{'90',risk_indicators.getHRIDesc('90'),risk_indicators.getHRIPriority('90')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.IsCodeMN(clam.iid.socllowissue, clam.historydate), DATASET([{'MN',risk_indicators.getHRIDesc('MN'),risk_indicators.getHRIPriority('MN')}],layout_FP3_reasons)),
	count1);

groupGReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode12(clam.iid.zipclass), DATASET([{'12',risk_indicators.getHRIDesc('12'),risk_indicators.getHRIPriority('12')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodePO(clam.shell_input.addr_type), DATASET([{'PO',risk_indicators.getHRIDesc('PO'),risk_indicators.getHRIPriority('PO')}],layout_FP3_reasons)),
	count1);

groupIReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeQI(clam.input_validation.address, clam.acc_logs.inquirySSNsPerAddr), DATASET([{'QI',risk_indicators.getHRIDesc('QI'),risk_indicators.getHRIPriority('QI')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQD(clam.input_validation.ssn_length, clam.acc_logs.inquiryAddrsPerSSN), DATASET([{'QD',risk_indicators.getHRIDesc('QD'),risk_indicators.getHRIPriority('QD')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQA(clam.input_validation.ssn_length, clam.acc_logs.inquiryPerSSN), DATASET([{'QA',risk_indicators.getHRIDesc('QA'),risk_indicators.getHRIPriority('QA')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQE(clam.input_validation.ssn_length, clam.acc_logs.inquiryDOBsPerSSN), DATASET([{'QE',risk_indicators.getHRIDesc('QE'),risk_indicators.getHRIPriority('QE')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQB(clam.input_validation.ssn_length, clam.acc_logs.inquiryADLsPerSSN), DATASET([{'QB',risk_indicators.getHRIDesc('QB'),risk_indicators.getHRIPriority('QB')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQC(clam.input_validation.ssn_length, clam.acc_logs.inquiryLNamesPerSSN), DATASET([{'QC',risk_indicators.getHRIDesc('QC'),risk_indicators.getHRIPriority('QC')}],layout_FP3_reasons)),
	count2);

groupJReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeQH(clam.input_validation.address, clam.acc_logs.inquiryLNamesPerAddr), DATASET([{'QH',risk_indicators.getHRIDesc('QH'),risk_indicators.getHRIPriority('QH')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQG(clam.input_validation.address, clam.acc_logs.inquiryADLsPerAddr), DATASET([{'QG',risk_indicators.getHRIDesc('QG'),risk_indicators.getHRIPriority('QG')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQF(clam.input_validation.address, clam.acc_logs.inquiryPerAddr), DATASET([{'QF',risk_indicators.getHRIDesc('QF'),risk_indicators.getHRIPriority('QF')}],layout_FP3_reasons)),
	count1);

groupKReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeQM(clam.input_validation.email, clam.acc_logs.inquiryADLsPerEmail), DATASET([{'QM',risk_indicators.getHRIDesc('QM'),risk_indicators.getHRIPriority('QM')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQL(clam.truedid, clam.acc_logs.inquiryemailsperadl), DATASET([{'QL',risk_indicators.getHRIDesc('QL'),risk_indicators.getHRIPriority('QL')}],layout_FP3_reasons)),
	count1);

groupLReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeS5(nf_seg_fraudpoint_3_0), DATASET([{'S5',risk_indicators.getHRIDesc('S5'),risk_indicators.getHRIPriority('S5')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeS4(nf_seg_fraudpoint_3_0), DATASET([{'S4',risk_indicators.getHRIDesc('S4'),risk_indicators.getHRIPriority('S4')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeS3(nf_seg_fraudpoint_3_0), DATASET([{'S3',risk_indicators.getHRIDesc('S3'),risk_indicators.getHRIPriority('S3')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeS2(nf_seg_fraudpoint_3_0), DATASET([{'S2',risk_indicators.getHRIDesc('S2'),risk_indicators.getHRIPriority('S2')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeS1(nf_seg_fraudpoint_3_0), DATASET([{'S1',risk_indicators.getHRIDesc('S1'),risk_indicators.getHRIPriority('S1')}],layout_FP3_reasons)),
	count1);

groupMReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodeQK(clam.input_validation.homephone, clam.acc_logs.inquiryADLsPerPhone), DATASET([{'QK',risk_indicators.getHRIDesc('QK'),risk_indicators.getHRIPriority('QK')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeQJ(clam.input_validation.homephone, clam.acc_logs.inquiryPerPhone), DATASET([{'QJ',risk_indicators.getHRIDesc('QJ'),risk_indicators.getHRIPriority('QJ')}],layout_FP3_reasons)),
	count1);

groupOReasons := CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode02(clam.iid.decsflag), DATASET([{'02',risk_indicators.getHRIDesc('02'),risk_indicators.getHRIPriority('02')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeVL(clam.truedid, clam.fdattributesv2.validationrisklevel), DATASET([{'VL',risk_indicators.getHRIDesc('VL'),risk_indicators.getHRIPriority('VL')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode03(clam.iid.socsdobflag), DATASET([{'03',risk_indicators.getHRIDesc('03'),risk_indicators.getHRIPriority('03')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeSC(clam.truedid, clam.fdattributesv2.searchcomponentrisklevel), DATASET([{'SC',risk_indicators.getHRIDesc('SC'),risk_indicators.getHRIPriority('SC')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeVX(clam.truedid, clam.fdattributesv2.variationrisklevel), DATASET([{'VX',risk_indicators.getHRIDesc('VX'),risk_indicators.getHRIPriority('VX')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode50(clam.iid.hriskaddrflag, clam.iid.hrisksic, clam.iid.hriskphoneflag, clam.iid.hrisksicphone), DATASET([{'50',risk_indicators.getHRIDesc('50'),risk_indicators.getHRIPriority('50')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeSA(clam.truedid, clam.fdattributesv2.correlationssnaddrcount), DATASET([{'SA',risk_indicators.getHRIDesc('SA'),risk_indicators.getHRIPriority('SA')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeSN(clam.input_validation.firstname, clam.input_validation.ssn_length, clam.iid.nas_summary, clam.input_validation.lastname, clam.iid.firstssnmatch, clam.iid.lastssnmatch), DATASET([{'SN',risk_indicators.getHRIDesc('SN'),risk_indicators.getHRIPriority('SN')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode71(clam.iid.ssnExists, clam.shell_input.ssn, clam.iid.socsvalflag), DATASET([{'71',risk_indicators.getHRIDesc('71'),risk_indicators.getHRIPriority('71')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeVR(clam.truedid, clam.fdattributesv2.idverrisklevel), DATASET([{'VR',risk_indicators.getHRIDesc('VR'),risk_indicators.getHRIPriority('VR')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeDR(clam.truedid, clam.fdattributesv2.divrisklevel), DATASET([{'DR',risk_indicators.getHRIDesc('DR'),risk_indicators.getHRIPriority('DR')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeIR(clam.truedid, clam.fdattributesv2.identityrisklevel), DATASET([{'IR',risk_indicators.getHRIDesc('IR'),risk_indicators.getHRIPriority('IR')}],layout_FP3_reasons)) &
  IF(Risk_Indicators.rcSet.isCodeCB(clam.truedid, clam.fdattributesv2.correlationrisklevel, reqInputCB), DATASET([{'CB',risk_indicators.getHRIDesc('CB'),risk_indicators.getHRIPriority('CB')}],layout_FP3_reasons)) &	
	IF(Risk_Indicators.rcSet.isCode38(clam.iid.altlast, clam.iid.socscount, clam.iid.lastcount, clam.iid.altlast2, clam.iid.correctlast != ''), DATASET([{'38',risk_indicators.getHRIDesc('38'),risk_indicators.getHRIPriority('38')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode06(clam.iid.socsvalflag, clam.shell_input.ssn), DATASET([{'06',risk_indicators.getHRIDesc('06'),risk_indicators.getHRIPriority('06')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode85(clam.shell_input.ssn, clam.iid.socllowissue), DATASET([{'85',risk_indicators.getHRIDesc('85'),risk_indicators.getHRIPriority('85')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeBO(clam.header_summary.ver_sources) and ~isFP1510_2_0, DATASET([{'BO',risk_indicators.getHRIDesc('BO'),risk_indicators.getHRIPriority('BO')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeHA(clam.truedid, r_C10_M_Hdr_FS_d), DATASET([{'HA',risk_indicators.getHRIDesc('HA'),risk_indicators.getHRIPriority('HA')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeVV(clam.inferred_age), DATASET([{'VV',risk_indicators.getHRIDesc('VV'),risk_indicators.getHRIPriority('VV')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode09(clam.phone_verification.telcordia_type), DATASET([{'09',risk_indicators.getHRIDesc('09'),risk_indicators.getHRIPriority('09')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeVE(clam.truedid, clam.fdattributesv2.searchvelocityrisklevel), DATASET([{'VE',risk_indicators.getHRIDesc('VE'),risk_indicators.getHRIPriority('VE')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.IsCodeFV(clam.advo_input_addr.address_vacancy_indicator), DATASET([{'FV',risk_indicators.getHRIDesc('FV'),risk_indicators.getHRIPriority('FV')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode9D(clam.address_verification.input_address_information.date_first_seen, clam.address_verification.address_history_1.date_first_seen, clam.address_verification.address_history_2.date_first_seen, clam.historydate), DATASET([{'9D',risk_indicators.getHRIDesc('9D'),risk_indicators.getHRIPriority('9D')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode14(clam.iid.hriskaddrflag), DATASET([{'14',risk_indicators.getHRIDesc('14'),risk_indicators.getHRIPriority('14')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode11(clam.iid.addrvalflag, clam.shell_input.in_streetAddress, clam.shell_input.in_city, clam.shell_input.in_state, clam.shell_input.z5), DATASET([{'11',risk_indicators.getHRIDesc('11'),risk_indicators.getHRIPriority('11')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode40(clam.iid.zipclass), DATASET([{'40',risk_indicators.getHRIDesc('40'),risk_indicators.getHRIPriority('40')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.IsCode9K(clam.shell_input.addr_type) and ~isFP1510_2_0, DATASET([{'9K',risk_indicators.getHRIDesc('9K'),risk_indicators.getHRIPriority('9K')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeSR(clam.iid.combo_sec_rangescore), DATASET([{'SR',risk_indicators.getHRIDesc('SR'),risk_indicators.getHRIPriority('SR')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodePA(clam.iid.inputAddrNotMostRecent), DATASET([{'PA',risk_indicators.getHRIDesc('PA'),risk_indicators.getHRIPriority('PA')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode16(clam.iid.phonezipflag), DATASET([{'16',risk_indicators.getHRIDesc('16'),risk_indicators.getHRIPriority('16')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode07(clam.iid.hriskphoneflag), DATASET([{'07',risk_indicators.getHRIDesc('07'),risk_indicators.getHRIPriority('07')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodePN(clam.Experian_Phone_Verification, clam.iid.nap_summary, clam.insurance_phones_summary.Insurance_Phone_Verification, clam.shell_input.phone10), DATASET([{'PN',risk_indicators.getHRIDesc('PN'),risk_indicators.getHRIPriority('PN')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode73(clam.shell_input.phone10, clam.iid.phonephonecount, clam.iid.combo_hphonecount), DATASET([{'73',risk_indicators.getHRIDesc('73'),risk_indicators.getHRIPriority('73')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeCC(clam.truedid, clam.fdattributesv2.componentcharrisklevel), DATASET([{'CC',risk_indicators.getHRIDesc('CC'),risk_indicators.getHRIPriority('CC')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodeRC(clam.truedid, clam.fdattributesv2.sourcerisklevel), DATASET([{'RC',risk_indicators.getHRIDesc('RC'),risk_indicators.getHRIPriority('RC')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCodePH(clam.shell_input.phone10, clam.iid.name_addr_phone, clam.iid.nap_summary, clam.input_validation.firstname, clam.input_validation.lastname, clam.input_validation.address), DATASET([{'PH',risk_indicators.getHRIDesc('PH'),risk_indicators.getHRIPriority('PH')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode82(clam.iid.name_addr_phone, clam.shell_input.phone10, clam.iid.dirsaddr_lastscore), DATASET([{'82',risk_indicators.getHRIDesc('82'),risk_indicators.getHRIPriority('82')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode08(clam.iid.phonetype, clam.shell_input.phone10), DATASET([{'08',risk_indicators.getHRIDesc('08'),risk_indicators.getHRIPriority('08')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode10(clam.phone_verification.telcordia_type), DATASET([{'10',risk_indicators.getHRIDesc('10'),risk_indicators.getHRIPriority('10')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode15(clam.iid.hriskphoneflag), DATASET([{'15',risk_indicators.getHRIDesc('15'),risk_indicators.getHRIPriority('15')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode75(clam.iid.publish_code), DATASET([{'75',risk_indicators.getHRIDesc('75'),risk_indicators.getHRIPriority('75')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode34(clam.iid.combo_lastcount, clam.iid.combo_addrcount, clam.iid.combo_hphonecount, clam.iid.combo_ssncount, clam.shell_input.phone10, clam.shell_input.ssn),DATASET([{'34',risk_indicators.getHRIDesc('34'),risk_indicators.getHRIPriority('34')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode49(clam.iid.disthphoneaddr), DATASET([{'49',risk_indicators.getHRIDesc('49'),risk_indicators.getHRIPriority('49')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.IsCodeFQ(clam.acc_logs.inquiries.count12), DATASET([{'FQ',risk_indicators.getHRIDesc('FQ'),risk_indicators.getHRIPriority('FQ')}],layout_FP3_reasons)) &
	IF(include_criminal and Risk_Indicators.rcSet.isCode97(clam.bjl.felony_count), DATASET([{'97',risk_indicators.getHRIDesc('97'),risk_indicators.getHRIPriority('97')}],layout_FP3_reasons)) &	
	IF(include_criminal and Risk_Indicators.rcSet.isCodeCR(clam.relatives.relative_felony_count), DATASET([{'CR',risk_indicators.getHRIDesc('CR'),risk_indicators.getHRIPriority('CR')}],layout_FP3_reasons)) &	
	IF(include_criminal and Risk_Indicators.rcSet.isCodeAR(clam.truedid, clam.fdattributesv2.assocrisklevel), DATASET([{'AR',risk_indicators.getHRIDesc('AR'),risk_indicators.getHRIPriority('AR')}],layout_FP3_reasons)) &
	IF(include_criminal and Risk_Indicators.rcSet.isCodeRF(clam.truedid, clam.relatives.relative_felony_count), DATASET([{'RF',risk_indicators.getHRIDesc('RF'),risk_indicators.getHRIPriority('RF')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode77(clam.shell_input.lname, clam.shell_input.fname), DATASET([{'77',risk_indicators.getHRIDesc('77'),risk_indicators.getHRIPriority('77')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode78(clam.shell_input.in_streetAddress), DATASET([{'78',risk_indicators.getHRIDesc('78'),risk_indicators.getHRIPriority('78')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode79(clam.shell_input.ssn), DATASET([{'79',risk_indicators.getHRIDesc('79'),risk_indicators.getHRIPriority('79')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode80(clam.shell_input.phone10), DATASET([{'80',risk_indicators.getHRIDesc('80'),risk_indicators.getHRIPriority('80')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode81(clam.shell_input.dob), DATASET([{'81',risk_indicators.getHRIDesc('81'),risk_indicators.getHRIPriority('81')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode53(clam.iid.disthphonewphone), DATASET([{'53',risk_indicators.getHRIDesc('53'),risk_indicators.getHRIPriority('53')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode55(clam.iid.wphonevalflag), DATASET([{'55',risk_indicators.getHRIDesc('55'),risk_indicators.getHRIPriority('55')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode56(clam.iid.wphonedissflag), DATASET([{'56',risk_indicators.getHRIDesc('56'),risk_indicators.getHRIPriority('56')}],layout_FP3_reasons)) &
	IF(Risk_Indicators.rcSet.isCode57(clam.iid.wphonetypeflag), DATASET([{'57',risk_indicators.getHRIDesc('57'),risk_indicators.getHRIPriority('57')}],layout_FP3_reasons)),
cnt);

emptyReasons := 
	DATASET([{'00','',99}],layout_FP3_reasons) &
	DATASET([{'00','',99}],layout_FP3_reasons) &
	DATASET([{'00','',99}],layout_FP3_reasons) &
	DATASET([{'00','',99}],layout_FP3_reasons) &
	DATASET([{'00','',99}],layout_FP3_reasons) &
	DATASET([{'00','',99}],layout_FP3_reasons);

sortRCs := choosen(sort(groupAReasons + groupBReasons + groupCReasons + groupEReasons + groupFReasons + groupGReasons +
												groupIReasons + groupJReasons + groupKReasons + groupLReasons + groupMReasons + groupOReasons + emptyReasons, 
												rc_priority),
									 cnt);

//drop priority from the layout
fp3RCs := project(sortRCs,transform(risk_indicators.Layout_Desc, self := left)); 

Return fp3RCs;

end;