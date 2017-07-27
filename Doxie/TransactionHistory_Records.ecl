import	Custombanktransaction,doxie,iesp, Census_Data;

EXPORT	TransactionHistory_Records(dataset(doxie.layout_references)	dids)	:=
function
	
	rTransactionHistoryPayload_Layout	:=	RECORD
		recordof(Custombanktransaction.key_did);
		string18 Q22cnty_name;
		string18 Q17cnty_name;
	END;	
	
	// Join the DID file to the chase DID payload index
	dTransactionHistory	:=	join(	dids,
																Custombanktransaction.key_did,
																keyed(left.did	=	right.did),
																transform(right),
																limit(iesp.Constants.BPS.TRANSACTION_HIST_MAX_COUNT_RECS,SKIP)
															);
	
	// If we get duplicate records for the same DID, pick the latest one
	dTransactionHistDedup:=	dedup(sort(dTransactionHistory,did,-date_last_seen,-process_date,record),did);
	

	rTransactionHistoryPayload_Layout addcnty(dTransactionHistDedup L) := transform
		SELF.Q22cnty_name := '';
		SELF.Q17cnty_name := '';
		SELF := L;
	end;

	inputrec := project(dTransactionHistDedup,addcnty(LEFT));
	// Fetch the county name from couty codes. Bug:166329
	Census_Data.MAC_Fips2County_Keyed(inputrec,
															Q22_atm_most_visited_addr_clean.st,
															Q22_atm_most_visited_addr_clean.fips_county,
															Q22cnty_name,transhist);
	
	Census_Data.MAC_Fips2County_Keyed(transhist,
															q17_bk_ctr_addr_clean.st,
															q17_bk_ctr_addr_clean.fips_county,
															Q17cnty_name,outrec);
	
	
	iesp.transactionhistory.t_TransactionHistoryRecord	tFormat2Iesp(rTransactionHistoryPayload_Layout	pInput)	:=
	transform
		// ATM visits transform
		iesp.transactionhistory.t_ATMVisit	makeATMVisits()	:=
		transform									
			self.Address					:=	iesp.ECL2ESP.SetAddress(	pInput.Q22_atm_most_visited_addr_clean.prim_name,
																													pInput.Q22_atm_most_visited_addr_clean.prim_range,
																													pInput.Q22_atm_most_visited_addr_clean.predir,
																													pInput.Q22_atm_most_visited_addr_clean.postdir,
																													pInput.Q22_atm_most_visited_addr_clean.addr_suffix,
																													pInput.Q22_atm_most_visited_addr_clean.unit_desig,
																													pInput.Q22_atm_most_visited_addr_clean.sec_range,
																													pInput.Q22_atm_most_visited_addr_clean.v_city_name,
																													pInput.Q22_atm_most_visited_addr_clean.st,
																													pInput.Q22_atm_most_visited_addr_clean.zip,
																													pInput.Q22_atm_most_visited_addr_clean.zip4,
																												  pInput.Q22cnty_name
																												);
			self.VisitDate				:=	iesp.ECL2ESP.toDatestring8(pInput.Q01_last_ATM_visit_dt);
			self.DepositDate			:=	iesp.ECL2ESP.toDatestring8(pInput.Q02_atm_last_deposit_dt);
			self.WithdrawalDate		:=	iesp.ECL2ESP.toDatestring8(pInput.Q03_atm_last_withdrawal_dt);
			self.DepositAmount		:=	(string)pInput.Q04_ATM_last_deposit_amt;
			self.WithdrawalAmount	:=	(string)pInput.Q05_ATM_last_withdrawal_amt;
		end;

		// Tripleg transform
		iesp.transactionhistory.t_Tripleg	makeTripLegs()	:=
		transform
			self.OriginationAirport	:=	pInput.tripleg_origapt;
			self.DestinationAirport	:=	pInput.tripleg_destapt;
			self.DepartureDate			:=	iesp.ECL2ESP.toDatestring8(pInput.tripleg_dprt_dt);
			self.AirlineCode				:=	pInput.tripleg_airline1;
		end;
		
		// Main transform
		
		self.ATMVisits							:=	dataset([makeATMVisits()]);
		self.CosignerDOB						:=	iesp.ECL2ESP.toDatestring8(pInput.Q06_cosigner_dob);
		self.OpenLastCheckingYear		:=	iesp.ECL2ESP.toDatestring8(pInput.Q16_opn_yr);
		
																	 
		self.OpenLastBranchAddress	:=	iesp.ECL2ESP.SetAddress(	pInput.q17_bk_ctr_addr_clean.prim_name,pInput.q17_bk_ctr_addr_clean.prim_range,
																															pInput.q17_bk_ctr_addr_clean.predir,pInput.q17_bk_ctr_addr_clean.postdir,
																															pInput.q17_bk_ctr_addr_clean.addr_suffix,pInput.q17_bk_ctr_addr_clean.unit_desig,
																															pInput.q17_bk_ctr_addr_clean.sec_range,pInput.q17_bk_ctr_addr_clean.v_city_name,
																															pInput.q17_bk_ctr_addr_clean.st,pInput.q17_bk_ctr_addr_clean.zip,
																															pInput.q17_bk_ctr_addr_clean.zip4,pInput.Q17cnty_name
																														);
																															
		self.LoginCount							:=	pInput.Q20_chase_com_login_cnt;
		self.TripLegs								:=	dataset([makeTripLegs()]);
	end;
	
	dBPSTransactionData	:=	project(outrec,tFormat2Iesp(left));
	return	dBPSTransactionData;
end;