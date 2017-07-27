/*--SOAP--
<message name="PatriotWeekly">
</message>
*/

export Patriot_Weekly := MACRO

output(choosen(Patriot.key_baddids,10));
output(choosen(Patriot.key_badnames,10));
output(choosen(Patriot.Key_Baddids_with_name,10));
output(choosen(patriot.key_patriot_file,10));
output(choosen(patriot.key_did_patriot_file,10));
output(choosen(patriot.key_bdid_patriot_file,10));
//output(choosen(patriot.key_patriot_key,10));
output(choosen(patriot.Key_Phonetic_Name,10));

ENDMACRO;