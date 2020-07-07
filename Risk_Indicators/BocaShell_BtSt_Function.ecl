﻿import riskwise, gateway, Risk_Indicators, doxie;
//Old legacy RISKWISE services will not be shouldn't be sending in new score input fields...as otherwise
//they should be updated to use our newer services.
export BocaShell_BtSt_Function(grouped dataset(risk_indicators.layout_ciid_btst_Output) iid_btst, dataset(Gateway.Layouts.Config) gateways,
													unsigned1 dppa_val, unsigned1 glb_val, boolean isUtility=false, boolean isLN=false, 
													// optimization options
													boolean includeRelativeInfo=true, boolean includeDLInfo=true, boolean includeVehInfo=true,
													boolean includeDerogInfo = true, unsigned1 BSversion=1, boolean doScore=false, boolean nugen=false,
													string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, unsigned8 inBSOptions = 0,
													string50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
													dataset(Risk_Indicators.Layout_BocaShell_BtSt.input_Scores) input_Scores = dataset( [], Risk_Indicators.Layout_BocaShell_BtSt.input_Scores),
													boolean NetAcuity_v4 = true, boolean ipid_only = false,
													boolean skip_businessHeader = false,
                                                    unsigned1 LexIdSourceOptout = 1,
                                                    string TransactionID = '',
                                                    string BatchUID = '',
                                                    unsigned6 GlobalCompanyId = 0) := FUNCTION 
                                                    
   mod_access := MODULE(Doxie.IDataAccess)
      EXPORT glb := glb_val;
      EXPORT dppa := dppa_val;
      EXPORT DataPermissionMask := DataPermission;
      EXPORT DataRestrictionMask := DataRestriction;
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;

risk_indicators.Layout_Output norm(iid_btst L, integer C) := transform
	self.seq := L.Bill_To_Output.seq + C - 1;
	self := if (C = 1, L.Bill_To_Output, L.Ship_To_Output);
end;

iid_results := normalize(iid_btst, 2, norm(LEFT,COUNTER));
	

outf := risk_indicators.Boca_Shell_Function(iid_results, gateways, dppa_val, glb_val, isUtility, isLN, 
									includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, 
									BSversion, doScore, nugen := nugen, DataRestriction:=DataRestriction,
									BSOptions:=inBSOptions, DataPermission:=DataPermission,
                                    LexIdSourceOptout := LexIdSourceOptout, 
                                    TransactionID := TransactionID, 
                                    BatchUID := BatchUID, 
                                    GlobalCompanyID := GlobalCompanyID);

outseq := record
	unsigned4	seq;
	risk_indicators.layout_bocashell_btst_out;
end;

outseq into_out1(outf L) := transform
	self.seq := If (L.seq % 2 = 0, L.seq, skip);
	self.bill_to_out := L;
	self := [];
end;

outf2 := project(outf, into_out1(LEFT));

risk_indicators.layout_bocashell_btst_out into_out2(outf2 L, outf R) := transform
	self.ship_to_out := R;
	self := L;
end;

outf3 := join(outf2, outf, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer);

sc := risk_indicators.Score_And_Distance_Function(iid_btst, dppa_val, glb_val);

risk_indicators.layout_bocashell_btst_out add_scores(outf3 le, sc rt) := transform
	self.eddo := rt;
	self := le;
end;

wScores := join(outf3, sc, left.bill_to_out.seq=right.seq, add_scores(left, right));

riskwise.Layout_IPAI prep_ips(iid_btst le) := transform
	self.seq := le.bill_to_output.seq;
	self.ipaddr := le.Bill_to_output.ip_address;
	self.did := le.Bill_to_output.did;
end;

preNetAcuity := ungroup(project(iid_btst, prep_ips(left)));

ips := if(ipid_only, dataset([], riskwise.Layout_IP2O),risk_indicators.getNetAcuity(preNetAcuity, gateways, dppa_val, glb_val, NetAcuity_v4, applyOptOut := TRUE));

risk_indicators.layout_bocashell_btst_out add_ips(wScores le, ips rt) := transform
	self.ip2o := rt;
	self := le;
end;

wIPs := join(wScores, ips, left.bill_to_out.seq=right.seq, add_ips(left,right),left outer);
wIPs2 := group(sort(wIPs, bill_to_out.seq),bill_to_out.seq);

//CBD 5.0 Start:
//only want to run records that have a valid BT did that is not 	
iid_btst_filtered := iid_btst(Bill_To_Output.did != 0 and ship_to_output.did != 0 and ship_to_output.did != Bill_To_Output.did);
//want to get only the records that are not valid - in right side - NOT in left
WithNeg1s := join(iid_btst, iid_btst_filtered,
	left.Bill_To_Output.seq = right.Bill_To_Output.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_did_summary := map(
			left.Bill_To_Output.did != 0 and left.Ship_To_Output.did = 0 => 1,
			left.Bill_To_Output.did =  0 and left.Ship_To_Output.did != 0 => 2,
			left.Bill_To_Output.did != 0 and left.Ship_To_Output.did = left.Bill_To_Output.did  => 3,
			left.Bill_To_Output.did != 0 and left.Ship_To_Output.did != left.Bill_To_Output.did  => 4,
					0),
		NotGoodDidDefault := if(self.btst_did_summary < 4, true, false);
		//Only populate if BT and ST different and NOT 0s, -1 otherwise
		self.btst_emails_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_free_emails_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_isp_emails_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_edu_emails_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_corp_emails_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_last_names_in_common:= if(NotGoodDidDefault, -1, 0);
		self.btst_businesses_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_property_deeds_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_addrs_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_owned_addrs_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_lres_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_addr_dists_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_addr_states_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_phones_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_landlines_in_common := if(NotGoodDidDefault, -1, 0);
		self.btst_cellphones_in_common := if(NotGoodDidDefault, -1, 0);
		self.bill_to_out := left.bill_to_output;
		self.ship_to_out := left.ship_to_output;
		self := left;
		self := []), atmost(riskwise.max_atmost), left only, parallel);

