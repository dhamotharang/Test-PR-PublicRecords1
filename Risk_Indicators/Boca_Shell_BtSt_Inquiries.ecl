/*
Used in the BTST shell
BT ST Identity-tied Transaction Count - (btst_cbd_inq_ver_count) - number of times 
a BT and a ST have been seen together as part of the same transaction in the search activity (inquiry) database.  
This field shall be delivered as a count of these identified transactions.
This field shall return a -1 if either the BT or ST identity cannot be found
Additional Inquiry Insights:
btst_cbd_ids_per_bt_id_ct - Number of unique Ship-To identities (LexIDs) associated with transactions tied to the Bill-To identity (-1 if no BT inquires found)
btst_cbd_ids_per_st_id_ct- Number of unique Bill-To identities (LexIDs) associated with transactions tied to the Ship-To identity (-1 if no ST inquires found)
bt_phone_found_on_st_inq_count - Number of Bill-To phone found on the Ship-to Inquiries
bt_addr_found_on_st_inq_count- Number of Bill-To address found on the Ship-to Inquiries
bt_ssn_found_on_st_inq_count - Number of Bill-To ssn found on the Ship-to Inquiries
st_phone_found_on_bt_inq_count - Number of Ship-To phone found on the Bill-to Inquiries
st_addr_found_on_bt_inq_count - Number of Ship-To address found on the Bill-to Inquiries
st_ssn_found_on_bt_inq_count  - Number of Ship-To ssn found on the Bill-to Inquiries
...then more fields like this with same definition but broken down by bucket.
*/

import Inquiry_AccLogs, gateway, Inquiry_Deltabase, riskwise, doxie, Suppress, Risk_Indicators;

