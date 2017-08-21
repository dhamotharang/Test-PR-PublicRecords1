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
	//mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.ST = RIGHT.ST AND ( ~left.ST_isnull AND ~right.ST_isnull ) AND ( left.CLIA_NUMBER = right.CLIA_NUMBER OR left.CLIA_NUMBER_isnull OR right.CLIA_NUMBER_isnull ) AND ( left.NPI_NUMBER = right.NPI_NUMBER OR left.NPI_NUMBER_isnull OR right.NPI_NUMBER_isnull ) AND ( left.CNP_STORE_NUMBER = right.CNP_STORE_NUMBER OR left.CNP_STORE_NUMBER_isnull OR right.CNP_STORE_NUMBER_isnull ) AND ( left.FEIN = right.FEIN OR left.FEIN_isnull OR right.FEIN_isnull ) AND ( left.CNP_NUMBER = right.CNP_NUMBER OR left.CNP_NUMBER_isnull OR right.CNP_NUMBER_isnull ) AND ( ~left.PRIM_NAME_isnull AND ~right.PRIM_NAME_isnull ) AND (( ~left.CNP_NAME_isnull AND ~right.CNP_NAME_isnull ) OR ( ~left.C_LIC_NBR_isnull AND ~right.C_LIC_NBR_isnull ) OR ( ~left.MEDICARE_FACILITY_NUMBER_isnull AND ~right.MEDICARE_FACILITY_NUMBER_isnull )) AND ( left.TAXONOMY_CODE = right.TAXONOMY_CODE OR left.TAXONOMY_CODE_isnull OR right.TAXONOMY_CODE_isnull ) AND ( left.CNP_BTYPE = right.CNP_BTYPE OR left.CNP_BTYPE_isnull OR right.CNP_BTYPE_isnull ) AND ( ~left.ADDRESS_isnull AND ~right.ADDRESS_isnull ),match_join(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.ST = RIGHT.ST,10000),HASH);
	//Fixed fields ->:address(23)
	_dn3 := h(~ZIP_isnull AND ~PRIM_NAME_isnull);
	_dn3_deduped := _dn3(PRIM_NAME_weight100 + ZIP_weight100>=1000); // Use specificity to flag high-dup counts
	_mj3 := JOIN( _dn3_deduped, _dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.ZIP = RIGHT.ZIP AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME ,match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.ZIP = RIGHT.ZIP AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME,20000),HASH);
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
	_dn8 := h(~phone_isnull);
	_dn8_deduped := _dn8(Phone_weight100>=1000); // Use specificity to flag high-dup counts
	_mj8 := JOIN( _dn8_deduped, _dn8_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PHONE = RIGHT.PHONE,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.PHONE = RIGHT.PHONE,20000),HASH);
	_dn9 := h(~fax_isnull);
	_dn9_deduped := _dn9(FAX_weight100>=1000); // Use specificity to flag high-dup counts
	_mj9 := JOIN( _dn9_deduped, _dn9_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.FAX = RIGHT.FAX,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.FAX = RIGHT.FAX,20000),HASH);
	_dn10 := h(~NCPDP_Number_isnull);
	_dn10_deduped := _dn10(NCPDP_Number_weight100>=1000); // Use specificity to flag high-dup counts
	_mj10 := JOIN( _dn10_deduped, _dn10_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NCPDP_Number = RIGHT.NCPDP_Number,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.NCPDP_Number = RIGHT.NCPDP_Number,20000),HASH);
	_dn11 := h(~MEDICAID_Number_isnull);
	_dn11_deduped := _dn11(MEDICAID_Number_weight100>=1000); // Use specificity to flag high-dup counts
	_mj11 := JOIN( _dn11_deduped, _dn11_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.MEDICAID_Number = RIGHT.MEDICAID_Number,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.MEDICAID_Number = RIGHT.MEDICAID_Number,20000),HASH);
	_mjs0_t := _mj0+_mj1+_mj2+_mj3+_mj4+_mj5+_mj6+_mj7+_mj8+_mj9+_mj10+_mj11;
	RETURN _mjs0_t;
ENDMACRO;

