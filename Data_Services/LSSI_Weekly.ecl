/*--SOAP--
<message name="LSSIWeekly">
</message>
*/

export LSSI_Weekly := MACRO

output(choosen(doxie.Key_Lssi_Did,10));
output(choosen(doxie.Key_Lssi_Hhid,10));

ENDMACRO;