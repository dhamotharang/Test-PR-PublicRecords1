#option('outputLimit', 100);

import ut, Business_Header, Gong, BBB;

// Selected IR Sample Data
layout_sample := record
// From Business Header Best Record
	unsigned6 bdid;
	qstring120 company_name := '';
	qstring10 prim_range := '';
	string2   predir := '';
	qstring28 prim_name := '';
	qstring4  addr_suffix := '';
	string2   postdir := '';
	qstring5  unit_desig := '';
	qstring8  sec_range := '';
	qstring25 city := '';
	string2   state := '';
	unsigned3 zip := 0;
	unsigned2 zip4 := 0;
	unsigned6 phone := 0;
	unsigned4 fein := 0;        // Federal Tax ID
	unsigned1 best_flags := 0;
	string2   source := '';	   // source type (non-blank only if DPPA_State is non-blank)
     string2   DPPA_State := ''; // If nonblank, indicates state code for a DPPA restricted record
unsigned4 dt_last_seen := 0;
unsigned3 base_record_count := 0;
// Source Data Record Counts
unsigned3 corp_record_cnt := 0;
unsigned3 ucc_record_cnt := 0;
//unsigned3 fbn_record_cnt := 0;
unsigned3 busreg_record_cnt := 0;
unsigned3 bk_record_cnt := 0;
unsigned3 lj_record_cnt := 0;
unsigned3 gb_record_cnt := 0;
unsigned3 irs5500_record_cnt := 0;
unsigned3 dnb_record_cnt := 0;
// D&B Info
unsigned3 dnb_number_employees := 0;
unsigned6 dnb_revenues := 0;
// DCA Info
unsigned3 dca_number_employees := 0;
unsigned6 dca_revenues := 0;
// Infousa Info
unsigned3 infousa_number_employees := 0;
unsigned6 infousa_revenues := 0;
// Lien/Judgment Info
unsigned6 amount;
// Business Owner information
unsigned3 bo_cnt := 0;
// Bankruptcy Info
unsigned4 bk_dt_last_seen := 0;
end;

ir_sample := dataset('TMTEMP::IR_Sample', layout_sample, flat);

// Get list of BDIDs for lookups
layout_bdid_list := record
ir_sample.bdid;
end;

ir_bdids := table(ir_sample, layout_bdid_list);

layout_sample_out := record
string12  bdid;
string1   selection_flag := '';  // 'G' - good, 'B' - bad, 'U' - unknown
string120 best_CompanyName := '';
string120 best_addr1 := '';
string30	best_city := '';
string2	best_state := '';
string5	best_zip :='';
string4	best_zip4 := '';
string10  best_phone := '';
string9   best_fein := '';
string8   bbb_member_since_date := '';
string7   base_record_count := '';
string8   base_dt_first_seen_min := '';
string8   base_dt_last_seen_max := '';
string4   corpfiling_record_cnt := '';
string8   corpfiling_dt_first_seen_min := '';
string8   corpfiling_dt_last_seen_max := '';
string4   busreg_record_cnt := '';
string8   busreg_dt_first_seen_min := '';
string8   busreg_dt_last_seen_max := '';
string4   dnb_record_cnt := '';
string8   dnb_dt_first_seen_min := '';
string8   dnb_dt_last_seen_max := '';
string4   iusa_record_cnt := '';
string8   iusa_dt_first_seen_min := '';
string8   iusa_dt_last_seen_max := '';
string4   dca_record_cnt := '';
string8   dca_dt_first_seen_min := '';
string8   dca_dt_last_seen_max := '';
string7   ucc_record_cnt := '';
string8   ucc_dt_first_seen_min := '';
string8   ucc_dt_last_seen_max := '';
string4   irs5500_record_cnt := '';
string8   irs5500_dt_first_seen_min := '';
string8   irs5500_dt_last_seen_max := '';
string4   busphone_record_cnt := '';
string1   busphone_current_flag := 'N';  // 'Y' - has current phone, 'N' - no current phone
string8   busphone_dt_first_seen_min := '';
string8   busphone_dt_last_seen_max := '';
string4   yellowpage_record_cnt := '';
string8   yellowpage_dt_first_seen_min := '';
string8   yellowpage_dt_last_seen_max := '';
string4   lj_record_cnt := '';
string8   lj_dt_first_seen_min := '';
string8   lj_dt_last_seen_max := '';
string9   lj_max_amount := '';
string4   bk_record_cnt := '';
string8   bk_dt_first_seen_min := '';
string8   bk_dt_last_seen_max := '';
end;

