export fbnv2Keys() := macro

output(choosen(FBNV2.Key_BDID,10));
output(choosen(FBNV2.Key_date,10));
output(choosen(FBNV2.Key_DID,10));
output(choosen(FBNV2.Key_Filing_Number,10));
output(choosen(FBNV2.Key_Jurisdiction,10));
output(choosen(FBNV2.Key_Payload,10));
output(choosen(FBNV2.Key_Rmsid,10));
output(choosen(FBNV2.Key_Rmsid_Business,10));
output(choosen(FBNV2.Key_Rmsid_Contact,10));

akn := fbnv2.Constant('').ak_QAname;

output(choosen(Autokey.Key_Address(akn),10));
output(choosen(AutoKey.Key_CityStName(akn),10));
output(choosen(AutoKey.Key_Name(akn),10));
// output(choosen(AutoKey.Key_Phone(akn),10));
output(choosen(AutoKey.Key_Phone2(akn),10));
// output(choosen(AutoKey.Key_SSN(akn),10));
output(choosen(AutoKey.Key_SSN2(akn),10));
output(choosen(AutoKey.Key_StName(akn),10));
output(choosen(AutoKey.Key_Zip(akn),10));
output(choosen(AutokeyB2.Key_Address(akn),10));
output(choosen(AutoKeyB2.Key_CityStName(akn),10));
output(choosen(AutoKeyB2.Key_FEIN(akn),10));
output(choosen(AutoKeyB2.key_name(akn),10));
output(choosen(AutoKeyB2.Key_NameWords(akn),10));
output(choosen(AutoKeyB2.key_phone(akn),10));
output(choosen(AutoKeyB2.Key_StName(akn),10));
output(choosen(AutoKeyB2.Key_Zip(akn),10));

endmacro;