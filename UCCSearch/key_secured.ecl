import UCCsearch, uccd;

f1 := UCCD.File_WithExpsecured2_Base_Dev;

base_key_Name := '~thor_data400::key::moxie_ucc_secured2.';
			

export key_secured := index(f1,{l_ucc_key := ucc_key},{f1},base_key_Name + 'ucc_key');

