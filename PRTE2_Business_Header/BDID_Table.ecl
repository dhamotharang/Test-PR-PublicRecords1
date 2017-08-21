import Business_Header, Prte2_Gong, mdr;

// Stats by BDID for use in determining Business Risk

Layout_BDID_Risk_Table := record
Business_Header.Layout_BQI_Stats;
// dates
unsigned4 dt_first_seen_min := 0;   // min for all base records
unsigned4 dt_last_seen_max := 0;    // max for all base records
unsigned4 dt_vendor_first_reported_min := 0; // min for all base records
unsigned4 dt_first_seen_Y := 0; // min for a current YP record
unsigned4 dt_last_seen_Y := 0; // max for a current YP record
unsigned4 dt_first_seen_G := 0;// min for a current Gong record
unsigned4 dt_last_seen_G := 0;// max for a current Gong record
unsigned4 dt_first_seen_C := 0;// min for a Corporate record
unsigned4 dt_last_seen_C := 0;// max for a Corporate record
unsigned4 dt_first_seen_BR := 0;// min for a Business Registration record
unsigned4 dt_last_seen_BR := 0;// max for a Business Registration record
unsigned4 dt_first_seen_UCC := 0;// min for a UCC record
unsigned4 dt_last_seen_UCC := 0;// max for a UCC record
unsigned4 dt_first_seen_D := 0;// min for a D&B record
unsigned4 dt_last_seen_D := 0;// max for a D&B record
unsigned4 dt_first_seen_I := 0;// min for a IRS5500 record
unsigned4 dt_last_seen_I := 0;// max for a IRS5500 record
unsigned4 dt_first_seen_ST := 0;// min for a Sales Tax record
unsigned4 dt_last_seen_ST := 0;// max for a Sales Tax record
unsigned4 dt_last_seen_B := 0;// max for a Bankruptcy record
unsigned4 dt_last_seen_LJ := 0;// max for a Liens Judgment record
unsigned4 dt_first_seen_BM := 0;// min for a BBB member record
unsigned4 dt_last_seen_BM := 0;// max for a BBB member record
unsigned4 dt_first_seen_BN := 0;// min for a BBB non-member record
unsigned4 dt_last_seen_BN := 0;// max for a BBB non-member record
unsigned4 dt_first_seen_IA := 0;// min for a InfoUSA record
unsigned4 dt_last_seen_IA := 0;// max for a InfoUSA record
unsigned4 dt_first_seen_DC := 0;// min for a DCA record
unsigned4 dt_last_seen_DC := 0;// max for a DCA record
unsigned4 dt_first_seen_EB := 0;// min for a Experian Business Header record
unsigned4 dt_last_seen_EB := 0;// max for a Experian Business Header record
// Gong indicators
string1 gong_current_record_flag := 'N';  
unsigned4 gong_deletion_date := 0;
unsigned2 gong_disc_cnt6 := 0;
unsigned2 gong_disc_cnt12 := 0;
unsigned2 gong_disc_cnt18 := 0;
// source record counts
unsigned3 cnt_base := 0; // base record count
unsigned2 cnt_AE := 0; // Experian Vehicles
unsigned2 cnt_AF := 0; // ATF Firearms and Explosives
unsigned2 cnt_AT := 0; // Accurint Trade Show
unsigned2 cnt_AW := 0; // Watercraft
unsigned2 cnt_B  := 0; // Bankruptcy
unsigned2 cnt_BM := 0; // BBBB Members
unsigned2 cnt_BN := 0; // BBB Non-Members
unsigned2 cnt_BR := 0; // Business Registration
unsigned2 cnt_C  := 0; // Corporate
unsigned2 cnt_CU := 0; // Credit Unions
unsigned2 cnt_D  := 0; // Dun & Bradstreet
unsigned2 cnt_DC := 0; // DCA - Directory of Corporate Affiliations
unsigned2 cnt_DE := 0; // DEA
unsigned2 cnt_E  := 0; // Edgar
unsigned2 cnt_EB := 0; // Experian Business Header
unsigned2 cnt_ED := 0; // Employee Directories
unsigned2 cnt_F  := 0; // Fictitious Business Names
unsigned2 cnt_FA := 0; // FAA Aircraft Registrations
unsigned2 cnt_FC := 0; // FCC Radio Licenses
unsigned2 cnt_FD := 0; // FDIC
unsigned2 cnt_FF := 0; // Florida FBN
unsigned2 cnt_FN := 0; // Florida Non-Profit
unsigned2 cnt_GB := 0; // Gong Business
unsigned2 cnt_GG := 0; // Gong Government
unsigned2 cnt_I  := 0; // IRS 5500
unsigned2 cnt_IA := 0; // INFOUSA ABIUS(USABIZ)
unsigned2 cnt_ID := 0; // INFOUSA DEAD COMPANIES
unsigned2 cnt_IF := 0; // INFOUSA FBNS
unsigned2 cnt_II := 0; // INFOUSA IDEXEC
unsigned2 cnt_IN := 0; // IRS Non-Profit
unsigned2 cnt_LJ := 0; // Liens and Judgments
unsigned2 cnt_LB := 0; // Lobbyists
unsigned2 cnt_LP := 0; // LN Property
unsigned2 cnt_MD := 0; // Medical Information Directory
unsigned2 cnt_MV := 0; // Motor Vehicles
unsigned2 cnt_PL := 0; // Professional Licenses
unsigned2 cnt_PR := 0; // Property File
unsigned2 cnt_SB := 0; // SEC Broker/Dealer
unsigned2 cnt_SK := 0; // SK&A Medical Professionals
unsigned2 cnt_ST := 0; // State Sales Tax
unsigned3 cnt_U  := 0; // UCC
unsigned2 cnt_V  := 0; // Vickers
unsigned2 cnt_W  := 0; // Domain Registrations (WHOIS)
unsigned2 cnt_WC := 0; // State Workers Comp
unsigned2 cnt_WT := 0; // Wither and Die
unsigned2 cnt_Y  := 0; // Yellow Pages
end;