// skip the business header searching to make the query faster for OSN1608 for vivid seats
btst_without_busHeader := project(iid_btst,
transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_did_summary := map(
																left.bill_to_output.did != 0 and left.ship_to_output.did = 0 => 1,
																left.bill_to_output.did = 0 and left.ship_to_output.did != 0 => 2,
																left.bill_to_output.did != 0 and left.ship_to_output.did = left.bill_to_output.did  => 3,
																left.bill_to_output.did != 0 and left.ship_to_output.did != left.bill_to_output.did  => 4,
																		0);
		self.Bill_To_Out := left.Bill_To_Output;
		self.Ship_To_Out := left.Ship_To_Output;
		self := [];
				));

btst_wBusHdr := risk_indicators.Boca_Shell_BtSt_Bus_Header(iid_btst, glb_val, dppa_val, DataRestriction, DataPermission, mod_access);
//verify if did is populated that this works
btst_wDidSum_original := JOIN(btst_wBusHdr, btst_wBusHdr,
	left.bill_to_out.seq = right.ship_to_out.seq - 1,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_did_summary := map(
		left.bill_to_out.did != 0 and left.ship_to_out.did = 0 => 1,
		left.bill_to_out.did = 0 and left.ship_to_out.did != 0 => 2,
		left.bill_to_out.did != 0 and left.ship_to_out.did = left.bill_to_out.did  => 3,
		left.bill_to_out.did != 0 and left.ship_to_out.did != left.bill_to_out.did  => 4,
				0);
	self.btst_bt_bip_addr_ct := right.btst_bt_bip_addr_ct;
	self.btst_st_bip_addr_ct := right.btst_st_bip_addr_ct;
	self.btst_bt_addr_bip_match := right.btst_bt_addr_bip_match;
	self.btst_st_addr_bip_match := right.btst_st_addr_bip_match;
		self.bill_to_out := left.bill_to_out;
		self.ship_to_out := left.ship_to_out,
		self := left), atmost(riskwise.max_atmost), left outer, parallel);

btst_wDidSum := if(skip_businessHeader, ungroup(btst_without_busHeader), btst_wDidSum_original);

btst_header := Risk_Indicators.Boca_Shell_BtSt_Header(iid_btst_filtered);
btst_wHeader := join(btst_wDidSum, btst_header,
	left.bill_to_out.seq = right.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
	self.btst_last_names_in_common := right.btst_last_names_in_common;
	self := left), atmost(riskwise.max_atmost),
	left outer, parallel);

btst_trajectory := Risk_Indicators.getBSTSEconomicTrajectory(outf);
btst_wTraj := join(btst_wHeader, btst_trajectory,
	left.bill_to_out.seq = right.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
	self.btst_economic_trajectory := if(left.btst_did_summary < 4, -1, right.economic_trajectory);
	self := left),atmost(riskwise.max_atmost), 
	left outer, parallel);

