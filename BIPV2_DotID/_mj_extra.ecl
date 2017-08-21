EXPORT _mj_extra(h,tr) := functionmacro
	_dn0 := h(~prim_name_isnull AND ~st_isnull);
	_dn0_deduped := _dn0(cnp_number_weight100 + prim_range_weight100 + prim_name_weight100 + st_weight100 + isContact_weight100>=500); // Use specificity to flag high-dup counts
	mjx0 := JOIN( _dn0_deduped                , _dn0_deduped                , LEFT.DOTid > RIGHT.DOTid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.isContact = RIGHT.isContact AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.company_fein = right.company_fein OR left.company_fein_isnull OR right.company_fein_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.name_suffix = right.name_suffix OR left.name_suffix_isnull OR right.name_suffix_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ) AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4]    ,tr(LEFT,RIGHT,1)   ,HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.isContact = RIGHT.isContact AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4],20000),SKEW(1));
	mjx1 := JOIN( _dn0_deduped(sec_range<>'') , _dn0_deduped(sec_range<>'') , LEFT.DOTid > RIGHT.DOTid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.isContact = RIGHT.isContact AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.company_fein = right.company_fein OR left.company_fein_isnull OR right.company_fein_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull ) AND ( left.cnp_number = right.cnp_number OR left.cnp_number_isnull OR right.cnp_number_isnull ) AND ( left.sec_range = right.sec_range OR left.sec_range_isnull OR right.sec_range_isnull ) AND ( left.name_suffix = right.name_suffix OR left.name_suffix_isnull OR right.name_suffix_isnull ) AND ( left.cnp_btype = right.cnp_btype OR left.cnp_btype_isnull OR right.cnp_btype_isnull ) AND LEFT.sec_range      = RIGHT.sec_range         ,tr(LEFT,RIGHT,2)   ,HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.isContact = RIGHT.isContact AND LEFT.sec_range = RIGHT.sec_range,20000),SKEW(1));
	return mjx0+mjx1;
endmacro;