// Initialize sample output from IR sample
os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_sample_out InitSampleOut(layout_sample l) := transform
self.bdid := intformat(l.bdid, 12, 1);
self.selection_flag := map(l.gb_record_cnt > 0 and not l.bk_record_cnt > 0 and l.amount < 5000 => 'G',
                           (l.bk_record_cnt > 0 and ut.DaysApart((string8)l.bk_dt_last_seen, stringlib.GetDateYYYYMMDD()) < 366) and
                             l.amount < 5000 => 'B',
					  l.bk_record_cnt = 0 and l.amount > 5000 => 'B',
					  'U');
self.best_CompanyName := l.company_name;

self.best_addr1 := 
			os(l.prim_range) + 
			os(l.predir) + 
			os(l.prim_name) +
			os(l.addr_suffix) +
			os(l.postdir) +
				if(ut.tails(l.prim_name, os(l.unit_desig) + os(l.sec_range)),
					'',
					os(l.unit_desig) + os(l.sec_range));
self.best_city := l.city;
self.best_state := l.state;
self.best_zip := if(l.zip = 0, '', intformat(l.zip, 5, 1));
self.best_zip4 := if(l.zip4 <> 0, '-' + intformat(l.zip4, 4, 1), '');

self.best_phone := if(l.phone <> 0, intformat(l.phone, 10, 1), '');
self.best_fein := if(l.fein <> 0, intformat(l.fein, 9, 1), '');
self.base_record_count := intformat(l.base_record_count, 7, 1);
self.lj_max_amount := if(l.amount <> 0, intformat(l.amount, 9, 1), '');
end;

ir_out_init := project(ir_sample, InitSampleOut(left));

// Get Gong History Stats
gh := join(Gong.File_Gong_History_Full,
           ir_bdids,
		 left.bdid = right.bdid,
		 transform(Gong.Layout_history, self := left),
		 lookup);
		 
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

string8 FormatDate(unsigned4 date) := if(date = 0 or date = 99999999, '', intformat(date, 8, 1));

layout_sample_out AppendGongStats(layout_sample_out l, layout_gong_history_stats r) := transform
self.busphone_dt_first_seen_min := FormatDate(r.dt_first_seen_G);
self.busphone_dt_last_seen_max := FormatDate(r.dt_last_seen_G);
self.busphone_current_flag := if(r.gong_current_record_count > 0, 'Y', 'N');
self := l;
end;

ir_out_gong := join(ir_out_init,
                    gh_stats,
			     ((unsigned6)left.bdid) = right.bdid,
				AppendGongStats(left, right),
				left outer,
				hash);
					  
// Calculate statistics on sample set
bh := join(Business_Header.File_Business_Header,
           ir_bdids,
		 left.bdid = right.bdid,
		 transform(Business_Header.Layout_Business_Header_Base, self := left),
		 lookup);
			   
