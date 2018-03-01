import ut, Business_Header, Business_Header_SS, Patriot, did_add, std;

bdid_stats := Business_Risk.BDID_Table;

// Check for date in last 6 months
boolean CheckDateLast6Mos(unsigned4 date) := if(date <> 0,
                                             ut.DaysApart((string8)intformat(date, 8, 1), stringlib.GetDateYYYYMMDD()) <= 183,
											 false);

// Check for date in last year					
boolean CheckDateLastYr(unsigned4 date) := if(date <> 0,
                                             ut.DaysApart((string8)intformat(date, 8, 1), stringlib.GetDateYYYYMMDD()) <= 365,
											 false);

// Current Year with offset
unsigned2 CurrentYearOffset(integer1 offset) := (integer)(stringlib.GetDateYYYYMMDD()[1..4]) + offset;

// Current End of Year with offset											 
unsigned4 CurrentYearEndOffset(integer1 offset) :=  (((integer)(stringlib.GetDateYYYYMMDD()[1..4]) + offset) * 10000) + 1231;
					

layout_bdid_risk_table_temp := record
unsigned6 bdid;
unsigned1 PRScore := 0;
unsigned4 PRScore_date;
string120 best_CompanyName := '';
string60 best_addr1 := '';
string60 best_addr2 := '';
string10  best_phone := '';
string9   best_fein := '';
unsigned1 busreg_flag;
unsigned1 corp_flag;
unsigned1 dnb_flag;
unsigned1 irs5500_flag;
unsigned1 st_flag;
unsigned1 ucc_flag;
unsigned1 yp_flag;
unsigned1 tier1srcs;
unsigned1 t1scr5;
unsigned1 currphn;
unsigned1 currcorp;
unsigned1 currbr;
unsigned1 currdnb;
unsigned1 currucc;
unsigned1 curry;
unsigned1 currt1cnt;
unsigned1 currt1src4;
unsigned2 year_lj;
unsigned1 lj;
unsigned1 ustic;
unsigned1 t1x;
unsigned2 OFAC_cnt := 0;
unsigned2 cnt_B;
end;

layout_bdid_risk_table_temp InitBDIDRiskTable(bdid_stats l) := transform
self.PRScore_date := (unsigned4)Stringlib.GetDateYYYYMMDD();
self.busreg_flag := if(l.cnt_BR > 0, 1, 0);
self.corp_flag := if(l.cnt_C > 0, 1, 0);
self.dnb_flag := if(l.cnt_D > 0, 1, 0);
self.irs5500_flag := if(l.cnt_I > 0, 1, 0);
self.st_flag := if(l.cnt_ST > 0, 1, 0);
self.ucc_flag := if(l.cnt_U > 0, 1, 0);
self.yp_flag := if(l.cnt_Y > 0, 1, 0);
self.tier1srcs := self.busreg_flag +
                  self.corp_flag +
				  self.dnb_flag +
				  self.irs5500_flag +
				  self.st_flag +
				  self.ucc_flag +
				  self.yp_flag;
self.t1scr5 := if(self.tier1srcs > 5, 5, self.tier1srcs);
self.currphn := if(CheckDateLast6Mos(l.dt_last_seen_G), 1, 0);
self.currcorp := if(CheckDateLastYr(l.dt_last_seen_C), 1, 0);
self.currbr := if(CheckDateLastYr(l.dt_last_seen_BR), 1, 0);
self.currdnb := if(CheckDateLastYr(l.dt_last_seen_D), 1, 0);
self.currucc := if(CheckDateLastYr(l.dt_last_seen_UCC), 1, 0);
self.curry := if(CheckDateLastYr(l.dt_last_seen_Y), 1, 0);
self.currt1cnt := self.currcorp +
				  self.currbr +
				  self.currdnb +
				  self.currucc  +
				  self.curry;
self.currt1src4 := if(self.currt1cnt > 4, 4, self.currt1cnt);
self.year_lj := map(l.dt_last_seen_lj = 0 => 0,
                    l.dt_last_seen_lj < 18999999 => 1,
                    l.dt_last_seen_lj < CurrentYearEndOffset(-6) => CurrentYearOffset(-6),
                    l.dt_last_seen_lj < CurrentYearEndOffset(-5) => CurrentYearOffset(-5),
                    l.dt_last_seen_lj < CurrentYearEndOffset(-4) => CurrentYearOffset(-4),
                    l.dt_last_seen_lj < CurrentYearEndOffset(-3) => CurrentYearOffset(-3),
                    l.dt_last_seen_lj < CurrentYearEndOffset(-2) => CurrentYearOffset(-2),
                    l.dt_last_seen_lj < CurrentYearEndOffset(-1) => CurrentYearOffset(-1),
                    l.dt_last_seen_lj < CurrentYearEndOffset(-0) => CurrentYearOffset(0),
                    CurrentYearOffset(1));
