/*--SOAP--
<message name="UtilityDaily">
</message>
*/

export UtilityDailyKeys := MACRO


output(choosen(UtilFile.Key_Util_Daily_Address,10));
output(choosen(UtilFile.Key_Util_Daily_CityStName,10));
output(choosen(utilfile.Key_Util_Daily_Did,10));
output(choosen(utilfile.Key_Util_Daily_FDID,10));
//output(choosen(utilfile.Key_Util_Daily_ID,10));
output(choosen(utilfile.Key_Util_Daily_Name,10));
output(choosen(utilfile.Key_Util_Daily_Phone,10));
output(choosen(utilfile.Key_Util_Daily_SSN,10));
output(choosen(utilfile.Key_Util_Daily_StName,10));
output(choosen(utilfile.Key_Util_Daily_Zip,10));
output(choosen(utilfile.Key_Address,10));
output(choosen(Autokey.Key_ZipPRLName('~thor_data400::key::utility::daily.'),10));
output(choosen(suppress.key_ssnOver,10));
output(choosen(UtilFile.Key_Bus_Address,10));
output(choosen(UtilFile.Key_Util_Daily_Bus_Bdid,10));
output(choosen(UtilFile.Key_Util_Daily_Bus_ID,10));
output(choosen(AutokeyB2.Key_Address('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_CityStName('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
// output(choosen(AutoKeyB2.Key_FEIN('~thor_data400::key::utility::daily::bus::autokey::'),10));
output(choosen(AutoKeyB2.key_name('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_NameWords('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
output(choosen(AutoKeyB2.key_phone('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_StName('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
output(choosen(AutoKeyB2.Key_Zip('~thor_data400::key::utility::daily::bus::autokey::qa::'),10));
output(choosen(UtilFile.Key_Util_Daily_Bus_Payload,10));
output(choosen(utilfile.key_did,10));
output(choosen(misc2.key_misc2b_hval,10));
output(choosen(misc2.key_DateCorrect_hval,10));
ENDMACRO;