layout_bh_stat := record
bh.bdid;
unsigned4 dt_first_seen_min := min(group, if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen));   // min for all base records
unsigned4 dt_last_seen_max := max(group, bh.dt_last_seen);    // max for all base records
unsigned4 dt_first_seen_Y := min(group, if(bh.source = 'Y', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a current YP record
unsigned4 dt_last_seen_Y := max(group, if(bh.source = 'Y', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_C := min(group, if(bh.source = 'C', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Corp record
unsigned4 dt_last_seen_C := max(group, if(bh.source = 'C', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_BR := min(group, if(bh.source = 'BR', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Business Registration record
unsigned4 dt_last_seen_BR := max(group, if(bh.source = 'BR', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_UCC := min(group, if(bh.source = 'U', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a UCC record
unsigned4 dt_last_seen_UCC := max(group, if(bh.source = 'U', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_D := min(group, if(bh.source = 'D', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a D&B record
unsigned4 dt_last_seen_D := max(group, if(bh.source = 'D', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_I := min(group, if(bh.source = 'I', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a IRS5500 record
unsigned4 dt_last_seen_I := max(group, if(bh.source = 'I', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_B := min(group, if(bh.source = 'B', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Bankruptcy record
unsigned4 dt_last_seen_B := max(group, if(bh.source = 'B', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_LJ := min(group, if(bh.source = 'LJ', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a Liens Judgment record
unsigned4 dt_last_seen_LJ := max(group, if(bh.source = 'LJ', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_DC := min(group, if(bh.source = 'DC', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a DCA record
unsigned4 dt_last_seen_DC := max(group, if(bh.source = 'DC', bh.dt_last_seen, 0));
unsigned4 dt_first_seen_IA := min(group, if(bh.source = 'IA', if(bh.dt_first_seen = 0, 99999999, bh.dt_first_seen), 99999999));// min for a InfoUSA record
unsigned4 dt_last_seen_IA := max(group, if(bh.source = 'IA', bh.dt_last_seen, 0));
unsigned2 cnt_B  := count(group, bh.source='B');  // Bankruptcy
unsigned2 cnt_BR := count(group, bh.source='BR'); // Business Registration
unsigned2 cnt_C  := count(group, bh.source='C');  // Corporate
unsigned2 cnt_D  := count(group, bh.source='D');  // Dun & Bradstreet
unsigned2 cnt_GB := count(group, bh.source='GB'); // Gong Business
unsigned2 cnt_I  := count(group, bh.source='I');  // IRS 5500
unsigned2 cnt_LJ := count(group, bh.source='LJ'); // Liens and Judgments
unsigned3 cnt_U  := count(group, bh.source='U');  // UCC
unsigned2 cnt_Y  := count(group, bh.source='Y');  // Yellow Pages
unsigned2 cnt_DC := count(group, bh.source='DC'); // Directory of Corporate Affiliations
unsigned2 cnt_IA := count(group, bh.source='IA'); // InfoUSA ABIUS Company
end;

bh_stats := table(bh, layout_bh_stat, bdid);

layout_sample_out AppendBHStats(layout_sample_out l, layout_bh_stat r) := transform
self.base_dt_first_seen_min := FormatDate(r.dt_first_seen_min);
self.base_dt_last_seen_max := FormatDate(r.dt_last_seen_max);
self.corpfiling_record_cnt := intformat(r.cnt_C, 4, 1);
self.corpfiling_dt_first_seen_min := FormatDate(r.dt_first_seen_C);
self.corpfiling_dt_last_seen_max := FormatDate(r.dt_last_seen_C);
self.busreg_record_cnt := intformat(r.cnt_BR, 4, 1);
self.busreg_dt_first_seen_min := FormatDate(r.dt_first_seen_BR);
self.busreg_dt_last_seen_max := FormatDate(r.dt_last_seen_BR);
self.dnb_record_cnt := intformat(r.cnt_D, 4, 1);
self.dnb_dt_first_seen_min := FormatDate(r.dt_first_seen_D);
self.dnb_dt_last_seen_max := FormatDate(r.dt_last_seen_D);
self.iusa_record_cnt := intformat(r.cnt_IA, 4, 1);
self.iusa_dt_first_seen_min := FormatDate(r.dt_first_seen_IA);
self.iusa_dt_last_seen_max := FormatDate(r.dt_last_seen_IA);
self.dca_record_cnt := intformat(r.cnt_DC, 4, 1);
self.dca_dt_first_seen_min := FormatDate(r.dt_first_seen_DC);
self.dca_dt_last_seen_max := FormatDate(r.dt_last_seen_DC);
self.ucc_record_cnt := intformat(r.cnt_U, 7, 1);
self.ucc_dt_first_seen_min := FormatDate(r.dt_first_seen_UCC);
self.ucc_dt_last_seen_max := FormatDate(r.dt_last_seen_UCC);
self.irs5500_record_cnt := intformat(r.cnt_I, 4, 1);
self.irs5500_dt_first_seen_min := FormatDate(r.dt_first_seen_I);
self.irs5500_dt_last_seen_max := FormatDate(r.dt_last_seen_I);
self.busphone_record_cnt := intformat(r.cnt_GB, 4, 1);
self.yellowpage_record_cnt := intformat(r.cnt_Y, 4, 1);
self.yellowpage_dt_first_seen_min := FormatDate(r.dt_first_seen_Y);
self.yellowpage_dt_last_seen_max := FormatDate(r.dt_last_seen_Y);
self.lj_record_cnt := intformat(r.cnt_LJ, 4, 1);
self.lj_dt_first_seen_min := FormatDate(r.dt_first_seen_LJ);
self.lj_dt_last_seen_max := FormatDate(r.dt_last_seen_LJ);
self.bk_record_cnt := intformat(r.cnt_B, 4, 1);
self.bk_dt_first_seen_min := FormatDate(r.dt_first_seen_B);
self.bk_dt_last_seen_max := FormatDate(r.dt_last_seen_B);
self := l;
end;

ir_out_bh := join(ir_out_gong,
                  bh_stats,
			   ((unsigned6)left.bdid) = right.bdid,
		        AppendBHStats(left, right),
			   left outer,
			   hash);
			   
// Check for BBB Member
bbb_base := BBB.File_BBB_Base;

layout_bbb_bdid := record
bbb_base.bdid;
bbb_base.member_since_date;
end;

bbb_members := table(bbb_base, layout_bbb_bdid);
bbb_members_dedup := dedup(bbb_members, bdid, all);

ir_out_bbb := join(ir_out_bh,
                   bbb_members_dedup,
			    ((unsigned6)left.bdid) = right.bdid,
			    transform(layout_sample_out, self.bbb_member_since_date := right.member_since_date, self := left),
			    left outer,
			    hash) : persist('TMTEMP::IR_Sample_Out');

output(ir_out_bbb, all);