btst_inquiries := Risk_Indicators.Boca_Shell_BtSt_Inquiries(iid_btst, bsVersion,gateways, mod_access);
btst_wInq := join(btst_wTraj, btst_inquiries,
	left.bill_to_out.seq = right.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_cbd_inq_ver_count := right.btst_cbd_inq_ver_count;
		self.btst_cbd_ids_per_st_id_ct := right.btst_cbd_ids_per_st_id_ct;
		self.btst_cbd_ids_per_bt_id_ct := right.btst_cbd_ids_per_bt_id_ct;
	  self.bt_addr_found_on_st_inq_count := right.bt_addr_found_on_st_inq_count;
		self.bt_phone_found_on_st_inq_count := right.bt_phone_found_on_st_inq_count ;
		self.bt_ssn_found_on_st_inq_count := right.bt_ssn_found_on_st_inq_count;
		self.bt_phone_found_on_st_inq_auto_count := right.bt_phone_found_on_st_inq_auto_count ;
		self.bt_addr_found_on_st_inq_auto_count :=right.bt_addr_found_on_st_inq_auto_count;
		self.bt_ssn_found_on_st_inq_auto_count := right.bt_ssn_found_on_st_inq_auto_count;
		self.bt_phone_found_on_st_inq_banking_count := right.bt_phone_found_on_st_inq_banking_count;
		self.bt_addr_found_on_st_inq_banking_count  := right.bt_addr_found_on_st_inq_banking_count;
		self.bt_ssn_found_on_st_inq_banking_count  := right.bt_ssn_found_on_st_inq_banking_count; 
		self.bt_phone_found_on_st_inq_Collection_count :=right.bt_phone_found_on_st_inq_Collection_count ;
		self.bt_addr_found_on_st_inq_Collection_count := right.bt_addr_found_on_st_inq_Collection_count;
		self.bt_ssn_found_on_st_inq_Collection_count  := right.bt_ssn_found_on_st_inq_Collection_count ;
		self.bt_phone_found_on_st_inq_Mortgage_count := right.bt_phone_found_on_st_inq_Mortgage_count ;
		self.bt_addr_found_on_st_inq_Mortgage_count  := right.bt_addr_found_on_st_inq_Mortgage_count ;
		self.bt_ssn_found_on_st_inq_Mortgage_count := right.bt_ssn_found_on_st_inq_Mortgage_count ; 
		self.bt_phone_found_on_st_inq_HighRiskCredit_count  := right.bt_phone_found_on_st_inq_HighRiskCredit_count;
		self.bt_addr_found_on_st_inq_HighRiskCredit_count := right.bt_addr_found_on_st_inq_HighRiskCredit_count;
		self.bt_ssn_found_on_st_inq_HighRiskCredit_count := right.bt_ssn_found_on_st_inq_HighRiskCredit_count;
		self.bt_phone_found_on_st_inq_Retail_count  := right.bt_phone_found_on_st_inq_Retail_count;
		self.bt_addr_found_on_st_inq_Retail_count := right.bt_addr_found_on_st_inq_Retail_count ;			
		self.bt_ssn_found_on_st_inq_Retail_count := right.bt_ssn_found_on_st_inq_Retail_count;
		self.bt_phone_found_on_st_inq_Communications_count := right.bt_phone_found_on_st_inq_Communications_count;
		self.bt_addr_found_on_st_inq_Communications_count := right.bt_addr_found_on_st_inq_Communications_count;
		self.bt_ssn_found_on_st_inq_Communications_count  := right.bt_ssn_found_on_st_inq_Communications_count;
		self.bt_phone_found_on_st_inq_Other_count    := right.bt_phone_found_on_st_inq_Other_count;
		self.bt_addr_found_on_st_inq_Other_count  := right.bt_addr_found_on_st_inq_Other_count ;   
		self.bt_ssn_found_on_st_inq_Other_count := right.bt_ssn_found_on_st_inq_Other_count;      
		self.bt_phone_found_on_st_inq_prepaidCards_count  := right.bt_phone_found_on_st_inq_prepaidCards_count;
		self.bt_addr_found_on_st_inq_prepaidCards_count := right.bt_addr_found_on_st_inq_prepaidCards_count;
		self.bt_ssn_found_on_st_inq_prepaidCards_count  := right.bt_ssn_found_on_st_inq_prepaidCards_count ;
		self.bt_phone_found_on_st_inq_QuizProvider_count  := right.bt_phone_found_on_st_inq_QuizProvider_count ; 
		self.bt_addr_found_on_st_inq_QuizProvider_count := right.bt_addr_found_on_st_inq_QuizProvider_count;
		self.bt_ssn_found_on_st_inq_QuizProvider_count  := right.bt_ssn_found_on_st_inq_QuizProvider_count;
		self.bt_phone_found_on_st_inq_retailPayments_count := right.bt_phone_found_on_st_inq_retailPayments_count;
		self.bt_addr_found_on_st_inq_retailPayments_count := right.bt_addr_found_on_st_inq_retailPayments_count ;
		self.bt_ssn_found_on_st_inq_retailPayments_count  := right.bt_ssn_found_on_st_inq_retailPayments_count ; 
		self.bt_phone_found_on_st_inq_StudentLoans_count  := right.bt_phone_found_on_st_inq_StudentLoans_count ;
		self.bt_addr_found_on_st_inq_StudentLoans_count  := right.bt_addr_found_on_st_inq_StudentLoans_count; 
		self.bt_ssn_found_on_st_inq_StudentLoans_count := right.bt_ssn_found_on_st_inq_StudentLoans_count;
		self.bt_phone_found_on_st_inq_Utilities_count  := right.bt_phone_found_on_st_inq_Utilities_count ;
		self.bt_addr_found_on_st_inq_Utilities_count  := right.bt_addr_found_on_st_inq_Utilities_count ; 
		self.bt_ssn_found_on_st_inq_Utilities_count := right.bt_ssn_found_on_st_inq_Utilities_count ;
		self.st_addr_found_on_bt_inq_count := right.st_addr_found_on_bt_inq_count;
		self.st_phone_found_on_bt_inq_count := right.st_phone_found_on_bt_inq_count;
		self.st_ssn_found_on_bt_inq_count :=  right.st_ssn_found_on_bt_inq_count;
		self.st_phone_found_on_bt_inq_auto_count := right.st_phone_found_on_bt_inq_auto_count;
		self.st_addr_found_on_bt_inq_auto_count := right.st_addr_found_on_bt_inq_auto_count;
		self.st_ssn_found_on_bt_inq_auto_count := right.st_ssn_found_on_bt_inq_auto_count;
		self.st_phone_found_on_bt_inq_banking_count :=  right.st_phone_found_on_bt_inq_banking_count;	
		self.st_addr_found_on_bt_inq_banking_count  := right.st_addr_found_on_bt_inq_banking_count;
		self.st_ssn_found_on_bt_inq_banking_count  := right.st_ssn_found_on_bt_inq_banking_count; 
		self.st_phone_found_on_bt_inq_Collection_count :=right.st_phone_found_on_bt_inq_Collection_count;
		self.st_addr_found_on_bt_inq_Collection_count := right.st_addr_found_on_bt_inq_Collection_count;
		self.st_ssn_found_on_bt_inq_Collection_count  := right.st_ssn_found_on_bt_inq_Collection_count;
		self.st_phone_found_on_bt_inq_Mortgage_count := right.st_phone_found_on_bt_inq_Mortgage_count;
		self.st_addr_found_on_bt_inq_Mortgage_count  := right.st_addr_found_on_bt_inq_Mortgage_count;
		self.st_ssn_found_on_bt_inq_Mortgage_count := right.st_ssn_found_on_bt_inq_Mortgage_count; 
		self.st_phone_found_on_bt_inq_HighRiskCredit_count  := right.st_phone_found_on_bt_inq_HighRiskCredit_count;
		self.st_addr_found_on_bt_inq_HighRiskCredit_count := right.st_addr_found_on_bt_inq_HighRiskCredit_count;
		self.st_ssn_found_on_bt_inq_HighRiskCredit_count := right.st_ssn_found_on_bt_inq_HighRiskCredit_count;
		self.st_phone_found_on_bt_inq_Retail_count  :=  right.st_phone_found_on_bt_inq_Retail_count;
		self.st_addr_found_on_bt_inq_Retail_count := right.st_addr_found_on_bt_inq_Retail_count;			
		self.st_ssn_found_on_bt_inq_Retail_count := right.st_ssn_found_on_bt_inq_Retail_count;
		self.st_phone_found_on_bt_inq_Communications_count := right.st_phone_found_on_bt_inq_Communications_count;
		self.st_addr_found_on_bt_inq_Communications_count := right.st_addr_found_on_bt_inq_Communications_count;
		self.st_ssn_found_on_bt_inq_Communications_count  :=  right.st_ssn_found_on_bt_inq_Communications_count;
		self.st_phone_found_on_bt_inq_Other_count    := right.st_phone_found_on_bt_inq_Other_count;
		self.st_addr_found_on_bt_inq_Other_count  := right.st_addr_found_on_bt_inq_Other_count;   
		self.st_ssn_found_on_bt_inq_Other_count := right.st_ssn_found_on_bt_inq_Other_count;      
		self.st_phone_found_on_bt_inq_prepaidCards_count  := right.st_phone_found_on_bt_inq_prepaidCards_count;
		self.st_addr_found_on_bt_inq_prepaidCards_count := right.st_addr_found_on_bt_inq_prepaidCards_count;
		self.st_ssn_found_on_bt_inq_prepaidCards_count  := right.st_ssn_found_on_bt_inq_prepaidCards_count;
		self.st_phone_found_on_bt_inq_QuizProvider_count  :=  right.st_phone_found_on_bt_inq_QuizProvider_count; 
		self.st_addr_found_on_bt_inq_QuizProvider_count := right.st_addr_found_on_bt_inq_QuizProvider_count;
		self.st_ssn_found_on_bt_inq_QuizProvider_count  := right.st_ssn_found_on_bt_inq_QuizProvider_count;
		self.st_phone_found_on_bt_inq_retailPayments_count := right.st_phone_found_on_bt_inq_retailPayments_count;
		self.st_addr_found_on_bt_inq_retailPayments_count := right.st_addr_found_on_bt_inq_retailPayments_count;
		self.st_ssn_found_on_bt_inq_retailPayments_count  :=  right.st_ssn_found_on_bt_inq_retailPayments_count; 
		self.st_phone_found_on_bt_inq_StudentLoans_count  := right.st_phone_found_on_bt_inq_StudentLoans_count;
		self.st_addr_found_on_bt_inq_StudentLoans_count  := right.st_addr_found_on_bt_inq_StudentLoans_count; 
		self.st_ssn_found_on_bt_inq_StudentLoans_count := right.st_ssn_found_on_bt_inq_StudentLoans_count;
		self.st_phone_found_on_bt_inq_Utilities_count  := right.st_phone_found_on_bt_inq_Utilities_count;
		self.st_addr_found_on_bt_inq_Utilities_count  := right.st_addr_found_on_bt_inq_Utilities_count; 
		self.st_ssn_found_on_bt_inq_Utilities_count := right.st_ssn_found_on_bt_inq_Utilities_count;
	self := left), 
	left outer, parallel);

