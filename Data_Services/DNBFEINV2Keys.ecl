export DNBFEINV2Keys := macro
	output(choosen(DNB_FEINV2.key_DNB_Fein_BDID,10));
	output(choosen(DNB_FEINV2.key_dnb_fein_tmsid,10));
	output(choosen(DNB_FEINV2.key_DNBFein_AutokeyPayload,10));
	output(choosen(AutokeyB2.Key_Address(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.Key_CityStName(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.Key_FEIN(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.key_name(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.Key_NameWords(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.Key_StName(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.Key_Zip(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));
	output(choosen(AutoKeyB2.Key_Phone(dnb_feinv2.cluster + 'key::Dnbfein::autokey::'),10));

endmacro;