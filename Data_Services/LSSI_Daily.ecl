/*--SOAP--
<message name="LSSIDaily">
</message>
*/

export LSSI_Daily := MACRO

output(choosen(doxie.Key_Lssi_Did_Add,10));
output(choosen(doxie.Key_Lssi_Hhid_Add,10));
output(choosen(doxie.Key_Lssi_Remove,10));

ENDMACRO;