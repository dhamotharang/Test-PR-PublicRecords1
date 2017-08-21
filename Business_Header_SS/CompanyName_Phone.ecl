IMPORT Business_Header, ut;

export CompanyName_Phone(

	 dataset(Business_Header.Layout_Business_Header_Base	)	pBusinessHeaders	= Business_Header.Files().Base.Business_Headers.Built
	,dataset(Business_Header.Layout_BH_Best								)	pBH_Best					= Business_Header.Files().Base.Business_Header_Best.Built
	,string																									pPersistName			= business_header.persistnames().CompanyNamePhone

) :=
function
bh := business_header.filters.keys.business_headers(pBusinessHeaders)(phone != 0);

// Project to slim record.
layout_slim := RECORD
	bh.bdid;
	bh.company_name;
	bh.phone;
END;

layout_slim SlimBH(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim := PROJECT(bh, SlimBH(LEFT));

bhd := DISTRIBUTE(bh_slim, HASH(bdid));
bhs := SORT(bhd, bdid, company_name, phone, LOCAL);
bh_ded := DEDUP(bhs, bdid, company_name, phone, LOCAL);

// Get a count of how many bdid's match within a certain
// name similarity range for each name-phone combination.
layout_similar := RECORD
	UNSIGNED6 bdid_r;
	bh.company_name;
	bh.phone;
END;

layout_similar JoinSimilar(bh_ded l, bh_ded r) := TRANSFORM
	SELF.bdid_r := r.bdid;
	SELF := l;
END;

// Very bad skew on this join, and neither this or a random
// distribution helps much.
bh_dist_p := DISTRIBUTE(bh_ded, HASH(phone));
similar := JOIN(bh_dist_p, bh_dist_p,
				LEFT.phone = RIGHT.phone AND
				ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 35,
				JoinSimilar(LEFT, RIGHT), LOCAL,
				atmost(LEFT.phone = RIGHT.phone, 1000));

similar_d := DISTRIBUTE(similar, HASH(company_name, phone));
similar_s := SORT(similar_d, company_name, phone, bdid_r, LOCAL);
similar_ded := DEDUP(similar_s, company_name, phone, bdid_r, LOCAL);

layout_scn_p := RECORD
	similar_ded.company_name;
	similar_ded.phone;
	UNSIGNED1 scn_p_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

scn_p_stat := TABLE(similar_ded, layout_scn_p, company_name, phone, LOCAL);

// Join the similar count back.
Layout_CompanyName_Phone_SS JoinBack(bhd l, scn_p_stat r) := TRANSFORM
	SELF.cn_p_bdids := r.scn_p_ct;
	self.prim_range := '';
	self.prim_name  := '';
	self.sec_range	 := '';
	self.zip		 := 0;
	SELF := l;
END;

ss_cn_p := JOIN(bh_ded, scn_p_stat,
					LEFT.company_name = RIGHT.company_name AND
					LEFT.phone = RIGHT.phone,
					JoinBack(LEFT, RIGHT), LEFT OUTER, HASH);

ss_cn_p get_best_addr(ss_cn_p L, business_header.File_Business_Header_Best R) := transform
	self.prim_range := R.prim_Range;
	self.prim_name	 := R.prim_name;
	self.sec_range  := R.sec_range;
	self.zip		 := R.zip;
	self := L;
end;

outfinal := join(ss_cn_p,
			  pBH_Best,
				left.bdid = right.bdid,
			  get_best_addr(LEFT,RIGHT),
			  left outer, hash);


CompanyName_Phone_persisted := 
	DISTRIBUTE(outfinal, HASH(phone))(cn_p_bdids > 0 and cn_p_bdids < 100)
		: PERSIST(pPersistName);

return CompanyName_Phone_persisted;

end;