btst_student := Risk_Indicators.Boca_Shell_BtSt_Student(outf);
btst_wstudent := join(btst_wInq, btst_student,
	left.bill_to_out.seq = right.bt_seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_schools_in_common := right.btst_schools_in_common;
	self := left),atmost(riskwise.max_atmost),
	left outer, parallel);

btst_email := Risk_Indicators.Boca_Shell_BtSt_Email(iid_btst_filtered, mod_access);
btst_wemail := join(btst_wstudent, btst_email,
	left.bill_to_out.seq = right.bt_seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_emails_in_common := right.btst_emails_in_common;
		self.btst_free_emails_in_common := right.btst_free_emails_in_common;
		self.btst_isp_emails_in_common := right.btst_isp_emails_in_common;
		self.btst_edu_emails_in_common := right.btst_edu_emails_in_common;
		self.btst_corp_emails_in_common := right.btst_corp_emails_in_common;
	self := left), atmost(riskwise.max_atmost),
	left outer, parallel);

btst_phones := Risk_Indicators.Boca_Shell_BtSt_Phones(iid_btst_filtered, dppa_val, glb_val, DataRestriction, mod_access);
btst_wphones := join(btst_wemail, btst_phones,
	left.bill_to_out.seq = right.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_phones_in_common := right.btst_phones_in_common;
		self.btst_landlines_in_common := right.btst_landlines_in_common;
		self.btst_cellphones_in_common := right.btst_cellphones_in_common;
	self := left), atmost(riskwise.max_atmost),
	left outer, parallel);
	
btst_Deeds_Addrs := Risk_Indicators.Boca_Shell_BtSt_Address(iid_btst_filtered, dppa_val, glb_val, DataRestriction, BSversion);
btst_wDeeds_Addrs := join(btst_wphones, btst_Deeds_Addrs,
	left.bill_to_out.seq = right.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_owned_addrs_in_common := right.btst_owned_addrs_in_common;
		self.btst_property_deeds_in_common := right.btst_property_deeds_in_common;
		self.btst_addrs_in_common := right.btst_addrs_in_common;
		self.btst_lres_in_common := right.btst_lres_in_common;
		self.btst_addr_dists_in_common := right.btst_addr_dists_in_common;
		self.btst_addr_states_in_common := right.btst_addr_states_in_common;
	self := left), atmost(riskwise.max_atmost),
	left outer, parallel);

btst_with3rdPrtyScores := join(btst_wDeeds_Addrs, input_Scores,
	left.bill_to_out.seq = (right.seq * 2),
	transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_DeviceProvider1_score := if(right.DeviceProvider1_value = '', '-1', risk_indicators.iid_constants.DeviceProvider1Score(right.DeviceProvider1_value));//right.kountscore;     
		self.btst_DeviceProvider2_score := if(right.DeviceProvider2_value = '', '-1', risk_indicators.iid_constants.DeviceProvider2Score(right.DeviceProvider2_value));//right.tmxscore;     
		self.btst_DeviceProvider3_score := if(right.DeviceProvider3_value = '', '-1', risk_indicators.iid_constants.DeviceProvider3Score(right.DeviceProvider3_value));//right.lovationscore;        
		self.btst_DeviceProvider4_score := if(right.DeviceProvider4_value = '', '-1', risk_indicators.iid_constants.DeviceProvider4Score(right.DeviceProvider4_value));//right.para41score;
		self.btst_order_type := right.btst_order_type,
	self := left),atmost(riskwise.max_atmost), keep(1),
	left outer, parallel);
