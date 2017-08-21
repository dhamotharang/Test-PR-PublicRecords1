EXPORT Custom_JOIN (h, match_join) := FUNCTIONMACRO
		integer MAX_Specificity := 1000;
	_dn0 := h(~SSN_isnull);
	_dn0_deduped := _dn0(SSN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj0 := JOIN( _dn0_deduped, _dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.SSN = RIGHT.SSN ,match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.SSN = RIGHT.SSN,10000),HASH);
	//Fixed fields ->:UPIN(24)
	_dn1 := h(~UPIN_isnull);
	_dn1_deduped := _dn1(UPIN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj1 := JOIN( _dn1_deduped, _dn1_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.UPIN = RIGHT.UPIN ,match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.UPIN = RIGHT.UPIN,10000),HASH);
	//Fixed fields ->:VENDOR_ID(24)
	_dn2 := h(~VENDOR_ID_isnull);
	_dn2_deduped := _dn2(VENDOR_ID_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	// _mj2 := JOIN( _dn2_deduped, _dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,10000),HASH);
	_mj2 := JOIN( _dn2_deduped, _dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC ,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC, 10000),HASH);	
	//Fixed fields ->:DID(23)
	_dn3 := h(~DID_isnull);
	_dn3_deduped := _dn3(DID_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj3 := JOIN( _dn3_deduped, _dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DID = RIGHT.DID  ,match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.DID = RIGHT.DID,10000),HASH);
	//Fixed fields ->:NPI_NUMBER(23)
	_dn4 := h(~NPI_NUMBER_isnull);
	_dn4_deduped := _dn4(NPI_NUMBER_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj4 := JOIN( _dn4_deduped, _dn4_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,10000),HASH);
	//Fixed fields ->:DEA_NUMBER(23)
	_dn5 := h(~DEA_NUMBER_isnull);
	_dn5_deduped := _dn5(DEA_NUMBER_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj5 := JOIN( _dn5_deduped, _dn5_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,match_join(LEFT,RIGHT,5),HINT(Parallel_Match),ATMOST(LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,10000),HASH);
	_dn6 := h(~VENDOR_ID_isnull and ~NPI_NUMBER_isnull and ~UPIN_isnull);
	_dn6_deduped := _dn6(VENDOR_ID_weight100>=MAX_Specificity and NPI_NUMBER_weight100>=MAX_Specificity and UPIN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj6 := JOIN( _dn6_deduped, _dn6_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.UPIN = RIGHT.UPIN AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.UPIN = RIGHT.UPIN AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER, 10000),HASH);	
	_dn7 := h(~VENDOR_ID_isnull and ~NPI_NUMBER_isnull and ~DEA_NUMBER_isnull);
	_dn7_deduped := _dn7(VENDOR_ID_weight100>=MAX_Specificity and NPI_NUMBER_weight100>=MAX_Specificity and DEA_NUMBER_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj7 := JOIN( _dn7_deduped, _dn7_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER, 10000),HASH);	
	_mjs0_t := _mj0+_mj1+_mj2+_mj3+_mj4+_mj5+_mj6+_mj7;
	RETURN _mjs0_t;
ENDMACRO;