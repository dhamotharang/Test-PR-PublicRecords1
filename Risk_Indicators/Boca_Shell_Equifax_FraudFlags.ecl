IMPORT Risk_Indicators, RiskWise, UT, header_quick;

EXPORT Boca_Shell_Equifax_FraudFlags(grouped DATASET(Risk_Indicators.Layout_Boca_Shell) Shell, 
																		 boolean isFCRA) := FUNCTION

key_did := header_quick.key_fraud_flag_eq; 

Layout_Eqfx_FraudFlags_Plus := RECORD
	unsigned4 seq;
	unsigned3 earliest_date;
	RECORDOF(key_did);
	Risk_Indicators.Layouts.Layout_Equifax_FraudFlags;
end;

//Join to the Equifax Fraud Flags key to get the raw records and tack on the other info from the shell that we'll need later to calculate the fraud flags.
Layout_Eqfx_FraudFlags_Plus getFraudFlags(Shell le, key_did ri) := transform
	self.seq							:= le.seq;
	self.earliest_date 		:= min(le.Header_Summary.header_build_date, (unsigned3)risk_indicators.iid_constants.full_history_date(le.historydate));
	self 									:= ri;
	self 									:= [];
end;

fraudFlagsRecs := join(Shell, key_did,
									left.did!=0 and keyed(right.did = left.did) and
									(unsigned3)(right.date_reported) < left.historydate,
									getFraudFlags(left,right), inner, atmost(right.did=left.did, riskwise.max_atmost));

//Sort the fraud flags records so they can be rolled up in the next step
fraudFlagsSorted	:= sort(fraudFlagsRecs, seq, did, vendor_id, factact_code, date_reported, dt_vendor_first_reported);

//The purpose of this rollup is to account for a nuance within the Fraud Flags key where there are multiple records for the same alert. Basically when there are multiple records for the same
//DID, vendor_id, alert code and date_reported but have different first seen / last seen date ranges, these can be rolled up to reflect only one alert with one continuous date range versus 
//the appearance of having 2 alerts, each with a different date range. Since it's really the same alert, we need to roll up here to avoid potentially counting as 2 different alerts - one 
//current and one historical for instance.

Layout_Eqfx_FraudFlags_Plus fraudFlagsRoll(Layout_Eqfx_FraudFlags_Plus le, Layout_Eqfx_FraudFlags_Plus ri) := transform
	self.dt_vendor_first_reported 			:= le.dt_vendor_first_reported;	//keep left here because it will be the earlier date because of the sort 
	self.dt_vendor_last_reported 				:= max(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);	//keep whichever has the most recent last seen date
	self 																:= le;
end;

fraudFlagsRolled := rollup(fraudFlagsSorted, left.seq=right.seq and 
																										 left.did=right.did and 
																										 left.vendor_id = right.vendor_id and 
																										 left.factact_code = right.factact_code and 
																										 left.date_reported = right.date_reported, 
																										 fraudFlagsRoll(left,right));     

//Use a project to populate the new fields that will eventually be appended to the shell
fraudFlagsProjected := project(fraudFlagsRolled, transform(Layout_Eqfx_FraudFlags_Plus,
	self.factact_curr_active_duty 			:= if(left.factact_code in Risk_Indicators.iid_constants.Set_Equifax_Active_Duty_Alert_Codes and left.dt_vendor_last_reported >= left.earliest_date, 1, 0);
	self.factact_curr_active_duty_fseen := if(left.factact_code in Risk_Indicators.iid_constants.Set_Equifax_Active_Duty_Alert_Codes and left.dt_vendor_last_reported >= left.earliest_date, left.date_reported, 0);
	self.factact_curr_fraud_alert 			:= if(left.factact_code in Risk_Indicators.iid_constants.Set_Equifax_Fraud_Alert_Codes and left.dt_vendor_last_reported >= left.earliest_date, 1, 0);
	self.factact_curr_fraud_alert_fseen := if(left.factact_code in Risk_Indicators.iid_constants.Set_Equifax_Fraud_Alert_Codes and left.dt_vendor_last_reported >= left.earliest_date, left.date_reported, 0);
	self.factact_curr_alert_code 				:= if(left.dt_vendor_last_reported >= left.earliest_date, left.factact_code, '');
	self.factact_hist_fraud_alert_ct 		:= if(left.factact_code in Risk_Indicators.iid_constants.Set_Equifax_Fraud_Alert_Codes and left.dt_vendor_last_reported < left.earliest_date, 1, 0);
	self.factact_hist_fraud_alert_lseen := if(left.factact_code in Risk_Indicators.iid_constants.Set_Equifax_Fraud_Alert_Codes and left.dt_vendor_last_reported < left.earliest_date, left.dt_vendor_last_reported, 0);
	// self.date_reported									:= if(left.dt_vendor_last_reported < left.earliest_date, left.date_reported, 0);
	self 																:= left));

