import Risk_Indicators;	
	valid_npa				:= Risk_Indicators.File_Telcordia_tpm;
	valid_npa_dedp	:= dedup(sort(distribute(valid_npa, hash(npa)), npa, local),npa, local);
	
	EXPORT npa_list := valid_npa_dedp;