import Business_Risk;

acl_base := acl_prep;

acl_base_dist := distribute(acl_base(bdid <> 0), hash(bdid));
pr_table_dist := distribute(Business_Risk.BDID_Risk_Table, hash(bdid));

Layout_Accurint_Customer_List_Base AppendPRScore(Layout_Accurint_Customer_List_Base l, pr_table_dist r) := transform
self.PRScore := r.PRScore;
self.busreg_flag := r.busreg_flag;
self.corp_flag := r.corp_flag;
self.dnb_flag := r.dnb_flag;
self.irs5500_flag := r.irs5500_flag;
self.st_flag := r.st_flag;
self.ucc_flag := r.ucc_flag;
self.yp_flag := r.yp_flag;
self.tier1srcs := r.tier1srcs;
self.t1scr5 := r.t1scr5;
self.currphn := r.currphn;
self.currcorp := r.currcorp;
self.currbr := r.currbr;
self.currdnb := r.currdnb;
self.currucc := r.currucc;
self.curry := r.curry;
self.currt1cnt := r.currt1cnt;
self.currt1src4 := r.currt1src4;
self.year_lj := r.year_lj;
self.lj := r.lj;
self.ustic := r.ustic;
self.t1x := r.t1x;
self.OFAC_cnt := r.OFAC_cnt;
self.cnt_B := r.cnt_B;
self := l;
end;

acl_pr_append := join(acl_base_dist,
                      pr_table_dist,
				  left.bdid = right.bdid,
				  AppendPRScore(left, right));
				  
acl_pr_append_all := acl_pr_append + acl_base(bdid = 0);
acl_pr_append_sort := sort(acl_pr_append_all, seq);

export acl_prscore_append := acl_pr_append_sort : persist('TMTEST::accurint_customer_list_prscore');
