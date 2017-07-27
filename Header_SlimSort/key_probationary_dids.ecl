import doxie;

df := header_slimsort.Table_DID_OnProbation;

didrec := record
	df;
	unsigned __fpos := 0;
end;

df2 := table(df,didrec);

export key_probationary_dids := index(df2,,'~thor_data400::key::probationary_dids_'+doxie.Version_SuperKey);