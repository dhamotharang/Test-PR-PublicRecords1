import Business_Header, ut, MDR;

cname_var := record
	string81 cname;
	unsigned4 last_seen;
end;

rec := record
	unsigned4 fein;
	unsigned4 busheader_first_seen;
	unsigned4 busheader_last_seen;
	boolean isValidFormat;
	boolean isBankrupt;
	integer busheaderCount;
	integer BDIDCount;
	integer BestCount;
	unsigned6 BestBDID;
	cname_var cname1;
	cname_var cname2;
	cname_var cname3;
	cname_var cname4;
end;

// Get All FEIN's
bh := distribute(business_header.filters.keys.business_headers(Business_Header.Files().Base.Business_Headers.Built)(fein <> 0), hash(fein));

fein_var_rec := record
	bh.fein;
	string81 cname := ut.CleanCompany(bh.company_name);
	last_seen := max(group,bh.dt_last_seen);
end;

fein_var := table(bh,fein_var_rec,fein,ut.CleanCompany(bh.company_name),local);
fein_var4 := dedup(sort(fein_var,fein,cname,-last_seen,local),fein,keep(4),local);

slim := record
	bh.bdid;
	bh.fein;
	dt_first_seen := min(group,if(bh.dt_first_seen=0,99999999,bh.dt_first_seen));
	dt_last_seen := max(group,bh.dt_last_seen);
	cnt := count(group);
end;

bh_fein_bdid := table(bh, slim, fein, bdid, local);

slim_bk := record
bh.bdid;
unsigned2 cnt_bk := count(group, mdr.sourceTools.SourceIsBankruptcy(bh.source));
end;

bh_bdid_bk := table(bh, slim_bk, bdid);

slim_with_bk := record
slim;
unsigned2 cnt_bk;
end;

slim_with_bk AppendBKCount(bh_fein_bdid l, bh_bdid_bk r) := transform
self.cnt_bk := r.cnt_bk;
self := l;
end;

bh_fein_bdid_bk := join(bh_fein_bdid,
                        bh_bdid_bk,
						left.bdid = right.bdid,
						AppendBKCount(left, right),
						left outer,
						lookup);

slim_fein := record
	bh_fein_bdid_bk.fein;
	dt_first_seen := min(group,bh_fein_bdid_bk.dt_first_seen);
	dt_last_seen := max(group,bh_fein_bdid_bk.dt_last_seen);
	cnt := count(group);
	cnt_all := sum(group,bh_fein_bdid_bk.cnt);
	cnt_bk := sum(group,bh_fein_bdid_bk.cnt_bk);
end;

bh_fein := table(bh_fein_bdid_bk, slim_fein, fein, local);

rec reform(bh_fein l) := transform
	self.fein := l.fein;
	self.busheader_first_seen := if(l.dt_first_seen=999999,0,l.dt_first_seen);
	self.busheader_last_seen := l.dt_last_seen;
	self.BDIDCount := l.cnt;
	self.busheaderCount := l.cnt_all;
	self.isValidFormat := Business_Header.ValidFEIN(l.fein);
	self.isBankrupt := l.cnt_bk > 0;
	self := [];
end;

fein_start := project(bh_fein, reform(left));

rec getVars(rec l, fein_var4 r, INTEGER c) := transform
	SELF.cname1.cname := IF(c=1,r.cname,l.cname1.cname);
	SELF.cname1.last_seen := IF(c=1,r.last_seen,l.cname1.last_seen);

	SELF.cname2.cname := IF(c=2,r.cname,l.cname2.cname);
	SELF.cname2.last_seen := IF(c=2,r.last_seen,l.cname2.last_seen);
	
	SELF.cname3.cname := IF(c=3,r.cname,l.cname3.cname);
	SELF.cname3.last_seen := IF(c=3,r.last_seen,l.cname3.last_seen);
	
	SELF.cname4.cname := IF(c=4,r.cname,l.cname4.cname);
	SELF.cname4.last_seen := IF(c=4,r.last_seen,l.cname4.last_seen);
	SELF := l;
END;

with_vars := DENORMALIZE(fein_start,
                         fein_var4,
						 left.fein=right.fein,
						 getVars(left, right, counter),
						 left outer,
						 local);

// number of BDIDs with the FEIN as best
bhb := distribute(Business_Header.Files().Base.Business_Header_Best.Built(fein <> 0), hash(fein));

bhb_cnt_rec := record
	bhb.fein;
	cnt := count(group);
end;

bhb_cnt := table(bhb, bhb_cnt_rec, fein, local);

rec get_bhbfein_cnt(rec l, bhb_cnt_rec r) := transform
	self.BestCount := r.cnt;
	self := l;
end;

with_bestcnt := JOIN(with_vars,
                     bhb_cnt,
					 left.fein = right.fein,
					 get_bhbfein_cnt(left, right),
					 left outer,
					 local);

// If there is 1, get best BDID
rec getBest(rec l, Business_Header.File_Business_Header_Best r) := transform
	self.BestBDID := r.bdid;
	self := l;
end;

with_best := JOIN(with_bestcnt,
                  bhb,
				  left.fein = right.fein and left.BestCount=1,
				  getBest(left, right),
				  left outer,
				  local);

ddp := dedup(sort(with_best, fein, local), fein, local);

export FEIN_Table := ddp 
	: PERSIST(Business_Header._Dataset().thor_cluster_Persists + 'persist::Business_Risk::FEIN_Table');
