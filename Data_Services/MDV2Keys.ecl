export MDV2Keys := macro
	output(choosen(marriage_divorce_v2.key_mar_div_did,10));
output(choosen(marriage_divorce_v2.key_mar_div_filing_nbr,10));
output(choosen(marriage_divorce_v2.key_mar_div_id_main,10));
output(choosen(marriage_divorce_v2.key_mar_div_id_search,10));
output(choosen(marriage_divorce_v2.key_mar_div_payload,10));
output(choosen(autokey.key_address(Marriage_divorce_v2.constants().ak_keyname),10));
output(choosen(autokey.Key_CityStName(Marriage_divorce_v2.constants().ak_keyname),10));
output(choosen(autokey.Key_Name(Marriage_divorce_v2.constants().ak_keyname),10));
output(choosen(autokey.Key_StName(Marriage_divorce_v2.constants().ak_keyname),10));
output(choosen(autokey.Key_Zip(Marriage_divorce_v2.constants().ak_keyname),10));



endmacro;