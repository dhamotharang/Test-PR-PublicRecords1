IMPORT PhonesInfo, dx_PhonesInfo, Phones, UT;
EXPORT GetPhoneMetadata := MODULE

//Based on subject info get ALL ports and CURRENT deact records


	EXPORT GetPhoneTransactions(DATASET(Phones.Layouts.rec_phoneLayout) subjectInfo) := FUNCTION

	Phones.Layouts.portedMetadata_Main tAppendTransInfo(Phones.Layouts.rec_phoneLayout L, dx_PhonesInfo.Key_Phones_Transaction R):= TRANSFORM
		isDESU := (R.transaction_code IN [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE]);
		isSW := (R.transaction_code = Phones.Constants.TransactionCodes.SWAP_DEACTIVATION);
		isRE := (R.transaction_code = Phones.Constants.TransactionCodes.REACTIVATED);
		isPA := R.transaction_code = Phones.Constants.TransactionCodes.PORT_ADD;
		is_disconnected := (R.source IN [Phones.Constants.Sources.GONG_DISCONNECT_SRC, Phones.Constants.Sources.DISCONNECT_SRC] AND 
		  					(isDESU OR isSW));

		SELF.swap_start_dt := IF(isSW, R.transaction_start_dt, 0);

		SELF.swap_end_dt := IF(isSW, R.transaction_end_dt, 0);					 
		
		SELF.deact_start_dt  := IF(isDESU, R.transaction_start_dt, 0);
		
		SELF.deact_end_dt := IF(isDESU, R.transaction_end_dt, 0);;

		SELF.react_start_dt := IF(isRE, R.transaction_start_dt, 0);	
		
		SELF.react_end_dt :=IF(isRE, R.transaction_end_dt, 0);

		SELF.port_start_dt := IF(isPA, R.transaction_start_dt, 0);

		SELF.port_end_dt :=	IF(isPA, R.transaction_end_dt, 0);

		SELF.deact_code := IF(isDESU, R.transaction_code, '');
		

		SELF.is_deact := IF(is_disconnected AND R.transaction_code != Phones.Constants.TransactionCodes.SWAP_ACTIVATION
							AND R.transaction_end_dt = 0, 'Y', 'N' );
		SELF.is_react := IF((isRE AND R.transaction_end_dt = 0), 'Y', 'N');																  
		SELF.is_ported := (isPA	AND R.transaction_end_dt = 0);
		
		boolean suspended := SELF.deact_code = Phones.Constants.TransactionCodes.SUSPENDED_CODE;

		SELF.event_type := MAP(isPA => Phones.Constants.PhoneAttributes.PORTED_PHONE,
						(is_disconnected AND R.transaction_code != Phones.Constants.TransactionCodes.SWAP_ACTIVATION) => Phones.Constants.PhoneAttributes.DISCONNECTED,
						isRE => Phones.Constants.TransactionCodes.REACTIVATED,
						isSW => Phones.Constants.PhoneAttributes.NUMBER_SWAPPED,
						suspended => Phones.Constants.PhoneAttributes.SUSPENDED,
						 '');

		SELF.event_date := MAX(SELF.port_start_dt, SELF.swap_start_dt, SELF.swap_end_dt, SELF.deact_start_dt, SELF.react_start_dt);					 
		SELF.phone := L.phone;
		SELF := R;				 							
	 	SELF := [];
	END;
	
	Phones_transactions := dx_PhonesInfo.RAW.GetPhoneTransactions(subjectInfo);
	Phones_tranpayload := JOIN(subjectInfo , dx_PhonesInfo.Key_Phones_Transaction,
	 								(LEFT.phone = RIGHT.phone) AND 
									 RIGHT.transaction_code != Phones.Constants.TransactionCodes.PORT_DELETE,
	 								tAppendTransInfo(LEFT, RIGHT), LEFT OUTER);							  
									 
	RETURN Phones_tranpayload;
	END;	

    EXPORT CombineRawPhoneData(DATASET(Phones.Layouts.rec_phoneLayout) subjectInfo) := FUNCTION
								  
	phone_type := dx_PhonesInfo.RAW.GetPhoneType(subjectInfo);
	Phones_typepayload := JOIN(subjectInfo , phone_type,
									(LEFT.phone = RIGHT.phone),
									TRANSFORM(dx_PhonesInfo.Layouts.Phones_Type_Main, SELF.phone := LEFT.phone; SELF:= RIGHT),
									LEFT OUTER);
	
	dPhonesType := PROJECT (Phones_typepayload, TRANSFORM(Phones.Layouts.portedMetadata_Main, SELF := LEFT; SELF := [])) ;
	
	dPhonesTransaction_info :=	GetPhoneTransactions(subjectInfo);
	dPortedOnlyTransactions:= dPhonesTransaction_info(source = Phones.Constants.Sources.ICONECTIV_SRC);

	Phones.Layouts.portedMetadata_Main tAppendPortInfo(Phones.Layouts.portedMetadata_Main L, Phones.Layouts.portedMetadata_Main R):= TRANSFORM	
		
		SELF.account_owner := R.account_owner;	
		SELF.carrier_name  := R.carrier_name;	
		SELF.line := R.line;
		SELF.serv := R.serv;		
		SELF.operator_fullname := R.operator_fullname;					 
		SELF := L;				 							
	END;

	
	dPhonesTransaction_withport := JOIN(dPortedOnlyTransactions, dPhonesType,
								LEFT.phone = RIGHT.phone AND
								LEFT.source  = RIGHT.source AND 
								LEFT.vendor_first_reported_dt  = RIGHT.vendor_first_reported_dt AND 
								LEFT.vendor_last_reported_dt = RIGHT.vendor_last_reported_dt AND LEFT.spid = RIGHT.spid,
								tAppendPortInfo(LEFT, RIGHT), LEFT OUTER);

	dPhones_transactions_combined := SORT((dPhonesTransaction_info(source != Phones.Constants.Sources.ICONECTIV_SRC) + dPhonesTransaction_withport),
											phone, -vendor_last_reported_dt, vendor_first_reported_dt);

	portRec := SORT(dPhonesTransaction_withport, phone, -vendor_last_reported_dt, vendor_first_reported_dt);		

	//Refine is_deact and is_react to show Ports
	Phones.Layouts.portedMetadata_Main addPortflag(dPhones_transactions_combined L, portRec R) := TRANSFORM
		//Condition 1: Flag records as "ported," when the difference between the deact_start_dt (and/or swap_start_dt) and port_start_dt is -1 to 5 days
		//Condition 2: Flag records as "ported," when the difference between the deact_start_dt and port_start_dt is 6 to 30 days and 
		//the deact carrier_name is different than the port carrier_name
		dcDaysApt := ut.DaysApart((STRING)L.deact_start_dt, (STRING)R.port_start_dt);
		swDaysApt := ut.DaysApart((STRING)L.swap_start_dt, (STRING)R.port_start_dt);
		deacDtMatch_1_5 	:= (L.deact_start_dt<>0 AND R.port_start_dt<>0 AND dcDaysApt between Phones.Constants.PhoneAttributes.PORT_LOWER_THRESHOLD and Phones.Constants.PhoneAttributes.PORT_UPPER_THRESHOLD);		
		swapDtMatch_1_5		:= (L.swap_start_dt<>0 AND R.port_start_dt<>0 AND swDaysApt between Phones.Constants.PhoneAttributes.PORT_LOWER_THRESHOLD and Phones.Constants.PhoneAttributes.PORT_UPPER_THRESHOLD);
		deacDtMatch_6_30    := (L.deact_start_dt<>0 AND R.port_start_dt<>0 AND dcDaysApt between Phones.Constants.PhoneAttributes.DISCONNECT_LOWER_THRESHOLD AND Phones.Constants.PhoneAttributes.DISCONNECT_UPPER_THRESHOLD AND 
									TRIM(R.carrier_name, left, right)<>'' and TRIM(R.operator_fullname, left, right)<>'' AND 
									TRIM(R.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(TRIM(R.operator_fullname, left, right)));		
		swapDtMatch_6_30	:= (L.swap_start_dt<>0 AND R.port_start_dt<>0 AND swDaysApt between Phones.Constants.PhoneAttributes.DISCONNECT_LOWER_THRESHOLD AND Phones.Constants.PhoneAttributes.DISCONNECT_UPPER_THRESHOLD AND 
									TRIM(R.carrier_name, left, right)<>'' AND TRIM(R.operator_fullname, left, right)<>'' AND 
									TRIM(R.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(TRIM(R.operator_fullname, left, right))); 
		SELF.is_deact := MAP((deacDtMatch_1_5 AND L.deact_code in [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE]) => Phones.Constants.PhoneAttributes.PORTED,
		  					  (swapDtMatch_1_5 AND L.swap_start_dt<>0) => Phones.Constants.PhoneAttributes.PORTED,
		 					  (deacDtMatch_6_30 AND L.deact_code in [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE]) => Phones.Constants.PhoneAttributes.PORTED,
		  					  (swapDtMatch_6_30 and L.swap_start_dt<>0)=> Phones.Constants.PhoneAttributes.PORTED,
		 					  L.is_deact);
		
		SELF.is_react := MAP((deacDtMatch_1_5 AND L.deact_code in [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE])=> Phones.Constants.PhoneAttributes.PORTED,
		 					  (swapDtMatch_1_5 AND L.swap_start_dt<>0) => Phones.Constants.PhoneAttributes.PORTED,
							  (deacDtMatch_6_30 AND L.deact_code in [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE])=> Phones.Constants.PhoneAttributes.PORTED,
		 					  (swapDtMatch_6_30 and L.swap_start_dt<>0) => Phones.Constants.PhoneAttributes.PORTED,
		 						L.is_react);
		SELF.porting_dt := MAP((deacDtMatch_1_5 OR deacDtMatch_6_30) AND (L.deact_code in [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE]) =>R.port_start_dt,
		 						((swapDtMatch_1_5 or swapDtMatch_6_30) and L.swap_start_dt<>0) =>R.port_start_dt,	
		 						R.is_ported => R.port_start_dt, 
								 L.porting_dt);
		SELF := L;							
	END;

	dPhones_combined_info := JOIN(dPhones_transactions_combined, portRec,
							left.phone = right.phone and
							((ut.DaysApart((string)left.deact_start_dt,(string)right.port_start_dt) between Phones.Constants.PhoneAttributes.PORT_LOWER_THRESHOLD and Phones.Constants.PhoneAttributes.PORT_UPPER_THRESHOLD) or
							(ut.DaysApart((string)left.swap_start_dt,(string)right.port_start_dt) between Phones.Constants.PhoneAttributes.PORT_LOWER_THRESHOLD and Phones.Constants.PhoneAttributes.PORT_UPPER_THRESHOLD) or
							(ut.DaysApart((string)left.deact_start_dt,(string)right.port_start_dt) between Phones.Constants.PhoneAttributes.DISCONNECT_LOWER_THRESHOLD and Phones.Constants.PhoneAttributes.DISCONNECT_UPPER_THRESHOLD and 
							trim(left.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(trim(right.operator_fullname, left, right)) and trim(left.carrier_name, left, right)<>'' and trim(right.operator_fullname, left, right)<>'') or
							(ut.DaysApart((string)left.swap_start_dt,(string)right.port_start_dt) between Phones.Constants.PhoneAttributes.DISCONNECT_LOWER_THRESHOLD and Phones.Constants.PhoneAttributes.DISCONNECT_UPPER_THRESHOLD and 
							trim(left.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(trim(right.operator_fullname, left, right)) and trim(left.carrier_name, left, right)<>'' and trim(right.operator_fullname, left, right)<>'')),
							addPortflag(left, right), left outer);

	dPhones_combined :=	dPhones_combined_info + dPhonesType(source != Phones.Constants.Sources.ICONECTIV_SRC);

	dPhone_out :=  DEDUP(SORT(dPhones_combined, phone, source, account_owner, -event_date, -vendor_last_reported_dt, vendor_first_reported_dt),
								phone, source, account_owner, event_date, vendor_last_reported_dt, vendor_first_reported_dt);

	RETURN dPhone_out;
    END;

END;