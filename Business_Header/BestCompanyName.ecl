// Most frequent company name per BDID.
IMPORT ut;

export BestCompanyName(

	dataset(business_header.Layout_Business_Header_Base) bh = Files().Base.Business_Headers.Built

) := FUNCTION

bh_d_bdid := DISTRIBUTE(bh, HASH(bdid));

layout_cn_table := RECORD
	bh_d_bdid.bdid;
	bh_d_bdid.company_name;
	UNSIGNED2 cn_ct := COUNT(GROUP);
END;

cn_stat := TABLE(bh_d_bdid, layout_cn_table, bdid, company_name, LOCAL);
cn_g_stat := GROUP(SORT(cn_stat, bdid, LOCAL), bdid, LOCAL);
cn_d_stat := DEDUP(SORT(cn_g_stat, -cn_ct, -company_name), bdid);

// Deal with misspellings.  Separate the BDID's where the count of the
// name is 1, but there are other names for the same BDID from the rest.
layout_bdid_table := RECORD
	cn_stat.bdid;
	UNSIGNED2 bdid_ct := COUNT(GROUP);
END;

bdid_stat := TABLE(cn_stat, layout_bdid_table, bdid, LOCAL);
bdids_with_multiple_names := bdid_stat(bdid_ct > 1);

layout_clean_name := RECORD
	bh.bdid;
	bh.company_name;
END;

layout_clean_name GetWeak(cn_d_stat l) := TRANSFORM
	SELF := l; // Only care about the bdid, not the name here.
END;

weak := JOIN(cn_d_stat(cn_ct = 1), bdids_with_multiple_names,
				LEFT.bdid = RIGHT.bdid, 
				GetWeak(LEFT), LOCAL);

layout_clean_name GetCleanName(bh_d_bdid l) := TRANSFORM
	SELF.bdid := l.bdid;
	SELF.company_name := ut.CleanCompany(l.company_name);
END;

weak_names := JOIN(bh_d_bdid, weak,
				LEFT.bdid = RIGHT.bdid,
				GetCleanName(LEFT), LOCAL);

layout_ccn_table := RECORD
	weak_names.bdid;
	weak_names.company_name;
	UNSIGNED2 cn_ct := COUNT(GROUP);
END;

ccn_stat := TABLE(weak_names, layout_ccn_table, bdid, company_name, LOCAL);
ccn_g_stat := GROUP(SORT(ccn_stat, bdid, LOCAL), bdid, LOCAL);
ccn_d_stat := DEDUP(SORT(ccn_g_stat, -cn_ct, -company_name), bdid);

// Replace company name count with clean company name count for weak names
layout_cn_table ReplaceCount(cn_stat l, ccn_d_stat r) := transform
self.cn_ct := if(r.company_name <> '', r.cn_ct, l.cn_ct);
self := l
end;

cnr_stat := join(cn_stat,
                 ccn_d_stat,
				 left.bdid = right.bdid and
				   ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name),
				 ReplaceCount(left, right),
				 left outer,
				 local);
				 
cnr_g_stat := GROUP(SORT(cnr_stat, bdid, LOCAL), bdid, LOCAL);
cnr_d_stat := DEDUP(SORT(cnr_g_stat, -cn_ct, -company_name), bdid);

layout_bh_bestcompanyname := RECORD
	cnr_d_stat.bdid;
	cnr_d_stat.company_name;
END;

/*
layout_bh_bestcompanyname TakeRightName(cn_d_stat l, ccn_d_stat r) := TRANSFORM
	SELF.company_name := IF(r.company_name != '',
							 r.company_name, l.company_name);
	SELF := l;
END;

// Now join the cleaned best names back.
cn_ccn_stat := JOIN(cn_d_stat, ccn_d_stat,
					LEFT.bdid = RIGHT.bdid,
					TakeRightName(LEFT, RIGHT), LEFT OUTER, LOCAL);
*/

layout_bh_bestcompanyname FormatBestCompanyName(cnr_d_stat l) := transform
self := l;
end;

cn_ccn_stat := project(cnr_d_stat, FormatBestCompanyName(left));

bh_bcn := group(cn_ccn_stat);

return bh_bcn;
end;