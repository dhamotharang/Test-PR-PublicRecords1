import header_quick;

kFraudFlag := pull(header_quick.key_fraud_flag_eq);

$.layouts.rFraudFlags toFraud(kFraudFlag L) := TRANSFORM
	self.LexID := L.did;
	self.Factact_cd := L.factact_code;
	self.Fraud_Victim_Date_Reported := L.date_reported;
	self.First_Fraud_Victim_Date_Reported := L.dt_vendor_first_reported;
	self.Last_Fraud_Victim_Date_Reported  := L.dt_vendor_last_reported;
	self.Fraud_Flag_Ind := if(L.current, 'C', 'F');
END;

EXPORT FraudFlags := join($.AllowedLexids, distribute(kFraudFlag, hash(did)), left.lexid = right.did, toFraud(RIGHT), local);
