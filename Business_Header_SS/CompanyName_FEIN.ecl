IMPORT Business_Header, ut;

bh := Business_Header.File_Business_Header_Base(fein != 0);

// Project to slim record.
layout_slim := RECORD
	bh.bdid;
	bh.company_name;
	bh.fein;
END;

layout_slim SlimBH(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim := PROJECT(bh, SlimBH(LEFT));

bhd := DISTRIBUTE(bh_slim, HASH(bdid));
bhs := SORT(bhd, bdid, company_name, fein, LOCAL);
bh_ded := DEDUP(bhs, bdid, company_name, fein, LOCAL);

// Get a count of how many bdid's match within a certain
// name similarity range for each name-phone combination.
layout_similar := RECORD
	UNSIGNED6 bdid_r;
	bh.company_name;
	bh.fein;
END;

layout_similar JoinSimilar(bh_ded l, bh_ded r) := TRANSFORM
	SELF.bdid_r := r.bdid;
	SELF := l;
END;

bh_dist_f := DISTRIBUTE(bh_ded, HASH(fein));
similar := JOIN(bh_dist_f, bh_dist_f,
				LEFT.fein = RIGHT.fein AND
				ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 35,
				JoinSimilar(LEFT, RIGHT), LOCAL);

similar_d := DISTRIBUTE(similar, HASH(company_name, fein));
similar_s := SORT(similar_d, company_name, fein, bdid_r, LOCAL);
similar_ded := DEDUP(similar_s, company_name, fein, bdid_r, LOCAL);

layout_scn_f := RECORD
	similar_ded.company_name;
	similar_ded.fein;
	UNSIGNED1 scn_f_ct := IF(COUNT(GROUP) < 255, COUNT(GROUP), 255);
END;

scn_f_stat := TABLE(similar_ded, layout_scn_f, company_name, fein, LOCAL);

// Join the similar count back.
Layout_CompanyName_FEIN_SS JoinBack(bhd l, scn_f_stat r) := TRANSFORM
	SELF.cn_f_bdids := r.scn_f_ct;
	SELF := l;
END;

ss_cn_f := JOIN(bh_ded, scn_f_stat,
					LEFT.company_name = RIGHT.company_name AND
					LEFT.fein = RIGHT.fein,
					JoinBack(LEFT, RIGHT), LEFT OUTER, HASH);

EXPORT CompanyName_FEIN := DISTRIBUTE(ss_cn_f(cn_f_bdids > 0 and cn_f_bdids < 100), HASH(fein))
								: PERSIST('adTEMP::BH_SS_cn_f');