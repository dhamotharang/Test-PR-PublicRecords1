/*--SOAP--
<message name="LiensDaily">
</message>
*/

export Liens_Daily := MACRO


output(choosen(doxie.key_liens_did,10));
output(choosen(doxie.key_liens_bdid,10));
output(choosen(doxie.key_liens_rmsid,10));
output(choosen(doxie.key_liens_st_case,10));
output(choosen(bankrupt.key_liens_plaintiffname,10));
output(choosen(doxie.key_liens_bdid_pl,10));
output(choosen(doxie_files.Key_BocaShell_Liens,10));

ENDMACRO;