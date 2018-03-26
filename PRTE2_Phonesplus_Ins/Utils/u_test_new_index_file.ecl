//--------------------------------------------------
// PRTE2_Phonesplus_Ins.u_test_new_index_file
// testing new build key files
//--------------------------------------------------
IMPORT Phonesplus_v2, PRTE2_Phonesplus_Ins;
IMPORT PRTE2_Phonesplus_Ins, PRTE2_Header_Ins, PRTE2_X_DataCleanse, PRTE_CSV, Address, PRTE2_Common,ut;

/*

MHDR_Layout := PRTE2_X_Ins_DataCleanse.Layouts.Layout_Merged_IHDR_BHDR;
Dirty_MHDR := PRTE2_X_Ins_DataCleanse.Files_Alpha.Merged_Headers_DS((INTEGER)addr_ind=1);

MHDR := Dirty_MHDR;  // for simplicity

OUTPUT(MHDR);

DS1 := count(MHDR(phone = ''));
DS1;


DS2 := MHDR((integer)did <= 888809054141 AND (integer)did >= 888809052179);
DS2;
count(DS2);

*/




key_phonesplus_did := index(DATASET([],Phonesplus_v2.Layout_Phonesplus_Base),
														{unsigned6 l_did := did},{Phonesplus_v2.Layout_Phonesplus_Base},
														'~prte::key::phonesplusv2::20151016::did');

ds := key_phonesplus_did(l_did = (integer)'888809000000')
		+ key_phonesplus_did(l_did = (integer)'888809054137')		// not found
		+ key_phonesplus_did(l_did = (integer)'888809046498')
		+ key_phonesplus_did(lname = 'RELIFORD')		// not found
		+ key_phonesplus_did(lname = 'DUNKER')
		+ key_phonesplus_did(l_did = (integer)'888809052178')
		+ key_phonesplus_did(l_did = (integer)'888809052179')
		+ key_phonesplus_did(l_did = (integer)'888809052180')
		+ key_phonesplus_did(l_did = (integer)'888809052181')
		+ key_phonesplus_did(l_did = (integer)'888809052182')
		+ key_phonesplus_did(l_did = (integer)'888809052183')
		+ key_phonesplus_did(l_did = (integer)'888809052184')
		+ key_phonesplus_did(l_did = (integer)'888809052185')
		+ key_phonesplus_did(l_did = (integer)'888809052186')
		+ key_phonesplus_did(l_did = (integer)'888809052187')
		;

ds;
