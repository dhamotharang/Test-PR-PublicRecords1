EXPORT Custom_JOIN (h, match_join) := FUNCTIONMACRO
		integer MAX_Specificity := 1000;
		integer JOIN_LIMIT := 10000;
	_dn0 := h(~SSN_isnull);
	_dn0_deduped := _dn0(SSN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj0 := JOIN( _dn0_deduped, _dn0_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.SSN = RIGHT.SSN,match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.SSN = RIGHT.SSN,JOIN_LIMIT),HASH);
	//Fixed fields ->:UPIN(24)
	_dn1 := h(~UPIN_isnull);
	_dn1_deduped := _dn1(UPIN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj1 := JOIN( _dn1_deduped, _dn1_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.UPIN = RIGHT.UPIN,match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.UPIN = RIGHT.UPIN,JOIN_LIMIT),HASH);
	//Fixed fields ->:VENDOR_ID(24)
	_dn2 := h(~VENDOR_ID_isnull);
	_dn2_deduped := _dn2(VENDOR_ID_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj2 := JOIN( _dn2_deduped, _dn2_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC ,match_join(LEFT,RIGHT,5),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC, JOIN_LIMIT),HASH);	
	//Fixed fields ->:DID(23)
	_dn3 := h(~DID_isnull);
	_dn3_deduped := _dn3(DID_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj3 := JOIN( _dn3_deduped, _dn3_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DID = RIGHT.DID,match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.DID = RIGHT.DID,JOIN_LIMIT),HASH);
	//Fixed fields ->:NPI_NUMBER(23)
	_dn4 := h(~NPI_NUMBER_isnull);
	_dn4_deduped := _dn4(NPI_NUMBER_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj4 := JOIN( _dn4_deduped, _dn4_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,JOIN_LIMIT),HASH);
	//Fixed fields ->:DEA_NUMBER(23)
	_dn5 := h(~DEA_NUMBER_isnull);
	_dn5_deduped := _dn5(DEA_NUMBER_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj5 := JOIN( _dn5_deduped, _dn5_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER,JOIN_LIMIT),HASH);
	_dn6 := h(~VENDOR_ID_isnull and ~NPI_NUMBER_isnull and ~UPIN_isnull);
	_dn6_deduped := _dn6(VENDOR_ID_weight100>=MAX_Specificity and NPI_NUMBER_weight100>=MAX_Specificity and UPIN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj6 := JOIN( _dn6_deduped, _dn6_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.UPIN = RIGHT.UPIN AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,5),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.UPIN = RIGHT.UPIN AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER, JOIN_LIMIT),HASH);	
	_dn7 := h(~VENDOR_ID_isnull and ~NPI_NUMBER_isnull and ~DEA_NUMBER_isnull);
	_dn7_deduped := _dn7(VENDOR_ID_weight100>=MAX_Specificity and NPI_NUMBER_weight100>=MAX_Specificity and DEA_NUMBER_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj7 := JOIN( _dn7_deduped, _dn7_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER,match_join(LEFT,RIGHT,5),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER, JOIN_LIMIT),HASH);	
	_dn8 := h(~C_LIC_NBR_isnull);
	_dn8_deduped := _dn8(C_LIC_NBR_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj8 := JOIN( _dn8_deduped, _dn8_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,match_join(LEFT,RIGHT,8),HINT(Parallel_Match),ATMOST(LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,JOIN_LIMIT),HASH);
	_dn9 := h(~PHONE_isnull);
	_dn9_deduped := _dn9(PHONE_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj9 := JOIN( _dn9_deduped, _dn9_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PHONE = RIGHT.PHONE AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC ,match_join(LEFT,RIGHT,23),HINT(Parallel_Match),ATMOST(LEFT.PHONE = RIGHT.PHONE AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,JOIN_LIMIT),HASH);
	_dn10 := h(~FAX_isnull);
	_dn10_deduped := _dn10(FAX_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj10 := JOIN( _dn10_deduped, _dn10_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.FAX = RIGHT.FAX AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC ,match_join(LEFT,RIGHT,7),HINT(Parallel_Match),ATMOST(LEFT.FAX = RIGHT.FAX AND LEFT.VENDOR_ID = RIGHT.VENDOR_ID AND LEFT.SRC = RIGHT.SRC,JOIN_LIMIT),HASH);
	_dn11 := h(~CNSMR_SSN_isnull);
	_dn11_deduped := _dn11(CNSMR_SSN_weight100>=MAX_Specificity); // Use specificity to flag high-dup counts
	_mj11 := JOIN( _dn11_deduped, _dn11_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.CNSMR_SSN = RIGHT.CNSMR_SSN,match_join(LEFT,RIGHT,6),HINT(Parallel_Match),ATMOST(LEFT.CNSMR_SSN = RIGHT.CNSMR_SSN,JOIN_LIMIT),HASH);
	_dn12 := h((~CNSMR_DOB_year_isnull OR ~CNSMR_DOB_month_isnull OR ~CNSMR_DOB_day_isnull) and ~CNSMR_SSN_isnull);	
	_dn12_deduped := _dn12(CNSMR_DOB_year_weight100 + CNSMR_DOB_month_weight100 + CNSMR_DOB_day_weight100>=1600); // Use specificity to flag high-dup counts
	_mj12 := JOIN( _dn12_deduped, _dn12_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.CNSMR_DOB_year = RIGHT.CNSMR_DOB_year AND LEFT.CNSMR_DOB_MONTH = RIGHT.CNSMR_DOB_MONTH AND LEFT.CNSMR_DOB_DAY = RIGHT.CNSMR_DOB_DAY AND LEFT.CNSMR_SSN = RIGHT.CNSMR_SSN,match_join(LEFT,RIGHT,50),HINT(Parallel_Match),ATMOST(LEFT.CNSMR_DOB_YEAR = RIGHT.CNSMR_DOB_YEAR AND LEFT.CNSMR_DOB_MONTH = RIGHT.CNSMR_DOB_MONTH AND LEFT.CNSMR_DOB_DAY = RIGHT.CNSMR_DOB_DAY AND LEFT.CNSMR_SSN = RIGHT.CNSMR_SSN,JOIN_LIMIT),HASH);
	_dn13 := h(~NPI_Number_isnull and ~FNAME_isnull and ~LNAME_isnull);
	_dn13_deduped := _dn13(NPI_Number_weight100 + LNAME_weight100 + FNAME_weight100 + MNAME_weight100 >= 2500); // Use specificity to flag high-dup counts
	_mj13 := JOIN( _dn13_deduped, _dn13_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.NPI_NUMBER = RIGHT.NPI_NUMBER AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,JOIN_LIMIT),HASH);
	_dn14 := h(~DEA_Number_isnull and ~FNAME_isnull and ~LNAME_isnull);
	_dn14_deduped := _dn14(DEA_Number_weight100 + LNAME_weight100 + FNAME_weight100 + MNAME_weight100 >= 2500); // Use specificity to flag high-dup counts
	_mj14 := JOIN( _dn14_deduped, _dn14_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.DEA_NUMBER = RIGHT.DEA_NUMBER AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,JOIN_LIMIT),HASH);
	_dn15 := h(~UPIN_isnull and ~FNAME_isnull and ~LNAME_isnull);
	_dn15_deduped := _dn15(UPIN_weight100 + LNAME_weight100 + FNAME_weight100 + MNAME_weight100 >= 2500); // Use specificity to flag high-dup counts
	_mj15 := JOIN( _dn15_deduped, _dn15_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.UPIN = RIGHT.UPIN AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.UPIN = RIGHT.UPIN AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,JOIN_LIMIT),HASH);
	_dn16 := h(~PRIM_NAME_isnull AND ~PRIM_RANGE_isnull AND ~ZIP_isnull AND  ~FNAME_isnull and ~LNAME_isnull);	
	_dn16_deduped := _dn16(PRIM_NAME_weight100 + PRIM_RANGE_weight100 + ZIP_weight100 + LNAME_weight100 + FNAME_weight100 + MNAME_weight100 >= 2500); // Use specificity to flag high-dup counts
	_mj16 := JOIN( _dn16_deduped, _dn16_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.ZIP = RIGHT.ZIP AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME ,match_join(LEFT,RIGHT,85),HINT(unsorted_output),ATMOST(LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.ZIP = RIGHT.ZIP AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME,10000),HASH);
	_dn17 := h(~C_LIC_NBR_isnull and ~FNAME_isnull and ~LNAME_isnull);
	_dn17_deduped := _dn17(C_LIC_NBR_weight100 + LNAME_weight100 + FNAME_weight100 + MNAME_weight100 >= 2500); // Use specificity to flag high-dup counts
	_mj17 := JOIN( _dn17_deduped, _dn17_deduped, LEFT.LNPID > RIGHT.LNPID AND LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME ,match_join(LEFT,RIGHT,8),HINT(Parallel_Match),ATMOST(LEFT.C_LIC_NBR = RIGHT.C_LIC_NBR AND LEFT.LIC_STATE = RIGHT.LIC_STATE AND LEFT.LNAME = RIGHT.LNAME AND LEFT.FNAME = RIGHT.FNAME AND LEFT.MNAME = RIGHT.MNAME ,JOIN_LIMIT),HASH);
	_mjs0_t := _mj0+_mj1+_mj2+_mj3+_mj4+_mj5+_mj6+_mj7+_mj8+_mj9+_mj10+_mj11+_mj12+_mj13+_mj14+_mj15+_mj16+_mj17;
	RETURN _mjs0_t;
ENDMACRO;