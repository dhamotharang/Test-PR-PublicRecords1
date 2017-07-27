import GlobalWatchlists, worldcheck;

// hacky, but the size of the worldcheck file + the size o hte layout_batch_in + the 8 extra bytes
// + extra 3600 bytes to adjust for 'companies' and 'linked_tos' fileds translations
sz := worldcheck.constants.infile_max + 370 + 8 + 3600; // linked_tos: ~2000; companies: ~1600

export Layout_Out :=
RECORD, maxlength(sz)
	GlobalWatchlists.Layout_Batch_In;
	STRING3 HitNum;
	STRING5 score;
	Worldcheck.Layout_WorldCheck_in;
END;