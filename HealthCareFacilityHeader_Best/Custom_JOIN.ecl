EXPORT Custom_JOIN (h, match_join) := FUNCTIONMACRO
	_dn0 := h(~Tax_ID_isnull);
	_dn0_deduped := _dn0(Tax_ID_weight100>=500); // Use specificity to flag high-dup counts
	_mj0 := JOIN( _dn0_deduped, _dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.Tax_ID = RIGHT.Tax_ID ,match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.Tax_ID = RIGHT.Tax_ID,20000),HASH);
	//Fixed fields ->:FEIN(24)
	_dn1 := h(~FEIN_isnull);
	_dn1_deduped := _dn1(FEIN_weight100>=500); // Use specificity to flag high-dup counts
	_mj1 := JOIN( _dn1_deduped, _dn1_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.FEIN = RIGHT.FEIN ,match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.FEIN = RIGHT.FEIN,20000),HASH);
	//Fixed fields ->:VENDOR_ID(24)
	_dn2 := h(~VENDOR_ID_isnull);
	_dn2_deduped := _dn2(VENDOR_ID_weight100>=1000); // Use specificity to flag high-dup counts
	_mj2 := JOIN( _dn2_deduped, _dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,20000),HASH);
	//Fixed fields ->:DID(23)
	// _dn3 := h(~BDID_isnull);
	// _dn3_deduped := _dn3(BDID_weight100>=2000); // Use specificity to flag high-dup counts
	// _mj3 := JOIN( _dn3_deduped, _dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.BDID = RIGHT.BDID  ,match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.BDID = RIGHT.BDID,20000),HASH);
	//Fixed fields ->:NPI_NUMBER(23)
	_dn4 := h(~NPI_NUMBER_isnull);
	_dn4_deduped := _dn4(NPI_NUMBER_weight100>=1000); // Use specificity to flag high-dup counts
	_mj4 := JOIN( _dn4_deduped, _dn4_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,20000),HASH);
	_dn5 := h(~DEA_Number_isnull);
	_dn5_deduped := _dn5(DEA_NUMBER_weight100>=1000); // Use specificity to flag high-dup counts
	_mj5 := JOIN( _dn5_deduped, _dn5_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,20000),HASH);
	_dn6 := h(~CLIA_Number_isnull);
	_dn6_deduped := _dn6(CLIA_NUMBER_weight100>=1000); // Use specificity to flag high-dup counts
	_mj6 := JOIN( _dn6_deduped, _dn6_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.CLIA_NUMBER = RIGHT.CLIA_NUMBER,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.CLIA_NUMBER = RIGHT.CLIA_NUMBER,20000),HASH);
	_dn7 := h(~MEDICARE_FACILITY_Number_isnull);
	_dn7_deduped := _dn7(MEDICARE_FACILITY_Number_weight100>=1000); // Use specificity to flag high-dup counts
	_mj7 := JOIN( _dn7_deduped, _dn7_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.MEDICARE_FACILITY_Number = RIGHT.MEDICARE_FACILITY_Number,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.MEDICARE_FACILITY_Number = RIGHT.MEDICARE_FACILITY_Number,20000),HASH);
	_mjs0_t := _mj0+_mj1+_mj2+_mj4+_mj5+_mj6+_mj7;
	RETURN _mjs0_t;
ENDMACRO;

