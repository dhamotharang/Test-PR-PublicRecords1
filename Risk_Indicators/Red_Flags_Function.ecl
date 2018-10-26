import riskwise, fcra;

export Red_Flags_Function(GROUPED DATASET (Layout_output) iid, DATASET(riskwise.layouts.reasoncode_settings) rc_settings=DATASET([],riskwise.layouts.reasoncode_settings)) := function

addr_discrepancy_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodePA(layout.inputAddrNotMostRecent),DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
		IF(Risk_Indicators.rcSet.isCode04(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
				   layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount),
				   DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &	   
	IF(Risk_Indicators.rcSet.isCodeSR(layout.combo_sec_rangescore),DATASET([{'SR',risk_indicators.getHRIDesc('SR')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeZI(layout.combo_zipscore, true, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, 
																		layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'ZI',risk_indicators.getHRIDesc('ZI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCZ(layout.statezipflag, layout.cityzipflag),DATASET([{'CZ',risk_indicators.getHRIDesc('CZ')}],risk_indicators.Layout_Desc)),

cnt)
ENDMACRO;

suspicious_document_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode06(layout.socsvalflag, layout.ssn),DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIS(layout.ssn, layout.socsvalflag, layout.socllowissue, layout.socsRCISflag),DATASET([{'IS',risk_indicators.getHRIDesc('IS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode41(layout.drlcvalflag),DATASET([{'41',risk_indicators.getHRIDesc('41')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeDV(layout.dl_searched, layout.dl_exists, layout.verified_dl),DATASET([{'DV',risk_indicators.getHRIDesc('DV')}],risk_indicators.Layout_Desc))&
	IF(Risk_Indicators.rcSet.isCodeDF(layout.dl_searched, layout.dl_exists, layout.verified_dl, layout.drlcvalflag),DATASET([{'DF',risk_indicators.getHRIDesc(IF(rc_settings[1].IIDVersion=1,'DFN','DF'))}],risk_indicators.Layout_Desc))&
	IF(Risk_Indicators.rcSet.isCodeDM(layout.dl_searched, layout.dl_score, layout.verified_dl),DATASET([{'DM',risk_indicators.getHRIDesc('DM')}],risk_indicators.Layout_Desc))&
	IF(Risk_Indicators.rcSet.isCodeDD(layout.dl_searched, layout.any_dl_found, layout.verified_dl),DATASET([{'DD',risk_indicators.getHRIDesc('DD')}],risk_indicators.Layout_Desc)),
cnt)
ENDMACRO;


suspicious_address_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodePA(layout.inputAddrNotMostRecent),DATASET([{'PA',risk_indicators.getHRIDesc('PA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode19(layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'19',risk_indicators.getHRIDesc('19')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode04(layout.lastcount, layout.socscount, layout.addrcount, layout.phonever_type, layout.phonelastcount, layout.phonephonecount, layout.phoneaddrcount, layout.phoneaddr_lastcount,
				   layout.phoneaddr_phonecount, layout.phoneaddr_addrcount, layout.utiliaddr_lastcount, layout.utiliaddr_phonecount, layout.utiliaddr_addrcount),
				   DATASET([{'04',risk_indicators.getHRIDesc('04')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode25(layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'25',risk_indicators.getHRIDesc('25')}],risk_indicators.Layout_Desc)) &	   
	IF(Risk_Indicators.rcSet.isCodeSR(layout.combo_sec_rangescore),DATASET([{'SR',risk_indicators.getHRIDesc('SR')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode30(layout.addrmiskeyflag),DATASET([{'30',risk_indicators.getHRIDesc('30')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeZI(layout.combo_zipscore, true, layout.in_streetAddress, layout.combo_lastcount, layout.combo_addrcount, 
																		layout.combo_hphonecount, layout.combo_ssncount),DATASET([{'ZI',risk_indicators.getHRIDesc('ZI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCZ(layout.statezipflag, layout.cityzipflag),DATASET([{'CZ',risk_indicators.getHRIDesc('CZ')}],risk_indicators.Layout_Desc)),

cnt)
ENDMACRO;


suspicious_ssn_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode02(layout.decsflag),DATASET([{'02',risk_indicators.getHRIDesc('02')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode06(layout.socsvalflag, layout.ssn),DATASET([{'06',risk_indicators.getHRIDesc('06')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIS(layout.ssn, layout.socsvalflag, layout.socllowissue, layout.socsRCISflag),DATASET([{'IS',risk_indicators.getHRIDesc('IS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.IsCodeMS(layout.ssns_per_adl_seen_18months), DATASET([{'MS',risk_indicators.getHRIDesc('MS')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeIT(layout.ssn),DATASET([{'IT',risk_indicators.getHRIDesc('IT')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode39(layout.socllowissue, layout.historydate),DATASET([{'39',risk_indicators.getHRIDesc('39')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode89(layout.socllowissue, layout.historydate),DATASET([{'89',risk_indicators.getHRIDesc('89')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode90(layout.socllowissue, layout.dob),DATASET([{'90',risk_indicators.getHRIDesc('90')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode29(layout.socsmiskeyflag),DATASET([{'29',risk_indicators.getHRIDesc('29')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode71(layout.ssnExists, layout.ssn, layout.socsvalflag), DATASET([{'71',risk_indicators.getHRIDesc('71')}],risk_indicators.Layout_Desc)),

cnt)
ENDMACRO;


suspicious_dob_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode03(layout.socsdobflag),DATASET([{'03',risk_indicators.getHRIDesc('03')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode28(layout.combo_dobcount, layout.dob),DATASET([{'28',risk_indicators.getHRIDesc('28')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeNB(layout.dob, layout.combo_DOB) AND rc_settings[1].IIDVersion=1,DATASET([{'NB',risk_indicators.getHRIDesc('NB')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode83(layout.correctdob),DATASET([{'83',risk_indicators.getHRIDesc('83')}],risk_indicators.Layout_Desc)),
cnt)
ENDMACRO;


high_risk_address_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCodePO(layout.addr_type), DATASET([{'PO',risk_indicators.getHRIDesc('PO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCA(layout.ADVODropIndicator, le.hrisksic) AND rc_settings[1].IIDVersion=1,DATASET([{'CA',risk_indicators.getHRIDesc('CA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode50(layout.hriskaddrflag, layout.hrisksic, layout.hriskphoneflag, layout.hrisksicphone),DATASET([{'50',risk_indicators.getHRIDesc('50')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode11(layout.addrvalflag, layout.in_streetAddress, layout.in_city, layout.in_state, layout.in_zipCode),DATASET([{'11',risk_indicators.getHRIDesc('11')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode12(layout.zipclass),DATASET([{'12',risk_indicators.getHRIDesc('12')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode14(layout.hriskaddrflag),DATASET([{'14',risk_indicators.getHRIDesc('14')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeVA(layout.ADVOAddressVacancyIndicator) AND rc_settings[1].IIDVersion=1,DATASET([{'VA',risk_indicators.getHRIDesc('VA')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode40(layout.zipclass) AND rc_settings[1].IIDVersion=0,DATASET([{'40',risk_indicators.getHRIDesc('40')}],risk_indicators.Layout_Desc))&
	IF(Risk_Indicators.rcSet.isCodeMO(layout.zipclass) AND rc_settings[1].IIDVersion=1,DATASET([{'MO',risk_indicators.getHRIDesc('MO')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeCO(layout.zipclass) AND rc_settings[1].IIDVersion=1,DATASET([{'CO',risk_indicators.getHRIDesc('CO')}],risk_indicators.Layout_Desc)),
cnt)
ENDMACRO;

suspicious_phone_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode27(layout.phone10, layout.combo_lastcount, layout.combo_hphonecount),DATASET([{'27',risk_indicators.getHRIDesc('27')}],risk_indicators.Layout_Desc)) &			    
	IF(Risk_Indicators.rcSet.isCode74(layout.phonelastcount, layout.phoneaddrcount, layout.phonephonecount, layout.phonevalflag),DATASET([{'74',risk_indicators.getHRIDesc('74')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode07(layout.hriskphoneflag),DATASET([{'07',risk_indicators.getHRIDesc('07')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode08(layout.phonetype,layout.phone10),DATASET([{'08',risk_indicators.getHRIDesc('08')}],risk_indicators.Layout_Desc)) & 
	IF(Risk_Indicators.rcSet.isCode15(layout.hriskphoneflag),DATASET([{'15',risk_indicators.getHRIDesc('15')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode09(layout.nxx_type),DATASET([{'09',risk_indicators.getHRIDesc('09')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode10(layout.nxx_type),DATASET([{'10',risk_indicators.getHRIDesc('10')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode16(layout.phonezipflag),DATASET([{'16',risk_indicators.getHRIDesc('16')}],risk_indicators.Layout_Desc)) &	
	IF(Risk_Indicators.rcSet.isCode49(layout.disthphoneaddr),DATASET([{'49',risk_indicators.getHRIDesc('49')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode73(layout.phone10, layout.phonephonecount, layout.combo_hphonecount),DATASET([{'73',risk_indicators.getHRIDesc('73')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode31(layout.hphonemiskeyflag),DATASET([{'31',risk_indicators.getHRIDesc('31')}],risk_indicators.Layout_Desc)),

cnt)
ENDMACRO;


ssn_multiple_last_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode38(layout.altlast, layout.socscount, layout.lastcount, layout.altlast2, layout.correctlast<>''),DATASET([{'38',risk_indicators.getHRIDesc('38')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode66(layout.lname, layout.fname, layout.ssn, layout.lastcount, layout.socscount, layout.firstcount),DATASET([{'66',risk_indicators.getHRIDesc('66')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCodeMI(layout.adls_per_ssn_seen_18months),DATASET([{'MI',risk_indicators.getHRIDesc('MI')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode72((string)layout.socsverlevel, layout.ssn, layout.ssnExists, layout.lastssnmatch2),DATASET([{'72',risk_indicators.getHRIDesc('72')}],risk_indicators.Layout_Desc)) ,
cnt)
ENDMACRO;

missing_input_alerts(layout, cnt) := MACRO
CHOOSEN(
	IF(Risk_Indicators.rcSet.isCode77(layout.lname, layout.fname),DATASET([{'77',risk_indicators.getHRIDesc('77')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode79(layout.ssn),DATASET([{'79',risk_indicators.getHRIDesc('79')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode80(layout.phone10),DATASET([{'80',risk_indicators.getHRIDesc('80')}],risk_indicators.Layout_Desc)) &
	IF(Risk_Indicators.rcSet.isCode78(layout.in_streetAddress),DATASET([{'78',risk_indicators.getHRIDesc('78')}],risk_indicators.Layout_Desc)) &			
	IF(Risk_Indicators.rcSet.isCode81(layout.dob),DATASET([{'81',risk_indicators.getHRIDesc('81')}],risk_indicators.Layout_Desc)),
cnt)
ENDMACRO;


layout_pcr := RECORD
	unsigned4 seq; 				
	unsigned6 date_created;  // used for deduping the PCR records
	risk_indicators.Layout_ConsumerFlags;
END;

combined_layouts := record
	unsigned seq;
	riskwise.layouts.red_flags_online_layout;
	riskwise.layouts.red_flags_batch_layout;
end;


	did_pcr := join(iid, FCRA.Key_Override_NPCR_DID,
										left.did != 0 and
										keyed(right.s_did = left.did), 
										transform(layout_pcr,
															SELF.corrected_flag := true;
															SELF.consumer_statement_flag := (right.consumer_statement_flag='1');
															SELF.dispute_flag := (right.dispute_flag='1');
															SELF.security_freeze := (right.security_freeze='1');
															SELF.security_alert := (right.security_alert='1');
															SELF.negative_alert := (right.negative_alert='1');
															SELF.id_theft_flag := (right.id_theft_flag='1');
                              SELF.legal_hold_alert := false;  // new field that doesn't get used in NonFCRA
															SELF.seq := left.seq;
															SELF.date_created := (unsigned)right.date_created), atmost(100), keep(1) );
															
	ssn_pcr := join(iid, FCRA.Key_Override_NPCR_SSN,
										left.ssn<>'' and 
										keyed(right.ssn = left.ssn) and  
										datalib.NameMatch(left.fname,left.mname, left.lname,right.fname, right.mname, right.lname)<3,
										transform(layout_pcr,
															SELF.corrected_flag := true;
															SELF.consumer_statement_flag := (right.consumer_statement_flag='1');
															SELF.dispute_flag := (right.dispute_flag='1');
															SELF.security_freeze := (right.security_freeze='1');
															SELF.security_alert := (right.security_alert='1');
															SELF.negative_alert := (right.negative_alert='1');
															SELF.id_theft_flag := (right.id_theft_flag='1');
                              SELF.legal_hold_alert := false;  // new field that doesn't get used in NonFCRA
															SELF.seq := left.seq;
															SELF.date_created := (unsigned)right.date_created), atmost(100), keep(1) );
															
	// in the case of 2 different overrides found by ssn and did, use the most recent override record														
	fcra_flags := dedup(sort( ungroup(did_pcr + ssn_pcr), seq, -date_created), seq);


combined_layouts add_flags(iid le, fcra_flags rt) := transform
	self.seq := le.seq;
	mac_add_sequence(addr_discrepancy_alerts(le, riskwise.layouts.max_alerts), ADDRESS_DISCREPANCY);
	mac_add_sequence(suspicious_document_alerts(le, riskwise.layouts.max_alerts), SUSPICIOUS_DOCUMENTS);
	mac_add_sequence(suspicious_address_alerts(le, riskwise.layouts.max_alerts), SUSPICIOUS_ADDRESS) ;
	mac_add_sequence(suspicious_ssn_alerts(le, riskwise.layouts.max_alerts), SUSPICIOUS_SSN);
	mac_add_sequence(suspicious_dob_alerts(le, riskwise.layouts.max_alerts), SUSPICIOUS_DOB );
	mac_add_sequence(high_risk_address_alerts(le, riskwise.layouts.max_alerts), HIGH_RISK_ADDRESS );
	mac_add_sequence(suspicious_phone_alerts(le, riskwise.layouts.max_alerts), SUSPICIOUS_PHONE );
	mac_add_sequence(ssn_multiple_last_alerts(le, riskwise.layouts.max_alerts), SSN_MULTIPLE_LAST);
	mac_add_sequence(missing_input_alerts(le, riskwise.layouts.max_alerts), MISSING_INPUT);
	mac_add_sequence(if(Risk_Indicators.rcSet.isCode93(rt.id_theft_flag),
				dataset([{'93',risk_indicators.getHRIDesc('93')}],risk_indicators.Layout_Desc)), FRAUD_ALERT );
	mac_add_sequence(if(Risk_Indicators.rcSet.isCode91(rt.security_freeze),
				dataset([{'91',risk_indicators.getHRIDesc('91')}],risk_indicators.Layout_Desc)), CREDIT_FREEZE );
	mac_add_sequence(if(Risk_Indicators.rcSet.isCode93(rt.id_theft_flag),
				dataset([{'93',risk_indicators.getHRIDesc('93')}],risk_indicators.Layout_Desc)), IDENTITY_THEFT );
	
	self.ADDRESS_DISCREPANCY_CODES := ADDRESS_DISCREPANCY;
	self.SUSPICIOUS_DOCUMENTS_CODES := SUSPICIOUS_DOCUMENTS;
	self.SUSPICIOUS_ADDRESS_CODES := SUSPICIOUS_ADDRESS;
	self.SUSPICIOUS_SSN_CODES := SUSPICIOUS_SSN;
	self.SUSPICIOUS_DOB_CODES := SUSPICIOUS_DOB;
	self.HIGH_RISK_ADDRESS_CODES := HIGH_RISK_ADDRESS;
	self.SUSPICIOUS_PHONE_CODES := SUSPICIOUS_PHONE;
	self.SSN_MULTIPLE_LAST_CODES := SSN_MULTIPLE_LAST;
	self.MISSING_INPUT_CODES := MISSING_INPUT;		
	self.FRAUD_ALERT_CODES := FRAUD_ALERT;
	self.CREDIT_FREEZE_CODES := CREDIT_FREEZE;
	self.IDENTITY_THEFT_CODES := IDENTITY_THEFT;
	
	self.ADDRESS_DISCREPANCY :=  if(count(ADDRESS_DISCREPANCY) > 0, 'Y', 'N');
	self.ADDRESS_DISCREPANCY_RC1 := ADDRESS_DISCREPANCY[1].hri;		
	self.ADDRESS_DISCREPANCY_RC2 := ADDRESS_DISCREPANCY[2].hri;	
	self.ADDRESS_DISCREPANCY_RC3 := ADDRESS_DISCREPANCY[3].hri;	
	self.ADDRESS_DISCREPANCY_RC4 := ADDRESS_DISCREPANCY[4].hri;	

	self.SUSPICIOUS_DOCUMENTS :=  if(count(SUSPICIOUS_DOCUMENTS) > 0, 'Y', 'N');
	self.SUSPICIOUS_DOCUMENTS_RC1 := SUSPICIOUS_DOCUMENTS[1].hri;	
	self.SUSPICIOUS_DOCUMENTS_RC2 := SUSPICIOUS_DOCUMENTS[2].hri;	
	self.SUSPICIOUS_DOCUMENTS_RC3 := SUSPICIOUS_DOCUMENTS[3].hri;	
	self.SUSPICIOUS_DOCUMENTS_RC4 := SUSPICIOUS_DOCUMENTS[4].hri;	
	
	self.SUSPICIOUS_ADDRESS :=  if(count(SUSPICIOUS_ADDRESS) > 0, 'Y', 'N');
	self.SUSPICIOUS_ADDRESS_RC1 := SUSPICIOUS_ADDRESS[1].hri;	
	self.SUSPICIOUS_ADDRESS_RC2 := SUSPICIOUS_ADDRESS[2].hri;	
	self.SUSPICIOUS_ADDRESS_RC3 := SUSPICIOUS_ADDRESS[3].hri;	
	self.SUSPICIOUS_ADDRESS_RC4 := SUSPICIOUS_ADDRESS[4].hri;		

	self.SUSPICIOUS_SSN :=  if(count(SUSPICIOUS_SSN) > 0, 'Y', 'N');
	self.SUSPICIOUS_SSN_RC1 := SUSPICIOUS_SSN[1].hri;	
	self.SUSPICIOUS_SSN_RC2 := SUSPICIOUS_SSN[2].hri;	
	self.SUSPICIOUS_SSN_RC3 := SUSPICIOUS_SSN[3].hri;	
	self.SUSPICIOUS_SSN_RC4 := SUSPICIOUS_SSN[4].hri;		

	self.SUSPICIOUS_DOB :=  if(count(SUSPICIOUS_DOB) > 0, 'Y', 'N');
	self.SUSPICIOUS_DOB_RC1 := SUSPICIOUS_DOB[1].hri;	
	self.SUSPICIOUS_DOB_RC2 := SUSPICIOUS_DOB[2].hri;	
	self.SUSPICIOUS_DOB_RC3 := SUSPICIOUS_DOB[3].hri;	
	self.SUSPICIOUS_DOB_RC4 := SUSPICIOUS_DOB[4].hri;		

	self.HIGH_RISK_ADDRESS :=  if(count(HIGH_RISK_ADDRESS) > 0, 'Y', 'N');
	self.HIGH_RISK_ADDRESS_RC1 := HIGH_RISK_ADDRESS[1].hri;	
	self.HIGH_RISK_ADDRESS_RC2 := HIGH_RISK_ADDRESS[2].hri;	
	self.HIGH_RISK_ADDRESS_RC3 := HIGH_RISK_ADDRESS[3].hri;	
	self.HIGH_RISK_ADDRESS_RC4 := HIGH_RISK_ADDRESS[4].hri;		

	self.SUSPICIOUS_PHONE :=  if(count(SUSPICIOUS_PHONE) > 0, 'Y', 'N');
	self.SUSPICIOUS_PHONE_RC1 := SUSPICIOUS_PHONE[1].hri;	
	self.SUSPICIOUS_PHONE_RC2 := SUSPICIOUS_PHONE[2].hri;	
	self.SUSPICIOUS_PHONE_RC3 := SUSPICIOUS_PHONE[3].hri;	
	self.SUSPICIOUS_PHONE_RC4 := SUSPICIOUS_PHONE[4].hri;		

	self.SSN_MULTIPLE_LAST :=  if(count(SSN_MULTIPLE_LAST) > 0, 'Y', 'N');
	self.SSN_MULTIPLE_LAST_RC1 := SSN_MULTIPLE_LAST[1].hri;	
	self.SSN_MULTIPLE_LAST_RC2 := SSN_MULTIPLE_LAST[2].hri;	
	self.SSN_MULTIPLE_LAST_RC3 := SSN_MULTIPLE_LAST[3].hri;	
	self.SSN_MULTIPLE_LAST_RC4 := SSN_MULTIPLE_LAST[4].hri;		

	self.MISSING_INPUT :=  if(count(MISSING_INPUT) > 0, 'Y', 'N');
	self.MISSING_INPUT_RC1 := MISSING_INPUT[1].hri;	
	self.MISSING_INPUT_RC2 := MISSING_INPUT[2].hri;
	self.MISSING_INPUT_RC3 := MISSING_INPUT[3].hri;
	self.MISSING_INPUT_RC4 := MISSING_INPUT[4].hri;
	
	self.FRAUD_ALERT :=  if(count(FRAUD_ALERT) > 0, 'Y', 'N');
	self.FRAUD_ALERT_RC1 := FRAUD_ALERT[1].hri;	
	self.FRAUD_ALERT_RC2 := FRAUD_ALERT[2].hri;
	self.FRAUD_ALERT_RC3 := FRAUD_ALERT[3].hri;
	self.FRAUD_ALERT_RC4 := FRAUD_ALERT[4].hri;
	
	self.CREDIT_FREEZE :=  if(count(CREDIT_FREEZE) > 0, 'Y', 'N');
	self.CREDIT_FREEZE_RC1 := CREDIT_FREEZE[1].hri;	
	self.CREDIT_FREEZE_RC2 := CREDIT_FREEZE[2].hri;
	self.CREDIT_FREEZE_RC3 := CREDIT_FREEZE[3].hri;
	self.CREDIT_FREEZE_RC4 := CREDIT_FREEZE[4].hri;
	
	self.IDENTITY_THEFT :=  if(count(IDENTITY_THEFT) > 0, 'Y', 'N');
	self.IDENTITY_THEFT_RC1 := IDENTITY_THEFT[1].hri;	
	self.IDENTITY_THEFT_RC2 := IDENTITY_THEFT[2].hri;
	self.IDENTITY_THEFT_RC3 := IDENTITY_THEFT[3].hri;
	self.IDENTITY_THEFT_RC4 := IDENTITY_THEFT[4].hri;
	
	self := [];
end;

flags := join(iid, fcra_flags, left.seq=right.seq, add_flags(left, right), left outer, keep(1));

return flags;

end;
