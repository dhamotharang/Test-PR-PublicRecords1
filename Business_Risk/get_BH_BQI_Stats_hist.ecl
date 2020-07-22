IMPORT dx_Gong, dx_header, DNB, IRS5500, Business_Header, riskwise, doxie;

export get_BH_BQI_Stats_hist(dataset(Business_Risk.Layout_Output) biid,
                             doxie.IDataAccess mod_access) := FUNCTION

slim_layout := record
	unsigned seq;
	unsigned3 historydate;
	unsigned bdid;
	unsigned zip;
	string prim_name;
	string prim_range;
	string sec_range;
	string state;
end;


slim_layout append_best(biid le, business_header.key_bh_best rt) := transform
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.bdid := le.bdid;
	self.zip := rt.zip;
	self.prim_name := rt.prim_name;
	self.prim_range := rt.prim_range;
	self.sec_range := rt.sec_range;
	self.state := rt.state;
end;

// append the zip, prim_name and prim_range from the bh_best file
bdid_best_data := join(biid, business_header.key_bh_best,
						left.bdid!=0 and
						  keyed(left.bdid=right.bdid),
						  append_best(left, right),
						  ATMOST(keyed(left.bdid=right.bdid), RiskWise.max_atmost), keep(1), left outer);

bh_temp := record
	recordof(business_risk.Key_Business_Header_Address);
	unsigned3 historydate;
end;

bh := join(bdid_best_data, business_risk.Key_Business_Header_Address,
					left.prim_name!='' and
					keyed(right.zip=left.zip) and
					keyed(right.prim_name=left.prim_name) and
					keyed(right.prim_range=left.prim_range) and
					keyed(right.sec_range in ['', left.sec_range]) and
					(unsigned)((STRING)right.dt_first_seen)[1..6] <= left.historydate,
					transform(bh_temp,
									self := right,
									self.historydate := left.historydate),
					ATMOST(
						(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.zip) and
						 keyed(right.prim_range=left.prim_range) and keyed(right.sec_range in ['', left.sec_range])),5001 ),
					keep(5000));

bh_addr_all := DEDUP(SORT(bh, bdid, zip, prim_name, prim_range, sec_range),
							  bdid, zip, prim_name, prim_range, sec_range);

layout_full_stat := RECORD
	bh_addr_all.state;  // added state field so I can search gong history by address, which requires a state
	bh_addr_all.zip;
	bh_addr_all.prim_name;
	bh_addr_all.prim_range;
	bh_addr_all.sec_range;
	UNSIGNED4 bdid_per_addr := COUNT(GROUP);
	UNSIGNED4 apts := 0;
	UNSIGNED4 ppl := 0;
	UNSIGNED4 r_phone_per_addr := 0;
	UNSIGNED4 b_phone_per_addr := 0;
	bh_addr_all.historydate;
END;

bh_addr := TABLE(bh_addr_all, layout_full_stat, state, zip, prim_name, prim_range, sec_range);

// output(bh_addr, named('bh_addr'));

// no date first seen on this file, can't filter by history date at all
aparts := join(bh_addr, dx_header.Key_AptBuildings(),
			left.prim_name!='' and
					keyed((string)left.zip = right.zip)  and
					keyed(right.prim_name=left.prim_name) and
					keyed(right.prim_range=left.prim_range),
					transform(layout_full_stat, SELF.apts := right.apt_cnt,
												SELF.ppl := right.did_cnt,
												self := left),
					ATMOST(
						(keyed(right.prim_name=left.prim_name) and keyed((string)left.zip = RIGHT.zip) and
						 keyed(right.prim_range=left.prim_range)),RiskWise.max_atmost ),
					keep(500), left outer);

// output(aparts);


// Rollup in case of multiple predir/suffix
layout_full_stat Roll(aparts l, aparts r) := TRANSFORM
	SELF.apts := l.apts + r.apts;
	SELF.ppl := l.ppl + r.ppl;
	SELF := l;
END;

addr_with_people_roll := ROLLUP(
	group(SORT(aparts, zip, prim_name, prim_range, sec_range), zip, prim_name, prim_range, sec_range),
	LEFT.zip = RIGHT.zip AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.prim_range = RIGHT.prim_range and
	LEFT.sec_range = RIGHT.sec_range,
	Roll(LEFT, RIGHT));


// pull the full list of gong matches using the history date filters
gng_full := join(bh_addr, dx_Gong.key_history_address(),
					left.prim_name!='' and left.zip!=0 and
					(keyed(right.prim_name=left.prim_name) and keyed(right.st=left.state) and keyed(right.z5=(string)left.zip) and
					keyed(right.prim_range=left.prim_range)) and
					(right.sec_range = left.sec_range) and
					((unsigned)right.dt_first_seen[1..6] < left.historydate and
						 (RIGHT.current_flag OR
						 (unsigned)RIGHT.deletion_date[1..6] >= left.historydate )
						 ),

					transform(dx_Gong.layouts.i_history_address, self := right),
					ATMOST(
						(keyed(right.prim_name=left.prim_name) and keyed(right.st=left.state) and keyed(right.z5=(string)left.zip) and
						 keyed(right.prim_range=left.prim_range)),
						5001
					),
					keep(5000));


