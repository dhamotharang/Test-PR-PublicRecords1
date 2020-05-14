﻿import RiskWise, Gong, ut, business_header_ss, mdr, std, Doxie, Suppress, Business_Risk;

export getBDIDTable_Hist(dataset(Business_Risk.Layout_Output) biid, unsigned1 glb,
                                              doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

// instead of using the bdid_table, and bdid_risk_table, which aren't historical,
// we need to search all sources on those tables by bdid, and filter the raw data by the history_date.

// then, do the rollup and counts for all the fields that those tables have
// if the source doesn't have a history date, like yellow pages for example, use the current data

todays_date := (STRING8)Std.Date.Today();

layout_out := record
	unsigned4  seq := 0;
	unsigned3 historydate;
	unsigned6 bdid := 0;
	Business_Risk.Layout_Profile_Risk_model;
end;


bqi_stat := business_risk.get_BH_BQI_Stats_hist(biid, mod_access);

layout_out append_bqi(biid le, bqi_stat rt) := transform
	self.seq := le.seq,
	self.historydate := le.historydate;
	self.bdid := le.bdid,
	// ofac_cnt set to 1 if biid got ofac hit instead of doing another search against the patriot file by bdid
	self.ofac_cnt := if(le.watchlist_record_number[1..4] IN ['OFAC', 'OFC'], 1, 0);
	
	// these are the fields that couldn't be done in the bqi_stats_hist function, 
	// do them down at the bottom after all the header sources have been counted
	// SELF.company_name_score := ut.CompanySimilar(le.company_name, rt.company_name);
	// SELF.has_gong_yp := r.bdid != 0;
	// self.current_corp_cnt we can get from biid
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
	
	self := rt;	
end;



// append the zip, prim_name and prim_range from the bh_best file
bdid_tbl_init := join(biid, bqi_stat,
						left.bdid!=0 and 
						  left.bdid=right.bdid,
						  append_bqi(left, right), keep(1));

kgh := gong.Key_History_BDID;
layout_gong_slim := record
	kgh.bdid;
	kgh.phone10;
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	kgh.current_record_flag;
	unsigned4 deletion_date;
	kgh.disc_cnt6;
	kgh.disc_cnt12;
	kgh.disc_cnt18;
end;

gh_slim_unsuppressed := join(biid, kgh,
				 left.bdid!=0 and 
				  keyed(left.bdid=right.bdid) and 
				 (unsigned)right.dt_first_seen[1..6] < left.historydate,
				 transform({layout_gong_slim, UNSIGNED4 global_sid, UNSIGNED6 did}, self.dt_first_seen := (unsigned4)right.dt_first_seen,
											 self.dt_last_seen := (unsigned4)right.dt_last_seen,
											 self.deletion_date := (unsigned4)right.deletion_date,
											 self := right),
				 ATMOST(keyed(left.bdid=right.bdid), RiskWise.max_atmost), keep(1000));

gh_slim := Suppress.Suppress_ReturnOldLayout(gh_slim_unsuppressed, mod_access, layout_gong_slim);

layout_gong_history_stats := record
	gh_slim.bdid;
	unsigned4 dt_first_seen_G := min(group, if(gh_slim.dt_first_seen = 0, 99999999, gh_slim.dt_first_seen));
	unsigned4 dt_last_seen_G := max(group, gh_slim.dt_last_seen);
	unsigned1 gong_current_record_count := count(group, gh_slim.current_record_flag = 'Y');
	unsigned4 gong_deletion_date := max(group, gh_slim.deletion_date);
	unsigned2 gong_disc_cnt6 := sum(group, gh_slim.disc_cnt6);
	unsigned2 gong_disc_cnt12 := sum(group, gh_slim.disc_cnt12);
	unsigned2 gong_disc_cnt18 := sum(group, gh_slim.disc_cnt18);
end;

gh_stats := table(gh_slim, layout_gong_history_stats, bdid);

layout_out AppendGongStats(layout_out l, layout_gong_history_stats r) := transform
	self.dt_first_seen_G := if(r.dt_first_seen_G = 99999999, 0, r.dt_first_seen_G);
	self.dt_last_seen_G := r.dt_last_seen_G;
	self.gong_current_record_flag := if(r.gong_current_record_count > 0, 'Y', 'N');
	self.gong_deletion_date := r.gong_deletion_date;
	self.gong_disc_cnt6 := r.gong_disc_cnt6;
	self.gong_disc_cnt12 := r.gong_disc_cnt12;
	self.gong_disc_cnt18 := r.gong_disc_cnt18;
	self := l;
end;

// join the gong history stats to our init table
bdid_tbl_gong := join(bdid_tbl_init,
                      gh_stats,
					  left.bdid = right.bdid,
					  AppendGongStats(left, right),
					  left outer, lookup);


// kbh := business_risk.Key_Business_Header_BDID;
kbh := Business_Header_SS.Key_BH_BDID_pl;

bh := join(biid, kbh,
				 left.bdid!=0 and 
				  keyed(left.bdid=right.bdid) and 
					ut.PermissionTools.glb.SrcOk(glb, right.source, right.dt_first_seen) and
				 (unsigned)((STRING)right.dt_first_seen)[1..6] < left.historydate, 
				 transform(recordof(kbh), self := right),
				 ATMOST(keyed(left.bdid=right.bdid), RiskWise.max_atmost), keep(1000));

// output(bh);

layout_bh_stat := record
	bh.bdid;
	unsigned4 dt_first_seen_min := min(group, map(bh.dt_first_seen = 0 => 99999999,
												  bh.dt_first_seen <= 9999 => bh.dt_first_seen * 10000,
										 bh.dt_first_seen));  // fix for D&B problem with year only
	//unsigned4 dt_first_seen_min := min(group, if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen));   // min for all base records
	unsigned4 dt_last_seen_max := max(group, if(bh.dt_last_seen <= 9999 and bh.dt_last_seen > 0, bh.dt_last_seen * 10000, bh.dt_last_seen));    // max for all base records
	//unsigned4 dt_last_seen_max := max(group, bh.dt_last_seen);    // max for all base records
	unsigned4 dt_vendor_first_reported_min := min(group, map(bh.dt_vendor_first_reported = 0 => 99999999,
												  bh.dt_vendor_first_reported <= 9999 => bh.dt_vendor_first_reported * 10000,
										 bh.dt_vendor_first_reported));  // fix for D&B problem with year only
	//unsigned4 dt_vendor_first_reported_min := min(group, if(bh.dt_vendor_first_reported = 0, 99999999, bh.dt_vendor_first_reported)); // min for all base records
	unsigned4 dt_first_seen_Y := min(group, if(mdr.sourcetools.SourceIsYellow_Pages(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a current YP record
	unsigned4 dt_last_seen_Y := max(group, if(mdr.sourcetools.SourceIsYellow_Pages(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_C := min(group, if(mdr.sourcetools.SourceIsCorpV2(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Corp record
	unsigned4 dt_last_seen_C := max(group, if(mdr.sourcetools.SourceIsCorpV2(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_BR := min(group, if(mdr.sourcetools.SourceIsBusiness_Registration(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Business Registration record
	unsigned4 dt_last_seen_BR := max(group, if(mdr.sourcetools.SourceIsBusiness_Registration(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_UCC := min(group, if(mdr.sourcetools.SourceIsUCCS(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a UCC record
	unsigned4 dt_last_seen_UCC := max(group, if(mdr.sourcetools.SourceIsUCCS(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_D := min(group, if(mdr.sourcetools.SourceIsDunn_Bradstreet(bh.source) and bh.fein = 0, map(bh.dt_first_seen = 0 => 99999999,
												  bh.dt_first_seen <= 9999 => bh.dt_first_seen * 10000,
										 bh.dt_first_seen), 99999999));// min for a D&B record

	//unsigned4 dt_first_seen_D := min(group, if(bh.source = 'D' and bh.fein = 0, if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a D&B record
	unsigned4 dt_last_seen_D := max(group, if(mdr.sourcetools.SourceIsDunn_Bradstreet(bh.source) and bh.fein = 0, if(bh.dt_last_seen <= 9999 and bh.dt_last_seen > 0, bh.dt_last_seen * 10000, bh.dt_last_seen), 0));
	//unsigned4 dt_last_seen_D := max(group, if(bh.source = 'D' and bh.fein = 0, bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_I := min(group, if(mdr.sourcetools.SourceIsIRS_5500(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a IRS5500 record
	unsigned4 dt_last_seen_I := max(group, if(mdr.sourcetools.SourceIsIRS_5500(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_ST := min(group, if(mdr.sourcetools.SourceIsState_Sales_Tax(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Sales Tax record
	unsigned4 dt_last_seen_ST := max(group, if(mdr.sourcetools.SourceIsState_Sales_Tax(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_last_seen_B := max(group, if(mdr.sourcetools.SourceIsBankruptcy(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_last_seen_LJ := max(group, if(mdr.sourcetools.SourceIsLiens_and_Judgments(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_BM := min(group, if(mdr.sourcetools.SourceIsBBB_Member(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a BBB Member record
	unsigned4 dt_last_seen_BM := max(group, if(mdr.sourcetools.SourceIsBBB_Member(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_BN := min(group, if(mdr.sourcetools.SourceIsBBB_Non_Member(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a BBB Non Member record
	unsigned4 dt_last_seen_BN := max(group, if(mdr.sourcetools.SourceIsBBB_Non_Member(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_IA := min(group, if(mdr.sourcetools.SourceIsINFOUSA_ABIUS_USABIZ(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a InfoUSA record
	unsigned4 dt_last_seen_IA := max(group, if(mdr.sourcetools.SourceIsINFOUSA_ABIUS_USABIZ(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_DC := min(group, if(mdr.sourcetools.SourceIsDCA(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a DCA record
	unsigned4 dt_last_seen_DC := max(group, if(mdr.sourcetools.SourceIsDCA(bh.source), bh.dt_last_seen, 0));
	unsigned4 dt_first_seen_EB := min(group, if(mdr.sourcetools.SourceIsEBR(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Experian Business Header record
	unsigned4 dt_last_seen_EB := max(group, if(mdr.sourcetools.SourceIsEBR(bh.source), bh.dt_last_seen, 0));
	unsigned3 cnt_base := count(group); // base record count
	unsigned2 cnt_AE := count(group, mdr.sourcetools.SourceIsExperianVehicle(bh.source)); // Experian Vehicles
	unsigned2 cnt_AF := count(group, mdr.sourcetools.SourceIsATF(bh.source)); // ATF Firearms and Explosives
	unsigned2 cnt_AT := count(group, mdr.sourcetools.SourceIsAccurint_Trade_Show(bh.source)); // Accurint Trade Show
	unsigned2 cnt_AW := count(group, mdr.sourcetools.SourceIsWC(bh.source)); // Watercraft
	unsigned2 cnt_B  := count(group, mdr.sourcetools.SourceIsBankruptcy(bh.source));  // Bankruptcy
	unsigned2 cnt_BM := count(group, mdr.sourcetools.SourceIsBBB_Member(bh.source)); // BBB Member
	unsigned2 cnt_BN := count(group, mdr.sourcetools.SourceIsBBB_Non_Member(bh.source)); // BBB Non-Member
	unsigned2 cnt_BR := count(group, mdr.sourcetools.SourceIsBusiness_Registration(bh.source)); // Business Registration
	unsigned2 cnt_C  := count(group, mdr.sourcetools.SourceIsCorpV2(bh.source));  // Corporate
	unsigned2 cnt_CU := count(group, mdr.sourcetools.SourceIsCredit_Unions(bh.source)); // Credit Unions
	unsigned2 cnt_D  := count(group, mdr.sourcetools.SourceIsDunn_Bradstreet(bh.source));  // Dun & Bradstreet
	unsigned2 cnt_DC := count(group, mdr.sourcetools.SourceIsDCA(bh.source)); // DCA
	unsigned2 cnt_DE := count(group, mdr.sourcetools.SourceIsDea(bh.source)); // DEA
	unsigned2 cnt_E  := count(group, mdr.sourcetools.SourceIsEdgar(bh.source));  // Edgar
	unsigned2 cnt_EB := count(group, mdr.sourcetools.SourceIsEBR(bh.source)); // Experian Business
	unsigned2 cnt_ED := count(group, mdr.sourcetools.SourceIsEmployee_Directories(bh.source)); // Employee Directories
	unsigned2 cnt_F  := count(group, mdr.sourcetools.SourceIsFBNV2(bh.source));  // Fictitious Business Names
	unsigned2 cnt_FA := count(group, mdr.sourcetools.SourceIsFAA(bh.source)); // FAA Aircraft Registrations
	unsigned2 cnt_FC := count(group, mdr.sourcetools.SourceIsFCC_Radio_Licenses(bh.source)); // FCC Radio Licenses
	unsigned2 cnt_FD := count(group, mdr.sourcetools.SourceIsFDIC(bh.source)); // FDIC
	unsigned2 cnt_FF := count(group, mdr.sourcetools.SourceIsFL_FBN(bh.source)); // Florida FBN
	unsigned2 cnt_FN := count(group, mdr.sourcetools.SourceIsFL_Non_Profit(bh.source)); // Florida Non-Profit
	unsigned2 cnt_GB := count(group, mdr.sourcetools.SourceIsGong_Business(bh.source)); // Gong Business
	unsigned2 cnt_GG := count(group, mdr.sourcetools.SourceIsGong_Government(bh.source)); // Gong Government
	unsigned2 cnt_I  := count(group, mdr.sourcetools.SourceIsIRS_5500(bh.source));  // IRS 5500
	unsigned2 cnt_IA := count(group, mdr.sourcetools.SourceIsINFOUSA_ABIUS_USABIZ(bh.source)); // INFOUSA ABIUS(USABIZ)
	unsigned2 cnt_ID := count(group, mdr.sourcetools.SourceIsINFOUSA_DEAD_COMPANIES(bh.source)); // INFOUSA DEAD COMPANIES
	unsigned2 cnt_IF := count(group, mdr.sourcetools.SourceIsFBNV2(bh.source)); // INFOUSA FBNS
	unsigned2 cnt_II := count(group, mdr.sourcetools.SourceIsINFOUSA_IDEXEC(bh.source)); // INFOUSA IDEXEC
	unsigned2 cnt_IN := count(group, mdr.sourcetools.SourceIsIRS_Non_Profit(bh.source)); // IRS Non-Profit
	unsigned2 cnt_LJ := count(group, mdr.sourcetools.SourceIsLiens_and_Judgments(bh.source)); // Liens and Judgments
	unsigned2 cnt_LB := count(group, mdr.sourcetools.SourceIsLobbyists(bh.source)); // Lobbyists
	unsigned2 cnt_LP := count(group, mdr.sourcetools.SourceIsLnPropV2_Lexis_Deeds_Mtgs(bh.source)); // LN Property
	unsigned2 cnt_MD := count(group, mdr.sourcetools.SourceIsAMIDIR(bh.source));  // Medical Information Directory
	unsigned2 cnt_MV := count(group, mdr.sourcetools.SourceIsDirectVehicle(bh.source));  // Motor Vehicles
	unsigned2 cnt_PL := count(group, mdr.sourcetools.SourceIsProfessional_License(bh.source)); // Professional Licenses
	unsigned2 cnt_PR := count(group, mdr.Sourcetools.SourceIsProperty(bh.source)); //this PR code going away DGL 8/21/09 bh.source='PR'); // Property File
	unsigned2 cnt_SB := count(group, mdr.Sourcetools.SourceIsSEC_Broker_Dealer(bh.source)); // SEC Broker/Dealer
	unsigned2 cnt_SK := count(group, mdr.sourcetools.SourceIsSKA(bh.source)); // SK&A Medical Professionals
	unsigned2 cnt_ST := count(group, mdr.sourcetools.SourceIsState_Sales_Tax(bh.source)); // State Sales Tax
	unsigned3 cnt_U  := count(group, mdr.sourcetools.SourceIsUCCS(bh.source));  // UCC
	unsigned2 cnt_V  := count(group, mdr.sourcetools.SourceIsVickers(bh.source));  // Vickers
	unsigned2 cnt_W  := count(group, mdr.sourcetools.SourceIswhois_domains(bh.source));  // Domain Registrations (WHOIS)
	unsigned2 cnt_WC := count(group, mdr.sourcetools.SourceIsWorkmans_Comp(bh.source)); // State Workers Comp
	unsigned2 cnt_WT := count(group, mdr.sourcetools.SourceIsWither_and_Die(bh.source)); // Wither and Die
	unsigned2 cnt_Y  := count(group, mdr.sourcetools.SourceIsYellow_Pages(bh.source));  // Yellow Pages
	
end;

bh_stat := table(bh, layout_bh_stat, bdid);

// output(bh_stat);


// Check for date in last 6 months
boolean CheckDateLast6Mos(unsigned4 date) := if(date <> 0,
                                             ut.DaysApart((string8)intformat(date, 8, 1), todays_date) <= 183,
											 false);

// Check for date in last year					
boolean CheckDateLastYr(unsigned4 date) := if(date <> 0,
                                             ut.DaysApart((string8)intformat(date, 8, 1), todays_date) <= 365,
											 false);

// Current Year with offset
unsigned2 CurrentYearOffset(integer1 offset) := (integer)(todays_date[1..4]) + offset;

// Current End of Year with offset											 
unsigned4 CurrentYearEndOffset(integer1 offset) :=  (((integer)(todays_date[1..4]) + offset) * 10000) + 1231;

layout_out_final := record
	layout_out - historydate;
end;

layout_out_final Append_Header_Stats(layout_out l, layout_bh_stat r) := transform
	self.seq := l.seq;
	self.bdid := l.bdid;
	
	SELF.domainss := r.cnt_W;
	// self.source_ct := r.cnt_base;
	self.dt_first_seen_Y := if(r.dt_first_seen_Y = 99999999, 0, r.dt_first_seen_Y);
	self.dt_first_seen_C := if(r.dt_first_seen_C = 99999999, 0, r.dt_first_seen_C);
	self.dt_first_seen_BR := if(r.dt_first_seen_BR = 99999999, 0, r.dt_first_seen_BR);
	self.dt_first_seen_UCC := if(r.dt_first_seen_UCC = 99999999, 0, r.dt_first_seen_UCC);
	self.dt_first_seen_D := if(r.dt_first_seen_D = 99999999, 0, r.dt_first_seen_D);
	self.dt_first_seen_I := if(r.dt_first_seen_I = 99999999, 0, r.dt_first_seen_I);
	self.dt_first_seen_ST := if(r.dt_first_seen_ST = 99999999, 0, r.dt_first_seen_ST);
	self.dt_first_seen_BM := if(r.dt_first_seen_BM = 99999999, 0, r.dt_first_seen_BM);
	self.dt_first_seen_BN := if(r.dt_first_seen_BN = 99999999, 0, r.dt_first_seen_BN);
	self.dt_first_seen_IA := if(r.dt_first_seen_IA = 99999999, 0, r.dt_first_seen_IA);
	self.dt_first_seen_DC := if(r.dt_first_seen_DC = 99999999, 0, r.dt_first_seen_DC);
	self.dt_first_seen_EB := if(r.dt_first_seen_EB = 99999999, 0, r.dt_first_seen_EB);
	self.dt_first_seen_min := if(r.dt_first_seen_min = 99999999, 0, r.dt_first_seen_min);
	self.dt_vendor_first_reported_min := if(r.dt_vendor_first_reported_min = 99999999, 0, r.dt_vendor_first_reported_min);
	
	// SELF.company_name_score := ut.CompanySimilar(le.company_name, rt.company_name);
	// SELF.has_gong_yp := r.bdid != 0;
	// self.current_corp_cnt we can get from biid
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
	
	
	self.gong_yp_cnt := if(r.cnt_gb>0,1,0) + if(r.cnt_gg>0,1,0) + if(r.cnt_y>0,1,0);
	
	// this section of the transform is from BDID_risk_table InitBDIDRiskTable
		self.PRScore_date := if(l.historydate=999999, (unsigned4)todays_date, (unsigned4)((string)l.historydate + '01') );
		busregf := if(r.cnt_BR > 0, 1, 0);
		self.busreg_flag := busregf;
		
		corpf := if(r.cnt_C > 0, 1, 0);
		self.corp_flag := corpf;
		
		dnbf := if(r.cnt_D > 0, 1, 0);
		self.dnb_flag := dnbf;
		
		irs5500f := if(r.cnt_I > 0, 1, 0);
		self.irs5500_flag := irs5500f;
		
		stf := if(r.cnt_ST > 0, 1, 0);
		self.st_flag := stf;
		
		uccf := if(r.cnt_U > 0, 1, 0);
		self.ucc_flag := uccf;
		
		ypf := if(r.cnt_Y > 0, 1, 0);
		self.yp_flag := ypf;
		
		tier1 :=  busregf +
				  corpf +
				  dnbf +
				  irs5500f +
				  stf +
				  uccf +
				  ypf;
		self.tier1srcs := tier1;
		
		t1scr5 := if(tier1 > 5, 5, tier1);
		self.t1scr5 := t1scr5;
		
		currphn := if(CheckDateLast6Mos(l.dt_last_seen_G), 1, 0);
		self.currphn := currphn;
		
		currcorp := if(CheckDateLastYr(r.dt_last_seen_C), 1, 0);
		self.currcorp := currcorp;
		
		currbr := if(CheckDateLastYr(r.dt_last_seen_BR), 1, 0);
		self.currbr := currbr;
		
		currdnb := if(CheckDateLastYr(r.dt_last_seen_D), 1, 0);
		self.currdnb := currdnb;
		
		currucc := if(CheckDateLastYr(r.dt_last_seen_UCC), 1, 0);
		self.currucc := currucc;
		
		curry := if(CheckDateLastYr(r.dt_last_seen_Y), 1, 0);
		self.curry := curry;
		
		ct1cnt := currcorp + currbr + currdnb + currucc  + curry;
		self.currt1cnt := ct1cnt;
		
		ct1scrc4 := if(ct1cnt > 4, 4, ct1cnt);		
		self.currt1src4 := ct1scrc4;
		
		
		ylj := map(l.dt_last_seen_lj = 0 => 0,
							l.dt_last_seen_lj < 18999999 => 1,
							l.dt_last_seen_lj < CurrentYearEndOffset(-6) => CurrentYearOffset(-6),
							l.dt_last_seen_lj < CurrentYearEndOffset(-5) => CurrentYearOffset(-5),
							l.dt_last_seen_lj < CurrentYearEndOffset(-4) => CurrentYearOffset(-4),
							l.dt_last_seen_lj < CurrentYearEndOffset(-3) => CurrentYearOffset(-3),
							l.dt_last_seen_lj < CurrentYearEndOffset(-2) => CurrentYearOffset(-2),
							l.dt_last_seen_lj < CurrentYearEndOffset(-1) => CurrentYearOffset(-1),
							l.dt_last_seen_lj < CurrentYearEndOffset(-0) => CurrentYearOffset(0),
							CurrentYearOffset(1));
		self.year_lj := ylj;
		
		clj := map(l.cnt_LJ > 0 and ylj <= CurrentYearOffset(-5) => 3,
					   l.cnt_LJ > 0 and ylj = CurrentYearOffset(-4) => 2,
					   l.cnt_LJ > 0 and ylj <= CurrentYearOffset(-1) => 1,
					   0);
		self.lj := clj; 
			
		ustic := if((uccf + stf + irs5500f + corpf) > 0, 1, 0);	
		self.ustic := ustic;
		
		t1x := map(ct1scrc4 = 0 => 0,
						ct1scrc4 = 1 => 1,
						ct1scrc4 = 2 and t1scr5 < 5 => 2,
						3);
		self.t1x := t1x;
						
	
	// this section was from the bdid_risk_table CalcScore transform
		unsigned1 score := map(l.OFAC_cnt > 0 => 50,
                       r.cnt_B > 0 or (clj = 1 and t1x = 0) => 60,
					   clj = 1 and t1x < 3 => 65,
					   clj = 1 => 70,
					   clj = 2 and t1x=0 => 65,
					   clj = 2 and t1x < 3 => 70,
					   clj = 2 => 80,
					   t1x = 0 => 70,
					   t1x = 1 => 80,
					   t1x = 2 => 90,
					   t1x = 3 => 95,
					   50);
					   
		unsigned1 score1 := map(score in [60, 65, 90, 95] and currphn > 0 => score + 5,
								score in [70, 80] and currphn > 0 => score + 10,
								score);
							
		self.PRScore := map(score1 in [70, 80, 90] and ustic > 0 => score1 + 5,
							score1 = 95 and ustic > 0 and currphn > 0 => score1 + 5,
							score1);
					
	self := r;
	self := l;
end;

fscores := join(bdid_tbl_gong,
                      bh_stat,
					  left.bdid = right.bdid,
					  Append_Header_Stats(left, right),
					  left outer, lookup);

	

// output(bdid_tbl_init, named('bdid_tbl_init'));
// output(bdid_tbl_gong, named('bdid_tbl_gong'));
// output(bh_stat, named('bh_stat'));

	return fscores;
end;