//CBD 5.0 END //except relative changes below for it;

//get relative info for cbd attributes
relatives := risk_indicators.getBTSTrelInfo(iid_btst);

risk_indicators.layout_bocashell_btst_out addRels(wIPs2 le, relatives ri) := TRANSFORM
	self.eddo.btst_are_relatives := ri.billto_shipto_are_relative;
	self.eddo.btst_relatives_in_common := ri.billto_shipto_share_common_relatives,
	shipto_order    := (((integer) le.eddo.addrscore < 80) and le.Ship_To_Out.addrPop);//le.Ship_To_Out.Input_Validation.address);
	both_dids_found := (ri.bill_to_output_did > 0 and ri.ship_to_output_did > 0);
	different_dids  := (ri.bill_to_output_did != ri.ship_to_output_did);
	not_related     := (not (self.eddo.btst_are_relatives or self.eddo.btst_relatives_in_common));
	self.isShipToBillToDifferent := (
			shipto_order
			and both_dids_found
			and different_dids
			and not_related);
	// self.btst_closest_association := ri.btst_closest_association;
	self.btst_association_type := ri.btst_association_type;
	self.btst_association_confidence := ri.btst_association_confidence;
	self.btst_cohabit_cnt := ri.btst_cohabit_cnt;
	self.btst_overlap_mths := ri.btst_overlap_mths;
	self.btst_any_lname_match := ri.btst_any_lname_match;
	self.btst_any_phone_match := ri.btst_any_phone_match;
	self.btst_early_lname_match := ri.btst_early_lname_match;
	self.btst_curr_lname_match := ri.btst_curr_lname_match;
	self.btst_mixed_lname_match := ri.btst_mixed_lname_match;
	self.btst_personal_association := ri.btst_personal_association;
	self.btst_business_association := ri.btst_business_association;
	self.btst_other_association := ri.btst_other_association;
	self.btst_st_relation_to_bt := ri.btst_st_relation_to_bt;
	self.btst_st_associate_or_relative := ri.btst_st_associate_or_relative;
	self.btst_st_isbusiness := ri.btst_st_isbusiness;	
	//self.relly_did := ri.relly_did;
	self := le;
END;
wRels := join(wIPs2, relatives, left.bill_to_out.seq=right.seq, addRels(left,right), left outer, parallel);

iid_btstWithNeg1s := join(wRels, WithNeg1s, 
	left.Bill_To_Out.seq = right.bill_to_out.seq,
	transform(risk_indicators.layout_bocashell_btst_out,
		self.bill_to_out := left.bill_to_out;
		self.ship_to_out := left.ship_to_out;
		UseNeg1s := left.Bill_To_Out.seq = right.bill_to_out.seq;
		self.btst_did_summary := if(UseNeg1s, right.btst_did_summary, left.btst_did_summary);
		self.btst_emails_in_common := if(UseNeg1s, right.btst_emails_in_common, left.btst_emails_in_common);
		self.btst_free_emails_in_common :=if(UseNeg1s, right.btst_free_emails_in_common, left.btst_free_emails_in_common);
		self.btst_isp_emails_in_common := if(UseNeg1s, right.btst_isp_emails_in_common, left.btst_isp_emails_in_common);
		self.btst_edu_emails_in_common := if(UseNeg1s, right.btst_edu_emails_in_common, left.btst_edu_emails_in_common);
		self.btst_corp_emails_in_common := if(UseNeg1s, right.btst_corp_emails_in_common, left.btst_corp_emails_in_common);
		self.btst_last_names_in_common:= if(UseNeg1s, right.btst_last_names_in_common, left.btst_last_names_in_common);
		self.btst_businesses_in_common := if(UseNeg1s, right.btst_businesses_in_common, left.btst_businesses_in_common);
		self.btst_property_deeds_in_common := if(UseNeg1s, right.btst_property_deeds_in_common, left.btst_property_deeds_in_common);
		self.btst_addrs_in_common := if(UseNeg1s, right.btst_addrs_in_common, left.btst_addrs_in_common);
		self.btst_owned_addrs_in_common :=if(UseNeg1s, right.btst_owned_addrs_in_common, left.btst_owned_addrs_in_common);
		self.btst_lres_in_common := if(UseNeg1s, right.btst_lres_in_common, left.btst_lres_in_common);
		self.btst_addr_dists_in_common := if(UseNeg1s, right.btst_addr_dists_in_common, left.btst_addr_dists_in_common);
		self.btst_addr_states_in_common := if(UseNeg1s, right.btst_addr_states_in_common, left.btst_addr_states_in_common);
		self.btst_phones_in_common := if(UseNeg1s, right.btst_phones_in_common, left.btst_corp_emails_in_common);
		self.btst_landlines_in_common := if(UseNeg1s, right.btst_landlines_in_common, left.btst_landlines_in_common);
		self.btst_cellphones_in_common := if(UseNeg1s, right.btst_cellphones_in_common, left.btst_cellphones_in_common);
		self := left;
		self := []), atmost(riskwise.max_atmost), left outer, parallel);



wRels2 := group(sort(iid_btstWithNeg1s, bill_to_out.seq),bill_to_out.seq);

final_tmp := if(bsVersion>=3, wRels2, wIPs2);