bdid_tbl_init := project(Prte2_Business_Header.BH_BQI_Stats, transform(Layout_BDID_Risk_Table, self := left));

// Get Gong History Stats
gh := PRTE2_Gong.Files.file_Gong_History(bdid <> 0);

layout_gong_slim := record
gh.bdid;
gh.phone10;
unsigned4 dt_first_seen := (unsigned4)gh.dt_first_seen;
unsigned4 dt_last_seen := (unsigned4)gh.dt_last_seen;
gh.current_record_flag;
unsigned4 deletion_date := (unsigned4)gh.deletion_date;
gh.disc_cnt6;
gh.disc_cnt12;
gh.disc_cnt18;
end;

gh_slim := table(gh,layout_gong_slim);

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

Layout_BDID_Risk_Table AppendGongStats(Layout_BDID_Risk_Table l, layout_gong_history_stats r) := transform
self.dt_first_seen_G := if(r.dt_first_seen_G = 99999999, 0, r.dt_first_seen_G);
self.dt_last_seen_G := r.dt_last_seen_G;
self.gong_current_record_flag := if(r.gong_current_record_count > 0, 'Y', 'N');
self.gong_deletion_date := r.gong_deletion_date;
self.gong_disc_cnt6 := r.gong_disc_cnt6;
self.gong_disc_cnt12 := r.gong_disc_cnt12;
self.gong_disc_cnt18 := r.gong_disc_cnt18;
self := l;
end;

bdid_tbl_gong := join(bdid_tbl_init,
                      gh_stats,
					  left.bdid = right.bdid,
					  AppendGongStats(left, right),
					  left outer,
					  hash);

