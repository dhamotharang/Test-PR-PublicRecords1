IMPORT Business_Header, ut;

export CompanyName_Address_Broad(

	 dataset(Business_Header.Layout_Business_Header_Base	)	pBusinessHeaders	= Business_Header.Files().Base.Business_Headers.Built
	,string																									pPersistName			= business_header.persistnames().CompanyNameAddressBroad

) :=
function

bh := business_header.filters.keys.business_headers(pBusinessHeaders)
(
	state != '' OR zip != 0
);

// Project to slim record.
layout_slim := RECORD
	bh.bdid;
	bh.company_name;
	bh.zip;
	bh.state;
END;

layout_slim SlimBH(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim := PROJECT(bh, SlimBH(LEFT));

bh_ded1 := DEDUP(bh_slim, bdid, company_name, zip, state, ALL);
bh_ded := bh_ded1;

bh_d_zip_d := DISTRIBUTE(bh_ded(zip != 0), HASH(zip,company_name[1..2]));
bh_ded_zip := bh_d_zip_d;

// Get a count of how many bdid's match within a certain
// name similarity range for each name-zip combination.
layout_similar_zip := RECORD
	UNSIGNED6 bdid_r;
	layout_slim.company_name;
	layout_slim.zip;
END;

layout_similar_zip JoinSimilarZip(bh_ded l, bh_ded r) := TRANSFORM
	SELF.bdid_r := r.bdid;
	SELF := l;
END;

bh_d_zip_s := SORT(bh_ded_zip, zip, company_name, bdid, LOCAL);
bh_d_zip := DEDUP(bh_d_zip_s, zip, company_name, bdid, LOCAL);

similar_zip := JOIN(bh_d_zip, bh_d_zip,
	LEFT.zip = RIGHT.zip AND
	LEFT.company_name[1..2] = RIGHT.company_name[1..2] AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10,
	JoinSimilarZip(LEFT, RIGHT), LIMIT(3000,skip), LOCAL);

similar_zip_ded := DEDUP(sort(similar_zip, zip, company_name, bdid_r, LOCAL),
													  zip, company_name, bdid_r, LOCAL);
 
layout_cn_z := RECORD
	similar_zip_ded.company_name;
	similar_zip_ded.zip;
	UNSIGNED1 cn_z_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

cn_zip_stat := TABLE(similar_zip_ded, layout_cn_z, zip, company_name, LOCAL);

// Join the similar count back.
Layout_CompanyName_Address_Broad_SS JoinBackZip(bh_ded l, cn_zip_stat r) := TRANSFORM
	SELF.cn_zip_bdids := IF(r.cn_z_ct = 0, 255, r.cn_z_ct);
	SELF := l;
END;

ss_cn_zip := JOIN(bh_ded, cn_zip_stat,
	LEFT.company_name = RIGHT.company_name AND
	LEFT.zip = RIGHT.zip,
	JoinBackZip(LEFT, RIGHT), LEFT OUTER, HASH) 
	: PERSIST(business_header.persistnames().CompanyNameAddressBroadJoinBackZip);

// Get a count of how many bdid's match within a certain
// name similarity range for each name-state combination.
bh_d_st_d := DISTRIBUTE(bh_ded(state != ''), HASH(state,company_name[1..2]));
bh_ded_st := bh_d_st_d;

layout_similar_st := RECORD
	UNSIGNED6 bdid_r;
	bh_ded.company_name;
	bh_ded.state;
END;

layout_similar_st JoinSimilarSt(bh_ded l, bh_ded r) := TRANSFORM
	SELF.bdid_r := r.bdid;
	SELF := l;
END;

bh_d_st_s := SORT(bh_ded_st, state, company_name, bdid, LOCAL);
bh_d_st := DEDUP(bh_d_st_s, state, company_name, bdid, LOCAL);

similar_st := JOIN(bh_d_st, bh_d_st,
	LEFT.state = RIGHT.state AND
	LEFT.company_name[1..2] = RIGHT.company_name[1..2] AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10,
	JoinSimilarSt(LEFT, RIGHT), LIMIT(3000,skip), LOCAL);

similar_st_ded := DEDUP(sort(similar_st, state, company_name, bdid_r, LOCAL),
																 state, company_name, bdid_r, LOCAL);

layout_cn_st := RECORD
	similar_st_ded.company_name;
	similar_st_ded.state;
	UNSIGNED1 cn_st_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

cn_st_stat := TABLE(similar_st_ded, layout_cn_st, state, company_name, LOCAL);

// Join the similar state count back.
Layout_CompanyName_Address_Broad_SS JoinBackSt(ss_cn_zip l, cn_st_stat r) := TRANSFORM
	SELF.cn_st_bdids := IF(r.cn_st_ct = 0, 255, r.cn_st_ct);
	SELF := l;
END;

ss_cn_st := JOIN(ss_cn_zip, cn_st_stat,
					LEFT.company_name = RIGHT.company_name AND
					LEFT.state = RIGHT.state,
					JoinBackSt(LEFT, RIGHT), LEFT OUTER, HASH);

// Count the number of bdid's at each address (zip).
addr_bdid_zip := DEDUP(ss_cn_st, bdid, zip, ALL);
layout_bdid_per_addr_zip := RECORD
	addr_bdid_zip.zip;
	UNSIGNED4 bdid_count := COUNT(GROUP);
END;

bdid_ct_zip := TABLE(
	DISTRIBUTE(addr_bdid_zip, HASH(zip)),
	layout_bdid_per_addr_zip, zip, LOCAL);

// Add it to the slimsort.
Layout_CompanyName_Address_Broad_SS AddBDIDCountZip(ss_cn_st l, bdid_ct_zip r) := TRANSFORM
	SELF.zip_bdids := r.bdid_count;
	SELF := l;
END;

cn_addr_zip := JOIN(
	ss_cn_st, bdid_ct_zip,
	LEFT.zip = RIGHT.zip,
	AddBDIDCountZip(LEFT, RIGHT), HASH);

// Count the number of bdid's at each address (st).
addr_bdid_st := DEDUP(cn_addr_zip, bdid, state, ALL);
layout_bdid_per_addr_st := RECORD
	addr_bdid_st.state;
	UNSIGNED4 bdid_count := COUNT(GROUP);
END;

bdid_ct_st := TABLE(
	DISTRIBUTE(addr_bdid_st, HASH(state)),
	layout_bdid_per_addr_st, state, LOCAL);

// Add it to the slimsort.
Layout_CompanyName_Address_Broad_SS AddBDIDCountSt(cn_addr_zip l, bdid_ct_st r) := TRANSFORM
	SELF.st_bdids := r.bdid_count;
	SELF := l;
END;

cn_addr := JOIN(
	cn_addr_zip, bdid_ct_st,
	LEFT.state = RIGHT.state,
	AddBDIDCountSt(LEFT, RIGHT), HASH);

CompanyName_Address_persisted := 
		//leave out any recs with no valid (0 to 100) counts
	cn_addr((cn_zip_bdids > 0 and cn_zip_bdids < 100) or
					 (cn_st_bdids > 0 and cn_st_bdids < 100))
		: PERSIST(pPersistName);

return CompanyName_Address_persisted;

end;