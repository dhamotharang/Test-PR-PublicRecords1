export FCCKeys := macro
	output(choosen(FCC.Key_FCC_BDID,10));
	output(choosen(FCC.Key_FCC_DID,10));
	output(choosen(FCC.Key_FCC_seq,10));
	output(choosen(FCC.Key_Payload,10));
	output(choosen(autokey.key_stname(FCC.constant('').ak_qaname),10));
output(choosen(autokey.key_address(FCC.constant('').ak_qaname),10));
output(choosen(autokey.key_name(FCC.constant('').ak_qaname),10));
output(choosen(autokey.key_phone2(FCC.constant('').ak_qaname),10));
output(choosen(autokey.key_citystname(FCC.constant('').ak_qaname),10));
output(choosen(autokey.key_zip(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_citystname(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_zip(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_address(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_namewords(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_stname(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_name(FCC.constant('').ak_qaname),10));
output(choosen(autokeyb2.key_phone(FCC.constant('').ak_qaname),10));

endmacro;