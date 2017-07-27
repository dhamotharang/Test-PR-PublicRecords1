/*--SOAP--
<message name="UCCKeys">
</message>
*/

export UCCKeys := macro
output(choosen(uccd.key_did,10));
output(choosen(uccd.key_bdid,10));
output(choosen(uccd.key_ucc,10));
endmacro;