IMPORT Business_Header, ut;

bh := Business_Header.File_Business_Header_Base
(
    prim_name != '',
	prim_name NOT IN Business_Header.Bad_Address_List,
	(state != '' OR zip != 0)
);

// Project to slim record.
layout_slim := RECORD
	bh.bdid;
	bh.company_name;
	bh.prim_range;
	bh.prim_name;
	bh.sec_range;
	bh.zip;
	bh.state;
END;

layout_slim SlimBH(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim := PROJECT(bh, SlimBH(LEFT));

bh_ded1 := DEDUP(bh_slim, bdid, company_name, prim_range, prim_name, sec_range, zip, state, ALL);
bh_ded := bh_ded1 : PERSIST('adTEMP::BH_SS_cn_a_init');

bh_d_pr_zip_d := DISTRIBUTE(bh_ded(zip != 0), HASH(zip, prim_name, prim_range));
ut.MAC_Remove_Withdups_Local(
	bh_d_pr_zip_d, HASH(zip, prim_name, prim_range), 
	3000, bh_ded_pr_zip)

// Get a count of how many bdid's match within a certain
// name similarity range for each name-pr-pn-zip combination.
layout_similar_zip := RECORD
	UNSIGNED6 bdid_r;
	layout_slim.company_name;
	layout_slim.prim_range;
	layout_slim.prim_name;
	layout_slim.zip;
END;

layout_similar_zip JoinSimilarZip(bh_ded l, bh_ded r) := TRANSFORM
	SELF.bdid_r := r.bdid;
	SELF := l;
END;

bh_d_pr_zip_s := SORT(bh_ded_pr_zip, zip, prim_name, prim_range, bdid, company_name, LOCAL);
bh_d_pr_zip := DEDUP(bh_d_pr_zip_s, zip, prim_name, prim_range, bdid, company_name, LOCAL);

similar_pr_zip := JOIN(bh_d_pr_zip, bh_d_pr_zip,
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.zip = RIGHT.zip AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 35,
	JoinSimilarZip(LEFT, RIGHT), keep(3000), LOCAL);

similar_pr_zip_ded := DEDUP(sort(similar_pr_zip, zip, prim_name, prim_range, company_name, bdid_r, LOCAL),
													  zip, prim_name, prim_range, company_name, bdid_r, LOCAL);
 
layout_cn_pr_pn_z := RECORD
	similar_pr_zip_ded.company_name;
	similar_pr_zip_ded.prim_range;
	similar_pr_zip_ded.prim_name;
	similar_pr_zip_ded.zip;
	UNSIGNED1 cn_pr_pn_z_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

cn_pr_pn_zip_stat := TABLE(similar_pr_zip_ded, layout_cn_pr_pn_z, zip, prim_name, prim_range, company_name, LOCAL);

// Join the similar count back.
Layout_CompanyName_Address_SS JoinBackZip(bh_ded l, cn_pr_pn_zip_stat r) := TRANSFORM
	SELF.cn_pr_pn_zip_bdids := IF(r.cn_pr_pn_z_ct = 0, 255, r.cn_pr_pn_z_ct);
	SELF := l;
END;

ss_cn_pr_pn_zip := JOIN(bh_ded, cn_pr_pn_zip_stat,
	LEFT.company_name = RIGHT.company_name AND
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.zip = RIGHT.zip,
	JoinBackZip(LEFT, RIGHT), LEFT OUTER, HASH) : PERSIST('adTEMP::BH_SS_cn_pr_pn_zip');

// Get a count of how many bdid's match within a certain
// name similarity range for each name-pr-pn-sr-state combination.
bh_d_pr_pn_sr_st_d := DISTRIBUTE(bh_ded(state != ''), HASH(prim_name, prim_range, sec_range, state));
ut.MAC_Remove_Withdups_Local(
	bh_d_pr_pn_sr_st_d, HASH(prim_name, prim_range, sec_range, state), 
	3000, bh_ded_pr_pn_sr_st)

layout_similar_st := RECORD
	UNSIGNED6 bdid_r;
	bh_ded.company_name;
	bh_ded.prim_range;
	bh_ded.prim_name;
	bh_ded.sec_range;
	bh_ded.state;
END;

layout_similar_st JoinSimilarSt(bh_ded l, bh_ded r) := TRANSFORM
	SELF.bdid_r := r.bdid;
	SELF := l;
END;

bh_d_pr_pn_sr_st_s := SORT(bh_ded_pr_pn_sr_st, prim_name, prim_range, sec_range, state, bdid, company_name, LOCAL);
bh_d_pr_pn_sr_st := DEDUP(bh_d_pr_pn_sr_st_s, prim_name, prim_range, sec_range, state, bdid, company_name, LOCAL);

similar_pr_pn_sr_st := JOIN(bh_d_pr_pn_sr_st, bh_d_pr_pn_sr_st,
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.sec_range = RIGHT.sec_range AND
	LEFT.state = RIGHT.state AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 35,
	JoinSimilarSt(LEFT, RIGHT), LOCAL,
	atmost(LEFT.prim_range = RIGHT.prim_range AND
				 LEFT.prim_name = RIGHT.prim_name AND
				 LEFT.sec_range = RIGHT.sec_range AND
				 LEFT.state = RIGHT.state, 3000));

similar_pr_pn_sr_st_ded := DEDUP(sort(similar_pr_pn_sr_st, prim_name, prim_range, sec_range, state, company_name, bdid_r, LOCAL),
																 prim_name, prim_range, sec_range, state, company_name, bdid_r, LOCAL);

layout_cn_pr_pn_sr_st := RECORD
	similar_pr_pn_sr_st_ded.company_name;
	similar_pr_pn_sr_st_ded.prim_range;
	similar_pr_pn_sr_st_ded.prim_name;
	similar_pr_pn_sr_st_ded.sec_range;
	similar_pr_pn_sr_st_ded.state;
	UNSIGNED1 cn_pr_pn_sr_st_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

cn_pr_pn_sr_st_stat := TABLE(similar_pr_pn_sr_st_ded, layout_cn_pr_pn_sr_st, prim_name, prim_range, sec_range, state, company_name, LOCAL);

// Join the similar state count back.
Layout_CompanyName_Address_SS JoinBackSt(ss_cn_pr_pn_zip l, cn_pr_pn_sr_st_stat r) := TRANSFORM
	SELF.cn_pr_pn_sr_st_bdids := IF(r.cn_pr_pn_sr_st_ct = 0, 255, r.cn_pr_pn_sr_st_ct);
	SELF := l;
END;

ss_cn_pr_pn_sr_st := JOIN(ss_cn_pr_pn_zip, cn_pr_pn_sr_st_stat,
					LEFT.company_name = RIGHT.company_name AND
					LEFT.prim_range = RIGHT.prim_range AND
					LEFT.prim_name = RIGHT.prim_name AND
					LEFT.sec_range = RIGHT.sec_range AND
					LEFT.state = RIGHT.state,
					JoinBackSt(LEFT, RIGHT), LEFT OUTER, HASH);

// Count the number of bdid's at each address (pr, pn, zip).
addr_bdid_zip := DEDUP(ss_cn_pr_pn_sr_st, bdid, prim_range, prim_name, zip, ALL);
layout_bdid_per_addr_zip := RECORD
	addr_bdid_zip.prim_range;
	addr_bdid_zip.prim_name;
	addr_bdid_zip.zip;
	UNSIGNED4 bdid_count := COUNT(GROUP);
END;

bdid_ct_zip := TABLE(
	DISTRIBUTE(addr_bdid_zip, HASH(prim_range, prim_name, zip)),
	layout_bdid_per_addr_zip, prim_range, prim_name, zip, LOCAL);

// Add it to the slimsort.
Layout_CompanyName_Address_SS AddBDIDCountZip(ss_cn_pr_pn_sr_st l, bdid_ct_zip r) := TRANSFORM
	SELF.pr_pn_zip_bdids := r.bdid_count;
	SELF := l;
END;

cn_addr_zip := JOIN(
	ss_cn_pr_pn_sr_st, bdid_ct_zip,
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.zip = RIGHT.zip,
	AddBDIDCountZip(LEFT, RIGHT), HASH);

// Count the number of bdid's at each address (pr, pn, sr, st).
addr_bdid_st := DEDUP(cn_addr_zip, bdid, prim_range, prim_name, sec_range, state, ALL);
layout_bdid_per_addr_st := RECORD
	addr_bdid_st.prim_range;
	addr_bdid_st.prim_name;
	addr_bdid_st.sec_range;
	addr_bdid_st.state;
	UNSIGNED4 bdid_count := COUNT(GROUP);
END;

bdid_ct_st := TABLE(
	DISTRIBUTE(addr_bdid_st, HASH(prim_range, prim_name, sec_range, state)),
	layout_bdid_per_addr_st, prim_range, prim_name, sec_range, state, LOCAL);

// Add it to the slimsort.
Layout_CompanyName_Address_SS AddBDIDCountSt(cn_addr_zip l, bdid_ct_st r) := TRANSFORM
	SELF.pr_pn_sr_st_bdids := r.bdid_count;
	SELF := l;
END;

cn_addr := JOIN(
	cn_addr_zip, bdid_ct_st,
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.sec_range = RIGHT.sec_range AND
	LEFT.state = RIGHT.state,
	AddBDIDCountSt(LEFT, RIGHT), HASH);


// Deal with the overflow records.  Do both the zip and state counts
// for them as for the normal recs, except require the first two characters
// of the company name to be the same and the similarity to be 10 or less.
layout_slim SlimSS(cn_addr l) := TRANSFORM
	SELF := l;
END;

strict_needed_zip := PROJECT(cn_addr(pr_pn_zip_bdids >= 3000, pr_pn_zip_bdids < 60000), SlimSS(LEFT));

strict_cn_pr_pn_zip := DEDUP(
		SORT(
		DISTRIBUTE(strict_needed_zip(zip != 0), HASH(zip, prim_name, prim_range, company_name[1..2])),
		 zip, prim_name, prim_range, bdid, company_name, LOCAL),
		 zip, prim_name, prim_range, bdid, company_name, LOCAL);

similar_strict_pr_pn_zip := JOIN(strict_cn_pr_pn_zip, strict_cn_pr_pn_zip,
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.zip = RIGHT.zip AND
	LEFT.company_name[1..2] = RIGHT.company_name[1..2] AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10,
	JoinSimilarZip(LEFT, RIGHT), LOCAL,
	atmost(LEFT.prim_range = RIGHT.prim_range AND
				 LEFT.prim_name = RIGHT.prim_name AND
				 LEFT.zip = RIGHT.zip AND
				 LEFT.company_name[1..2] = RIGHT.company_name[1..2], 3000));

similar_strict_pr_pn_zip_ded := DEDUP(sort(similar_strict_pr_pn_zip, zip, prim_name, prim_range, company_name, bdid_r, LOCAL),
																			zip, prim_name, prim_range, company_name, bdid_r, LOCAL);

layout_strict_cn_pr_pn_z := RECORD
	similar_strict_pr_pn_zip_ded.company_name;
	similar_strict_pr_pn_zip_ded.prim_range;
	similar_strict_pr_pn_zip_ded.prim_name;
	similar_strict_pr_pn_zip_ded.zip;
	UNSIGNED1 strict_cn_pr_pn_z_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

strict_cn_pr_pn_zip_stat := TABLE(similar_strict_pr_pn_zip_ded, layout_strict_cn_pr_pn_z, zip, prim_name, prim_range, company_name, LOCAL);

// Join the strict pr-pn-zip count back.
Layout_CompanyName_Address_SS JoinBackStrictZip(cn_addr l, strict_cn_pr_pn_zip_stat r) := TRANSFORM
	SELF.cn_pr_pn_zip_bdids := IF(r.strict_cn_pr_pn_z_ct = 0, l.cn_pr_pn_zip_bdids, r.strict_cn_pr_pn_z_ct);
	SELF := l;
END;

cn_addr_strict_pr_pn_zip := JOIN(
	cn_addr, strict_cn_pr_pn_zip_stat,
	LEFT.company_name = RIGHT.company_name AND
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.zip = RIGHT.zip,
	JoinBackStrictZip(LEFT, RIGHT), LEFT OUTER, HASH, atmost(3000));

// Now do the strict state count
strict_needed_st := PROJECT(cn_addr(pr_pn_sr_st_bdids >= 3000, pr_pn_sr_st_bdids < 60000), SlimSS(LEFT));
strict_cn_pr_pn_sr_st := DEDUP(
		SORT(
		DISTRIBUTE(strict_needed_st(state != ''), HASH(prim_name, prim_range, sec_range, state, company_name[1..2])),
		 prim_name, prim_range, sec_range, state, bdid, company_name, LOCAL),
		 prim_name, prim_range, sec_range, state, bdid, company_name, LOCAL);
	
similar_strict_pr_pn_sr_st := JOIN(strict_cn_pr_pn_sr_st, strict_cn_pr_pn_sr_st,
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.sec_range = RIGHT.sec_range AND
	LEFT.state = RIGHT.state AND
	LEFT.company_name[1..2] = RIGHT.company_name[1..2] AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10,
	JoinSimilarSt(LEFT, RIGHT), LOCAL,
	atmost(	LEFT.prim_range = RIGHT.prim_range AND
					LEFT.prim_name = RIGHT.prim_name AND
					LEFT.sec_range = RIGHT.sec_range AND
					LEFT.state = RIGHT.state AND
					LEFT.company_name[1..2] = RIGHT.company_name[1..2], 3000));

similar_strict_pr_pn_sr_st_ded := DEDUP(sort(similar_strict_pr_pn_sr_st, prim_name, prim_range, sec_range, state, company_name, bdid_r, LOCAL),
																				prim_name, prim_range, sec_range, state, company_name, bdid_r, LOCAL);

layout_strict_cn_pr_pn_sr_st := RECORD
	similar_strict_pr_pn_sr_st_ded.company_name;
	similar_strict_pr_pn_sr_st_ded.prim_range;
	similar_strict_pr_pn_sr_st_ded.prim_name;
	similar_strict_pr_pn_sr_st_ded.sec_range;
	similar_strict_pr_pn_sr_st_ded.state;
	UNSIGNED1 strict_cn_pr_pn_sr_st_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

strict_cn_pr_pn_sr_st_stat := TABLE(similar_strict_pr_pn_sr_st_ded, layout_strict_cn_pr_pn_sr_st, prim_name, prim_range, sec_range, state, company_name, LOCAL);

// Join the strict pr-pn-sr-st count back.
Layout_CompanyName_Address_SS JoinBackStrictSt(cn_addr_strict_pr_pn_zip l, strict_cn_pr_pn_sr_st_stat r) := TRANSFORM
	SELF.cn_pr_pn_sr_st_bdids := IF(r.strict_cn_pr_pn_sr_st_ct = 0, l.cn_pr_pn_sr_st_bdids, r.strict_cn_pr_pn_sr_st_ct);
	SELF := l;
END;

all_info := JOIN(cn_addr_strict_pr_pn_zip, strict_cn_pr_pn_sr_st_stat,
					LEFT.company_name = RIGHT.company_name AND
					LEFT.prim_range = RIGHT.prim_range AND
					LEFT.prim_name = RIGHT.prim_name AND
					LEFT.sec_range = RIGHT.sec_range AND
					LEFT.state = RIGHT.state,
					JoinBackStrictSt(LEFT, RIGHT), LEFT OUTER, HASH);

EXPORT CompanyName_Address := 
		//leave out any recs with no valid (0 to 100) counts
	all_info((pr_pn_zip_bdids > 0 and pr_pn_zip_bdids < 100) or
					 (pr_pn_sr_st_bdids > 0 and pr_pn_sr_st_bdids < 100) or
					 (cn_pr_pn_zip_bdids > 0 and cn_pr_pn_zip_bdids < 100) or
					 (cn_pr_pn_sr_st_bdids > 0 and cn_pr_pn_sr_st_bdids < 100))
		: PERSIST('adTEMP::BH_SS_cn_a');