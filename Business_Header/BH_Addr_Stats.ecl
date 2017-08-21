IMPORT Gong_Neustar, Header, DNB, IRS5500, Corp2, Business_Header_SS, ut;

bh := Business_Header.Files().Base.Business_Headers.built;
bb := Business_Header.Files().Base.Business_Header_Best.built;

bh_addr_all := DEDUP(
	SORT(
	DISTRIBUTE(bh(zip != 0, prim_name != ''), HASH(zip, prim_name, prim_range)),
	zip, prim_name, prim_range, sec_range, bdid, LOCAL),
	zip, prim_name, prim_range, sec_range, bdid, LOCAL);

layout_full_stat := RECORD
	bh_addr_all.zip;
	bh_addr_all.prim_name;
	bh_addr_all.prim_range;
	bh_addr_all.sec_range;
	UNSIGNED4 bdid_per_addr := COUNT(GROUP);
	UNSIGNED4 apts := 0;
	UNSIGNED4 ppl := 0;
	UNSIGNED4 r_phone_per_addr := 0;
	UNSIGNED4 b_phone_per_addr := 0;
END;

bh_addr := TABLE(bh_addr_all, layout_full_stat, zip, prim_name, prim_range, sec_range, LOCAL);


// Get residential phones per addr.
gng_res := Gong_Neustar.File_Gong_full(publish_code = 'P', listing_type_res <> '', z5 != '', prim_name != '');
gong_res_dist := DEDUP(
	SORT(
	DISTRIBUTE(gng_res, HASH(z5, prim_name, prim_range)),
	z5, prim_name, prim_range, sec_range, phone10, LOCAL),
	z5, prim_name, prim_range, sec_range, phone10, LOCAL);

layout_res_phones_per_addr := RECORD
	gong_res_dist.prim_range;
	gong_res_dist.prim_name;
	gong_res_dist.sec_range;
	gong_res_dist.z5;
	UNSIGNED4 r_phone_per_addr := COUNT(GROUP);
END;

gong_r_phone_per_addr := TABLE(gong_res_dist, layout_res_phones_per_addr,
		z5, prim_name, prim_range, sec_range, LOCAL);

// Get business/gov phones per addr.
gng_bus := Gong_Neustar.File_Gong_full(publish_code IN ['P','U'], listing_type_bus <> '', z5 != '', prim_name != '');
gong_bus_dist := DEDUP(
	SORT(
	DISTRIBUTE(gng_bus, HASH(z5, prim_name, prim_range)),
	z5, prim_name, prim_range, sec_range, phone10, LOCAL),
	z5, prim_name, prim_range, sec_range, phone10, LOCAL);

layout_bus_phones_per_addr := RECORD
	gong_bus_dist.prim_range;
	gong_bus_dist.prim_name;
	gong_bus_dist.sec_range;
	gong_bus_dist.z5;
	UNSIGNED4 b_phone_per_addr := COUNT(GROUP);
END;

gong_b_phone_per_addr := TABLE(gong_bus_dist, layout_bus_phones_per_addr,
		z5, prim_name, prim_range, sec_range, LOCAL);

// Apartment/person counts
aparts := Header.ApartmentBuildings;

layout_full_stat AddAptCnt(bh_addr l, aparts r) := TRANSFORM
	SELF.apts := r.apt_cnt;
	SELF.ppl := r.did_cnt;
	SELF := l;
END;

