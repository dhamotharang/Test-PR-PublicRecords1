/*--SOAP--
<message name="LNProperty1">
</message>
*/

export LNProperty1 := macro

output(choosen(doxie_ln.Key_Addr_Fid,10));
output(choosen(doxie_ln.key_assessor_fid,10));
output(choosen(doxie_ln.Key_Assessors_ParcelNum,10));
output(choosen(doxie_ln.key_deed_fid,10));
output(choosen(doxie_ln.Key_Deeds_ParcelNum,10));
output(choosen(doxie_ln.key_fid_county,10));
output(choosen(doxie_ln.key_fid_search,10));
output(choosen(doxie_ln.Key_FIDAddlNames,10));
output(choosen(doxie_ln.Key_Prop_Address,10));
output(choosen(doxie_ln.Key_Prop_Ownership,10));
output(choosen(doxie_ln.key_property_did,10));
output(choosen(doxie_ln.Key_Search_BDID,10));

endmacro;