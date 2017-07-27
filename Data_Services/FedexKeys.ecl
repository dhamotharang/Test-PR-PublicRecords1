export FedexKeys := macro
/*
output(choosen(fedex.key_fedex_payload,10));
t := '~thor_data400::key::fedex::autokey::qa::';
output(choosen(AutoKey.Key_CityStName(t),10));
output(choosen(AutoKey.Key_Name(t),10));
output(choosen(AutoKey.Key_Phone2(t),10));
output(choosen(AutoKey.Key_StName(t),10));
dzipPRLname := DATASET([], CanadianPhones.layouts.zipPRLname);
output(choosen(INDEX(dzipPRLname, {dzipPRLname}, TRIM(t)+'ZipPRLname'),10));
dzip:= DATASET([], CanadianPhones.layouts.zip);
output(choosen(INDEX(dzip, {dzip}, TRIM(t)+'Zip'),10));
daddress := DATASET([], CanadianPhones.layouts.address);
output(choosen(INDEX(daddress, {daddress}, TRIM(t)+'address'),10));
*/
// New fedex keys

output(choosen(fedex.key_fedex2_payload,10));
t1 := '~thor_data400::key::fedex2::autokey::qa::';
output(choosen(AutoKey.Key_CityStName(t1),10));
output(choosen(AutoKey.Key_Name(t1),10));
output(choosen(AutoKey.Key_Phone2(t1),10));
output(choosen(AutoKey.Key_StName(t1),10));
dzipPRLname1 := DATASET([], CanadianPhones.layouts.zipPRLname);
output(choosen(INDEX(dzipPRLname1, {dzipPRLname1}, TRIM(t1)+'ZipPRLname'),10));
dzip1:= DATASET([], CanadianPhones.layouts.zip);
output(choosen(INDEX(dzip1, {dzip1}, TRIM(t1)+'Zip'),10));
daddress1 := DATASET([], CanadianPhones.layouts.address);
output(choosen(INDEX(daddress1, {daddress1}, TRIM(t1)+'address'),10));
endmacro;