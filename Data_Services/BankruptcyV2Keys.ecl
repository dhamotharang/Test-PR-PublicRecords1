/*--SOAP--
<message name="BankruptDaily">
</message>
*/

export BankruptcyV2Keys := macro
	output(choosen(Autokey.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKey.Key_CityStName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKey.Key_Name(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKey.Key_Phone2(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKey.Key_SSN2(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKey.Key_StName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKey.Key_Zip(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutokeyB2.Key_Address(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.Key_CityStName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.Key_FEIN(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.key_name(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.Key_NameWords(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.key_phone(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.Key_StName(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(AutoKeyB2.Key_Zip(BankruptcyV2.cluster + 'key::bankruptcy::autokey::'),10));
	output(choosen(bankruptcyv2.key_bankruptcy_bdid(),10));
	output(choosen(bankruptcyv2.key_bankruptcy_casenumber(),10));
	output(choosen(bankruptcyv2.key_bankruptcy_did(),10));
	output(choosen(bankruptcyv2.key_bankruptcy_main_full(),10));
	output(choosen(bankruptcyv2.key_bankruptcy_search_full(),10));
	output(choosen(bankruptcyv2.Key_Bankruptcy_Payload(),10));
	//output(choosen(BankruptcyV2.Key_BocaShell_bkruptV2,10));
	output(choosen(Bankruptcyv2.key_bankruptcy_ssn(),10));
	output(choosen(BankruptcyV3.key_bankruptcyV3_search_full(),10));
	output(choosen(BankruptcyV3.key_bankruptcyV3_main_full(),10));
	output(choosen(BankruptcyV3.Key_BocaShell_bkruptV3,10));
	output(choosen(BankruptcyV3.Key_bankruptcyV3_bocashell,10));
	output(choosen(BankruptcyV3.Key_bankruptcyV3_ssnmatch(),10));
	output(choosen(BankruptcyV3.key_bankruptcy_main_supp(),10));
	output(choosen(BankruptcyV3.key_bankruptcyV3_ssn4st(),10));
	output(choosen(BankruptcyV2.key_bankruptcy_ssn4name('~thor_data400::key::bankruptcy::autokey::'),10));
	output(choosen(BankruptcyV3.key_bankruptcyv3_trusteeidname(),10));
endmacro;