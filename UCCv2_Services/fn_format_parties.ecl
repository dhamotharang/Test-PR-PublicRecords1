import doxie, suppress, FFD, STD;

UCCv2_Services.MAC_Field_Declare();

gm := AutoStandardI.GlobalModule();

export fn_format_parties(
	dataset(uccv2_services.layout_ucc_party_raw)	in_data,
	string1																				in_party,
	string 																				in_ssn_mask_type,
  boolean IsFCRA = false
) := function

	// Skip worthless records
	in_decent := in_data(
		party_type = in_party,
		ssn != '' OR
		fein != '' OR
		orig_name != '' OR
		lname != '' OR
		fname != '' OR
		mname != '' OR
		name_suffix != ''
	);

	// Narrow to (flattened) name information
	layout_name := RECORD
		in_data.tmsid;
		in_data.Party_type;
		in_data.Orig_name;
		in_data.company_name;		
		UCCv2_Services.layout_ucc_party_parsed;		
		FFD.Layouts.CommonRawRecordElements;
	END;
	names := PROJECT(in_decent, transform(layout_name, self := left, self := []));

	// Sort and dedup the names
	names_p				:= names(lname<>'' and fname<>'');																							// parsed
	names_u 			:= names(lname='' or fname='');																									// unparsed
	names_p_d			:= dedup( sort( names_p, record, except orig_name), record, except orig_name );	// parsed & deduped
	names_u_d			:= dedup( sort( names_u, record ), record );																		// unparsed & deduped
	deduped_names := SORT(names_p_d + names_u_d, RECORD);																					// assimilated

	// Narrow to (flattened) address information
	layout_addr := RECORD
		in_data.tmsid;
		in_data.Orig_name;
		in_data.title;
		in_data.lname;
		in_data.fname;
		in_data.mname;
		in_data.name_suffix;
		in_data.bdid;
		in_data.did;
		uccv2_services.layout_ucc_party_address;
		FFD.Layouts.CommonRawRecordElements;
	END;
	addresses := PROJECT(in_decent, transform(layout_addr, self := left; self := []));

	// Sort and dedup the addresses
	deduped_addresses := DEDUP(SORT(addresses, RECORD));

	// Take deduped_names and project the name information
	// for a party into a child dataset, per the layout requirements.
	layout_name_child := RECORD
		in_data.tmsid;
		in_data.Party_type;
		in_data.orig_name;
		in_data.company_name;
		in_data.title;
		in_data.lname;
		in_data.fname;
		in_data.mname;
		in_data.name_suffix;
		in_data.bdid;
		in_data.did;
		DATASET(UCCv2_Services.layout_ucc_party_parsed) names{maxcount(25)};
		unsigned2 penalt1;
		unsigned2 penalt2;
		FFD.Layouts.CommonRawRecordElements;
	END;

	// Mask SSNs (after SSN penalty has been calculated)
	DATASET(UCCv2_Services.layout_ucc_party_parsed) maskNames(layout_name l) := FUNCTION
		nms := dataset([transform(UCCv2_Services.layout_ucc_party_parsed,self:=L)]);
		Suppress.MAC_Mask(nms, names_masked, ssn, null, true, false, maskVal:=in_ssn_mask_type);
		RETURN names_masked;
	END;
	
	layout_name_child xf_name_child(layout_name L) := TRANSFORM
		temp_mod_biz_name_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
			export cname_field := l.company_name;
		end;
		temp_mod_biz_name_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
			export companyname := gm.entity2_companyname;
			export cname_field := l.company_name;
		end;
		temp_mod_bdid_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
			export bdid_field := (string)l.bdid;
		end;
		temp_mod_bdid_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
			export bdid				:= gm.entity2_bdid;
			export bdid_field	:= (string)l.bdid;
		end;
		temp_mod_business_ids_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_BusinessIds.full,opt))
			export ultid_field := l.ultid;
			export orgid_field := l.orgid;
			export seleid_field := l.seleid;
			export proxid_field := l.proxid;
			export powid_field := l.powid;
			export empid_field := l.empid;
			export dotid_field := l.dotid;
		end;	
		temp_mod_did_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
			export did_field := (string)l.did;
		end;
		temp_mod_did_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
			export did				:= gm.entity2_did;
			export did_field	:= (string)l.did;
		end;
		temp_mod_ssn_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
			export ssn_field := l.ssn;
		end;
		temp_mod_ssn_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
			export ssn				:= gm.entity2_ssn;
			export ssn_field	:= l.ssn;
		end;
		temp_mod_fein_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
			export fein_field := l.fein;
		end;
		temp_mod_fein_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
			export fein := gm.entity2_fein;
			export fein_field := l.fein;
		end;
		temp_mod_indv_name_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
			export allow_wildcard := false;
			export fname_field 		:= l.fname;
			export mname_field 		:= l.mname;
			export lname_field 		:= l.lname;
		end;
		temp_mod_indv_name_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
			export allow_wildcard := false;
			export unparsedfullname := gm.entity2_unparsedfullname;
			export allownicknames := gm.entity2_allownicknames;
			export phoneticmatch := gm.entity2_phoneticmatch;
			export firstname := gm.entity2_firstname;
			export middlename := gm.entity2_middlename;
			export lastname := gm.entity2_lastname;
			export fname_field := l.fname;
			export mname_field := l.mname;
			export lname_field := l.lname;
		end;
		self.penalt1 := if (IsFCRA, 0,
			AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(temp_mod_biz_name_1) +
			AutoStandardI.LIBCALL_PenaltyI_BDID.val(temp_mod_bdid_1) +
			AutoStandardI.LIBCALL_PenaltyI_BusinessIds.val(temp_mod_business_ids_1) +
			AutoStandardI.LIBCALL_PenaltyI_DID.val(temp_mod_did_1) +
			AutoStandardI.LIBCALL_PenaltyI_SSN.val(temp_mod_ssn_1) +
			AutoStandardI.LIBCALL_PenaltyI_FEIN.val(temp_mod_fein_1) +
			AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(temp_mod_indv_name_1));
		self.penalt2 := if (IsFCRA or ~gm.TwoPartySearch, 0,
			AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(temp_mod_biz_name_2) +
			AutoStandardI.LIBCALL_PenaltyI_BDID.val(temp_mod_bdid_2) +
			AutoStandardI.LIBCALL_PenaltyI_DID.val(temp_mod_did_2) +
			AutoStandardI.LIBCALL_PenaltyI_SSN.val(temp_mod_ssn_2) +
			AutoStandardI.LIBCALL_PenaltyI_FEIN.val(temp_mod_fein_2) +
			AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(temp_mod_indv_name_2));
		SELF.names := maskNames(l);
		SELF.statementids := l.statementids;
		SELF.isdisputed := l.isdisputed;		
		SELF := l;
	END;

	// prune old ssn references if requested
	doxie.MAC_PruneOldSSNs(deduped_names, deduped_names_pruned, ssn, did, IsFCRA);

	name_child := PROJECT(deduped_names_pruned, xf_name_child(LEFT));

	// Concatenate all related records from each of the child datasets.
	layout_name_child xf_rollup_name_child(layout_name_child l, layout_name_child r) := TRANSFORM
		SELF.names := choosen(l.names + r.names,25);
		SELF.statementids := l.statementids + r.statementids;
		SELF.isdisputed := l.isdisputed or r.isdisputed;		
		SELF := l;
	END;

	// Build the new recordset/rollup. Use the 'keyname' key to roll up those records
	// whose did is zero/invalid and bdid is zero/invalid and lname and fname and mname and
	// cname are equivalent.
	rollup_name_child := ROLLUP(
		name_child,
		LEFT.tmsid       		= RIGHT.tmsid AND
			LEFT.orig_name   	= RIGHT.orig_name AND
			LEFT.title       	= RIGHT.title AND
			LEFT.lname       	= RIGHT.lname AND
			LEFT.fname      	= RIGHT.fname AND
			LEFT.mname       	= RIGHT.mname AND
			LEFT.name_suffix 	= RIGHT.name_suffix AND
			LEFT.did  				= 0 AND
			RIGHT.did  				= 0 AND
			LEFT.bdid 				= 0 AND
			RIGHT.bdid 				= 0,
		xf_rollup_name_child(LEFT, RIGHT)
	);

	// Take deduped_addresses and project the address information for
	// a party into a child dataset, per the layout requirements.
	layout_addr_child := RECORD
		in_data.tmsid;
		in_data.orig_name;
		in_data.title;
		in_data.lname;
		in_data.fname;
		in_data.mname;
		in_data.name_suffix;
		in_data.bdid;
		in_data.did;
		DATASET(UCCv2_Services.layout_ucc_party_address) addresses{maxcount(25)};
		unsigned2 penalt1;
		unsigned2 penalt2;
		boolean is_addr_empty;
		FFD.Layouts.CommonRawRecordElements;
	END;
	layout_addr_child xf_addr_child(layout_addr L) := TRANSFORM
		temp_mod_addr_1 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
			export allow_wildcard := false;
			export prange_field := l.prim_range;
			export predir_field := l.predir;
			export pname_field := l.prim_name;
			export suffix_field := l.addr_suffix;
			export postdir_field := l.postdir;
			export srange_field := l.sec_range;
			export city_field := l.v_city_name;
			export city2_field := '';
			export state_field := l.st;
			export zip_field := l.zip5;
		end;
		temp_mod_addr_2 := module(project(gm,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
			export allow_wildcard := false;
			export addr := gm.entity2_addr;
			export city := gm.entity2_city;
			export state := gm.entity2_state;
			export zip := gm.entity2_zip;
			export zipradius := gm.entity2_zipradius;
			export prange_field := l.prim_range;
			export predir_field := l.predir;
			export pname_field := l.prim_name;
			export suffix_field := l.addr_suffix;
			export postdir_field := l.postdir;
			export srange_field := l.sec_range;
			export city_field := l.v_city_name;
			export city2_field := '';
			export state_field := l.st;
			export zip_field := l.zip5;
		end;
		self.penalt1 := AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_mod_addr_1);
		self.penalt2 := IF (~gm.TwoPartySearch, 0, AutoStandardI.LIBCALL_PenaltyI_Addr.val(temp_mod_addr_2));
		self.addresses := dataset([transform(UCCv2_Services.layout_ucc_party_address,self:=l)]);
		self.is_addr_empty := TRIM(l.address1 + l.address2)='';
		self.statementids := l.statementids;
		self.isdisputed := l.isdisputed;		
		SELF := l;
	END;
	addr_child := PROJECT(deduped_addresses, xf_addr_child(LEFT));

	// Specify yet another TRANSFORM, which will roll up (i.e. concatenate) all related
	// records from each of the child datasets.
	layout_addr_child xf_rollup_addr_child(layout_addr_child l, layout_addr_child r) := TRANSFORM
		SELF.addresses := choosen(l.addresses & r.addresses,25);
		SELF.statementids := l.statementids + r.statementids;
		SELF.isdisputed := l.isdisputed or r.isdisputed;		
		SELF := l;
	END;

	// Build the new recordset/rollup.
	rollup_addr_child := ROLLUP(
		sort(
			addr_child,
			tmsid, orig_name, lname, fname, mname, name_suffix, penalt1 + penalt2, is_addr_empty
		),
		LEFT.tmsid						 = RIGHT.tmsid AND
			LEFT.orig_name       = RIGHT.orig_name AND
			LEFT.title           = RIGHT.title AND
			LEFT.lname           = RIGHT.lname AND
			LEFT.fname           = RIGHT.fname AND
			LEFT.mname           = RIGHT.mname AND
			LEFT.name_suffix     = RIGHT.name_suffix AND
			LEFT.did  = 0	AND RIGHT.did  = 0 AND
			LEFT.bdid = 0 AND	RIGHT.bdid = 0,
		xf_rollup_addr_child(LEFT, RIGHT)
	);

	// Join the party's NAMES to their ADDRESSES.
	layout_party := RECORD
		UCCv2_Services.layout_ucc_party_raw_src.tmsid;
		DATASET(UCCv2_Services.layout_ucc_party) parties{maxcount(25)};
		unsigned2 penalt;
	END;
	layout_party_exp := RECORD
		layout_party;
		boolean is_addr_empty;
	END;
	layout_party_exp xf_party(layout_name_child L, layout_addr_child R) := TRANSFORM
		self.penalt	 := if(
      // Were we searching against these parties? (needed for penalties)
      (party_type='') OR (party_type=in_party),
			MAX(L.penalt1 + R.penalt1,L.penalt2 + R.penalt2),
			uccPenalty.large
		);
		SELF.tmsid   := L.tmsid;
		SELF.parties := DATASET(
			[{
				if(
					L.orig_name != '',
					L.orig_name,
					STD.Str.CleanSpaces(
						L.title + ' ' + L.fname + ' ' + L.mname + ' ' + L.lname + ' ' + L.name_suffix
					)
				),
				choosen(L.names,10),
				choosen(R.addresses,10),
				dedup(L.statementids + R.statementids, all),
				L.isdisputed or R.isdisputed				
			}],
		UCCv2_Services.layout_ucc_party
		);
		SELF.is_addr_empty := R.is_addr_empty;
	END;
	party := JOIN(
		rollup_name_child, rollup_addr_child,
		LEFT.tmsid        	= RIGHT.tmsid AND
			LEFT.orig_name		= RIGHT.orig_name	AND
			LEFT.title				= RIGHT.title	AND
			LEFT.lname				= RIGHT.lname AND
			LEFT.fname				= RIGHT.fname AND
			LEFT.mname				= RIGHT.mname AND
			LEFT.name_suffix	= RIGHT.name_suffix AND
			LEFT.bdid					= RIGHT.bdid AND
			LEFT.did					= RIGHT.did,
		xf_party(LEFT,RIGHT),
		LEFT OUTER,
		keep(10000)
	);

	// Optionally throw out all but one party
	max_parties := if(
		in_party='D',
		if(retRolledDebtors, 25, 1),
		if(incMultSecured, 25, 1)
	);
	// NOTE: Should IncludeMultipleSecured be applied to assignee and creditor
	// records?  Should they have their own comparable parameters?  Should they
	// always be max_parties=1?

	// Rollup the parties under the same tmsid.
	party_sorted := PROJECT(sort(party, tmsid, penalt,is_addr_empty, record),layout_party);
	layout_party xf_roll_party(layout_party l, layout_party r) := TRANSFORM
		SELF.penalt := L.penalt;
		SELF.tmsid := l.tmsid;
		SELF.parties := choosen(l.parties & r.parties,max_parties);
	END;
	rollup_party := ROLLUP(
		party_sorted,
		LEFT.tmsid = RIGHT.tmsid,
		xf_roll_party(LEFT,RIGHT)
	);

	// Limit max parties
	limit_party := dedup(party_sorted, tmsid, KEEP(max_parties));

	// Optionally return debtors separately
	results_party := if(max_parties>1, rollup_party, limit_party);
	// DONE!
	
	return results_party;
end;