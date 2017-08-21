IMPORT ut, Header, prte2_Gong, prte2_DNB, prte2_IRS, prte2_Corp, DNB_DMI, Business_Header, Business_Header_SS,  versioncontrol,mdr;

EXPORT BC_Stats(

	 dataset(Business_Header.Layout_Business_Header_Base					) pBusinessHeaders			= Files().Base.Business_Headers.built
	,dataset(Business_Header.Layout_BH_Best												) pBusinessHeadersBest	= Files().Base.Business_Header_Best.built
	,dataset(Business_Header.Layout_Business_Contact_Full_new			) pBusinessContacts			= Files().Base.Business_Contacts.built
	,dataset(business_header_ss.Layout_CompanyName_SS							) pCompanyname					= Files().Base.Companyname.Built
	,dataset(prte2_Gong.Layouts.Layout_Gong_DID										) pFile_Gong_full				= prte2_gong.Files.DS_gong_did
	,dataset(prte2_dnb.Layouts.CompaniesForBIP2										) pFile_DNB_Base				= prte2_dnb.Files.dnb_linkids
	,dataset(prte2_irs.Layouts.Base																) pFile_IRS5500_Base		= prte2_IRS.Files.base
	,dataset(prte2_Corp.Layouts.Layout_Corporate_Direct_Corp_Base	) pCorp2_Base_Corp			= prte2_CORP.Files.DS_corp_Direct
	,dataset(Business_Header.Layout_Business_Contact_Plus					) pBusinessContactsPlus	= Files().Base.Business_Contacts_Plus.keybuild

) :=
function

	bh	:= pBusinessHeaders			;
	bb	:= pBusinessHeadersBest	;
	bc	:= pBusinessContacts		;
	cnf := pCompanyname					;

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

	bh_bdid_per_addr := TABLE(bh_addr_all, layout_full_stat, zip, prim_name, prim_range, sec_range, LOCAL);

	bc_addr := DEDUP(
		SORT(
		DISTRIBUTE(bc(zip != 0, prim_name != ''), HASH(zip, prim_name, prim_range)),
		zip, prim_name, prim_range, sec_range, LOCAL),
		zip, prim_name, prim_range, sec_range, LOCAL);

	layout_full_stat TakeLeft(bc_addr l, bh_bdid_per_addr r) := TRANSFORM
		SELF.bdid_per_addr := r.bdid_per_addr;
		SELF := l;
	END;

	// Keep only addresses present in contacts
	bh_addr := JOIN(bc_addr, bh_bdid_per_addr,
		LEFT.zip = RIGHT.zip AND 
		LEFT.prim_name = RIGHT.prim_name AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.sec_range = RIGHT.sec_range,
		TakeLeft(LEFT, RIGHT), LEFT OUTER, LOCAL);

	// Get residential phones per addr.
	gng_res := pFile_Gong_full(publish_code = 'P', listing_type_res <> '', z5 != '', prim_name != '');
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
	gng_bus := pFile_Gong_full(publish_code IN ['P','U'], listing_type_bus <> '', z5 != '', prim_name != '');
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

	bc_unique_bdid := TABLE(DISTRIBUTE(bh(bdid != 0), HASH(bdid)), layout_bs_join, bdid, LOCAL);

	bh_duns_recs := DEDUP(bh(MDR.sourceTools.SourceIsDunn_Bradstreet(source), vendor_id[1] != 'D'), vendor_id, ALL);

	layout_bs_join AddDNB(pFile_DNB_Base l, bh_duns_recs r) := TRANSFORM
		SELF.bdid := r.bdid;	
		SELF.dnb_emps := 
				IF((INTEGER4) (l.rawfields.employees_total_sign + l.rawfields.employees_total) > 0, 
					(UNSIGNED4) l.rawfields.employees_total,
					IF((INTEGER4) (l.rawfields.employees_here_sign + l.rawfields.employees_here) > 0,
						(UNSIGNED4) l.rawfields.employees_here,
						1));
	END;

	setcurrentrecs := [DNB_DMI.Utilities.RecordType.Updated,DNB_DMI.Utilities.RecordType.New];
	
	bs_dnb_only := JOIN(
			DISTRIBUTE(pFile_DNB_Base(rawfields.duns_number != '', record_type in setcurrentrecs, active_duns_number = 'Y'), HASH((STRING9) rawfields.duns_number)),
			DISTRIBUTE(bh_duns_recs, HASH((STRING9) vendor_id)),
		LEFT.rawfields.duns_number = RIGHT.vendor_id,
		AddDNB(LEFT, RIGHT), LOCAL);

	bs_dnb_dedup := DEDUP(
				SORT(
					DISTRIBUTE(bs_dnb_only, HASH(bdid)),
					bdid, -dnb_emps, LOCAL),
				bdid, LOCAL);

	layout_bs_join AddDNB2(bc_unique_bdid l, bs_dnb_dedup r) := TRANSFORM
		SELF.dnb_emps := r.dnb_emps;
		SELF := l;
	END;

	bs_dnb := JOIN(
		DISTRIBUTE(bc_unique_bdid, HASH(bdid)),
		bs_dnb_dedup,
		LEFT.bdid = RIGHT.bdid, 
		AddDNB2(LEFT, RIGHT), LEFT OUTER, LOCAL);

	bh_irs_recs := DEDUP(bh(MDR.sourceTools.SourceIsIRS_5500(source)), vendor_id, ALL);

	layout_bs_join AddIRS(pFile_IRS5500_Base l, bh_irs_recs r) := TRANSFORM
		SELF.bdid := r.bdid;
		SELF.irs5500_emps :=
				IF((UNSIGNED4) l.tot_partcp_boy_cnt != 0,
					(UNSIGNED4) l.tot_partcp_boy_cnt,
					IF((UNSIGNED4) l.tot_active_partcp_cnt != 0,
						(UNSIGNED4) l.tot_active_partcp_cnt,
						1));
	END;

	bs_irs_only := JOIN(
			DISTRIBUTE(pFile_IRS5500_Base, HASH((QSTRING34) document_locator_number)),
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
				DISTRIBUTE(bh(MDR.sourceTools.SourceIsWhois_domains(source)), HASH(bdid)), 
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
	bs_has_gong := DEDUP(bh_source_ded(
					MDR.sourceTools.SourceIsGong_Business		(source)
		or 		MDR.sourceTools.SourceIsGong_Government	(source)
		or 		MDR.sourceTools.SourceIsYellow_Pages		(source)
		), bdid, LOCAL);

	layout_bs_join AddHasGong(bs_dnb_irs_cnf_whois_source l, bs_has_gong r) := TRANSFORM
		SELF.has_gong_yp := r.bdid != 0;
		SELF := l;
	END;

	bs_dnb_irs_cnf_whois_source_gong := 
	JOIN(bs_dnb_irs_cnf_whois_source, bs_has_gong,
		LEFT.bdid = RIGHT.bdid,
		AddHasGong(LEFT, RIGHT), LEFT OUTER, LOCAL);

	// Add the best phone
	layout_bs_join AddBestPhone(bs_dnb_irs_cnf_whois_source_gong l, bb r) := TRANSFORM
		SELF.best_phone := r.phone;
		SELF := l;
	END;

	bs_dnb_irs_cnf_whois_source_gong_bestph := 
	JOIN(bs_dnb_irs_cnf_whois_source_gong, DISTRIBUTE(bb, HASH(bdid)),
		LEFT.bdid = RIGHT.bdid,
		AddBestPhone(LEFT, RIGHT), LEFT OUTER, LOCAL);

	// Check if we have a current corporate record for the bdid.
	corp_recs := bh(MDR.sourceTools.SourceIsCorpV2(source), current);

	layout_corp_check := RECORD
		UNSIGNED6 bdid;
	END;

	layout_corp_check TakeCurrentCorpBDID(corp_recs l) := TRANSFORM
		SELF := l;
	END;

	corp_base_recs := 
		pCorp2_Base_Corp(business_header.is_ActiveCorp(record_type, corp_status_cd, corp_status_desc));

	current_corp_recs := JOIN(
		DISTRIBUTE(corp_recs, HASH((STRING34) vendor_id)),
		DISTRIBUTE(corp_base_recs, HASH((STRING34)corp_key)),
		(STRING34)LEFT.vendor_id = (STRING34)RIGHT.corp_key,
		TakeCurrentCorpBDID(LEFT), LOCAL);

	current_corp_recs_ded := DEDUP(current_corp_recs, bdid, ALL);

	layout_bs_join AddCurrentCorp(bs_dnb_irs_cnf_whois_source_gong_bestph l, 
			current_corp_recs_ded r) := TRANSFORM
		SELF.current_corp := r.bdid != 0;
		SELF := l;
	END;

	bs_all := JOIN(bs_dnb_irs_cnf_whois_source_gong_bestph, 
		DISTRIBUTE(current_corp_recs_ded, HASH(bdid)),
		LEFT.bdid = RIGHT.bdid,
		AddCurrentCorp(LEFT, RIGHT), LEFT OUTER, LOCAL);

		
	// ################################################################## 

	// Check if we can match did'ed contacts with employer name
	// from credit headers.
	contacts := pBusinessContactsPlus;
	contacts_check_eq := contacts(did != 0, from_hdr != 'E');

	business_header.Layout_Business_Contacts_Stats AddEqFlag(contacts_check_eq l, business_header.Layout_Business_Contact_Full_new r) := TRANSFORM
		SELF.eq_emp_match := r.did != 0;
		SELF := l;
	END;

	contacts_eq_j1 := JOIN(
		DISTRIBUTE(contacts_check_eq, HASH(did)),
		DISTRIBUTE(bc(MDR.sourceTools.SourceIsEq_Employer(source)), HASH(did)),
		LEFT.did = RIGHT.did AND
		ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10,
		AddEqFlag(LEFT, RIGHT), LEFT OUTER, KEEP(1), LOCAL);

	// Just in case KEEP(1) flakes.
	contacts_eq_j := DEDUP(contacts_eq_j1, __filepos, ALL);

	business_header.Layout_Business_Contacts_Stats toLayout_Business_Contacts_Stats(contacts l) := transform
		self := l;
	end;

	contacts_eq := contacts_eq_j 
		+ project(contacts(did = 0 OR from_hdr = 'E'), toLayout_Business_Contacts_Stats(left));
	// ################################################################## 

	// Build employment file joined with stats.
	business_header.Layout_Business_Contacts_Stats AddSourceStats(contacts_eq l, bs_all r) := TRANSFORM
		SELF.dnb_emps := r.dnb_emps;
		SELF.irs5500_emps := r.irs5500_emps;
		SELF.domainss := r.domainss;
		SELF.sources := r.sources;
		SELF.has_gong_yp := r.has_gong_yp;
		SELF.best_phone := r.best_phone;
		SELF.company_name_score := r.company_name_score;
		SELF.current_corp := r.current_corp;
		SELF := l;
	END;

	contacts_eq_bs := JOIN(DISTRIBUTE(contacts_eq(bdid != 0), HASH(bdid)),
		bs_all,
		LEFT.bdid = RIGHT.bdid,
		AddSourceStats(LEFT, RIGHT), LEFT OUTER, LOCAL);

	empf := contacts_eq_bs + contacts_eq(bdid = 0);
	empf_dist := DISTRIBUTE(empf(zip != 0, prim_name != ''), 
		HASH(zip, prim_name, prim_range, sec_range));

	business_header.Layout_Business_Contacts_Stats AddStats(empf_dist l, addr_all r) := TRANSFORM
		SELF.bdid_per_addr := r.bdid_per_addr;
		SELF.apts := r.apts;
		SELF.ppl := r.ppl;
		SELF.r_phone_per_addr := r.r_phone_per_addr;
		SELF.b_phone_per_addr := r.b_phone_per_addr;
		SELF := l;
	END;
		
	with_stats := JOIN(empf_dist, addr_all,
		LEFT.zip = RIGHT.zip AND 
		LEFT.prim_name = RIGHT.prim_name AND
		LEFT.prim_range = RIGHT.prim_range AND
		LEFT.sec_range = RIGHT.sec_range,
		AddStats(LEFT, RIGHT), LEFT OUTER, LOCAL);

	with_stats_dist := DISTRIBUTE(
		with_stats + empf(zip = 0 OR prim_name = ''), HASH(__filepos));

	business_header.Layout_Business_Contacts_Stats ScoreContact(with_stats_dist r) := TRANSFORM
		SELF.combined_score := r.contact_score +
			IF(r.b_phone_per_addr > r.r_phone_per_addr, 2, 
				IF(r.b_phone_per_addr > 0, 1, 0)) +
			IF(r.dnb_emps + r.irs5500_emps > r.ppl, 5, 0) +
			IF(r.domainss > 1, 2 ,0) +
			IF(r.bdid_per_addr > r.apts, 2, 0) +
			IF(r.company_name_score > 10, 2,
				IF(r.company_name_score > 1, 1, 0)) +
			IF(r.sources > 4, 1, 0) +
			IF(r.has_gong_yp, 2, 0) +
			IF(r.eq_emp_match, 5, 0) +
			IF(r.current_corp, 2, 0) +
			IF(r.from_hdr = 'N', 100, IF(r.from_hdr = 'E', 50, 0));
		SELF := r;
	END;

	// We can optionally strip all the Business_Header.File_BCP_ForStats
	// fields (except __filepos) to output the stats only.  For now, keep
	// the full record.
	scored_stats := PROJECT(with_stats_dist, ScoreContact(LEFT));

	return scored_stats;

end;