risk_indicators.layout_bocashell_btst_out addBTSTInfo (risk_indicators.layout_bocashell_btst_out l, risk_indicators.layout_bocashell_btst_out r) := transform
	//self.btst_closest_association := l.btst_closest_association;
	self.btst_did_summary := if(l.btst_did_summary > 0, l.btst_did_summary, r.btst_did_summary);	
	UseRight := if(self.btst_did_summary >= 4, true, false);
	
	self.btst_DeviceProvider1_score := r.btst_DeviceProvider1_score;  //KountScore   
	self.btst_DeviceProvider2_score := r.btst_DeviceProvider2_score;  //TmxScore   
	self.btst_DeviceProvider3_score := r.btst_DeviceProvider3_score;  //lovationScore      
	self.btst_DeviceProvider4_score := r.btst_DeviceProvider4_score;  //Para41Score
	self.btst_order_type := r.btst_order_type;
	//relative attributes
	self.btst_association_type := l.btst_association_type;
	self.btst_association_confidence := l.btst_association_confidence;
	self.btst_cohabit_cnt := l.btst_cohabit_cnt;
	self.btst_overlap_mths := l.btst_overlap_mths;
	self.btst_any_lname_match := l.btst_any_lname_match;
	self.btst_any_phone_match := l.btst_any_phone_match;
	self.btst_early_lname_match := l.btst_early_lname_match;
	self.btst_curr_lname_match := l.btst_curr_lname_match;
	self.btst_mixed_lname_match := l.btst_mixed_lname_match;
	self.btst_personal_association := l.btst_personal_association;
	self.btst_business_association := l.btst_business_association;
	self.btst_other_association := l.btst_other_association;
	self.btst_st_relation_to_bt := l.btst_st_relation_to_bt;
	self.btst_st_associate_or_relative := l.btst_st_associate_or_relative;
	self.btst_st_isbusiness := l.btst_st_isbusiness;	
	
	self.btst_bt_bip_addr_ct := r.btst_bt_bip_addr_ct;
	self.btst_bt_addr_bip_match := r.btst_bt_addr_bip_match;
	self.btst_st_bip_addr_ct := r.btst_st_bip_addr_ct;
	self.btst_st_addr_bip_match := r.btst_st_addr_bip_match;
	self.btst_businesses_in_common := r.btst_businesses_in_common;
	self.st_addr_is_bt_business_addr := r.st_addr_is_bt_business_addr;
 //good below
	self.btst_economic_trajectory := r.btst_economic_trajectory;
	
	self.btst_cbd_inq_ver_count := r.btst_cbd_inq_ver_count;
	self.btst_cbd_ids_per_st_id_ct := r.btst_cbd_ids_per_st_id_ct;
	self.btst_cbd_ids_per_bt_id_ct := r.btst_cbd_ids_per_bt_id_ct;

	self.btst_schools_in_common := l.btst_schools_in_common;
	
	self.btst_emails_in_common := if(UseRight, r.btst_emails_in_common, l.btst_emails_in_common);
	self.btst_free_emails_in_common := if(UseRight, r.btst_free_emails_in_common, l.btst_free_emails_in_common);
	self.btst_isp_emails_in_common := if(UseRight, r.btst_isp_emails_in_common, l.btst_isp_emails_in_common);
	self.btst_edu_emails_in_common := if(UseRight, r.btst_edu_emails_in_common, l.btst_edu_emails_in_common);
	self.btst_corp_emails_in_common := if(UseRight, r.btst_corp_emails_in_common, l.btst_corp_emails_in_common);
	self.btst_last_names_in_common := if(UseRight, r.btst_last_names_in_common, l.btst_last_names_in_common);
	self.btst_phones_in_common := if(UseRight, r.btst_phones_in_common, l.btst_phones_in_common);
	self.btst_landlines_in_common := if(UseRight, r.btst_landlines_in_common, l.btst_landlines_in_common);
	self.btst_cellphones_in_common := if(UseRight, r.btst_cellphones_in_common, l.btst_cellphones_in_common);
	self.btst_owned_addrs_in_common := if(UseRight, r.btst_owned_addrs_in_common, l.btst_owned_addrs_in_common);
	self.btst_property_deeds_in_common := if(UseRight, r.btst_property_deeds_in_common, l.btst_property_deeds_in_common);
	self.btst_addrs_in_common := if(UseRight, r.btst_addrs_in_common, l.btst_addrs_in_common);
	self.btst_lres_in_common := if(UseRight, r.btst_lres_in_common, l.btst_lres_in_common);
	self.btst_addr_dists_in_common :=if(UseRight, r.btst_addr_dists_in_common,  l.btst_addr_dists_in_common);
	self.btst_addr_states_in_common := if(UseRight, r.btst_addr_states_in_common, l.btst_addr_states_in_common);
	//start of inquiries
	self.bt_addr_found_on_st_inq_count := r.bt_addr_found_on_st_inq_count ;
	self.bt_phone_found_on_st_inq_count := r.bt_phone_found_on_st_inq_count ;
	self.bt_ssn_found_on_st_inq_count := r.bt_ssn_found_on_st_inq_count;
	self.bt_phone_found_on_st_inq_auto_count := r.bt_phone_found_on_st_inq_auto_count ;
	self.bt_addr_found_on_st_inq_auto_count :=r.bt_addr_found_on_st_inq_auto_count;
	self.bt_ssn_found_on_st_inq_auto_count := r.bt_ssn_found_on_st_inq_auto_count;
	self.bt_phone_found_on_st_inq_banking_count := r.bt_phone_found_on_st_inq_banking_count;
	self.bt_addr_found_on_st_inq_banking_count  := r.bt_addr_found_on_st_inq_banking_count;
	self.bt_ssn_found_on_st_inq_banking_count  := r.bt_ssn_found_on_st_inq_banking_count; 
	self.bt_phone_found_on_st_inq_Collection_count :=r.bt_phone_found_on_st_inq_Collection_count ;
	self.bt_addr_found_on_st_inq_Collection_count := r.bt_addr_found_on_st_inq_Collection_count;
	self.bt_ssn_found_on_st_inq_Collection_count  := r.bt_ssn_found_on_st_inq_Collection_count ;
	self.bt_phone_found_on_st_inq_Mortgage_count := r.bt_phone_found_on_st_inq_Mortgage_count ;
	self.bt_addr_found_on_st_inq_Mortgage_count  := r.bt_addr_found_on_st_inq_Mortgage_count ;
	self.bt_ssn_found_on_st_inq_Mortgage_count := r.bt_ssn_found_on_st_inq_Mortgage_count ; 
	self.bt_phone_found_on_st_inq_HighRiskCredit_count  := r.bt_phone_found_on_st_inq_HighRiskCredit_count;
	self.bt_addr_found_on_st_inq_HighRiskCredit_count := r.bt_addr_found_on_st_inq_HighRiskCredit_count;
	self.bt_ssn_found_on_st_inq_HighRiskCredit_count := r.bt_ssn_found_on_st_inq_HighRiskCredit_count;
	self.bt_phone_found_on_st_inq_Retail_count  := r.bt_phone_found_on_st_inq_Retail_count;
	self.bt_addr_found_on_st_inq_Retail_count := r.bt_addr_found_on_st_inq_Retail_count ;			
	self.bt_ssn_found_on_st_inq_Retail_count := r.bt_ssn_found_on_st_inq_Retail_count;
	self.bt_phone_found_on_st_inq_Communications_count := r.bt_phone_found_on_st_inq_Communications_count;
	self.bt_addr_found_on_st_inq_Communications_count := r.bt_addr_found_on_st_inq_Communications_count;
	self.bt_ssn_found_on_st_inq_Communications_count  := r.bt_ssn_found_on_st_inq_Communications_count;
	self.bt_phone_found_on_st_inq_Other_count    := r.bt_phone_found_on_st_inq_Other_count;
	self.bt_addr_found_on_st_inq_Other_count  := r.bt_addr_found_on_st_inq_Other_count ;   
	self.bt_ssn_found_on_st_inq_Other_count := r.bt_ssn_found_on_st_inq_Other_count;      
	self.bt_phone_found_on_st_inq_prepaidCards_count  := r.bt_phone_found_on_st_inq_prepaidCards_count;
	self.bt_addr_found_on_st_inq_prepaidCards_count := r.bt_addr_found_on_st_inq_prepaidCards_count;
	self.bt_ssn_found_on_st_inq_prepaidCards_count  := r.bt_ssn_found_on_st_inq_prepaidCards_count ;
	self.bt_phone_found_on_st_inq_QuizProvider_count  := r.bt_phone_found_on_st_inq_QuizProvider_count ; 
	self.bt_addr_found_on_st_inq_QuizProvider_count := r.bt_addr_found_on_st_inq_QuizProvider_count;
	self.bt_ssn_found_on_st_inq_QuizProvider_count  := r.bt_ssn_found_on_st_inq_QuizProvider_count;
	self.bt_phone_found_on_st_inq_retailPayments_count := r.bt_phone_found_on_st_inq_retailPayments_count;
	self.bt_addr_found_on_st_inq_retailPayments_count := r.bt_addr_found_on_st_inq_retailPayments_count ;
	self.bt_ssn_found_on_st_inq_retailPayments_count  := r.bt_ssn_found_on_st_inq_retailPayments_count ; 
	self.bt_phone_found_on_st_inq_StudentLoans_count  := r.bt_phone_found_on_st_inq_StudentLoans_count ;
	self.bt_addr_found_on_st_inq_StudentLoans_count  := r.bt_addr_found_on_st_inq_StudentLoans_count; 
	self.bt_ssn_found_on_st_inq_StudentLoans_count := r.bt_ssn_found_on_st_inq_StudentLoans_count;
	self.bt_phone_found_on_st_inq_Utilities_count  := r.bt_phone_found_on_st_inq_Utilities_count ;
	self.bt_addr_found_on_st_inq_Utilities_count  := r.bt_addr_found_on_st_inq_Utilities_count ; 
	self.bt_ssn_found_on_st_inq_Utilities_count := r.bt_ssn_found_on_st_inq_Utilities_count ;
	self.st_addr_found_on_bt_inq_count := r.st_addr_found_on_bt_inq_count;
	self.st_phone_found_on_bt_inq_count := r.st_phone_found_on_bt_inq_count;
	self.st_ssn_found_on_bt_inq_count :=  r.st_ssn_found_on_bt_inq_count;
	self.st_phone_found_on_bt_inq_auto_count := r.st_phone_found_on_bt_inq_auto_count;
	self.st_addr_found_on_bt_inq_auto_count := r.st_addr_found_on_bt_inq_auto_count;
	self.st_ssn_found_on_bt_inq_auto_count := r.st_ssn_found_on_bt_inq_auto_count;
	self.st_phone_found_on_bt_inq_banking_count :=  r.st_phone_found_on_bt_inq_banking_count;	
	self.st_addr_found_on_bt_inq_banking_count  := r.st_addr_found_on_bt_inq_banking_count;
	self.st_ssn_found_on_bt_inq_banking_count  := r.st_ssn_found_on_bt_inq_banking_count; 
	self.st_phone_found_on_bt_inq_Collection_count :=r.st_phone_found_on_bt_inq_Collection_count;
	self.st_addr_found_on_bt_inq_Collection_count := r.st_addr_found_on_bt_inq_Collection_count;
	self.st_ssn_found_on_bt_inq_Collection_count  := r.st_ssn_found_on_bt_inq_Collection_count;
	self.st_phone_found_on_bt_inq_Mortgage_count := r.st_phone_found_on_bt_inq_Mortgage_count;
	self.st_addr_found_on_bt_inq_Mortgage_count  := r.st_addr_found_on_bt_inq_Mortgage_count;
	self.st_ssn_found_on_bt_inq_Mortgage_count := r.st_ssn_found_on_bt_inq_Mortgage_count; 
	self.st_phone_found_on_bt_inq_HighRiskCredit_count  := r.st_phone_found_on_bt_inq_HighRiskCredit_count;
	self.st_addr_found_on_bt_inq_HighRiskCredit_count := r.st_addr_found_on_bt_inq_HighRiskCredit_count;
	self.st_ssn_found_on_bt_inq_HighRiskCredit_count := r.st_ssn_found_on_bt_inq_HighRiskCredit_count;
	self.st_phone_found_on_bt_inq_Retail_count  :=  r.st_phone_found_on_bt_inq_Retail_count;
	self.st_addr_found_on_bt_inq_Retail_count := r.st_addr_found_on_bt_inq_Retail_count;			
	self.st_ssn_found_on_bt_inq_Retail_count := r.st_ssn_found_on_bt_inq_Retail_count;
	self.st_phone_found_on_bt_inq_Communications_count := r.st_phone_found_on_bt_inq_Communications_count;
	self.st_addr_found_on_bt_inq_Communications_count := r.st_addr_found_on_bt_inq_Communications_count;
	self.st_ssn_found_on_bt_inq_Communications_count  :=  r.st_ssn_found_on_bt_inq_Communications_count;
	self.st_phone_found_on_bt_inq_Other_count    := r.st_phone_found_on_bt_inq_Other_count;
	self.st_addr_found_on_bt_inq_Other_count  := r.st_addr_found_on_bt_inq_Other_count;   
	self.st_ssn_found_on_bt_inq_Other_count := r.st_ssn_found_on_bt_inq_Other_count;      
	self.st_phone_found_on_bt_inq_prepaidCards_count  := r.st_phone_found_on_bt_inq_prepaidCards_count;
	self.st_addr_found_on_bt_inq_prepaidCards_count := r.st_addr_found_on_bt_inq_prepaidCards_count;
	self.st_ssn_found_on_bt_inq_prepaidCards_count  := r.st_ssn_found_on_bt_inq_prepaidCards_count;
	self.st_phone_found_on_bt_inq_QuizProvider_count  :=  r.st_phone_found_on_bt_inq_QuizProvider_count; 
	self.st_addr_found_on_bt_inq_QuizProvider_count := r.st_addr_found_on_bt_inq_QuizProvider_count;
	self.st_ssn_found_on_bt_inq_QuizProvider_count  := r.st_ssn_found_on_bt_inq_QuizProvider_count;
	self.st_phone_found_on_bt_inq_retailPayments_count := r.st_phone_found_on_bt_inq_retailPayments_count;
	self.st_addr_found_on_bt_inq_retailPayments_count := r.st_addr_found_on_bt_inq_retailPayments_count;
	self.st_ssn_found_on_bt_inq_retailPayments_count  :=  r.st_ssn_found_on_bt_inq_retailPayments_count; 
	self.st_phone_found_on_bt_inq_StudentLoans_count  := r.st_phone_found_on_bt_inq_StudentLoans_count;
	self.st_addr_found_on_bt_inq_StudentLoans_count  := r.st_addr_found_on_bt_inq_StudentLoans_count; 
	self.st_ssn_found_on_bt_inq_StudentLoans_count := r.st_ssn_found_on_bt_inq_StudentLoans_count;
	self.st_phone_found_on_bt_inq_Utilities_count  := r.st_phone_found_on_bt_inq_Utilities_count;
	self.st_addr_found_on_bt_inq_Utilities_count  := r.st_addr_found_on_bt_inq_Utilities_count; 
	self.st_ssn_found_on_bt_inq_Utilities_count := r.st_ssn_found_on_bt_inq_Utilities_count;
	// self.relly_did := l.relly_did;
	self := l;