//Do final rollup for when there are legitimate multiple alerts for one DID	
Layout_Eqfx_FraudFlags_Plus roll_fraudFlags(Layout_Eqfx_FraudFlags_Plus le, Layout_Eqfx_FraudFlags_Plus ri) := transform
	sameAlert														:= le.factact_code = ri.factact_code and le.date_reported = ri.date_reported;	//same alert code and date reported means same alert, even if diff vendor ID
	self.factact_curr_active_duty 			:= if(le.factact_curr_active_duty = 1 or ri.factact_curr_active_duty = 1, 1, 0); 
	self.factact_curr_active_duty_fseen := map(le.factact_curr_active_duty_fseen = 0		=> ri.factact_curr_active_duty_fseen,
																						 ri.factact_curr_active_duty_fseen = 0		=> le.factact_curr_active_duty_fseen,
																																												 min(le.factact_curr_active_duty_fseen, ri.factact_curr_active_duty_fseen));
	self.factact_curr_fraud_alert 			:= if(le.factact_curr_fraud_alert = 1 or ri.factact_curr_fraud_alert = 1, 1, 0);
	self.factact_curr_fraud_alert_fseen := map(le.factact_curr_fraud_alert_fseen = 0		=> ri.factact_curr_fraud_alert_fseen,
																						 ri.factact_curr_fraud_alert_fseen = 0		=> le.factact_curr_fraud_alert_fseen,
																																												 min(le.factact_curr_fraud_alert_fseen, ri.factact_curr_fraud_alert_fseen));
	self.factact_curr_alert_code 				:= map(le.factact_curr_alert_code = ''					=> ri.factact_curr_alert_code,
																						 ri.factact_curr_alert_code = ''					=> le.factact_curr_alert_code,
																						 le.factact_curr_alert_code in ['W','Q']	=> le.factact_curr_alert_code, //'W' and 'Q' indicate both active duty and fraud alert so don't change to an alert code that indicates only one or the other even if it is more recent ('N','V','X') 
																						 ri.date_reported > le.date_reported			=> ri.factact_curr_alert_code,
																																												 le.factact_curr_alert_code);
	self.factact_hist_fraud_alert_ct 		:= le.factact_hist_fraud_alert_ct + if(~sameAlert or le.factact_hist_fraud_alert_ct = 0, ri.factact_hist_fraud_alert_ct, 0); //same alert - count as only one
	self.factact_hist_fraud_alert_lseen := map(le.factact_hist_fraud_alert_lseen = 0		=> ri.factact_hist_fraud_alert_lseen,
																						 ri.factact_hist_fraud_alert_lseen = 0		=> le.factact_hist_fraud_alert_lseen,
																																												 max(le.factact_hist_fraud_alert_lseen, ri.factact_hist_fraud_alert_lseen));
	self.factact_code										:= if(le.factact_code <> '', le.factact_code, ri.factact_code);		//keep whichever is populated
	self.date_reported									:= if(le.date_reported <> 0, le.date_reported, ri.date_reported);	//keep whichever is populated
	self.dt_vendor_last_reported				:= if(le.dt_vendor_last_reported <> 0, le.dt_vendor_last_reported, ri.dt_vendor_last_reported);	//keep whichever is populated
	self := ri;
end;

fraudFlagsSorted2 := sort(fraudFlagsProjected, seq, did, -factact_code, date_reported);

fraudFlagsRolled2 := rollup(fraudFlagsSorted2, left.seq=right.seq and left.did=right.did, roll_fraudFlags(left,right));     

