/*--SOAP--
<message name="UtilityDaily">
</message>
*/

export Utility_Daily := MACRO


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

ENDMACRO;