bh := Prte2_Business_Header.Files().Base.Business_Headers.built;

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
//unsigned4 dt_vendor_first_reported_min := min(group, if(bh.dt_vendor_first_reported = 0, 99999999, bh.dt_vendor_first_reported)); // min for all base records S
unsigned4 dt_first_seen_Y := min(group, if(mdr.sourcetools.SourceIsYellow_Pages(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a current YP record
unsigned4 dt_last_seen_Y := max(group, if(mdr.sourcetools.SourceIsYellow_Pages(bh.source), bh.dt_last_seen, 0));
unsigned4 dt_first_seen_C := min(group, if(mdr.sourcetools.SourceIsCorpV2(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Corp record
unsigned4 dt_last_seen_C := max(group, if(mdr.sourcetools.sourceIsCorpV2(bh.source), bh.dt_last_seen, 0));
unsigned4 dt_first_seen_BR := min(group, if(mdr.sourcetools.SourceIsBusiness_Registration(bh.source) , if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Business Registration record
unsigned4 dt_last_seen_BR := max(group, if(mdr.sourcetools.SourceIsBusiness_Registration(bh.source) , bh.dt_last_seen, 0));
unsigned4 dt_first_seen_UCC := min(group, if(mdr.sourcetools.SourceIsUCCS(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a UCC record
unsigned4 dt_last_seen_UCC := max(group, if(mdr.sourcetools.SourceIsUCCS(bh.source), bh.dt_last_seen, 0));
unsigned4 dt_first_seen_D := min(group, if(mdr.sourcetools.SourceIsDunn_Bradstreet(bh.source)  and bh.fein = 0, map(bh.dt_first_seen = 0 => 99999999,
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
unsigned4 dt_first_seen_IA := min(group, if(mdr.sourcetools.SourceIsInfousa(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a InfoUSA record
unsigned4 dt_last_seen_IA := max(group, if(mdr.sourcetools.SourceIsInfousa(bh.source), bh.dt_last_seen, 0));
unsigned4 dt_first_seen_DC := min(group, if(mdr.sourcetools.SourceIsDCA(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a DCA record
unsigned4 dt_last_seen_DC := max(group, if(mdr.sourcetools.SourceIsDCA(bh.source), bh.dt_last_seen, 0));
unsigned4 dt_first_seen_EB := min(group, if(mdr.sourcetools.SourceIsEBR(bh.source), if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Experian Business Header record
unsigned4 dt_last_seen_EB := max(group, if(mdr.sourcetools.SourceIsEBR(bh.source), bh.dt_last_seen, 0));
unsigned3 cnt_base := count(group); // base record count
unsigned2 cnt_AE := count(group, mdr.sourcetools.SourceIsVehicle(bh.source)); // Experian Vehicles  SourceIsExperianVehicle
unsigned2 cnt_AF := count(group, mdr.sourcetools.SourceIsATF(bh.source)); // ATF Firearms and Explosives
unsigned2 cnt_AT := count(group, mdr.sourcetools.SourceIsAccurint_Trade_Show(bh.source)); // Accurint Trade Show
unsigned2 cnt_AW := count(group, mdr.sourcetools.sourceIsWC(bh.source)); // Watercraft
unsigned2 cnt_B  := count(group, mdr.sourcetools.SourceIsBankruptcy(bh.source));  // Bankruptcy
unsigned2 cnt_BM := count(group, mdr.sourcetools.SourceIsBBB(bh.source)); // BBB Member
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
unsigned2 cnt_MV := count(group, mdr.sourcetools.SourceIsVehicle(bh.source));  // Motor Vehicles
unsigned2 cnt_PL := count(group, mdr.sourcetools.SourceIsProfessional_License(bh.source)); // Professional Licenses
unsigned2 cnt_PR := count(group, mdr.Sourcetools.SourceIsProperty(bh.source)); // this PR code going away DGL 8/21/09 bh.source='PR'); // Property File
unsigned2 cnt_SB := count(group, mdr.Sourcetools.SourceIsSEC_Broker_Dealer(bh.source)); // SEC Broker/Dealer
unsigned2 cnt_SK := count(group, mdr.sourcetools.SourceIsSKA(bh.source)); // SK&A Medical Professionals
unsigned2 cnt_ST := count(group, mdr.sourcetools.SourceIsState_Sales_Tax(bh.source)); // State Sales Tax
unsigned3 cnt_U  := count(group, mdr.sourcetools.SourceIsUCCS(bh.source));  // UCC
unsigned2 cnt_V  := count(group, mdr.sourcetools.SourceIsVickers(bh.source));  // Vickers
unsigned2 cnt_W  := count(group, mdr.sourcetools.SourceIsWhois_domains(bh.source));  // Domain Registrations (WHOIS)
unsigned2 cnt_WC := count(group, mdr.sourcetools.SourceIsWorkmans_Comp(bh.source)); // State Workers Comp
unsigned2 cnt_WT := count(group, mdr.sourcetools.SourceIsWither_and_Die(bh.source)); // Wither and Die
unsigned2 cnt_Y  := count(group, mdr.sourcetools.SourceIsYellow_Pages(bh.source));  // Yellow Pages
end;

bh_stats := table(bh, layout_bh_stat, bdid);

Layout_BDID_Risk_Table AppendStats(Layout_BDID_Risk_Table l, layout_bh_stat r) := transform
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
self := r;
self := l;
end;

bdid_tbl_stat := join(bdid_tbl_gong,
                      bh_stats,
					  left.bdid = right.bdid,
					  AppendStats(left, right),
					  left outer,
					  hash) : persist('~prte::persist::prte2_business_header::bdid_table');

export BDID_Table := bdid_tbl_stat;