export Boca_Shell_BtSt_Inquiries(
	grouped dataset(Risk_Indicators.layout_ciid_btst_Output) input, 
	integer bsVersion,
	dataset(Gateway.Layouts.Config) gateways,
    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	ungrpd_input := ungroup(input);
	isFCRA := false;

	key_did := Inquiry_AccLogs.Key_Inquiry_DID;
	key_upd_did := Inquiry_AccLogs.Key_Inquiry_DID_Update;
	
	
	inq_tmp := record
		unsigned4 seq;
		unsigned6 did;
		string	Transaction_ID := '';
		string	Sequence_Number := '';
		boolean Hit;
		boolean CBD_Hit;
		string first_log_date;
		unsigned3 historydate;
		string histDatetime;
		string addr;
		string10 prim_range;
		string28 prim_name;
		string8 sec_range;
		string10 phone;
		string9 ssn;
		//inquiry types
		unsigned2 Collection;
		unsigned2 Auto;
		unsigned2 Banking;
		unsigned2 Mortgage;
		unsigned2 HighRiskCredit;
		unsigned2 Retail;
		unsigned2 Communications;
		unsigned2 Other;
		unsigned2 prepaidCards;  	
		unsigned2 QuizProvider;  	
		unsigned2 retailPayments;	
		unsigned2 StudentLoans;		
		unsigned2 Utilities;	
		integer btst_cbd_inq_ver_count := -1;
		integer btst_cbd_ids_per_st_id_ct := -1;
		integer btst_cbd_ids_per_bt_id_ct := -1;
		integer bt_phone_found_on_st_inq_count       := -1;
		integer bt_addr_found_on_st_inq_count             := -1;
		integer bt_ssn_found_on_st_inq_count              := -1;
		integer st_phone_found_on_bt_inq_count            := -1;
		integer st_addr_found_on_bt_inq_count             := -1;
		integer st_ssn_found_on_bt_inq_count              := -1;
		integer bt_phone_found_on_st_inq_auto_count       := -1;
		integer bt_addr_found_on_st_inq_auto_count        := -1;
		integer bt_ssn_found_on_st_inq_auto_count         := -1;
		integer st_phone_found_on_bt_inq_auto_count       := -1;
		integer st_addr_found_on_bt_inq_auto_count        := -1;
		integer st_ssn_found_on_bt_inq_auto_count         := -1;
		integer bt_phone_found_on_st_inq_banking_count    := -1;
		integer bt_addr_found_on_st_inq_banking_count     := -1;
		integer bt_ssn_found_on_st_inq_banking_count      := -1;
		integer st_phone_found_on_bt_inq_banking_count    := -1;
		integer st_addr_found_on_bt_inq_banking_count     := -1;
		integer st_ssn_found_on_bt_inq_banking_count      := -1;
		integer bt_phone_found_on_st_inq_Collection_count := -1;
		integer bt_addr_found_on_st_inq_Collection_count := -1;
		integer bt_ssn_found_on_st_inq_Collection_count  := -1;
		integer st_phone_found_on_bt_inq_Collection_count:= -1;
		integer st_addr_found_on_bt_inq_Collection_count:= -1;
		integer st_ssn_found_on_bt_inq_Collection_count := -1;
		integer bt_phone_found_on_st_inq_Mortgage_count := -1;
		integer bt_addr_found_on_st_inq_Mortgage_count  := -1;
		integer bt_ssn_found_on_st_inq_Mortgage_count   := -1;
		integer st_phone_found_on_bt_inq_Mortgage_count := -1;
		integer st_addr_found_on_bt_inq_Mortgage_count  := -1;
		integer st_ssn_found_on_bt_inq_Mortgage_count   := -1;
		integer bt_phone_found_on_st_inq_HighRiskCredit_count:= -1; 
		integer bt_addr_found_on_st_inq_HighRiskCredit_count := -1;
		integer bt_ssn_found_on_st_inq_HighRiskCredit_count  := -1;
		integer st_phone_found_on_bt_inq_HighRiskCredit_count:= -1;
		integer st_addr_found_on_bt_inq_HighRiskCredit_count := -1;
		integer st_ssn_found_on_bt_inq_HighRiskCredit_count  := -1;
		integer bt_phone_found_on_st_inq_Retail_count        := -1;
		integer bt_addr_found_on_st_inq_Retail_count					:= -1;
		integer bt_ssn_found_on_st_inq_Retail_count          := -1;
		integer st_phone_found_on_bt_inq_Retail_count        := -1;
		integer st_addr_found_on_bt_inq_Retail_count         := -1;
		integer st_ssn_found_on_bt_inq_Retail_count          := -1;
		integer bt_phone_found_on_st_inq_Communications_count:= -1;
		integer bt_addr_found_on_st_inq_Communications_count := -1;
		integer bt_ssn_found_on_st_inq_Communications_count  := -1;
		integer st_phone_found_on_bt_inq_Communications_count:= -1;
		integer st_addr_found_on_bt_inq_Communications_count  := -1;
		integer st_ssn_found_on_bt_inq_Communications_count   := -1;
		integer bt_phone_found_on_st_inq_Other_count          := -1;
		integer bt_addr_found_on_st_inq_Other_count           := -1;
		integer bt_ssn_found_on_st_inq_Other_count            := -1;
		integer st_phone_found_on_bt_inq_Other_count          := -1;
		integer st_addr_found_on_bt_inq_Other_count           := -1;
		integer st_ssn_found_on_bt_inq_Other_count            := -1;
		integer bt_phone_found_on_st_inq_prepaidCards_count   := -1;
		integer bt_addr_found_on_st_inq_prepaidCards_count    := -1;
		integer bt_ssn_found_on_st_inq_prepaidCards_count     := -1;
		integer st_phone_found_on_bt_inq_prepaidCards_count   := -1;
		integer st_addr_found_on_bt_inq_prepaidCards_count    := -1;
		integer st_ssn_found_on_bt_inq_prepaidCards_count     := -1;
		integer bt_phone_found_on_st_inq_QuizProvider_count   := -1;
		integer bt_addr_found_on_st_inq_QuizProvider_count    := -1;
		integer bt_ssn_found_on_st_inq_QuizProvider_count     := -1;
		integer st_phone_found_on_bt_inq_QuizProvider_count   := -1;
		integer st_addr_found_on_bt_inq_QuizProvider_count    := -1;
		integer st_ssn_found_on_bt_inq_QuizProvider_count     := -1;
		integer bt_phone_found_on_st_inq_retailPayments_count := -1;
		integer bt_addr_found_on_st_inq_retailPayments_count:= -1;
		integer bt_ssn_found_on_st_inq_retailPayments_count   := -1;
		integer st_phone_found_on_bt_inq_retailPayments_count:= -1;
		integer st_addr_found_on_bt_inq_retailPayments_count := -1;
		integer st_ssn_found_on_bt_inq_retailPayments_count  := -1;
		integer bt_phone_found_on_st_inq_StudentLoans_count  := -1;
		integer bt_addr_found_on_st_inq_StudentLoans_count   := -1;
		integer bt_ssn_found_on_st_inq_StudentLoans_count    := -1;
		integer st_phone_found_on_bt_inq_StudentLoans_count  := -1;
		integer st_addr_found_on_bt_inq_StudentLoans_count   := -1;
		integer st_ssn_found_on_bt_inq_StudentLoans_count    := -1;
		integer bt_phone_found_on_st_inq_Utilities_count     := -1;
		integer bt_addr_found_on_st_inq_Utilities_count      := -1;
		integer bt_ssn_found_on_st_inq_Utilities_count       := -1;
		integer st_phone_found_on_bt_inq_Utilities_count     := -1;
		integer st_addr_found_on_bt_inq_Utilities_count      := -1;
		integer st_ssn_found_on_bt_inq_Utilities_count       := -1;
	end;

    inq_tmp_CCPA := RECORD
        unsigned4 global_sid;
				boolean skip_opt_out := false;
        inq_tmp;
    END;
    
getBtStInquiryRaw(btStField, InquiryRawCount, KeyName, getDelta) := FUNCTIONMACRO
	inq_tmp_CCPA add_inquiry_raw(Risk_Indicators.layout_ciid_btst_Output le, key_did rt, integer c) := transform
        self.global_sid := rt.ccpa.global_sid;
		self.seq := if(c = 1, le.bill_to_output.seq, le.ship_to_output.seq);
		self.did := if(c = 1, le.bill_to_output.did, le.ship_to_output.did);
		hist_date := if(c = 1, le.ship_to_output.historydate, le.bill_to_output.historydate);;
		hist_datetime := if(c = 1, le.ship_to_output.historyDateTimeStamp, le.bill_to_output.historyDateTimeStamp);;
		self.historydate := hist_date;
		self.histDatetime := hist_datetime;
		industry := trim(StringLib.StringToUpperCase(rt.bus_intel.industry));
		vertical := trim(StringLib.StringToUpperCase(rt.bus_intel.vertical));
		sub_market := trim(StringLib.StringToUpperCase(rt.bus_intel.sub_market));
		func := trim(StringLib.StringToUpperCase(rt.search_info.function_description));
		product_code := trim(rt.search_info.product_code);
		logdate := rt.search_info.datetime[1..8];
		
		is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

		function_is_ok := if(isfcra, func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion), func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(BSversion));
		
		inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(hist_date, logdate, isFCRA) and
									 function_is_ok and
									 not is_banko_inquiry and
									 trim(rt.bus_intel.use)='' and
									 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;

		self.CBD_Hit := inquiry_hit and func in Inquiry_AccLogs.shell_constants.chargeback_functions;
		self.Hit := inquiry_hit;
		
		self.first_log_date := if(inquiry_hit, logdate, '');	
		self.Transaction_ID := rt.search_info.Transaction_ID;
		self.Sequence_Number := rt.search_info.Sequence_Number;
		self.addr := rt.person_q.address;
		self.prim_range := rt.person_q.prim_range;
		self.prim_name := rt.person_q.prim_name;
		self.sec_range := rt.person_q.sec_range;
		self.phone := rt.person_q.personal_phone;
		self.ssn := rt.person_q.ssn;
		// anything with the vertical or industry of collection goes into collections bucket
		collections_bucket :=  Inquiry_AccLogs.shell_constants.collections_vertical_set;		
		method := trim(StringLib.StringToUpperCase(rt.search_info.method));

		boolean methodFltr := method not in ['BATCH','MONITORING']; 

		boolean isCollection := inquiry_hit and 
				(~isFCRA or trim(rt.permissions.fcra_purpose) = '164') and
				(vertical in collections_bucket or industry IN Inquiry_AccLogs.shell_constants.collection_industry or
					StringLib.StringFind(StringLib.StringToUpperCase(sub_market),'FIRST PARTY', 1) > 0);	
		self.Collection := if(isCollection, 1, 0);
		boolean isAuto       					:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.auto_industry
					and methodFltr;	
		self.Auto := if(isAuto, 1, 0);
		boolean isBanking    					:= not isCollection and inquiry_hit and industry in 
			Inquiry_AccLogs.shell_constants.banking_industry5	and methodFltr;  
		self.Banking := if(isBanking, 1, 0);	
		boolean isMortgage   					:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Mortgage_industry 
					and methodFltr; 
		self.Mortgage := if(isMortgage, 1, 0);	
		boolean isHighRiskCredit 	:= not isCollection and inquiry_hit and industry in 
		Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5 and methodFltr;  
		self.HighRiskCredit := if(isHighRiskCredit, 1, 0);	
		boolean isRetail    					:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Retail_industry 
					and methodFltr;  
		self.Retail := if(isRetail, 1, 0);	
		boolean isCommunications	:= not isCollection and inquiry_hit and industry in 
		Inquiry_AccLogs.shell_constants.communications_industry5 and methodFltr; 
		self.Communications := if(isCommunications, 1, 0);	
		boolean isPrepaidCards				:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.PrepaidCards_industry
					and methodFltr; 
		self.PrepaidCards := if(isPrepaidCards, 1, 0);	
		boolean isRetailPayments			:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.RetailPayments_industry and
					func in Inquiry_AccLogs.shell_constants.RetailPayments_functions and methodFltr;
		self.RetailPayments := if(isRetailPayments, 1, 0);	
		boolean isUtilities						:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.Utilities_industry
					and methodFltr; 
		self.Utilities := if(isUtilities, 1, 0);	
		boolean isQuizProvider				:= not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.QuizProvider_industry
					and methodFltr; 
		self.QuizProvider := if(isQuizProvider, 1, 0);		
		boolean isStudentLoan				  := not isCollection and inquiry_hit and industry in Inquiry_AccLogs.shell_constants.StudentLoans_industry 
					and methodFltr; 
		self.StudentLoans := if(isStudentLoan, 1, 0);		

		boolean isOther_v5 := inquiry_hit and 
											not isCollection and 
											not isAuto and 
											not isBanking and 
											not isMortgage and
											not isHighRiskCredit and
											not isRetail and
											not isCommunications and
											not isPrepaidCards and
											not isRetailPayments and
											not isUtilities and
											not isQuizProvider and
											not isStudentLoan and
											methodFltr; 	
		
		self.Other := if(isOther_v5, 1, 0);		
		self.btst_cbd_inq_ver_count := 0;
		self := [];
	end;

	// did
    #IF(~getDelta)
	inq_unsuppressed := join(ungrpd_input, #EXPAND(KeyName), 
							left.#EXPAND(btStField).did<>0 and keyed(left.#EXPAND(btStField).did=right.s_did) and
							Inquiry_AccLogs.shell_constants.hist_is_ok(right.search_info.datetime, left.#EXPAND(btStField).historyDateTimeStamp, left.#EXPAND(btStField).historyDate, bsversion),	
							add_inquiry_raw(left, right, InquiryRawCount),
							left outer, atmost(5000));	
    #ELSE
    inq_unsuppressed := join(ungrpd_input, #EXPAND(KeyName), 
						(unsigned6) left.#EXPAND(btStField).seq = (unsigned6) right.Search_Info.Sequence_Number,
						add_inquiry_raw(left, right, InquiryRawCount),
						left outer, atmost(5000));	
    #END             
    inq_flagged := Suppress.CheckSuppression(inq_unsuppressed, mod_access);

inq := PROJECT(inq_flagged, TRANSFORM(inq_tmp, 
		self.CBD_Hit := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.CBD_Hit);
		self.Hit := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('STRING'), left.Hit);
		self.first_log_date := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.first_log_date);	
		self.Transaction_ID := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Transaction_ID);
		self.Sequence_Number := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.Sequence_Number);
		self.addr := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.addr);
		self.prim_range := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prim_range);
		self.prim_name := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.prim_name);
		self.sec_range := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.sec_range);
		self.phone := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.phone);
		self.ssn := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.ssn);
		self.Collection := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Collection);
		self.Auto :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Auto);
		self.Banking :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Banking);
		self.Mortgage :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Mortgage);
		self.HighRiskCredit :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.HighRiskCredit);
		self.Retail :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Retail);
		self.Communications :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Communications);
		self.PrepaidCards :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.PrepaidCards);
		self.RetailPayments := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.RetailPayments);	
		self.Utilities :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Utilities);
		self.QuizProvider :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.QuizProvider);
		self.StudentLoans :=  IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.StudentLoans);
		self.Other := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Other);
    SELF := LEFT;
)); 
    RETURN inq;
    
    ENDMACRO;
    inq_bt_did := getBtStInquiryRaw('bill_to_output', 1, 'key_did', false);
    inq_st_did := getBtStInquiryRaw('ship_to_output', 2, 'key_did', false);
    inq_bt_didUpd := getBtStInquiryRaw('bill_to_output', 1, 'key_upd_did', false);
    inq_st_didUpd := getBtStInquiryRaw('ship_to_output', 2, 'key_upd_did', false);
                                    
	inq_bt_delta := project(ungrpd_input, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_DID,
																	self.seq := left.bill_to_output.seq;
																	self.did := left.bill_to_output.did));
	inq_st_delta := project(ungrpd_input, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_DID,
																	self.seq := left.ship_to_output.seq;
																	self.did := left.ship_to_output.did));
	joint_delta_input := inq_bt_delta + inq_st_delta;																													
