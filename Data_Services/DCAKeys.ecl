/*--SOAP--
<message name="DCAKeys">
</message>
*/

export DCAKeys := macro

output(choosen(DCA.Key_DCA_BDID,10));
output(choosen(DCA.Key_DCA_Root_Sub,10));
output(choosen(DCA.Key_DCA_Hierarchy_BDID,10));
output(choosen(DCA.Key_DCA_Hierarchy_Root_Sub,10));
output(choosen(dca.key_dca_AutokeyPayload,10));

output(choosen(AutokeyB2.Key_Address(dca.Constants().ak_qa_keyname),10));
output(choosen(AutoKeyB2.Key_CityStName(dca.Constants().ak_qa_keyname),10));
// output(choosen(AutoKeyB2.Key_FEIN(dca.Constants().ak_qa_keyname),10));
output(choosen(AutoKeyB2.key_name(dca.Constants().ak_qa_keyname),10));
output(choosen(AutoKeyB2.Key_NameWords(dca.Constants().ak_qa_keyname),10));
// output(choosen(AutoKeyB2.key_phone(dca.Constants().ak_qa_keyname),10));
output(choosen(AutoKeyB2.Key_StName(dca.Constants().ak_qa_keyname),10));
output(choosen(AutoKeyB2.Key_Zip(dca.Constants().ak_qa_keyname),10));

// new key

output(choosen(dca.Key_DCA_Hierarchy_Parent_to_Child_Root_Sub,10));

endmacro;