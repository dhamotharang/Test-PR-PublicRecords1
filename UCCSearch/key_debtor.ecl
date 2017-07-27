import UCCsearch, uccd;

f1 := UCCD.File_WithExpDebtor2_Base_Dev;

base_key_Name := '~thor_data400::key::moxie_ucc_debtor2.';
			

export key_debtor := index(f1, {string50 l_ucc_key := ucc_key},{f1},base_key_Name + 'ucc_key');


			
			
