 IMPORT dx_PhoneFinderReportDelta, UT, STD;
  // Calculte the number of times phone was returned in response

  EXPORT GetPhoneTransactionCount(DATASET({$.Layouts.PhoneFinder.Final.phone}) dPhoneIn,
                            UNSIGNED1 ThresholdA_value) := FUNCTION

  currentDate := (STRING)STD.Date.Today();

  thresholdDate := UT.date_math((STRING)currentDate, -ThresholdA_value);

  dPrepTransactionReturn := SORT(JOIN(dPhoneIn, dx_PhoneFinderReportDelta.Key_Transactions_Phone,
 														    (LEFT.phone = RIGHT.phonenumber) AND
                                (RIGHT.transaction_date BETWEEN thresholdDate AND currentDate),
 														    TRANSFORM({$.Layouts.PhoneFinder.Final.phone}, SELF.phone := RIGHT.phonenumber)),phone);
																	

 PhoneCount := RECORD
    dPrepTransactionReturn.phone;
    phonecount := COUNT(GROUP);
  END;     

  dPhoneOut := TABLE(dPrepTransactionReturn, PhoneCount, phone);   

 RETURN dPhoneOut;                           

END;                            