addr_with_people := JOIN(	DISTRIBUTE(bh_addr, HASH(zip, prim_name, prim_range)),
		DISTRIBUTE(aparts, HASH((UNSIGNED3) zip, (QSTRING28) prim_name, (QSTRING10) prim_range)),
		LEFT.zip = (UNSIGNED3) RIGHT.zip AND
		LEFT.prim_name = (QSTRING28) RIGHT.prim_name AND
		LEFT.prim_range = (QSTRING10) RIGHT.prim_range, 
		AddAptCnt(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Rollup in case of multiple predir/suffix problems.
layout_full_stat Roll(addr_with_people l, addr_with_people r) := TRANSFORM
	SELF.apts := l.apts + r.apts;
	SELF.ppl := l.ppl + r.ppl;
	SELF := l;
END;

addr_with_people_roll := ROLLUP(
	SORT(addr_with_people, zip, prim_name, prim_range, sec_range, LOCAL),
	LEFT.zip = RIGHT.zip AND 
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.sec_range = RIGHT.sec_range,
	Roll(LEFT, RIGHT), LOCAL);

// Add back 0 zips.
stat1 := addr_with_people_roll;

// Add res phone counts.
layout_full_stat AddResCt(layout_full_stat l, gong_r_phone_per_addr r) := TRANSFORM
	SELF.r_phone_per_addr := r.r_phone_per_addr;
	SELF := l;
END;

stat2 := JOIN(
	DISTRIBUTE(stat1, HASH(zip, prim_name, prim_range, sec_range)), 
	DISTRIBUTE(gong_r_phone_per_addr, HASH(
		(UNSIGNED3) z5, (QSTRING28) prim_name, 
		(QSTRING10) prim_range, (QSTRING8) sec_range)),
	LEFT.zip = (UNSIGNED3) RIGHT.z5 AND 
	LEFT.prim_name = (QSTRING28) RIGHT.prim_name AND
	LEFT.prim_range = (QSTRING10) RIGHT.prim_range AND
	LEFT.sec_range = (QSTRING8) RIGHT.sec_range,
	AddResCt(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Add business phone counts.
layout_full_stat AddBusCt(layout_full_stat l, gong_b_phone_per_addr r) := TRANSFORM
	SELF.b_phone_per_addr := r.b_phone_per_addr;
	SELF := l;
END;

stat3 := JOIN(stat2,
	DISTRIBUTE(gong_b_phone_per_addr, HASH(
		(UNSIGNED3) z5, (QSTRING28) prim_name, 
		(QSTRING10) prim_range, (QSTRING8) sec_range)),
	LEFT.zip = (UNSIGNED3) RIGHT.z5 AND 
	LEFT.prim_name = (QSTRING28) RIGHT.prim_name AND
	LEFT.prim_range = (QSTRING10) RIGHT.prim_range AND
	LEFT.sec_range = (QSTRING8) RIGHT.sec_range,
	AddBusCt(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Get rid of a handful (<100) of duplicates due to the gong record fields not
// being the same length as the bh fields and thus not deduping exactly.
addr_all := DEDUP(
	SORT(stat3, zip, prim_name, prim_range, sec_range, LOCAL),
	zip, prim_name, prim_range, sec_range, LOCAL);
	
// Rollup by Primary Address
// Rollup by Primary Address
addr_all_dist := DISTRIBUTE(addr_all, HASH(zip, TRIM(prim_name), TRIM(prim_range)));
addr_all_sort := SORT(addr_all_dist, zip, prim_name, prim_range, LOCAL);
addr_all_grp := GROUP(addr_all_sort, zip, prim_name, prim_range, LOCAL);

layout_full_stat RollupAddrStats(layout_full_stat l, layout_full_stat r) := transform
SELF.bdid_per_addr := l.bdid_per_addr + r.bdid_per_addr;
SELF.apts := l.apts;  // Only count apts once for primary address
SELF.ppl := l.ppl;    // Only count people once for primary address
SELF.r_phone_per_addr := l.r_phone_per_addr + r.r_phone_per_addr;
SELF.b_phone_per_addr := l.b_phone_per_addr + r.b_phone_per_addr;
SELF := L;
end;

addr_all_rollup := GROUP(ROLLUP(addr_all_grp, TRUE, RollupAddrStats(LEFT,RIGHT)));


// ################################################################## 

// ################################################################## 
// Get information from DNB and IRS5500 per bdid.
layout_bs_join := RECORD	
	bh.bdid;
	UNSIGNED4 dnb_emps := 0;
	UNSIGNED4 irs5500_emps := 0;
	UNSIGNED4 domainss := 0;
	UNSIGNED1 sources := 0;
	BOOLEAN   has_gong_yp := FALSE;
	BOOLEAN   current_corp := FALSE;
	UNSIGNED6 best_phone := 0;
	UNSIGNED1 company_name_score := 0;
END;

bh_unique_bdid := TABLE(DISTRIBUTE(bh(bdid != 0), HASH(bdid)), layout_bs_join, bdid, LOCAL);

bh_duns_recs := DEDUP(bh(source = 'D', vendor_id[1] != 'D'), vendor_id, ALL);

layout_bs_join AddDNB(DNB.File_DNB_Base l, bh_duns_recs r) := TRANSFORM
	SELF.bdid := r.bdid;	
	SELF.dnb_emps := 
			IF((INTEGER4) (l.employees_total_sign + l.employees_total) > 0, 
				(UNSIGNED4) l.employees_total,
				IF((INTEGER4) (l.employees_here_sign + l.employees_here) > 0,
					(UNSIGNED4) l.employees_here,
					1));
END;

bs_dnb_only := JOIN(
		DISTRIBUTE(DNB.File_DNB_Base(duns_number != '', record_type = 'C', active_duns_number = 'Y'), HASH((STRING9) duns_number)),
		DISTRIBUTE(bh_duns_recs, HASH((STRING9) vendor_id)),
	LEFT.duns_number = RIGHT.vendor_id,
	AddDNB(LEFT, RIGHT), LOCAL);

bs_dnb_dedup := DEDUP(
			SORT(
				DISTRIBUTE(bs_dnb_only, HASH(bdid)),
				bdid, -dnb_emps, LOCAL),
			bdid, LOCAL);

layout_bs_join AddDNB2(bh_unique_bdid l, bs_dnb_dedup r) := TRANSFORM
	SELF.dnb_emps := r.dnb_emps;
	SELF := l;
END;

bs_dnb := JOIN(
	DISTRIBUTE(bh_unique_bdid, HASH(bdid)),
	bs_dnb_dedup,
	LEFT.bdid = RIGHT.bdid, 
	AddDNB2(LEFT, RIGHT), LEFT OUTER, LOCAL);

bh_irs_recs := DEDUP(bh(source = 'I'), vendor_id, ALL);

layout_bs_join AddIRS(IRS5500.File_IRS5500_Base l, bh_irs_recs r) := TRANSFORM
	SELF.bdid := r.bdid;
	SELF.irs5500_emps :=
			IF((UNSIGNED4) l.tot_partcp_boy_cnt != 0,
				(UNSIGNED4) l.tot_partcp_boy_cnt,
				IF((UNSIGNED4) l.tot_active_partcp_cnt != 0,
					(UNSIGNED4) l.tot_active_partcp_cnt,
					1));
END;

bs_irs_only := JOIN(
		DISTRIBUTE(IRS5500.File_IRS5500_Base, HASH((QSTRING34) document_locator_number)),
		DISTRIBUTE(bh_irs_recs, HASH(vendor_id)),
	LEFT.document_locator_number = RIGHT.vendor_id,
	AddIRS(LEFT, RIGHT), LOCAL);

bs_irs_dedup := DEDUP(
			SORT(
				DISTRIBUTE(bs_irs_only, HASH(bdid)),
				bdid, -irs5500_emps, LOCAL),
			bdid, LOCAL);

layout_bs_join AddIRS2(bs_dnb l, bs_irs_dedup r) := TRANSFORM
	SELF.irs5500_emps := r.irs5500_emps;
	SELF := l;
END;

bs_dnb_irs5500 := JOIN(bs_dnb, 
	bs_irs_dedup,
	LEFT.bdid = RIGHT.bdid, 
	AddIRS2(LEFT, RIGHT), LEFT OUTER, LOCAL);

cnf := Business_Header.Files().Base.CompanyName.keybuild;

// Add company name frequency from the slimsorts.
layout_bs_join AddCNScore(layout_bs_join l, cnf r) := TRANSFORM
	SELF.company_name_score := r.cn_bdids;
	SELF := l;
END;

bs_dnb_irs_cnf_pre := JOIN(bs_dnb_irs5500,
	DISTRIBUTE(cnf, HASH(bdid)),
	LEFT.bdid = RIGHT.bdid,
	AddCNScore(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Dedup to keep the worst name score for each bdid.
bs_dnb_irs_cnf := DEDUP(SORT(bs_dnb_irs_cnf_pre, bdid, -company_name_score, LOCAL), bdid, LOCAL);

// Get a count of whois source records for each bdid.
layout_domain_count := RECORD
	bh.bdid;
	UNSIGNED4 domain_ct := COUNT(group);
END;

domain_count := TABLE(
			DISTRIBUTE(bh(source = 'W'), HASH(bdid)), 
			layout_domain_count, bdid, LOCAL);

layout_bs_join AddDomainCt(bs_dnb_irs_cnf l, domain_count r) := TRANSFORM
	SELF.domainss := r.domain_ct;
	SELF := l;
END;

bs_dnb_irs_cnf_whois := JOIN(bs_dnb_irs_cnf, domain_count,
			LEFT.bdid = RIGHT.bdid,
			AddDomainCt(LEFT, RIGHT), LEFT OUTER, LOCAL);

bh_source_ded := DEDUP(
			SORT(DISTRIBUTE(bh, HASH(bdid)), bdid, source, LOCAL),
			bdid, source, LOCAL);

// Get a count of different sources per bdid.
layout_source_count := RECORD
	bh.bdid;
	UNSIGNED1 source_ct := COUNT(GROUP);
END;

source_count := TABLE(bh_source_ded, layout_source_count, bdid, LOCAL);

layout_bs_join AddSourceCt(bs_dnb_irs_cnf_whois l, source_count r) := TRANSFORM
	SELF.sources := r.source_ct;
	SELF := l;
END;

bs_dnb_irs_cnf_whois_source := JOIN(bs_dnb_irs_cnf_whois, source_count,
	LEFT.bdid = RIGHT.bdid,
	AddSourceCt(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Does a gong or yellow pages record exist?
bs_has_gong := DEDUP(bh_source_ded(source IN ['GB', 'GG', 'Y']), bdid, LOCAL);

layout_bs_join AddHasGong(bs_dnb_irs_cnf_whois_source l, bs_has_gong r) := TRANSFORM
	SELF.has_gong_yp := r.bdid != 0;
	SELF := l;
END;

bs_dnb_irs_cnf_whois_source_gong := 
JOIN(bs_dnb_irs_cnf_whois_source, bs_has_gong,
	LEFT.bdid = RIGHT.bdid,
	AddHasGong(LEFT, RIGHT), LEFT OUTER, LOCAL);

// Check if we have a current corporate record for the bdid.
corp_recs := bh(source = 'C', current);

layout_corp_check := RECORD
	UNSIGNED6 bdid;
END;

layout_corp_check TakeCurrentCorpBDID(corp_recs l) := TRANSFORM
	SELF := l;
END;

corp_base_recs := Corp2.Files().Base.Corp.Prod(business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc));

current_corp_recs := JOIN(
	DISTRIBUTE(corp_recs, HASH((STRING34) vendor_id)),
	DISTRIBUTE(corp_base_recs, HASH((STRING34)corp_key)),
	(STRING34)LEFT.vendor_id = (STRING34)RIGHT.corp_key,
	TakeCurrentCorpBDID(LEFT), LOCAL);

current_corp_recs_ded := DEDUP(current_corp_recs, bdid, ALL);

layout_bs_join AddCurrentCorp(bs_dnb_irs_cnf_whois_source_gong l, 
		current_corp_recs_ded r) := TRANSFORM
	SELF.current_corp := r.bdid != 0;
	SELF := l;
END;

bs_all := JOIN(bs_dnb_irs_cnf_whois_source_gong, 
	DISTRIBUTE(current_corp_recs_ded, HASH(bdid)),
	LEFT.bdid = RIGHT.bdid,
	AddCurrentCorp(LEFT, RIGHT), LEFT OUTER, LOCAL);
	
layout_bs_join_addr := RECORD
unsigned3 zip := 0;
qstring28 prim_name := '';
qstring10 prim_range := '';
qstring8  sec_range := '';
UNSIGNED4 dnb_emps := 0;
UNSIGNED4 irs5500_emps := 0;
UNSIGNED4 domainss := 0;
UNSIGNED1 sources := 0;
UNSIGNED1 company_name_score := 0;
UNSIGNED4 gong_yp_cnt := 0;
UNSIGNED4 current_corp_cnt := 0;
end;

// Add best address
layout_bs_join_addr AddBestAddress(bs_all l, bb r) := transform
self.zip := r.zip;
self.prim_name := r.prim_name;
self.prim_range := r.prim_range;
self.sec_range := r.sec_range;
self.gong_yp_cnt := if(l.has_gong_yp, 1, 0);
self.current_corp_cnt := if(l.current_corp, 1, 0);
self := l;
end;
	
bs_all_addr := JOIN(bs_all,
                    DISTRIBUTE(bb, HASH(bdid)),
					LEFT.bdid = RIGHT.bdid,
					AddBestAddress(LEFT, RIGHT), LEFT OUTER, LOCAL);
					
// Rollup by Primary Address
bs_all_addr_dist := DISTRIBUTE(bs_all_addr(zip != 0, prim_name != ''), HASH(zip, trim(prim_name), TRIM(prim_range)));
bs_all_addr_sort := SORT(bs_all_addr_dist, zip, prim_name, prim_range, LOCAL);
bs_all_addr_grp := GROUP(bs_all_addr_sort, zip, prim_name, prim_range, LOCAL);

layout_bs_join_addr RollupBDIDStats(layout_bs_join_addr l, layout_bs_join_addr r) := transform
SELF.dnb_emps := l.dnb_emps + r.dnb_emps;
SELF.irs5500_emps := l.irs5500_emps + r.irs5500_emps;
SELF.domainss := l.domainss + r.domainss;
SELF.sources := IF(l.sources > r.sources, l.sources, r.sources);
SELF.gong_yp_cnt := l.gong_yp_cnt + r.gong_yp_cnt;
SELF.current_corp_cnt := l.current_corp_cnt + r.current_corp_cnt;
SELF.company_name_score := l.company_name_score + r.company_name_score;
SELF := l;
end;

bs_all_addr_rollup := GROUP(ROLLUP(bs_all_addr_grp, TRUE, RollupBDIDStats(LEFT, RIGHT)));

// Combine Stats by Primary Address
Layout_BH_Addr_Stats CombineStats(layout_full_stat l, layout_bs_join_addr r) := transform
self.dnb_emps := r.dnb_emps;
self.irs5500_emps := r.irs5500_emps;
self.domainss := r.domainss;
self.sources := r.sources;
self.company_name_score := r.company_name_score;
self.gong_yp_cnt := r.gong_yp_cnt;
self.current_corp_cnt := r.current_corp_cnt;
self := l;
end;

bh_addr_stats_init := JOIN(addr_all_rollup,
						   bs_all_addr_rollup,
						   LEFT.zip = RIGHT.zip and
						     LEFT.prim_name = RIGHT.prim_name and
							 LEFT.prim_range = RIGHT.prim_range,
						   CombineStats(LEFT,RIGHT),
						   LEFT OUTER,
						   LOCAL);

Layout_BH_Addr_Stats ScoreAddr(Layout_BH_Addr_Stats l) := TRANSFORM
	SELF.combined_score := 0 +
		IF(l.b_phone_per_addr > l.r_phone_per_addr, 2, 
			IF(l.b_phone_per_addr > 0, 1, 0)) +
		IF(l.dnb_emps + l.irs5500_emps > l.ppl, 5, 0) +
		IF(l.domainss > 1, 2 ,0) +
		IF(l.bdid_per_addr > l.apts, 2, 0) +
		IF(l.company_name_score > 10, 2,
			IF(l.company_name_score > 1, 1, 0)) +
		IF(l.sources > 4, 1, 0) +
		IF(l.gong_yp_cnt > 0, 2, 0) +
		IF(l.current_corp_cnt > 0, 2, 0);
	SELF := l;
END;


scored_addr_stats := PROJECT(bh_addr_stats_init, ScoreAddr(LEFT));

EXPORT BH_Addr_Stats := scored_addr_stats : PERSIST(persistnames().BHAddrStats);