end;

	wRels2wBtSt := join(final_tmp, btst_with3rdPrtyScores,  
		left.bill_to_out.seq = right.bill_to_out.seq,
		addBTSTInfo(LEFT, RIGHT), atmost(riskwise.max_atmost), left outer);
	
	wRels2wBtSt2 := group(sort(wRels2wBtSt, bill_to_out.seq),bill_to_out.seq);

	wRelationShipIndexes := Risk_Indicators.getBTSTRelationShipIndexes(wRels2wBtSt2);

	wRels2wBtSt2wIndexes := join(wRels2wBtSt2, wRelationShipIndexes,
		left.bill_to_out.seq = right.seq,
		transform(risk_indicators.layout_bocashell_btst_out,
		self.btst_relationship_index_v1 := right.btst_relationship_index_v1;
		self.btst_relationship_index_v2 := right.btst_relationship_index_v2;
		self := left));
	wRels2wBtSt2wIndexes2 := group(sort(ungroup(wRels2wBtSt2wIndexes), bill_to_out.seq),bill_to_out.seq);

 final := if(bsVersion>=51, wRels2wBtSt2wIndexes2, final_tmp);

	// output(outf, named('outf'));
  // output(btst_inquiries, named('btst_inquiries'));
  // output(btst_wInq, named('btst_wInq'));
	// output(btst_wTraj, named('btst_wTraj'));
	// output(final_tmp, named('final_tmp'));
	// output(btst_email, named('btst_email'));
	// output(btst_wemail, named('btst_wemail'));
  // output(final, named('CLAM'));
	// output(btst_phones, named('btst_phones'));
	// output(btst_wDeeds_Addrs, named('btst_wDeeds_Addrs'));
	// output(btst_with3rdPrtyScores, named('btst_with3rdPrtyScores'));
  // output(btst_student, named('btst_student'));
	// output(btst_header, named('btst_header'));
	// output(btst_Properties, named('btst_Properties'));
	// output(btst_wDeeds_Addrs, named('btst_wDeeds_Addrs'));
	// output(iid_btst, named('iid_btst'));
	// output(WithNeg1s, named('WithNeg1s'));
	// output(iid_btstWithNeg1s, named('iid_btstWithNeg1s'));	
	// output(btst_wDidSum, named('btst_wDidSum'));
	// output(iid_btst_filtered, named('iid_btst_filtered'));
	// output(gateways, named('gateways_in_bstsFunc'));
	// output(ips, named('ips_bstsFunc'));
	// output(wIPs, named('wIPs_bstsFunc'));
	// output(iid_btst, named('iid_btst'));
	// output(btst_with3rdPrtyScores, named('btst_with3rdPrtyScores'));
	// output(wRels2wBtSt, named('wRels2wBtSt'));
	// output(input_Scores, named('input_Scores'));
return final;

end;