self.lj := map(l.cnt_LJ > 0 and self.year_lj <= CurrentYearOffset(-5) => 3,
               l.cnt_LJ > 0 and self.year_lj = CurrentYearOffset(-4) => 2,
			   l.cnt_LJ > 0 and self.year_lj <= CurrentYearOffset(-1) => 1,
			   0);
self.ustic := if((self.ucc_flag + self.st_flag + self.irs5500_flag + self.corp_flag) > 0, 1, 0);
self.t1x := map(self.currt1src4 = 0 => 0,
                self.currt1src4 = 1 => 1,
				self.currt1src4 = 2 and self.t1scr5 < 5 => 2,
				3);

self := l;
end;

bdid_risk_table_init := project(bdid_stats, InitBDIDRiskTable(left));

// Check for OFAC hit
patriot_bdid_key := Patriot.key_bdid_patriot_file;

layout_patriot_bdid := record
unsigned6 bdid;
patriot.Layout_Patriot;
end;

patriot_bdid := project(patriot_bdid_key,
                         transform(layout_patriot_bdid, self := left));

layout_bdid := record
unsigned6 bdid;
end;

bdid_patriot := join(bdid_risk_table_init,
                     patriot_bdid,
				     left.bdid = right.bdid,
					 transform(layout_bdid, self.bdid := left.bdid),
					 hash);
					 
layout_bdid_patriot_stat := record
bdid_patriot.bdid;
unsigned2 OFAC_cnt := count(group);
end;

bdid_patriot_stat := table(bdid_patriot, layout_bdid_patriot_stat, bdid, few);

bdid_risk_table_ofac := join(bdid_risk_table_init,
                             bdid_patriot_stat,
					         left.bdid = right.bdid,
					         transform(layout_bdid_risk_table_temp, self.OFAC_cnt := right.OFAC_cnt, self := left),
					         left outer,
					         lookup);

bh_best := Business_Header.File_Business_Header_Best;

os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_bdid_risk_table_temp CombineBest(bdid_risk_table_ofac l, bh_best r) := transform
self.best_CompanyName := r.company_name;

self.best_addr1 := 
			os(r.prim_range) + 
			os(r.predir) + 
			os(r.prim_name) +
			os(r.addr_suffix) +
			os(r.postdir) +
				if(Std.Str.EndsWith(r.prim_name, os(r.unit_desig) + os(r.sec_range)),
					'',
					os(r.unit_desig) + os(r.sec_range));

SELF.best_addr2 := 
			os(r.city) +
			os(r.state) +
			if(r.zip = 0, '', intformat(r.zip, 5, 1)) + 
				if(r.zip4 <> 0, '-' + intformat(r.zip4, 4, 1), '');

self.best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
self := l;
end;


bdid_risk_table_best := join(bdid_risk_table_ofac,
                             bh_best,
					         left.bdid = right.bdid,
					         CombineBest(left, right),
							 left outer,
					         hash);
							 
layout_bdid_risk_table_temp CalcScore(layout_bdid_risk_table_temp l) := transform
unsigned1 score := map(l.OFAC_cnt > 0 => 50,
                       l.cnt_B > 0 or (l.lj = 1 and l.t1x = 0) => 60,
					   l.lj = 1 and l.t1x < 3 => 65,
					   l.lj = 1 => 70,
					   l.lj = 2 and l.t1x=0 => 65,
					   l.lj = 2 and l.t1x < 3 => 70,
					   l.lj = 2 => 80,
					   l.t1x = 0 => 70,
					   l.t1x = 1 => 80,
					   l.t1x = 2 => 90,
					   l.t1x = 3 => 95,
					   50);
					   
unsigned1 score1 := map(score in [60, 65, 90, 95] and l.currphn > 0 => score + 5,
                        score in [70, 80] and l.currphn > 0 => score + 10,
				    score);
				    
self.PRScore := map(score1 in [70, 80, 90] and l.ustic > 0 => score1 + 5,
                    score1 = 95 and l.ustic > 0 and l.currphn > 0 => score1 + 5,
				score1);
self := l;
end;
							 
bdid_risk_table_score := project(bdid_risk_table_best, CalcScore(left));

export BDID_Risk_Table := bdid_risk_table_score : persist('TEMP::bdid_profile_risk_table');