risk_indicators.Layout_Boca_Shell addFraudFlags(risk_indicators.Layout_Boca_Shell le, fraudFlagsRolled2 ri) := TRANSFORM
	noHit																								:= ri.DID = 0;
	noDID																								:= le.DID = 0;
	invalidHit																					:= ri.factact_code = '' and ri.date_reported = 0 and ri.dt_vendor_last_reported = 0;
	SELF.Eqfx_FraudFlags.factact_curr_active_duty     	:= map(noDID															=> -1,
																														 noHit															=> -2,
																														 invalidHit													=> -3,
																																																	 ri.factact_curr_active_duty);
	SELF.Eqfx_FraudFlags.factact_curr_active_duty_fseen	:= map(noDID															=> -1,
																														 noHit															=> -2,
																														 invalidHit													=> -3,
																																																	 ri.factact_curr_active_duty_fseen);
	SELF.Eqfx_FraudFlags.factact_curr_fraud_alert				:= map(noDID															=> -1,
																														 noHit															=> -2,
																														 invalidHit													=> -3,
																																																	 ri.factact_curr_fraud_alert);
	SELF.Eqfx_FraudFlags.factact_curr_fraud_alert_fseen	:= map(noDID															=> -1,
																														 noHit															=> -2,
																														 invalidHit													=> -3,
																																																	 ri.factact_curr_fraud_alert_fseen);
	SELF.Eqfx_FraudFlags.factact_curr_alert_code				:= map(noDID															=> '-1',
																														 noHit															=> '-2',
																														 invalidHit													=> '-3',
																														 ri.factact_curr_alert_code = ''		=> '0', //return '0' instead of blank when we had a Fraud Flags key hit but it was not current
																																																	 ri.factact_curr_alert_code);
	SELF.Eqfx_FraudFlags.factact_hist_fraud_alert_ct		:= map(noDID															=> -1,
																														 noHit															=> -2,
																														 invalidHit													=> -3,
																																																	 ri.factact_hist_fraud_alert_ct);
	SELF.Eqfx_FraudFlags.factact_hist_fraud_alert_lseen	:= map(noDID															=> -1,
																														 noHit															=> -2,
																														 invalidHit													=> -3,
																														 ri.factact_hist_fraud_alert_lseen > le.historydate	=> le.historydate,
																																																	 ri.factact_hist_fraud_alert_lseen);
	SELF 																								:= le;
END;

WithFraudFlags := JOIN(Shell, fraudFlagsRolled2, LEFT.seq=RIGHT.seq, addFraudFlags(LEFT,RIGHT), LEFT OUTER);

//for FCRA these fields are not allowed so just set to -1 if no DID, else set to -2
FCRAdefaults := project(ungroup(shell), 
	transform(risk_indicators.Layout_Boca_Shell, 
		self.Eqfx_FraudFlags.factact_curr_active_duty 				:= if(left.DID = 0, -1, -2);
		self.Eqfx_FraudFlags.factact_curr_active_duty_fseen		:= if(left.DID = 0, -1, -2);
		self.Eqfx_FraudFlags.factact_curr_fraud_alert					:= if(left.DID = 0, -1, -2);
		self.Eqfx_FraudFlags.factact_curr_fraud_alert_fseen		:= if(left.DID = 0, -1, -2);
		self.Eqfx_FraudFlags.factact_curr_alert_code					:= if(left.DID = 0, '-1', '-2');
		self.Eqfx_FraudFlags.factact_hist_fraud_alert_ct			:= if(left.DID = 0, -1, -2);
		self.Eqfx_FraudFlags.factact_hist_fraud_alert_lseen		:= if(left.DID = 0, -1, -2);
		self := left));
	
finalFraudFlags := if(isFCRA, FCRAdefaults, WithFraudFlags);	

// OUTPUT(fraudFlagsRecs, NAMED('fraudFlagsRecs'));	
// OUTPUT(fraudFlagsSorted, NAMED('fraudFlagsSorted'));	
// OUTPUT(fraudFlagsRolled, NAMED('fraudFlagsRolled'));	
// OUTPUT(fraudFlagsProjected, NAMED('fraudFlagsProjected'));	
// OUTPUT(fraudFlagsSorted2, NAMED('fraudFlagsSorted2'));	
// OUTPUT(fraudFlagsRolled2, NAMED('fraudFlagsRolled2'));	

RETURN FinalFraudFlags;

END;													