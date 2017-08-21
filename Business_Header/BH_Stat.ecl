export BH_Stat(

	 dataset(Layout_Business_Header_Base		)	pBusinessHeaders		= Files().Base.Business_Headers.built
	,dataset(Layout_Business_Relative				)	pBH_Relatives				= Files().Base.Business_Relatives.built
	,dataset(Layout_Business_Relative_Group	)	pBH_Relative_Group	= Files().Base.Business_Relatives_Group.built

) :=
function

	//use the new ones just created, but not moved to built yet
	bh	:= filters.keys.business_headers(pBusinessHeaders)		;
	br	:= pBH_Relatives			;
	brg	:= pBH_Relative_Group	;


	// Stat of Base Records
	layout_bh_base := record
	unsigned6 bdid;
	end;

	layout_bh_base InitBHBase(bh l) := transform
	self := l;
	end;

	bh_base := project(bh, InitBHBase(left));
	bh_base_dist := distribute(bh_base, hash(bdid));

	layout_bh_base_stat := record
	bh_base_dist.bdid;
	unsigned3 base_record_count := count(group);
	end;

	bh_base_stat := table(bh_base_dist, layout_bh_base_stat, bdid, local);

	br_dist := distribute(br, hash(bdid1));

	// Stat of Relative Records
	layout_br_stat := record
	br_dist.bdid1;
	unsigned3 corp_charter_number_relative_count := count(group, br_dist.corp_charter_number);
	unsigned3 business_registration_relative_count := count(group, br_dist.business_registration);
	unsigned3 bankruptcy_filing_relative_count := count(group, br_dist.bankruptcy_filing);
	unsigned3 duns_number_relative_count := count(group, br_dist.duns_number);
	unsigned3 duns_tree_relative_count := count(group, br_dist.duns_tree);
	unsigned3 edgar_cik_relative_count := count(group, br_dist.edgar_cik);
	unsigned3 name_relative_count := count(group, br_dist.name);
	unsigned3 name_address_relative_count := count(group, br_dist.name_address);
	unsigned3 name_phone_relative_count := count(group, br_dist.name_phone);
	unsigned3 gong_group_relative_count := count(group, br_dist.gong_group);
	unsigned3 ucc_filing_relative_count := count(group, br_dist.ucc_filing);
	unsigned3 fbn_filing_relative_count := count(group, br_dist.fbn_filing);
	unsigned3 fein_relative_count := count(group, br_dist.fein);
	unsigned3 phone_relative_count := count(group, br_dist.phone);
	unsigned3 addr_relative_count := count(group, br_dist.addr);
	unsigned3 mail_address_relative_count := count(group, br_dist.mail_addr);
	unsigned3 dca_company_number_relative_count := count(group, br_dist.dca_company_number);
	unsigned3 dca_hierarchy_relative_count := count(group, br_dist.dca_hierarchy);
	unsigned3 abi_number_relative_count := count(group, br_dist.abi_number);
	unsigned3 abi_hierarchy_relative_count := count(group, br_dist.abi_hierarchy);
	end;

	br_stat := table(br_dist(not rel_group), layout_br_stat, bdid1, local);

	// Stat of Group Records
	layout_brg_stat := record
	brg.group_id;
	brg.group_type;
	unsigned3 group_count := count(group);
	end;

	brg_stat := table(brg, layout_brg_stat, group_id, group_type);

	brg_dist := distribute(brg, hash(bdid));

	layout_brg_stat_bdid := record
	unsigned6 bdid;
	string2 group_type;
	unsigned3 group_count;
	end;

	layout_brg_stat_bdid CombineStatBDID(brg_dist l, brg_stat r) := transform
	self.bdid := l.bdid;
	self.group_type := r.group_type;
	self.group_count := r.group_count;
	end;

	brg_stat_bdid := join(brg_dist,
												brg_stat,
												left.group_id = right.group_id,
												CombineStatBDID(left, right),
												lookup);

	// Combine base and relative stats
	Layout_Business_Header_Stat CombineBaseRelativeStats(layout_bh_base_stat l, layout_br_stat r) := transform
	self.bdid := l.bdid;
	self.base_record_count := l.base_record_count;
	self := r;
	end;

	bh_stat_init := join(bh_base_stat,
											 br_stat,
											 left.bdid = right.bdid1,
											 CombineBaseRelativeStats(left, right),
											 left outer,
											 local);

	// Add group counts
	Layout_Business_Header_Stat AddGroupCounts(Layout_Business_Header_Stat l, layout_brg_stat_bdid r, integer c) := transform
	self.name_relative_count := if(r.group_type = 'NM', l.name_relative_count + r.group_count, l.name_relative_count);
	self.addr_relative_count := if(r.group_type = 'AD', l.addr_relative_count + r.group_count, l.addr_relative_count);
	self.duns_tree_relative_count := if(r.group_type = 'DT', l.duns_tree_relative_count + r.group_count, l.duns_tree_relative_count);
	self := l;
	end;

	bh_stat_combined := denormalize(bh_stat_init,
																	brg_stat_bdid,
																	left.bdid = right.bdid,
																	AddGroupCounts(left, right, counter),
																	local);

	return bh_stat_combined;

end;