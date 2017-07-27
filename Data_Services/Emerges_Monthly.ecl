/*--SOAP--
<message name="EmergesMonthly">
</message>
*/

export Emerges_Monthly := Macro

output(choosen(doxie_files.key_hunters_did,10));
output(choosen(doxie_files.key_ccw_did,10));
output(choosen(doxie_files.key_voters_did,10));
endmacro;