//deltabase checks as some models might have more than 1 gateway
	deltabase_Name := gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1].servicename;
	//deltabase_URL := if(bsversion >= 50 and clam_pre_Inquiries[1].historydate=999999 and ~isFCRA, deltabase_check, '');
	deltabase_URL := if(ungrpd_input[1].bill_to_output.historydate=999999, gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1].url, '');
	
	DeltabaseGateway := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := deltabase_Name; 
																																							 SELF.URL := deltabase_URL;
																																							 SELF := []));
	btst_deltaBase_did_results := Inquiry_Deltabase.Search_DID(joint_delta_input, 
		Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);

	// st_deltaBase_did_results := Inquiry_Deltabase.Search_DID(inq_st_delta, 
		// Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);
                                     
    bt_delta := getBtStInquiryRaw('bill_to_output', 1, 'btst_deltaBase_did_results', true);
    st_delta := getBtStInquiryRaw('ship_to_output', 2, 'btst_deltaBase_did_results', true);                                         

//get hits
	btInq_hits := inq_bt_did(Hit = true) + inq_bt_didUpd(Hit = true) + bt_delta(Hit = true);
	btInq_hits_dpd := dedup(sort(btInq_hits, seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id);

	stInq_hits := inq_st_did(Hit = true) + inq_st_didUpd(Hit = true) + st_delta(Hit = true);
	stInq_hits_dpd := dedup(sort(stInq_hits, seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id);

//get only CBD hits
	btInq := inq_bt_did(CBD_Hit = true) + inq_bt_didUpd(CBD_Hit = true) + bt_delta(CBD_Hit = true);
	btInq_dpd := dedup(sort(btInq, seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id);

	stInq := inq_st_did(CBD_Hit = true) + inq_st_didUpd(CBD_Hit = true) + st_delta(CBD_Hit = true);
	stInq_dpd := dedup(sort(stInq, seq, transaction_id, -(unsigned3) first_log_date, Sequence_Number), seq, transaction_id);

	Neg1 := -1;
	chkNeg1(integer Lft, integer Rgt) := if(Lft = Neg1 or Rgt = Neg1, Neg1, Lft + Rgt);

//ship to input in bill to inquiries
	bt_in_st_inq := join(ungrpd_input, stInq_hits_dpd,
		left.bill_to_output.seq + 1 = right.seq,
			transform(inq_tmp, 
				self.seq := left.bill_to_output.seq;
				self.did := left.bill_to_output.did;
				//if Valid is false then have to show a -1 
				AddrValid := if(((left.bill_to_output.in_streetAddress != '' ) or 
					(left.bill_to_output.prim_range != ''  OR	 left.bill_to_output.prim_name != '' or left.bill_to_output.sec_range != ''))
					and left.ship_to_output.did != 0, true, false);
				AddrMatch := if(((left.bill_to_output.in_streetAddress != '' and left.bill_to_output.in_streetAddress = right.Addr) or
					(left.bill_to_output.prim_range != '' and left.bill_to_output.prim_range = right.prim_range and
					left.bill_to_output.prim_name = right.prim_name and
					left.bill_to_output.sec_range = right.sec_range)), true, false);
				//if Valid is false then have to show a -1 				
				PhoneValid := if(left.bill_to_output.phone10 != '' and left.ship_to_output.did != 0, true, false);
				PhoneMatch := left.bill_to_output.phone10 != '' and left.bill_to_output.phone10 = right.phone;
				//if Valid is false then have to show a -1 				
				SSNValid := if(left.bill_to_output.ssn != '' and left.ship_to_output.did != 0, true, false);				
				ssnMatch := left.bill_to_output.ssn != '' and left.bill_to_output.ssn = right.ssn;
				self.transaction_id := right.transaction_id;
				self.bt_addr_found_on_st_inq_count := if(AddrValid, if(AddrMatch, 1, 0), Neg1);
				self.bt_phone_found_on_st_inq_count := if(PhoneValid, if(PhoneMatch, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_count := if(SSNValid, if(ssnMatch, 1, 0), Neg1);
				isAuto := right.Auto >= 1;
				self.bt_phone_found_on_st_inq_auto_count := if(PhoneValid, if(PhoneMatch and isAuto, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_auto_count := if(AddrValid, if(AddrMatch and isAuto, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_auto_count := if(SSNValid, if(ssnMatch and isAuto, 1, 0), Neg1); 
				isBanking := right.Banking >= 1;
				self.bt_phone_found_on_st_inq_banking_count := if(PhoneValid, if(PhoneMatch and isBanking, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_banking_count  := if(AddrValid, if(AddrMatch and isBanking, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_banking_count  := if(SSNValid, if(ssnMatch and isBanking, 1, 0), Neg1); 
				isCollections := right.Collection >= 1;
				self.bt_phone_found_on_st_inq_Collection_count := if(PhoneValid, if(PhoneMatch and isCollections, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_Collection_count := if(AddrValid, if(AddrMatch and isCollections, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_Collection_count  := if(SSNValid, if(ssnMatch and isCollections, 1, 0), Neg1);
				isMortgage := right.Mortgage >= 1;
				self.bt_phone_found_on_st_inq_Mortgage_count := if(PhoneValid, if(PhoneMatch and isMortgage, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_Mortgage_count  := if(AddrValid, if(AddrMatch and isMortgage, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_Mortgage_count := if(SSNValid, if(ssnMatch and isMortgage, 1, 0), Neg1); 
				isHighRiskCredit := right.HighRiskCredit >= 1;
				self.bt_phone_found_on_st_inq_HighRiskCredit_count  := if(PhoneValid, if(PhoneMatch and isHighRiskCredit, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_HighRiskCredit_count := if(AddrValid, if(AddrMatch and isHighRiskCredit, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_HighRiskCredit_count := if(SSNValid, if(ssnMatch and isHighRiskCredit, 1, 0), Neg1);
				isRetail := right.Retail >= 1;
				self.bt_phone_found_on_st_inq_Retail_count  := if(PhoneValid, if(PhoneMatch and isRetail, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_Retail_count := if(AddrValid, if(AddrMatch and isRetail, 1, 0), Neg1);			
				self.bt_ssn_found_on_st_inq_Retail_count := if(SSNValid, if(ssnMatch and isRetail, 1, 0), Neg1);
				isCommunications := right.Communications >= 1;
				self.bt_phone_found_on_st_inq_Communications_count := if(PhoneValid, if(PhoneMatch and isCommunications, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_Communications_count := if(AddrValid, if(AddrMatch and isCommunications, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_Communications_count  := if(SSNValid, if(ssnMatch and isCommunications, 1, 0), Neg1);
				isOther := right.Other >= 1;
				self.bt_phone_found_on_st_inq_Other_count    := if(PhoneValid, if(PhoneMatch and isOther, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_Other_count  := if(AddrValid, if(AddrMatch and isOther, 1, 0), Neg1);   
				self.bt_ssn_found_on_st_inq_Other_count := if(SSNValid, if(ssnMatch and isOther, 1, 0), Neg1);      
				isPrepaidCards := right.PrePaidCards >= 1;
				self.bt_phone_found_on_st_inq_prepaidCards_count  := if(PhoneValid, if(PhoneMatch and isPrepaidCards, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_prepaidCards_count := if(AddrValid, if(AddrMatch and isPrepaidCards, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_prepaidCards_count  := if(SSNValid, if(ssnMatch and isPrepaidCards, 1, 0), Neg1);
				isQuizProvider := right.QuizProvider >= 1;
				self.bt_phone_found_on_st_inq_QuizProvider_count  := if(PhoneValid, if(PhoneMatch and isQuizProvider, 1, 0), Neg1); 
				self.bt_addr_found_on_st_inq_QuizProvider_count := if(AddrValid, if(AddrMatch and isQuizProvider, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_QuizProvider_count  := if(SSNValid, if(ssnMatch and isQuizProvider, 1, 0), Neg1);
				isRetailPayments := right.RetailPayments >= 1;
				self.bt_phone_found_on_st_inq_retailPayments_count := if(PhoneValid, if(PhoneMatch and isRetailPayments, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_retailPayments_count := if(AddrValid, if(AddrMatch and isRetailPayments, 1, 0), Neg1);
				self.bt_ssn_found_on_st_inq_retailPayments_count  := if(SSNValid, if(ssnMatch and isRetailPayments, 1, 0), Neg1); 
				isStudentLoans := right.StudentLoans >= 1;
				self.bt_phone_found_on_st_inq_StudentLoans_count  := if(PhoneValid, if(PhoneMatch and isStudentLoans, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_StudentLoans_count  := if(AddrValid, if(AddrMatch and isStudentLoans, 1, 0), Neg1); 
				self.bt_ssn_found_on_st_inq_StudentLoans_count := if(SSNValid, if(ssnMatch and isStudentLoans, 1, 0), Neg1);
				isUtilities := right.Utilities >= 1;
				self.bt_phone_found_on_st_inq_Utilities_count  := if(PhoneValid, if(PhoneMatch and isUtilities, 1, 0), Neg1);
				self.bt_addr_found_on_st_inq_Utilities_count  := if(AddrValid, if(AddrMatch and isUtilities, 1, 0), Neg1); 
				self.bt_ssn_found_on_st_inq_Utilities_count := if(SSNValid, if(ssnMatch and isUtilities, 1, 0), Neg1);
				self := []), KEEP(RiskWise.max_atmost), left outer);
//do rollup				
				
	inq_tmp btWithSt(inq_tmp l, inq_tmp r) := transform
				self.seq := l.seq;
				// self.did := l.did;	
				self.bt_addr_found_on_st_inq_count := chkNeg1(l.bt_addr_found_on_st_inq_count, r.bt_addr_found_on_st_inq_count);
				self.bt_phone_found_on_st_inq_count := chkNeg1(l.bt_phone_found_on_st_inq_count, r.bt_phone_found_on_st_inq_count);
				self.bt_ssn_found_on_st_inq_count := chkNeg1(l.bt_ssn_found_on_st_inq_count, r.bt_ssn_found_on_st_inq_count);
				self.bt_phone_found_on_st_inq_auto_count := chkNeg1(l.bt_phone_found_on_st_inq_auto_count, r.bt_phone_found_on_st_inq_auto_count);
				self.bt_addr_found_on_st_inq_auto_count := chkNeg1(l.bt_addr_found_on_st_inq_auto_count, r.bt_addr_found_on_st_inq_auto_count);
				self.bt_ssn_found_on_st_inq_auto_count := chkNeg1(l.bt_ssn_found_on_st_inq_auto_count, r.bt_ssn_found_on_st_inq_auto_count);
				self.bt_phone_found_on_st_inq_banking_count := chkNeg1(l.bt_phone_found_on_st_inq_banking_count,  r.bt_phone_found_on_st_inq_banking_count);
	
				self.bt_addr_found_on_st_inq_banking_count  := chkNeg1(l.bt_addr_found_on_st_inq_banking_count, r.bt_addr_found_on_st_inq_banking_count);
				self.bt_ssn_found_on_st_inq_banking_count  := chkNeg1(l.bt_ssn_found_on_st_inq_banking_count, r.bt_ssn_found_on_st_inq_banking_count); 
				self.bt_phone_found_on_st_inq_Collection_count := chkNeg1(l.bt_phone_found_on_st_inq_Collection_count, r.bt_phone_found_on_st_inq_Collection_count);
				self.bt_addr_found_on_st_inq_Collection_count := chkNeg1(l.bt_addr_found_on_st_inq_Collection_count, r.bt_addr_found_on_st_inq_Collection_count);
				self.bt_ssn_found_on_st_inq_Collection_count  := chkNeg1(l.bt_ssn_found_on_st_inq_Collection_count, r.bt_ssn_found_on_st_inq_Collection_count);
				self.bt_phone_found_on_st_inq_Mortgage_count := chkNeg1(l.bt_phone_found_on_st_inq_Mortgage_count, r.bt_phone_found_on_st_inq_Mortgage_count);
				self.bt_addr_found_on_st_inq_Mortgage_count  := chkNeg1(l.bt_addr_found_on_st_inq_Mortgage_count, r.bt_addr_found_on_st_inq_Mortgage_count);
				self.bt_ssn_found_on_st_inq_Mortgage_count := chkNeg1(l.bt_ssn_found_on_st_inq_Mortgage_count, r.bt_ssn_found_on_st_inq_Mortgage_count); 
				self.bt_phone_found_on_st_inq_HighRiskCredit_count  := chkNeg1(l.bt_phone_found_on_st_inq_HighRiskCredit_count, r.bt_phone_found_on_st_inq_HighRiskCredit_count);
				self.bt_addr_found_on_st_inq_HighRiskCredit_count := chkNeg1(l.bt_addr_found_on_st_inq_HighRiskCredit_count, r.bt_addr_found_on_st_inq_HighRiskCredit_count);
				self.bt_ssn_found_on_st_inq_HighRiskCredit_count := chkNeg1(l.bt_ssn_found_on_st_inq_HighRiskCredit_count, r.bt_ssn_found_on_st_inq_HighRiskCredit_count);
				self.bt_phone_found_on_st_inq_Retail_count  := chkNeg1(l.bt_phone_found_on_st_inq_Retail_count, r.bt_phone_found_on_st_inq_Retail_count);
				self.bt_addr_found_on_st_inq_Retail_count := chkNeg1(l.bt_addr_found_on_st_inq_Retail_count, r.bt_addr_found_on_st_inq_Retail_count);			
				self.bt_ssn_found_on_st_inq_Retail_count := chkNeg1(l.bt_ssn_found_on_st_inq_Retail_count, r.bt_ssn_found_on_st_inq_Retail_count);
				self.bt_phone_found_on_st_inq_Communications_count := chkNeg1(l.bt_phone_found_on_st_inq_Communications_count, r.bt_phone_found_on_st_inq_Communications_count);
				self.bt_addr_found_on_st_inq_Communications_count := chkNeg1(l.bt_addr_found_on_st_inq_Communications_count, r.bt_addr_found_on_st_inq_Communications_count);
				self.bt_ssn_found_on_st_inq_Communications_count  := chkNeg1(l.bt_ssn_found_on_st_inq_Communications_count, r.bt_ssn_found_on_st_inq_Communications_count);
				self.bt_phone_found_on_st_inq_Other_count    := chkNeg1(l.bt_phone_found_on_st_inq_Other_count, r.bt_phone_found_on_st_inq_Other_count);
				self.bt_addr_found_on_st_inq_Other_count  := chkNeg1(l.bt_addr_found_on_st_inq_Other_count, r.bt_addr_found_on_st_inq_Other_count);   
				self.bt_ssn_found_on_st_inq_Other_count := chkNeg1(l.bt_ssn_found_on_st_inq_Other_count, r.bt_ssn_found_on_st_inq_Other_count);      
				self.bt_phone_found_on_st_inq_prepaidCards_count  := chkNeg1(l.bt_phone_found_on_st_inq_prepaidCards_count, r.bt_phone_found_on_st_inq_prepaidCards_count);
				self.bt_addr_found_on_st_inq_prepaidCards_count := chkNeg1(l.bt_addr_found_on_st_inq_prepaidCards_count, r.bt_addr_found_on_st_inq_prepaidCards_count);
				self.bt_ssn_found_on_st_inq_prepaidCards_count  := chkNeg1(l.bt_ssn_found_on_st_inq_prepaidCards_count, r.bt_ssn_found_on_st_inq_prepaidCards_count);
				self.bt_phone_found_on_st_inq_QuizProvider_count  := chkNeg1(l.bt_phone_found_on_st_inq_QuizProvider_count, r.bt_phone_found_on_st_inq_QuizProvider_count); 
				self.bt_addr_found_on_st_inq_QuizProvider_count := chkNeg1(l.bt_addr_found_on_st_inq_QuizProvider_count, r.bt_addr_found_on_st_inq_QuizProvider_count);
				self.bt_ssn_found_on_st_inq_QuizProvider_count  := chkNeg1(l.bt_ssn_found_on_st_inq_QuizProvider_count ,r.bt_ssn_found_on_st_inq_QuizProvider_count);
				self.bt_phone_found_on_st_inq_retailPayments_count := chkNeg1(l.bt_phone_found_on_st_inq_retailPayments_count,r.bt_phone_found_on_st_inq_retailPayments_count);
				self.bt_addr_found_on_st_inq_retailPayments_count := chkNeg1(l.bt_addr_found_on_st_inq_retailPayments_count ,r.bt_addr_found_on_st_inq_retailPayments_count);
				self.bt_ssn_found_on_st_inq_retailPayments_count  := chkNeg1(l.bt_ssn_found_on_st_inq_retailPayments_count, r.bt_ssn_found_on_st_inq_retailPayments_count); 
				self.bt_phone_found_on_st_inq_StudentLoans_count  := chkNeg1(l.bt_phone_found_on_st_inq_StudentLoans_count, r.bt_phone_found_on_st_inq_StudentLoans_count);
				self.bt_addr_found_on_st_inq_StudentLoans_count  := chkNeg1(l.bt_addr_found_on_st_inq_StudentLoans_count ,r.bt_addr_found_on_st_inq_StudentLoans_count); 
				self.bt_ssn_found_on_st_inq_StudentLoans_count := chkNeg1(l.bt_ssn_found_on_st_inq_StudentLoans_count ,r.bt_ssn_found_on_st_inq_StudentLoans_count);
				self.bt_phone_found_on_st_inq_Utilities_count  := chkNeg1(l.bt_phone_found_on_st_inq_Utilities_count, r.bt_phone_found_on_st_inq_Utilities_count);
				self.bt_addr_found_on_st_inq_Utilities_count  := chkNeg1(l.bt_addr_found_on_st_inq_Utilities_count, r.bt_addr_found_on_st_inq_Utilities_count); 
				self.bt_ssn_found_on_st_inq_Utilities_count := chkNeg1(l.bt_ssn_found_on_st_inq_Utilities_count ,r.bt_ssn_found_on_st_inq_Utilities_count);
		self := []
	end;	
	bt_in_st_inq_srted := sort(bt_in_st_inq, seq, transaction_id);
	bt_in_st_inq_rolled := rollup(bt_in_st_inq_srted, left.seq = right.seq, btWithSt(left, right));
	
//ship to input in bill to inquiries				
	st_in_bt_inq := join(ungrpd_input, btInq_hits_dpd,
		left.ship_to_output.seq - 1 = right.seq,
			transform(inq_tmp, 
				self.seq := left.ship_to_output.seq;
				self.did := left.ship_to_output.did;
				AddrValid := if(((left.ship_to_output.in_streetAddress != '') or
					(left.ship_to_output.prim_range != '' or left.ship_to_output.prim_name != '' or
					left.ship_to_output.sec_range != '')) and left.bill_to_output.did != 0, true, false);
				AddrMatch := if(((left.ship_to_output.in_streetAddress != '' and left.ship_to_output.in_streetAddress = right.Addr) or
					(left.ship_to_output.prim_range != '' and left.ship_to_output.prim_range = right.prim_range and
					left.ship_to_output.prim_name = right.prim_name and
					left.ship_to_output.sec_range = right.sec_range)), true, false);
				PhoneValid := if(left.ship_to_output.phone10 != '' and left.bill_to_output.did != 0, true, false);	
				PhoneMatch := left.ship_to_output.phone10 != '' and left.ship_to_output.phone10 = right.phone;
				SSNValid := if(left.ship_to_output.ssn != '' and left.bill_to_output.did != 0, true, false);				
				ssnMatch := left.ship_to_output.ssn != '' and left.ship_to_output.ssn = right.ssn;
				self.transaction_id := right.transaction_id;
				self.st_addr_found_on_bt_inq_count := if(AddrValid, if(AddrMatch, 1, 0), Neg1);
				self.st_phone_found_on_bt_inq_count := if(PhoneValid, if(PhoneMatch, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_count := if(ssnValid, if(ssnMatch, 1, 0), Neg1);
				isAuto := right.Auto >= 1;
				self.st_phone_found_on_bt_inq_auto_count := if(PhoneValid, if(PhoneMatch and isAuto, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_auto_count := if(AddrValid, if(AddrMatch and isAuto, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_auto_count := if(ssnValid, if(ssnMatch and isAuto, 1, 0), Neg1); 
				isBanking := right.Banking >= 1;
				self.st_phone_found_on_bt_inq_banking_count := if(PhoneValid, if(PhoneMatch and isBanking, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_banking_count  := if(AddrValid, if(AddrMatch and isBanking, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_banking_count  := if(ssnValid, if(ssnMatch and isBanking, 1, 0), Neg1); 
				isCollections := right.Collection >= 1;
				self.st_phone_found_on_bt_inq_Collection_count := if(PhoneValid, if(PhoneMatch and isCollections, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_Collection_count := if(AddrValid, if(AddrMatch and isCollections, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_Collection_count  := if(ssnValid, if(ssnMatch and isCollections, 1, 0), Neg1);
				isMortgage := right.Mortgage >= 1;
				self.st_phone_found_on_bt_inq_Mortgage_count := if(PhoneValid, if(PhoneMatch and isMortgage, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_Mortgage_count  := if(AddrValid, if(AddrMatch and isMortgage, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_Mortgage_count := if(ssnValid, if(ssnMatch and isMortgage, 1, 0), Neg1); 
				isHighRiskCredit := right.HighRiskCredit >= 1;
				self.st_phone_found_on_bt_inq_HighRiskCredit_count  := if(PhoneValid, if(PhoneMatch and isHighRiskCredit, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_HighRiskCredit_count := if(AddrValid, if(AddrMatch and isHighRiskCredit, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_HighRiskCredit_count := if(ssnValid, if(ssnMatch and isHighRiskCredit, 1, 0), Neg1);
				isRetail := right.Retail >= 1;
				self.st_phone_found_on_bt_inq_Retail_count  := if(PhoneValid, if(PhoneMatch and isRetail, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_Retail_count := if(AddrValid, if(AddrMatch and isRetail, 1, 0), Neg1);			
				self.st_ssn_found_on_bt_inq_Retail_count := if(ssnValid, if(ssnMatch and isRetail, 1, 0), Neg1);
				isCommunications := right.Communications >= 1;
				self.st_phone_found_on_bt_inq_Communications_count := if(PhoneValid, if(PhoneMatch and isCommunications, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_Communications_count := if(AddrValid, if(AddrMatch and isCommunications, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_Communications_count  := if(ssnValid, if(ssnMatch and isCommunications, 1, 0), Neg1);
				isOther := right.Other >= 1;
				self.st_phone_found_on_bt_inq_Other_count    := if(PhoneValid, if(PhoneMatch and isOther, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_Other_count  := if(AddrValid, if(AddrMatch and isOther, 1, 0), Neg1);   
				self.st_ssn_found_on_bt_inq_Other_count := if(ssnValid, if(ssnMatch and isOther, 1, 0), Neg1);      
				isPrepaidCards := right.PrePaidCards >= 1;
				self.st_phone_found_on_bt_inq_prepaidCards_count  := if(PhoneValid, if(PhoneMatch and isPrepaidCards, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_prepaidCards_count := if(AddrValid, if(AddrMatch and isPrepaidCards, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_prepaidCards_count  := if(ssnValid, if(ssnMatch and isPrepaidCards, 1, 0), Neg1);
				isQuizProvider := right.QuizProvider >= 1;
				self.st_phone_found_on_bt_inq_QuizProvider_count  := if(PhoneValid, if(PhoneMatch and isQuizProvider, 1, 0), Neg1); 
				self.st_addr_found_on_bt_inq_QuizProvider_count := if(AddrValid, if(AddrMatch and isQuizProvider, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_QuizProvider_count  := if(ssnValid, if(ssnMatch and isQuizProvider, 1, 0), Neg1);
				isRetailPayments := right.RetailPayments >= 1;
				self.st_phone_found_on_bt_inq_retailPayments_count := if(PhoneValid, if(PhoneMatch and isRetailPayments, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_retailPayments_count := if(AddrValid, if(AddrMatch and isRetailPayments, 1, 0), Neg1);
				self.st_ssn_found_on_bt_inq_retailPayments_count  := if(ssnValid, if(ssnMatch and isRetailPayments, 1, 0), Neg1); 
				isStudentLoans := right.StudentLoans >= 1;
				self.st_phone_found_on_bt_inq_StudentLoans_count  := if(PhoneValid, if(PhoneMatch and isStudentLoans, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_StudentLoans_count  := if(AddrValid, if(AddrMatch and isStudentLoans, 1, 0), Neg1); 
				self.st_ssn_found_on_bt_inq_StudentLoans_count := if(ssnValid, if(ssnMatch and isStudentLoans, 1, 0), Neg1);
				isUtilities := right.Utilities >= 1;
				self.st_phone_found_on_bt_inq_Utilities_count  := if(PhoneValid, if(PhoneMatch and isUtilities, 1, 0), Neg1);
				self.st_addr_found_on_bt_inq_Utilities_count  := if(AddrValid, if(AddrMatch and isUtilities, 1, 0), Neg1); 
				self.st_ssn_found_on_bt_inq_Utilities_count := if(ssnValid, if(ssnMatch and isUtilities, 1, 0), Neg1);
				self := []), KEEP(RiskWise.max_atmost), left outer);

	inq_tmp stWithBt(inq_tmp l, inq_tmp r) := transform
				self.seq := l.seq;
				self.st_addr_found_on_bt_inq_count := chkNeg1(l.st_addr_found_on_bt_inq_count, r.st_addr_found_on_bt_inq_count);
				self.st_phone_found_on_bt_inq_count := chkNeg1(l.st_phone_found_on_bt_inq_count, r.st_phone_found_on_bt_inq_count);
				self.st_ssn_found_on_bt_inq_count := chkNeg1(l.st_ssn_found_on_bt_inq_count, r.st_ssn_found_on_bt_inq_count);
				self.st_phone_found_on_bt_inq_auto_count := chkNeg1(l.st_phone_found_on_bt_inq_auto_count, r.st_phone_found_on_bt_inq_auto_count);
				self.st_addr_found_on_bt_inq_auto_count :=chkNeg1(l.st_addr_found_on_bt_inq_auto_count, r.st_addr_found_on_bt_inq_auto_count);
				self.st_ssn_found_on_bt_inq_auto_count := chkNeg1(l.st_ssn_found_on_bt_inq_auto_count, r.st_ssn_found_on_bt_inq_auto_count);
				self.st_phone_found_on_bt_inq_banking_count := chkNeg1(l.st_phone_found_on_bt_inq_banking_count, r.st_phone_found_on_bt_inq_banking_count);	
				self.st_addr_found_on_bt_inq_banking_count  := chkNeg1(l.st_addr_found_on_bt_inq_banking_count, r.st_addr_found_on_bt_inq_banking_count);
				self.st_ssn_found_on_bt_inq_banking_count  := chkNeg1(l.st_ssn_found_on_bt_inq_banking_count, r.st_ssn_found_on_bt_inq_banking_count); 
				self.st_phone_found_on_bt_inq_Collection_count :=chkNeg1(l.st_phone_found_on_bt_inq_Collection_count, r.st_phone_found_on_bt_inq_Collection_count);
				self.st_addr_found_on_bt_inq_Collection_count := chkNeg1(l.st_addr_found_on_bt_inq_Collection_count, r.st_addr_found_on_bt_inq_Collection_count);
				self.st_ssn_found_on_bt_inq_Collection_count  := chkNeg1(l.st_ssn_found_on_bt_inq_Collection_count, r.st_ssn_found_on_bt_inq_Collection_count);
				self.st_phone_found_on_bt_inq_Mortgage_count := chkNeg1(l.st_phone_found_on_bt_inq_Mortgage_count, r.st_phone_found_on_bt_inq_Mortgage_count);
				self.st_addr_found_on_bt_inq_Mortgage_count  := chkNeg1(l.st_addr_found_on_bt_inq_Mortgage_count, r.st_addr_found_on_bt_inq_Mortgage_count);
				self.st_ssn_found_on_bt_inq_Mortgage_count := chkNeg1(l.st_ssn_found_on_bt_inq_Mortgage_count, r.st_ssn_found_on_bt_inq_Mortgage_count); 
				self.st_phone_found_on_bt_inq_HighRiskCredit_count  := chkNeg1(l.st_phone_found_on_bt_inq_HighRiskCredit_count, r.st_phone_found_on_bt_inq_HighRiskCredit_count);
				self.st_addr_found_on_bt_inq_HighRiskCredit_count := chkNeg1(l.st_addr_found_on_bt_inq_HighRiskCredit_count, r.st_addr_found_on_bt_inq_HighRiskCredit_count);
				self.st_ssn_found_on_bt_inq_HighRiskCredit_count := chkNeg1(l.st_ssn_found_on_bt_inq_HighRiskCredit_count, r.st_ssn_found_on_bt_inq_HighRiskCredit_count);
				self.st_phone_found_on_bt_inq_Retail_count  := chkNeg1(l.st_phone_found_on_bt_inq_Retail_count, r.st_phone_found_on_bt_inq_Retail_count);
				self.st_addr_found_on_bt_inq_Retail_count := chkNeg1(l.st_addr_found_on_bt_inq_Retail_count, r.st_addr_found_on_bt_inq_Retail_count);			
				self.st_ssn_found_on_bt_inq_Retail_count := chkNeg1(l.st_ssn_found_on_bt_inq_Retail_count, r.st_ssn_found_on_bt_inq_Retail_count);
				self.st_phone_found_on_bt_inq_Communications_count := chkNeg1(l.st_phone_found_on_bt_inq_Communications_count, r.st_phone_found_on_bt_inq_Communications_count);
				self.st_addr_found_on_bt_inq_Communications_count := chkNeg1(l.st_addr_found_on_bt_inq_Communications_count, r.st_addr_found_on_bt_inq_Communications_count);
				self.st_ssn_found_on_bt_inq_Communications_count  := chkNeg1(l.st_ssn_found_on_bt_inq_Communications_count, r.st_ssn_found_on_bt_inq_Communications_count);
				self.st_phone_found_on_bt_inq_Other_count    := chkNeg1(l.st_phone_found_on_bt_inq_Other_count, r.st_phone_found_on_bt_inq_Other_count);
				self.st_addr_found_on_bt_inq_Other_count  := chkNeg1(l.st_addr_found_on_bt_inq_Other_count, r.st_addr_found_on_bt_inq_Other_count);   
				self.st_ssn_found_on_bt_inq_Other_count := chkNeg1(l.st_ssn_found_on_bt_inq_Other_count, r.st_ssn_found_on_bt_inq_Other_count);      
				self.st_phone_found_on_bt_inq_prepaidCards_count  := chkNeg1(l.st_phone_found_on_bt_inq_prepaidCards_count, r.st_phone_found_on_bt_inq_prepaidCards_count);
				self.st_addr_found_on_bt_inq_prepaidCards_count := chkNeg1(l.st_addr_found_on_bt_inq_prepaidCards_count, r.st_addr_found_on_bt_inq_prepaidCards_count);
				self.st_ssn_found_on_bt_inq_prepaidCards_count  := chkNeg1(l.st_ssn_found_on_bt_inq_prepaidCards_count, r.st_ssn_found_on_bt_inq_prepaidCards_count);
				self.st_phone_found_on_bt_inq_QuizProvider_count  := chkNeg1(l.st_phone_found_on_bt_inq_QuizProvider_count, r.st_phone_found_on_bt_inq_QuizProvider_count); 
				self.st_addr_found_on_bt_inq_QuizProvider_count := chkNeg1(l.st_addr_found_on_bt_inq_QuizProvider_count, r.st_addr_found_on_bt_inq_QuizProvider_count);
				self.st_ssn_found_on_bt_inq_QuizProvider_count  := chkNeg1(l.st_ssn_found_on_bt_inq_QuizProvider_count ,r.st_ssn_found_on_bt_inq_QuizProvider_count);
				self.st_phone_found_on_bt_inq_retailPayments_count := chkNeg1(l.st_phone_found_on_bt_inq_retailPayments_count, r.st_phone_found_on_bt_inq_retailPayments_count);
				self.st_addr_found_on_bt_inq_retailPayments_count := chkNeg1(l.st_addr_found_on_bt_inq_retailPayments_count, r.st_addr_found_on_bt_inq_retailPayments_count);
				self.st_ssn_found_on_bt_inq_retailPayments_count  := chkNeg1(l.st_ssn_found_on_bt_inq_retailPayments_count, r.st_ssn_found_on_bt_inq_retailPayments_count); 
				self.st_phone_found_on_bt_inq_StudentLoans_count  := chkNeg1(l.st_phone_found_on_bt_inq_StudentLoans_count, r.st_phone_found_on_bt_inq_StudentLoans_count);
				self.st_addr_found_on_bt_inq_StudentLoans_count  := chkNeg1(l.st_addr_found_on_bt_inq_StudentLoans_count, r.st_addr_found_on_bt_inq_StudentLoans_count); 
				self.st_ssn_found_on_bt_inq_StudentLoans_count := chkNeg1(l.st_ssn_found_on_bt_inq_StudentLoans_count , r.st_ssn_found_on_bt_inq_StudentLoans_count);
				self.st_phone_found_on_bt_inq_Utilities_count  := chkNeg1(l.st_phone_found_on_bt_inq_Utilities_count, r.st_phone_found_on_bt_inq_Utilities_count);
				self.st_addr_found_on_bt_inq_Utilities_count  := chkNeg1(l.st_addr_found_on_bt_inq_Utilities_count, r.st_addr_found_on_bt_inq_Utilities_count); 
				self.st_ssn_found_on_bt_inq_Utilities_count := chkNeg1(l.st_ssn_found_on_bt_inq_Utilities_count, r.st_ssn_found_on_bt_inq_Utilities_count);
		self := []
	end;	
	st_in_bt_inq_srted := sort(st_in_bt_inq, seq, transaction_id);
	st_in_bt_inq_rolled := rollup(st_in_bt_inq_srted, left.seq = right.seq, stWithBt(left, right));

	inq_tmp TiedTrans(inq_tmp le, inq_tmp ri) := transform
			SELF.btst_cbd_inq_ver_count := if(le.CBD_Hit and ri.CBD_Hit, 1, 0);
			SELF := le;
	end;
	//tied counts on CBD inquiries only
	btst_tied_trans := join(btInq_dpd, stInq_dpd,
		left.seq = right.seq -1 and left.transaction_id = right.transaction_id,// and
		TiedTrans(left, right),
		inner, KEEP(RiskWise.max_atmost), 
			ATMOST(RiskWise.max_atmost));

	srt_tied := group(sort(btst_tied_trans, seq, transaction_id, Sequence_Number), seq);
	
	inq_tmp rollCommonTrans(inq_tmp l, inq_tmp r) := transform
		self.btst_cbd_inq_ver_count := l.btst_cbd_inq_ver_count + r.btst_cbd_inq_ver_count;
		self := l;
	end;
	btst_tied_trans_rolled := ROLLUP(srt_tied, LEFT.seq=RIGHT.seq, rollCommonTrans(LEFT,RIGHT));

	btst_tied_results := join(ungrpd_input, btst_tied_trans_rolled,
		left.bill_to_output.seq = right.seq, //or left.ship_to_output.seq = right.seq,
		transform(inq_tmp, 
			ValidInq := left.bill_to_output.did != 0 and left.ship_to_output.did != 0 and 
				left.bill_to_output.did != left.ship_to_output.did;
			self.btst_cbd_inq_ver_count := if(ValidInq, if(right.btst_cbd_inq_ver_count > 0, right.btst_cbd_inq_ver_count, 0), neg1); 
			self.seq := left.bill_to_output.seq;	
			self := right,
			self := left,			
			self := []), KEEP(RiskWise.max_atmost), 
			ATMOST(RiskWise.max_atmost),
		left outer);
		
	inq_trans_tmp := record
		unsigned4 seq;
		unsigned6 did;
		string	Transaction_ID := '';
		string	Sequence_Number := '';
		boolean CBD_Hit;
		string first_log_date;
	end;
	
	key_transactionId := Inquiry_AccLogs.Key_Inquiry_Transaction_ID;
  key_transactionId_upd := Inquiry_AccLogs.Key_Inquiry_Transaction_ID_Update;

	inq_trans_tmp add_inquiry_rawTrans(btInq_dpd le, key_transactionId rt) := transform
		self.seq := le.seq;
		self.did := rt.appended_adl;
		hist_date := le.historydate;
		hist_datetime := le.histDatetime;
		logdate := rt.datetime[1..8];

		industry := trim(StringLib.StringToUpperCase(rt.industry));
		vertical := trim(StringLib.StringToUpperCase(rt.vertical));
		sub_market := trim(StringLib.StringToUpperCase(rt.sub_market));
		func := trim(StringLib.StringToUpperCase(rt.function_description));
		product_code := trim(rt.product_code);
	
		is_banko_inquiry := func in Inquiry_AccLogs.shell_constants.banko_functions or (stringlib.stringfind(func, 'MONITORING', 1) > 0 AND product_code='5'); // monitoring transactions with product code=5 are also banko_batch

		function_is_ok := if(isfcra, func in Inquiry_AccLogs.shell_constants.set_valid_fcra_functions(bsversion), func in Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions(BSversion));
		
		inquiry_hit := Inquiry_AccLogs.shell_constants.inquiry_is_ok(hist_date, logdate, isFCRA) and
									 function_is_ok and
									 not is_banko_inquiry and
									 trim(rt.use)='' and
									 product_code in Inquiry_AccLogs.shell_constants.valid_product_codes;

		self.CBD_Hit := inquiry_hit and func in Inquiry_AccLogs.shell_constants.chargeback_functions;
		
		self.first_log_date := if(inquiry_hit, logdate, '');	
		self.Transaction_ID := le.transaction_id;
		self.Sequence_Number := rt.Sequence_Number;
end;

	bt_trans := join(btInq_dpd, key_transactionId, 
							left.transaction_id <> '' and left.did <> 0 and
							keyed(left.transaction_id = right.transaction_id) and
							left.did != right.appended_adl and //don't get transactions for bt person
							Inquiry_AccLogs.shell_constants.hist_is_ok(right.datetime, left.histDatetime, left.historydate, bsversion),	
							add_inquiry_rawTrans(left, right), keep(100),
							left outer, atmost(5000));	
	st_trans := join(stInq_dpd, key_transactionId, 
							left.transaction_id <> '' and left.did <> 0 and
							keyed(left.transaction_id = right.transaction_id) and
							left.did != right.appended_adl and //don't get transactions for bt person
							Inquiry_AccLogs.shell_constants.hist_is_ok(right.datetime, left.histDatetime, left.historydate, bsversion),	
							add_inquiry_rawTrans(left, right), keep(100),
							left outer, atmost(5000));	

	bttrans_didUpd := join(btInq_dpd, key_transactionId_upd, 
							left.transaction_id <> '' and left.did <> 0 and
							keyed(left.transaction_id = right.transaction_id) and
							left.did != right.appended_adl and //don't get transactions for bt person
							Inquiry_AccLogs.shell_constants.hist_is_ok(right.datetime, left.histDatetime, left.historydate, bsversion),	
							add_inquiry_rawTrans(left, right), keep(100),
							left outer, atmost(5000));

	sttrans_didUpd := join(stInq_dpd, key_transactionId_upd, 
							left.transaction_id <> '' and left.did <> 0 and
							keyed(left.transaction_id = right.transaction_id) and
							left.did != right.appended_adl and //don't get transactions for bt person
							Inquiry_AccLogs.shell_constants.hist_is_ok(right.datetime, left.histDatetime, left.historydate, bsversion),	
							add_inquiry_rawTrans(left, right), keep(100),
							left outer, atmost(5000));

	inq_tbt_delta := project(btInq_dpd, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_Transaction_ID,
																	self.seq := left.seq;
																	self.Transaction_ID := left.Transaction_ID));
	inq_tst_delta := project(stInq_dpd, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_Transaction_ID,
																	self.seq := left.seq;
																	self.Transaction_ID := left.Transaction_ID));
	joint_delta_tinput := inq_tbt_delta + inq_tst_delta;																													
	btst_deltaBase_tid_results := Inquiry_Deltabase.Search_Transaction_ID(joint_delta_tinput, 
		Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion), '10', DeltabaseGateway);

	tbt_delta_tmp := join(btInq_dpd, btst_deltaBase_tid_results, 
						left.Transaction_ID != '' and left.Transaction_ID = right.Transaction_ID, //and
						add_inquiry_rawTrans(left, right),keep(100),
						atmost(5000));	
	tbt_delta := join(btInq_dpd, tbt_delta_tmp,
							left.Transaction_ID = right.Transaction_ID and 
							left.did = right.did, 
						transform(right),
						RIGHT ONLY); 
	tst_delta_tmp := join(stInq_dpd, btst_deltaBase_tid_results, 
						left.Transaction_ID != '' and
						left.Transaction_ID = right.Transaction_ID, 
						add_inquiry_rawTrans(left, right), keep(100),
						atmost(5000));				
	tst_delta := join(stInq_dpd, tst_delta_tmp,
							left.Transaction_ID = right.Transaction_ID and 
							left.did = right.did, 
						transform(right), 
						RIGHT ONLY); 
	bt_trans_info := bt_trans(CBD_Hit = true) + bttrans_didUpd(CBD_Hit = true) + tbt_delta(CBD_Hit = true);	
	bt_trans_info_std := sort(bt_trans_info(did != 0), seq, did, transaction_id);
	bt_trans_info_dpd := dedup(bt_trans_info_std,seq, did);
	bt_trans_hits := bt_trans_info_dpd;
	bt_trans_did_cnt := table(bt_trans_hits, {seq, cnt := count(group)}, seq);	

	stassbt_info :=	join(ungrpd_input, bt_trans_did_cnt,
		left.ship_to_output.seq = right.seq + 1,
		transform(inq_tmp,
			self.seq := left.ship_to_output.seq; 
			self.btst_cbd_ids_per_bt_id_ct := if(left.bill_to_output.did != 0, if(right.cnt < 1, 0, right.cnt), neg1);
			self := left,
			self := []),
		left outer, keep(1));	
	//checking if ship to CBD inquiries are found
	st_trans_info := st_trans(CBD_Hit = true) + sttrans_didUpd(CBD_Hit = true)+ tst_delta(CBD_Hit = true);
	st_trans_info_std := sort(st_trans_info(did != 0), seq, did, transaction_id);
	st_trans_info_dpd := dedup(st_trans_info_std,seq, did);
	st_trans_hits := st_trans_info_dpd;	
	st_trans_did_cnt := table(st_trans_hits, {seq, cnt := count(group)}, seq);

	btassst_info :=	join(ungrpd_input, st_trans_did_cnt,
		left.bill_to_output.seq = right.seq - 1,
		transform(inq_tmp,
			self.seq := left.bill_to_output.seq;
			self.btst_cbd_ids_per_st_id_ct := if(left.ship_to_output.did != 0, if(right.cnt < 1, 0, right.cnt), neg1);
			self := left;
			self := []),
		left outer, keep(1));		
	
	btst_wbtAssSt := join(btst_tied_results, btassst_info,
		left.seq = right.seq,
		transform(inq_tmp,
			self.seq := left.seq;
			self.btst_cbd_ids_per_st_id_ct := right.btst_cbd_ids_per_st_id_ct;
			self := left;
			self := []),
		left outer, keep(1));

	btst_wstAssBt := 
	join(btst_wbtAssSt, stassbt_info,
		left.seq = right.seq - 1,
		transform(inq_tmp,
			self.seq := left.seq;
			self.btst_cbd_ids_per_bt_id_ct := right.btst_cbd_ids_per_bt_id_ct;
			self := left;
			self := []),
		left outer, keep(1));	
	
	//btst_wstAssBt := btst_tied_results;
	btst_wBTinq := join(btst_wstAssBt, bt_in_st_inq_rolled,
		left.seq = right.seq,
		transform(inq_tmp, 
			self.seq := left.seq;
			self.btst_cbd_inq_ver_count := left.btst_cbd_inq_ver_count;
			self.btst_cbd_ids_per_st_id_ct := left.btst_cbd_ids_per_st_id_ct;
			self.btst_cbd_ids_per_bt_id_ct := left.btst_cbd_ids_per_bt_id_ct;
			self := right;
			self := left), left outer, ATMOST(RiskWise.max_atmost));
		
	btst_wBTSTinq := join(btst_wBTinq, st_in_bt_inq_rolled,
		left.seq = right.seq - 1,
		transform(inq_tmp, 
			self.seq := left.seq;
			self.btst_cbd_inq_ver_count := left.btst_cbd_inq_ver_count;
			self.btst_cbd_ids_per_st_id_ct := left.btst_cbd_ids_per_st_id_ct;
			self.btst_cbd_ids_per_bt_id_ct := left.btst_cbd_ids_per_bt_id_ct;
			self.bt_addr_found_on_st_inq_count := left.bt_addr_found_on_st_inq_count;	
			self.bt_phone_found_on_st_inq_count := left.bt_phone_found_on_st_inq_count ;
			self.bt_ssn_found_on_st_inq_count := left.bt_ssn_found_on_st_inq_count;
			self.bt_phone_found_on_st_inq_auto_count := left.bt_phone_found_on_st_inq_auto_count ;
			self.bt_addr_found_on_st_inq_auto_count :=left.bt_addr_found_on_st_inq_auto_count;
			self.bt_ssn_found_on_st_inq_auto_count := left.bt_ssn_found_on_st_inq_auto_count;
			self.bt_phone_found_on_st_inq_banking_count := left.bt_phone_found_on_st_inq_banking_count;
			self.bt_addr_found_on_st_inq_banking_count  := left.bt_addr_found_on_st_inq_banking_count;
			self.bt_ssn_found_on_st_inq_banking_count  := left.bt_ssn_found_on_st_inq_banking_count; 
			self.bt_phone_found_on_st_inq_Collection_count :=left.bt_phone_found_on_st_inq_Collection_count ;
			self.bt_addr_found_on_st_inq_Collection_count := left.bt_addr_found_on_st_inq_Collection_count;
			self.bt_ssn_found_on_st_inq_Collection_count  := left.bt_ssn_found_on_st_inq_Collection_count ;
			self.bt_phone_found_on_st_inq_Mortgage_count := left.bt_phone_found_on_st_inq_Mortgage_count ;
			self.bt_addr_found_on_st_inq_Mortgage_count  := left.bt_addr_found_on_st_inq_Mortgage_count ;
			self.bt_ssn_found_on_st_inq_Mortgage_count := left.bt_ssn_found_on_st_inq_Mortgage_count ; 
			self.bt_phone_found_on_st_inq_HighRiskCredit_count  := left.bt_phone_found_on_st_inq_HighRiskCredit_count;
			self.bt_addr_found_on_st_inq_HighRiskCredit_count := left.bt_addr_found_on_st_inq_HighRiskCredit_count;
			self.bt_ssn_found_on_st_inq_HighRiskCredit_count := left.bt_ssn_found_on_st_inq_HighRiskCredit_count;
			self.bt_phone_found_on_st_inq_Retail_count  := left.bt_phone_found_on_st_inq_Retail_count;
			self.bt_addr_found_on_st_inq_Retail_count := left.bt_addr_found_on_st_inq_Retail_count ;			
			self.bt_ssn_found_on_st_inq_Retail_count := left.bt_ssn_found_on_st_inq_Retail_count;
			self.bt_phone_found_on_st_inq_Communications_count := left.bt_phone_found_on_st_inq_Communications_count;
			self.bt_addr_found_on_st_inq_Communications_count := left.bt_addr_found_on_st_inq_Communications_count;
			self.bt_ssn_found_on_st_inq_Communications_count  := left.bt_ssn_found_on_st_inq_Communications_count;
			self.bt_phone_found_on_st_inq_Other_count    := left.bt_phone_found_on_st_inq_Other_count;
			self.bt_addr_found_on_st_inq_Other_count  := left.bt_addr_found_on_st_inq_Other_count ;   
			self.bt_ssn_found_on_st_inq_Other_count := left.bt_ssn_found_on_st_inq_Other_count;      
			self.bt_phone_found_on_st_inq_prepaidCards_count  := left.bt_phone_found_on_st_inq_prepaidCards_count;
			self.bt_addr_found_on_st_inq_prepaidCards_count := left.bt_addr_found_on_st_inq_prepaidCards_count;
			self.bt_ssn_found_on_st_inq_prepaidCards_count  := left.bt_ssn_found_on_st_inq_prepaidCards_count ;
			self.bt_phone_found_on_st_inq_QuizProvider_count  := left.bt_phone_found_on_st_inq_QuizProvider_count ; 
			self.bt_addr_found_on_st_inq_QuizProvider_count := left.bt_addr_found_on_st_inq_QuizProvider_count;
			self.bt_ssn_found_on_st_inq_QuizProvider_count  := left.bt_ssn_found_on_st_inq_QuizProvider_count;
			self.bt_phone_found_on_st_inq_retailPayments_count := left.bt_phone_found_on_st_inq_retailPayments_count;
			self.bt_addr_found_on_st_inq_retailPayments_count := left.bt_addr_found_on_st_inq_retailPayments_count ;
			self.bt_ssn_found_on_st_inq_retailPayments_count  := left.bt_ssn_found_on_st_inq_retailPayments_count ; 
			self.bt_phone_found_on_st_inq_StudentLoans_count  := left.bt_phone_found_on_st_inq_StudentLoans_count ;
			self.bt_addr_found_on_st_inq_StudentLoans_count  := left.bt_addr_found_on_st_inq_StudentLoans_count; 
			self.bt_ssn_found_on_st_inq_StudentLoans_count := left.bt_ssn_found_on_st_inq_StudentLoans_count;
			self.bt_phone_found_on_st_inq_Utilities_count  := left.bt_phone_found_on_st_inq_Utilities_count ;
			self.bt_addr_found_on_st_inq_Utilities_count  := left.bt_addr_found_on_st_inq_Utilities_count ; 
			self.bt_ssn_found_on_st_inq_Utilities_count := left.bt_ssn_found_on_st_inq_Utilities_count ;
			self := right), left outer, ATMOST(RiskWise.max_atmost));
			
		btst_wBTSTinq_grpd := group(sort(btst_wBTSTinq, seq), seq);

			// // output debugs
			// output(inq_bt_did, named('inq_bt_did'));
			// output(inq_st_did, named('inq_st_did'));
			// output(inq_bt_didUpd, named('inq_bt_didUpd'));
			// output(inq_st_didUpd, named('inq_st_didUpd'));		
			// output(joint_delta_input, named('joint_delta_input'));
			// output(btst_deltaBase_did_results, named('btst_deltaBase_did_results'));		
			// output(bt_delta, named('bt_delta'));
			// output(st_delta);		
			// output(btInq, named('btInq'));
			// output(btInq_dpd, named('btInq_dpd'));	
			// output(stInq, named('stInq'));
			// output(stInq_dpd, named('stInq_dpd'));
			// output(st_in_bt_inq, named('st_in_bt_inq'));
			// output(bt_in_st_inq, named('bt_in_st_inq'));
			// output(bt_in_st_inq_rolled, named('bt_in_st_inq_rolled'));
			// output(btst_wBTinq, named('btst_wBTinq'));
			// output(st_in_bt_inq_rolled, named('st_in_bt_inq_rolled'));
			// output(btst_tied_trans, named('btst_tied_trans'));
			// output(btst_tied_trans_rolled, named('btst_tied_trans_rolled'));
			// output(btst_tied_results, named('btst_tied_results'));
			// output(btst_wstAssBt, named('btst_wstAssBt'));
			// output(btst_wbtAssSt, named('btst_wbtAssSt'));
			// output(btst_wBTinq, named('btst_wBTinq'));
			// output(stassbt_info, named('stassbt_info'));
			// output(btassst_info, named('btassst_info'));
			// output(srt_tied, named('srt_tied'));
			// output(bt_trans, named('bt_trans'));
			// output(bt_trans_hits, named('bt_trans_hits'));
			// output(btst_wBTSTinq, named('btst_wBTSTinq'));
			// output(bt_trans_did_cnt, named('bt_trans_did_cnt'));
			// output(St_trans, named('St_trans'));
			// output(St_trans_hits, named('St_trans_hits'));
			// output(bt_trans_info_std, named('bt_trans_info_std'));
			// output(st_trans_info_std, named('st_trans_info_std'));
			// output(St_trans_did_cnt, named('St_trans_did_cnt'));	
			// output(st_trans_info_dpd, named('st_trans_info_dpd'));
			// output(bt_trans_info_dpd, named('bt_trans_info_dpd'));
			// output(bttrans_didUpd, named('bttrans_didUpd'));
			// output(sttrans_didUpd, named('sttrans_didUpd'));
			// output(input, named('input'));
			// output(btst_wBTSTinq, named('btst_wBTSTinq'));
			// output(btst_wBTSTinq_grpd, named('btst_wBTSTinq_grpd'));
			// output(btInq_hits_dpd, named('btInq_hits_dpd'));
			// output(btst_deltaBase_did_results, named('btst_deltaBase_did_results'));
			// output(joint_delta_input, named('joint_delta_input'));
			// output(ungrpd_input, named('ungrpd_input'));
			// output(btst_deltaBase_did_results, named('btst_deltaBase_did_results'));	
			// output(btst_deltaBase_tid_results, named('btst_deltaBase_tid_results'));
			// output(deltabase_URL);
			 // output(DeltabaseGateway, named('DeltabaseGateway'));
	return btst_wBTSTinq_grpd;

end;