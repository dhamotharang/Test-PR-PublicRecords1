/*--SOAP--
<message name="DLWeekly">
</message>
*/

export DL_Weekly := MACRO

output(choosen(doxie_files.key_dl,10));
output(choosen(doxie_files.key_dl_number,10));
output(choosen(doxie_files.key_dl_indicatives,10));
output(choosen(doxie_files.key_dl_did,10));
output(choosen(doxie_files.Key_BocaShell_DL,10));
ENDMACRO;