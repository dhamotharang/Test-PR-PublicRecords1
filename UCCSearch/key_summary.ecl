import UCCsearch, uccd;

f1 := UCCD.File_WithExpSummary2_Base_Dev;


export key_summary := index(f1, {l_ucc_key := ucc_key},{f1},'~thor_data400::key::moxie_ucc_summary2.ucc_key');

