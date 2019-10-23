EXPORT _mj_extra(h,tr) := functionmacro
	// dn1 := h(~company_inc_state_isnull AND ~duns_number_isnull);
	// dn1_deduped := dn1(company_inc_state_weight100 + duns_number_weight100>=500); // Use specificity to flag high-dup counts
	// mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.company_inc_state = RIGHT.company_inc_state AND LEFT.duns_number = RIGHT.duns_number AND ( ~left.company_inc_state_isnull AND ~right.company_inc_state_isnull ),match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.company_inc_state = RIGHT.company_inc_state AND LEFT.duns_number = RIGHT.duns_number,10000),HASH);
	// This is a hacked version of the SALT-generated mj1
	_dn1 := h(~duns_number_isnull);
	_dn1_deduped := _dn1(duns_number_weight100>=500); // Use specificity to flag high-dup counts
	_mj1 := JOIN( _dn1_deduped, _dn1_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.duns_number  = RIGHT.duns_number  ,match_join(LEFT,RIGHT,100),HINT(Parallel_Match),ATMOST(LEFT.duns_number  = RIGHT.duns_number ,10000),HASH);
	_dn2 := h(~company_fein_isnull);
	_dn2_deduped := _dn2(company_fein_weight100>=500); // Use specificity to flag high-dup counts
	_mj2 := JOIN( _dn2_deduped, _dn2_deduped, LEFT.LGID3 > RIGHT.LGID3 AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.company_fein = RIGHT.company_fein ,match_join(LEFT,RIGHT,101),HINT(Parallel_Match),ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),HASH);
	return _mj1 + _mj2;
endmacro;