// Get residential phones per addr.
gng_res := gng_full(publish_code = 'P', listing_type_res <> '', z5 != '', prim_name != '');

gong_res_dist := DEDUP(
	SORT(gng_res,
	z5, prim_name, prim_range, sec_range, phone10),
	z5, prim_name, prim_range, sec_range, phone10);

layout_res_phones_per_addr := RECORD
	gong_res_dist.prim_range;
	gong_res_dist.prim_name;
	gong_res_dist.sec_range;
	gong_res_dist.z5;
	UNSIGNED4 r_phone_per_addr := COUNT(GROUP);
END;

gong_r_phone_per_addr := TABLE(gong_res_dist, layout_res_phones_per_addr, z5, prim_name, prim_range, sec_range);

// Get business/gov phones per addr.
gng_bus := gng_full(publish_code IN ['P','U'], listing_type_bus <> '', z5 != '', prim_name != '');
gong_bus_dist := DEDUP(
	SORT(gng_bus,
	z5, prim_name, prim_range, sec_range, phone10),
	z5, prim_name, prim_range, sec_range, phone10);

layout_bus_phones_per_addr := RECORD
	gong_bus_dist.prim_range;
	gong_bus_dist.prim_name;
	gong_bus_dist.sec_range;
	gong_bus_dist.z5;
	UNSIGNED4 b_phone_per_addr := COUNT(GROUP);
END;

gong_b_phone_per_addr := TABLE(gong_bus_dist, layout_bus_phones_per_addr, z5, prim_name, prim_range, sec_range);



stat2 := JOIN(addr_with_people_roll, gong_r_phone_per_addr,
	LEFT.zip = (UNSIGNED3) RIGHT.z5 AND
	LEFT.prim_name = (QSTRING28) RIGHT.prim_name AND
	LEFT.prim_range = (QSTRING10) RIGHT.prim_range AND
	LEFT.sec_range = (QSTRING8) RIGHT.sec_range,
	transform(layout_full_stat, self.r_phone_per_addr := right.r_phone_per_addr, self := left), LEFT OUTER, lookup);


// output(stat2, named('stat2'));

addr_all_rollup := JOIN(stat2, gong_b_phone_per_addr,
	LEFT.zip = (UNSIGNED3) RIGHT.z5 AND
	LEFT.prim_name = (QSTRING28) RIGHT.prim_name AND
	LEFT.prim_range = (QSTRING10) RIGHT.prim_range AND
	LEFT.sec_range = (QSTRING8) RIGHT.sec_range,
	transform(layout_full_stat, self.b_phone_per_addr := right.b_phone_per_addr, self := left), LEFT OUTER, lookup);


// ##################################################################

// ##################################################################
// Get information from DNB and IRS5500 per bdid.

// layout_bs_join := RECORD
	// unsigned zip;
	// string prim_name;
	// string prim_range;
	// unsigned bdid;
	// string9 dn;
	// string dnb_date_last_seen;
	// UNSIGNED4 dnb_emps := 0;
	// UNSIGNED4 irs5500_emps := 0;
	// string irs_date;
	// UNSIGNED4 domainss := 0;
	// UNSIGNED1 sources := 0;
	// BOOLEAN   has_gong_yp := FALSE;
	// BOOLEAN   current_corp := FALSE;
	// UNSIGNED6 best_phone := 0;
	// UNSIGNED1 company_name_score := 0;

	// UNSIGNED4 bdid_per_addr;
	// UNSIGNED4 apts;
	// UNSIGNED4 ppl;
	// UNSIGNED4 r_phone_per_addr;
	// UNSIGNED4 b_phone_per_addr;
// END;

with_address_counts := join(bdid_best_data, addr_all_rollup,
					right.zip=left.zip and
					right.prim_name=left.prim_name and
					right.prim_range=left.prim_range,
					transform(business_header.Layout_BQI_Stats,
									self.bdid := left.bdid,
									self.zip := left.zip,
									self.prim_name := left.prim_name,
									self.prim_range := left.prim_range,
									self := right,
									self := []), left outer, lookup);



l_temp := record
	business_header.Layout_BQI_Stats;
	string9 dn;
	string dnb_date_last_seen;
	string irs_date;
	unsigned3 historydate;
end;

l_temp append_dunsnumber(with_address_counts le, dnb.Key_DNB_BDID rt) := transform
	self.dn := rt.duns_number;
	self := le;
	self := [];
end;

duns_number := join(with_address_counts, dnb.key_dnb_bdid,
						  keyed(left.bdid=right.bd) and mod_access.use_DNB(),
						  append_dunsnumber(left, right),
						  ATMOST(keyed(left.bdid=right.bd), RiskWise.max_atmost), keep(1),
						  left outer);
 //output(duns_number);

