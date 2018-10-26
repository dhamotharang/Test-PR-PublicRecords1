import header,doxie,ut,mdr,drivers,suppress;

unsigned8 MaxCands := 100 : stored('CandidateLimit');
unsigned1 MaxNames := 10 : stored('MaxNames');
unsigned1 MaxAddr  := 10 : stored('MaxAddresses');
unsigned1 MaxRecsPer  := 50 : stored('MaxRecordsPerCandidate');

// doxie.MAC_Header_Field_Declare()
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
glb_ok := mod_access.isValidGLB ();
dppa_ok := mod_access.isValidDPPA ();

// nofold is added as a workaround and better be removed after HPCC-13292 is fixed
ds := group(limit(NOFOLD(doxie.Get_Dids()),MaxCands,FAIL('Too Many Candidates - Query Aborted')),did,all);

header.layout_header take_right(doxie.key_header le) := transform
  self := le;
  end;

t_data1 := JOIN(ds,doxie.key_header,left.did=right.s_did,take_right(right));

header.MAC_GlbClean_Header(t_data1,t_data, , , mod_access);

name_rec := record
  t_data.did;
  t_data.fname;
  t_data.mname;
  t_data.lname;
  t_data.name_suffix;
  unsigned3 d_first := min(group,header.get_first_seen(t_data.dt_first_seen,t_data.dt_last_seen,t_data.dt_vendor_first_reported,t_data.dt_vendor_last_reported));
  unsigned2 cnt := count(group);
  unsigned2 f_score := 0;
  unsigned2 r_score := 0;
  unsigned2 g_score := 0;
  unsigned2 t_score := 0;
  end;

name_rec eat_name(name_rec le,name_rec ri) := transform
  self.cnt := le.cnt+ri.cnt;
  self := le;
  end;

name_rec score_name(name_rec le,name_rec ri,unsigned fld) := transform
  self.f_score := IF( fld <> 1, ri.f_score, le.f_score+1 );
  self.r_score := IF( fld <> 2, ri.r_score, le.r_score+1 );
  self.g_score := IF( fld <> 3, ri.g_score, le.g_score+1 );
  self.t_score := IF( fld = 3, self.g_score+self.r_score+self.f_score, 0 );
  self := ri;
  end;

t_names := group(table(t_data,name_rec,did,fname,mname,lname,name_suffix),did,all);
t_n1 := rollup(sort(t_names,lname,-fname,name_suffix,-mname),ut.lead_contains(left.fname,right.fname) and
                                                             left.lname=right.lname and
															 left.name_suffix=right.name_suffix and
															 ut.Lead_Contains(left.mname,right.mname),
															 eat_name(left,right));

name_q(string f, string m, string l, string ns) :=
  MAP( length(trim(f)) = 0 => -2,
       length(trim(f)) ) + 
  MAP( length(trim(m)) = 0 => 0,
       length(trim(m)) = 1 => 1,
       3 ) + 
  MAP( length(trim(l)) = 0 => -4,
       stringlib.stringfind(trim(l),' ',1)<>0 => -1,
       length(trim(l)) ) + 
  MAP( length(trim(ns)) = 0 => 0,
       1 );
	  
	   
ts_n1 := iterate(sort(t_n1,cnt),score_name(left,right,1));
ts_n2 := iterate(sort(ts_n1,d_first),score_name(left,right,2));
// better name quality score
ts_n3 := iterate(sort(ts_n2,name_q(fname,mname,lname,name_suffix)),score_name(left,right,3));

name_res := dedup(sort( ts_n3,-t_score ),true,keep(MaxNames));

addr_rec := record
  t_data.did;
  t_data.prim_range;
  t_data.predir;
  t_data.prim_name;
  t_data.suffix;
  t_data.postdir;
  t_data.unit_desig;
  t_data.sec_range;
  t_data.city_name;
  t_data.st;
  t_data.zip;
  t_data.zip4;
  unsigned3 d_last := max(group,header.get_last_seen(t_data.dt_first_seen,t_data.dt_last_seen,t_data.dt_vendor_first_reported,t_data.dt_vendor_last_reported));
  unsigned2 cnt := count(group);
  unsigned2 f_score := 0;
  unsigned2 r_score := 0;
  unsigned2 g_score := 0;
  unsigned2 t_score := 0;
  end;
  
t_addrs := table(t_data,addr_rec,did,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4);

addr_rec eat_addr(addr_rec le,addr_rec ri) := transform
  self.cnt := le.cnt+ri.cnt;
  self := le;
  end;

t_a1 := rollup(sort(group(t_addrs,did,all),prim_name,-zip4),left.prim_name=right.prim_name and right.zip4='',eat_addr(left,right));
t_a2 := rollup(sort(t_a1,prim_range,zip,-zip4),left.prim_range=right.prim_range and left.zip=right.zip and right.zip4='',eat_addr(left,right));
t_a3 := rollup(sort(t_a2,prim_range,prim_name,zip,-sec_range),left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip and left.sec_range<>'' and right.sec_range='',eat_addr(left,right));

addr_rec score_addr(addr_rec le,addr_rec ri,unsigned fld) := transform
  self.f_score := IF( fld <> 1, ri.f_score, le.f_score+1 );
  self.r_score := IF( fld <> 2, ri.r_score, le.r_score+1 );
  self.g_score := MAP( fld <> 3 => ri.g_score, 
                       le.st<>ri.st => 10,
					   le.g_score=0 => 0,
					   le.g_score-5 );
  self.t_score := IF( fld = 3, self.g_score+self.r_score+self.f_score, 0 );
  self := ri;
  end;

ts_a1 := iterate(sort(t_a3,cnt,d_last),score_addr(left,right,1));
ts_a2 := iterate(sort(ts_a1,d_last,cnt),score_addr(left,right,2));
ts_a3 := iterate(sort(ts_a2,st,-d_last,cnt),score_addr(left,right,3));


addr_res := dedup(sort(ts_a3,-t_score),true,keep(MaxAddr));

result_type := record
  t_data.did;
  t_data.fname;
  t_data.mname;
  t_data.lname;
  t_data.name_suffix;
  t_data.prim_range;
  t_data.predir;
  t_data.prim_name;
  t_data.suffix;
  t_data.postdir;
  t_data.unit_desig;
  t_data.sec_range;
  t_data.city_name;
  t_data.st;
  t_data.zip;
  t_data.zip4;
  unsigned2 t_score;
  end;

result_type j_them(name_res le,addr_res ri) := transform
  self.t_score := le.t_score+ri.t_score;
  self := le;
  self := ri;
  end;

res := join(name_res,addr_res,left.did=right.did,j_them(left,right));

results := dedup(sort(res,did,-t_score),left.did=right.did,keep(MaxRecsPer));

export Expanded_Query := results;