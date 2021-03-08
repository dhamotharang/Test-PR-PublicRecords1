/*Cleans input phone
    Keep only digits 0123456789 (filter out anything else).
    Remove phones that are not 7 or 10 characters
    Remove phones that are in ut.Set_BadPhone
*/
IMPORT ut, STD;
EXPORT Fn_Clean_Phone (STRING phone) := FUNCTION
  PhoneNums := STD.Str.Filter(phone, '0123456789');
  PhoneNumsLen := LENGTH(PhoneNums);
  numericPhones := IF(PhoneNumsLen IN [7, 10], PhoneNums, '');
  PhonesGood := IF(numericPhones NOT IN ut.Set_BadPhones, numericPhones, '');
  
	RETURN PhonesGood;
END;