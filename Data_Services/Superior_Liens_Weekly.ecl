/*--SOAP--
<message name="SuperiorLiensWeekly">
</message>
*/

export Superior_Liens_Weekly := MACRO


output(choosen(liens_superior.key_did,10));
output(choosen(liens_superior.key_bdid,10));

ENDMACRO;