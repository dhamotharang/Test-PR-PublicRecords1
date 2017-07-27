IMPORT Business_Header, ut;

bh := Business_Header.File_Business_Header_Base;

// Project to slim record.
layout_slim := RECORD
	bh.bdid;
	STRING80 clean_company_name;
END;

layout_slim SlimBH(bh l) := TRANSFORM
	SELF.clean_company_name := ut.CleanCompany((STRING) l.company_name);
	SELF := l;
END;

bh_slim := PROJECT(bh, SlimBH(LEFT));
bh_ded_cn1 := DEDUP(
                SORT(
	              DISTRIBUTE(bh_slim(clean_company_name != ''), HASH(clean_company_name)),
				    clean_company_name, bdid, LOCAL),
	                 clean_company_name, bdid, LOCAL);

ut.MAC_Split_Withdups_Local(bh_ded_cn1, clean_company_name, 255, bh_ded_cn, bh_cn_overflow)

bh_ded_cn_dist := DISTRIBUTE(bh_ded_cn, HASH(clean_company_name[1..20]));

cn_only_dist := DISTRIBUTE(
	  DEDUP(sort(bh_ded_cn, clean_company_name, local), clean_company_name, local), //dedup local ok with sort bc bh_ded_cn1 is dist
	HASH(clean_company_name[1..20]));

layout_similar_count := RECORD
	bh_ded_cn_dist.clean_company_name;	
	UNSIGNED6 bdid_r;
END;

layout_similar_count AddRec(cn_only_dist l, bh_ded_cn_dist r) := TRANSFORM
	SELF.clean_company_name := l.clean_company_name;
	SELF.bdid_r := r.bdid;
END;

cn_joined := JOIN(cn_only_dist, bh_ded_cn_dist,
	LEFT.clean_company_name[1..20] = RIGHT.clean_company_name[1..20] AND
	ut.CompanySimilar100(LEFT.clean_company_name, RIGHT.clean_company_name) < 10,
	AddRec(LEFT, RIGHT), LOCAL);

cn_ded := DEDUP(
			SORT(
				DISTRIBUTE(cn_joined, HASH(clean_company_name)),
				clean_company_name, bdid_r, LOCAL),
			clean_company_name, bdid_r, LOCAL);

layout_cn_stat := RECORD
	cn_ded.clean_company_name;
	UNSIGNED1 ct := IF(COUNT(GROUP) > 255, 255, COUNT(GROUP));
END;

cn_stat := TABLE(cn_ded, layout_cn_stat, clean_company_name, LOCAL);

// Bump the scores of regular names to 255 if they're similar
// to any of the overflow names.
overflow_companies := DEDUP(sort(bh_cn_overflow, clean_company_name, local), clean_company_name, local);
	//above ds also dist bc bh_ded_cn1 is dist
	
layout_cn_stat AdjustScore(layout_cn_stat l, overflow_companies r) := TRANSFORM
	SELF.ct := IF(r.clean_company_name != '', 255, l.ct);
	SELF := l;
END;

cn_stat_adjust := JOIN(
	DISTRIBUTE(cn_stat, HASH(clean_company_name[1..20])),
	DISTRIBUTE(overflow_companies, HASH(clean_company_name[1..20])),
	LEFT.clean_company_name[1..20] = RIGHT.clean_company_name[1..20] AND
	ut.CompanySimilar100(LEFT.clean_company_name, RIGHT.clean_company_name) < 10,
	AdjustScore(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Multiple matches will all have a score of 255, so it doesn't
// matter which one we keep.
cn_stat_adjust_dedup := DEDUP(sort(cn_stat_adjust, clean_company_name, local), clean_company_name, local);
	// above dedup local ok bc dist by x[1..20] will have all equal values of x on same node

Layout_CompanyName_SS JoinCleanCount(bh_ded_cn l, cn_stat r) := TRANSFORM
	SELF.cn_bdids := IF(r.ct = 0, 255, r.ct);
	SELF := l;
END;

ss_cn := JOIN( 
		bh_ded_cn1, 
		DISTRIBUTE(cn_stat_adjust_dedup, HASH(clean_company_name)),
		LEFT.clean_company_name = RIGHT.clean_company_name,
		JoinCleanCount(LEFT, RIGHT), LEFT OUTER, LOCAL);

EXPORT CompanyName := ss_cn;