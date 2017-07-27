import UCCsearch, uccd;

f1 := UCCD.File_WithExpEvent2_Base_Dev;

base_key_Name := '~thor_data400::key::moxie_ucc_events2.';
			

export key_events := index(f1, {l_ucc_key := ucc_key},{f1},base_key_Name + 'ucc_key');


			