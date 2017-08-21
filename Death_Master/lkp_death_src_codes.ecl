layout_lkp_source_cd	:= record
	string3	state_cd;
	string3	src;
end;

EXPORT lkp_death_src_codes := dataset([
		{'CA','D0'},
		{'CT','D1'},
		{'FL','D2'},
		{'GA','D3'},
		{'KY','D4'},
		{'MA','D5'},
		{'ME','D6'},
		{'MI','D7'},
		{'MN','D8'},
		{'MT','D9'},
		{'NV','D!'},
		{'NC','D#'},
		{'OH','D@'},
		{'VA','D%'}
		],layout_lkp_source_cd
);