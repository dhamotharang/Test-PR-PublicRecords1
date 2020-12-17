IMPORT PhonesInfo, dx_PhonesInfo, Phones, UT, STD;
EXPORT GetPhoneMetadata := MODULE

//Based on subject info get ALL ports and CURRENT deact records


EXPORT GetPhoneTransactions(DATASET(Phones.Layouts.rec_phoneLayout) subjectInfo) := FUNCTION

  today := STD.Date.Today();
  OTPAllowedDate_30 := (UNSIGNED)ut.date_math((STRING)today, -30);
  OTPAllowedDate_60 := (UNSIGNED)ut.date_math((STRING)today, -60);
  OTPAllowedDate_90 := (UNSIGNED)ut.date_math((STRING)today, -90);
  OTPAllowedDate_180 := (UNSIGNED)ut.date_math((STRING)today, -180);
  OTPAllowedDate_365 := (UNSIGNED)ut.date_math((STRING)today, -365);
  OTPAllowedDate_730 := (UNSIGNED)ut.date_math((STRING)today, -730);

  Phones.Layouts.portedMetadata_Main tAppendTransInfo(Phones.Layouts.rec_phoneLayout L, dx_PhonesInfo.Key_Phones_Transaction R):= TRANSFORM
    isDESU := (R.transaction_code IN [Phones.Constants.TransactionCodes.DISCONNECTED_CODE, Phones.Constants.TransactionCodes.SUSPENDED_CODE]);
    isSW := (R.transaction_code = Phones.Constants.TransactionCodes.SWAP_DEACTIVATION);
    isRE := (R.transaction_code = Phones.Constants.TransactionCodes.REACTIVATED);
    isPA := R.transaction_code = Phones.Constants.TransactionCodes.PORT_ADD;
    is_disconnected := (R.source IN [Phones.Constants.Sources.GONG_DISCONNECT_SRC, Phones.Constants.Sources.DISCONNECT_SRC] AND
                (isDESU OR isSW));
    is_AS := R.transaction_code = Phones.Constants.TransactionCodes.ACTIVE_STATUS;
    is_OTP := R.Source = Phones.Constants.Sources.PHONEFRAUD_OTP;

    SELF.transaction_code := R.transaction_code;

    SELF.swap_start_dt := IF(isSW, R.transaction_start_dt, 0);

    SELF.swap_end_dt := IF(isSW, R.transaction_end_dt, 0);

    SELF.deact_start_dt  := IF(isDESU, R.transaction_start_dt, 0);

    SELF.deact_end_dt := IF(isDESU, R.transaction_end_dt, 0);;

    SELF.react_start_dt := IF(isRE, R.transaction_start_dt, 0);

    SELF.react_end_dt :=IF(isRE, R.transaction_end_dt, 0);

    SELF.port_start_dt := IF(isPA, R.transaction_start_dt, 0);

    SELF.port_end_dt :=	IF(isPA, R.transaction_end_dt, 0);

    SELF.deact_code := IF(isDESU, R.transaction_code, '');


    SELF.is_deact := MAP(is_disconnected AND R.transaction_code != Phones.Constants.TransactionCodes.SWAP_ACTIVATION AND R.transaction_end_dt = 0 => 'Y',
                        R.source IN [Phones.Constants.Sources.GONG_DISCONNECT_SRC, Phones.Constants.Sources.DISCONNECT_SRC] => 'N',
                        '' );
    SELF.is_react := MAP((isRE AND R.transaction_end_dt = 0) => 'Y',
                         R.source IN [Phones.Constants.Sources.GONG_DISCONNECT_SRC, Phones.Constants.Sources.DISCONNECT_SRC] => 'N',
                         '');
    SELF.is_ported := (isPA	AND R.transaction_end_dt = 0);

    SELF.dt_first_reported := IF(is_AS, R.transaction_start_dt,0);
    SELF.dt_last_reported := IF(is_AS, R.transaction_end_dt,0);

    boolean suspended := SELF.deact_code = Phones.Constants.TransactionCodes.SUSPENDED_CODE;

    SELF.event_type := MAP(isPA => Phones.Constants.PhoneAttributes.PORTED_PHONE,
            (is_disconnected AND R.transaction_code != Phones.Constants.TransactionCodes.SWAP_ACTIVATION) => Phones.Constants.PhoneAttributes.DISCONNECTED,
            isRE => Phones.Constants.TransactionCodes.REACTIVATED,
            isSW => Phones.Constants.PhoneAttributes.NUMBER_SWAPPED,
            suspended => Phones.Constants.PhoneAttributes.SUSPENDED,
            is_AS => Phones.Constants.TransactionCodes.ACTIVE_STATUS,
             '');

    SELF.event_date := MAX(SELF.port_start_dt, SELF.swap_start_dt, SELF.swap_end_dt, SELF.deact_start_dt, SELF.react_start_dt,SELF.dt_first_reported);
    SELF.phone := L.phone;
    SELF.account_owner := R.ocn;
    SELF.count_otp_30 := IF(is_OTP AND (R.transaction_end_dt >= OTPAllowedDate_30 OR R.transaction_start_dt >= OTPAllowedDate_30),R.transaction_count,0);
    SELF.count_otp_60 := IF(is_OTP AND (R.transaction_end_dt >= OTPAllowedDate_60 OR R.transaction_start_dt >= OTPAllowedDate_60),R.transaction_count,0);
    SELF.count_otp_90 := IF(is_OTP AND (R.transaction_end_dt >= OTPAllowedDate_90 OR R.transaction_start_dt >= OTPAllowedDate_90),R.transaction_count,0);
    SELF.count_otp_180 := IF(is_OTP AND (R.transaction_end_dt >= OTPAllowedDate_180 OR R.transaction_start_dt >= OTPAllowedDate_180),R.transaction_count,0);
    SELF.count_otp_365 := IF(is_OTP AND (R.transaction_end_dt >= OTPAllowedDate_365 OR R.transaction_start_dt >= OTPAllowedDate_365),R.transaction_count,0);
    SELF.count_otp_730 := IF(is_OTP AND (R.transaction_end_dt >= OTPAllowedDate_730 OR R.transaction_start_dt >= OTPAllowedDate_730),R.transaction_count,0);

    SELF := R;
     SELF := [];
  END;

  Phones_transactions := dx_PhonesInfo.RAW.GetPhoneTransactions(subjectInfo);
  Phones_tranpayload := JOIN(subjectInfo , Phones_transactions,
                   (LEFT.phone = RIGHT.phone) AND
                   RIGHT.transaction_code != Phones.Constants.TransactionCodes.PORT_DELETE,
                   tAppendTransInfo(LEFT, RIGHT), LEFT OUTER);


  Phones.Layouts.portedMetadata_Main tRollupOTP(Phones.Layouts.portedMetadata_Main L, Phones.Layouts.portedMetadata_Main R):= TRANSFORM
      SELF.count_otp_30 := L.count_otp_30 + R.count_otp_30;
      SELF.count_otp_60 := L.count_otp_60 + R.count_otp_60;
      SELF.count_otp_90 := L.count_otp_90 + R.count_otp_90;
      SELF.count_otp_180 := L.count_otp_180 + R.count_otp_180;
      SELF.count_otp_365 := L.count_otp_365 + R.count_otp_365;
      SELF.count_otp_730 := L.count_otp_730 + R.count_otp_730;
      SELF := L;
  END;

  Phones_tranpayloadwOTP :=  ROLLUP(SORT(Phones_tranpayload,phone,source,-vendor_last_reported_dt),LEFT.phone = RIGHT.phone AND
                                   (Left.Source = Phones.Constants.Sources.PHONEFRAUD_OTP AND Left.Source = Right.Source),
                                   tRollupOTP(LEFT,RIGHT));

  RETURN Phones_tranpayloadwOTP;
  END;

    EXPORT CombineRawPhoneData(DATASET(Phones.Layouts.rec_phoneLayout) subjectInfo) := FUNCTION

  phone_type := dx_PhonesInfo.RAW.GetPhoneType(subjectInfo);
  Phones_typepayload := JOIN(subjectInfo , phone_type,
                  (LEFT.phone = RIGHT.phone),
                  TRANSFORM(dx_PhonesInfo.Layouts.Phones_Type_Main, SELF.phone := LEFT.phone; SELF:= RIGHT),
                  LEFT OUTER);

  dPhonesType := PROJECT (Phones_typepayload, TRANSFORM(Phones.Layouts.portedMetadata_Main, SELF := LEFT; SELF := [])) ;

  dPhonesTransaction_info :=	GetPhoneTransactions(subjectInfo);

  dPortedOnlyTransactions:= dPhonesTransaction_info(source IN Phones.Constants.Sources.set_ICONECTIV_SRC);

  Phones.Layouts.portedMetadata_Main tAppendPortInfo(Phones.Layouts.portedMetadata_Main L, Phones.Layouts.portedMetadata_Main R):= TRANSFORM

    SELF.account_owner := R.account_owner;
    SELF.carrier_name  := R.carrier_name;
    SELF.line := R.line;
    SELF.serv := R.serv;
    SELF.operator_fullname := R.operator_fullname;
    SELF.high_risk_indicator := R.high_risk_indicator;
    SELF.prepaid := R.prepaid;
    SELF := L;
  END;


  dPhonesTransaction_withport := JOIN(dPortedOnlyTransactions, dPhonesType,
                LEFT.phone = RIGHT.phone AND
                LEFT.source  = RIGHT.source AND
                (LEFT.vendor_first_reported_dt  >= RIGHT.vendor_first_reported_dt AND
                LEFT.vendor_last_reported_dt <= RIGHT.vendor_last_reported_dt) AND LEFT.spid = RIGHT.spid,
                tAppendPortInfo(LEFT, RIGHT), LEFT OUTER);

  dPhones_transactions_combined := SORT((dPhonesTransaction_info(source NOT IN Phones.Constants.Sources.set_ICONECTIV_SRC) + dPhonesTransaction_withport),
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
                  TRIM(L.carrier_name, left, right)<>'' and TRIM(R.operator_fullname, left, right)<>'' AND
                  TRIM(L.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(TRIM(R.operator_fullname, left, right)));

    swapDtMatch_6_30	:= (L.swap_start_dt<>0 AND R.port_start_dt<>0 AND swDaysApt between Phones.Constants.PhoneAttributes.DISCONNECT_LOWER_THRESHOLD AND Phones.Constants.PhoneAttributes.DISCONNECT_UPPER_THRESHOLD AND
                  TRIM(L.carrier_name, left, right)<>'' AND TRIM(R.operator_fullname, left, right)<>'' AND
                  TRIM(L.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(TRIM(R.operator_fullname, left, right)));

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
                 L.port_start_dt);
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

  dPhones_combined :=	dPhones_combined_info + dPhonesType(source NOT IN Phones.Constants.Sources.set_ICONECTIV_SRC);

  dPhone_out :=  DEDUP(SORT(dPhones_combined, phone, source, account_owner, -event_date, -vendor_last_reported_dt, vendor_first_reported_dt, is_deact, is_react),
                phone, source, account_owner, event_date, vendor_last_reported_dt, vendor_first_reported_dt, is_deact, is_react);
  RETURN dPhone_out;
    END;

END;
