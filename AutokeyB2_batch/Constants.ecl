export Constants := MODULE

  // Search Statuses:
	export SUCCEEDED               :=   0;
	export FAILED_TOO_MANY_MATCHES := 203;
	export FAILED_NO_MATCHES       :=  98;
	
	// Match codes:
	export NO_MATCH                :=  '';
	export ADDRESS_MATCH           := 'A';
	export COMP_ADDR_MATCH         := 'Ac';
	export NAME_MATCH              := 'N';
	export COMP_NAME_MATCH         := 'Cn';
	export NAME_WORDS_MATCH        := 'W';
	export PHONE_MATCH             := 'Q';	// i.e. Business Phone
	export ZIP_MATCH               := 'Z';
	export ZIPPRLNAME_MATCH        := 'M';
	export FEIN_MATCH              := 'F';
	export STNAME_MATCH            := 'T';
	export CITYSTFLNAME_MATCH      := 'L';
	export SSN_MATCH               := 'S';
	
	// Bankruptcy only
	export SSN4NAME_MATCH					 := 'Rn';
	
	// Autokey codes:
	export ADDRESS           := 'A';
	export COMP_ADDR         := 'Ac';
	export NAME              := 'N';
	export COMP_NAME         := 'Cn';
	export NAME_WORDS        := 'W';
	export PHONE             := 'Q';
	export ZIP               := 'Z';
	export FEIN              := 'F';
	export STNAME            := 'T';
	export CITYSTFLNAME      := 'L';		
	export SSN               := 'S';
	
	EXPORT COMP_NAME_MATCH_THRESHOLD := 10; // This is a score assigned to the similarity between 'DAYTON TECHNOLOGY' and 'DAYTON TECH'.
end;