bs_dnb := join(duns_number, dnb.key_DNB_DunsNum, left.dn!='' and
					keyed(left.dn=right.duns) and mod_access.use_DNB() and
					 right.active_duns_number = 'Y' and right.record_type = 'C' and
					 (unsigned)right.date_first_seen[1..6] < left.historydate,
					transform(l_temp,
							self.dnb_emps := IF( (INTEGER4) right.employees_total > 0,
													(UNSIGNED4) right.employees_total,
													IF((INTEGER4) right.employees_here > 0,
														(UNSIGNED4) right.employees_here,
														if(right.duns!='', 1, 0))
												),
							self.dnb_date_last_seen := right.date_last_seen,
							self := left), left outer,
							ATMOST(keyed(left.dn=right.duns),RiskWise.max_atmost),
					keep(100));

 //output(bs_dnb, named('bs_dnb'));

bs_dnb_dedup := DEDUP(SORT(bs_dnb, bdid, -dnb_date_last_seen), bdid);
// output(bs_dnb_dedup, named('bs_dnb_dedup'));



bs_irs := join(bs_dnb_dedup, irs5500.key_irs5500_bdid, left.bdid!=0 and
					keyed(left.bdid=right.bdid) and
					 (unsigned)right.form_plan_year_begin_date[1..6] < left.historydate,
					transform(l_temp,
							self.irs5500_emps := IF( (INTEGER4) right.tot_partcp_boy_cnt > 0,
													(UNSIGNED4) right.tot_partcp_boy_cnt,
													IF((INTEGER4) right.tot_active_partcp_cnt > 0,
														(UNSIGNED4) right.tot_active_partcp_cnt,
														if(right.bdid!=0,1,0))
												),
							self.irs_date := right.form_plan_year_begin_date,
							self := left), left outer,
							ATMOST(keyed(left.bdid=right.bdid),RiskWise.max_atmost),
					keep(100));

// output(bs_irs, named('bs_irs'));

bs_irs_dedup := DEDUP(SORT(bs_irs, bdid, -irs_date), bdid);
// output(bs_irs_dedup, named('bs_irs_dedup'));

// do this on the file, compare input company to best company somewhere
// SELF.company_name_score := ut.CompanySimilar(le.company_name, rt.company_name);
// business_header_ss.Key_BH_CompanyName(keyed(clean_company_name60=));


// Does a gong or yellow pages record exist?
// bs_has_gong := DEDUP(bh_source_ded(source IN ['GB', 'GG', 'Y']), bdid, LOCAL);
//SELF.has_gong_yp := r.bdid != 0;
//current_corp_cnt we can get from biid


/*
// Add best address
business_header.Layout_BQI_Stats Merge_results(with_address_counts l, bs_irs_dedup r) := transform
	self.zip := l.zip;
	self.prim_name := l.prim_name;
	self.prim_range := l.prim_range;
	// self.gong_yp_cnt := if(l.has_gong_yp, 1, 0);
	// self.current_corp_cnt := if(l.current_corp, 1, 0);
	self.bdid_per_addr := l.bdid_per_addr;
	self.apts := l.apts;
	self.ppl := l.ppl;
	self.r_phone_per_addr := l.r_phone_per_addr;
	self.b_phone_per_addr := l.b_phone_per_addr;

	self := r;
	self := [];

	// SELF.combined_score := 0 +
		// IF(l.b_phone_per_addr > l.r_phone_per_addr, 2,
			// IF(l.b_phone_per_addr > 0, 1, 0)) +
		// IF(l.dnb_emps + l.irs5500_emps > l.ppl, 5, 0) +
		// IF(l.domainss > 1, 2 ,0) +
		// IF(l.bdid_per_addr > l.apts, 2, 0) +
		// IF(l.company_name_score > 10, 2,
			// IF(l.company_name_score > 1, 1, 0)) +
		// IF(l.sources > 4, 1, 0) +
		// IF(l.gong_yp_cnt > 0, 2, 0) +
		// IF(l.current_corp_cnt > 0, 2, 0);
end;




bqi_stats := join(with_address_counts, bs_irs_dedup,
					left.zip = right.zip  and
					left.prim_name=right.prim_name and
					left.prim_range=right.prim_range,
				  merge_results(left,right), keep(1));

// output(bqi_stats);
*/

bqi_stats := project(bs_irs_dedup, transform(business_header.Layout_BQI_Stats, self := left));

// output(gong_r_phone_per_addr, named('gong_r_phone_per_addr'));
// output(gong_b_phone_per_addr, named('gong_b_phone_per_addr'));
// output(bdid_best_data, named('bdid_best_data'));
// output(bh, named('bh'));
// output(bh_addr, named('bh_addr'));
// output(addr_with_people_roll, named('addr_with_people_roll'));
// output(addr_all_rollup, named('addr_all_rollup'));
// output(with_address_counts, named('with_address_counts'));
// output(gng_full, named('gng_full'));


	return bqi_stats;
end;
