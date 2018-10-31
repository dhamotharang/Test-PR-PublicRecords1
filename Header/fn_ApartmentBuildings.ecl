IMPORT PRTE2_Header;
export fn_ApartmentBuildings(boolean isEN=false,string filedate) := function

gds := header.fn_did_addresses(isEN,filedate);

scnt := record
	gds.prim_range;
	gds.prim_name;
	gds.zip;
	gds.predir;
	gds.suffix;
	integer4 cnt := count(group);
	integer4 cnt_dd := 1;
end;

s_nums_wo := table (gds(sec_range = ''),scnt,gds.prim_range,gds.prim_name,gds.zip,gds.predir,gds.suffix,local);

//s_nums_w_1 gives us a count of how many records have a sec_range (not deduped)
s_nums_w_1 := table (gds(sec_range != ''),scnt,gds.prim_range,gds.prim_name,gds.zip,gds.predir,gds.suffix,local);

// s_nums_w_2 gives us a real count of how many sec_range there are, including blanks.
dds := dedup(sort(gds,sec_range),sec_range);
s_nums_w_2 := table (dds,scnt,dds.prim_range,dds.prim_name,dds.zip,dds.predir,dds.suffix,local);


scnt count_dd(scnt L, scnt R) := transform
	self.cnt := L.cnt;
	self.cnt_dd := R.cnt;
	self := L;
end;

// s_nums_w has a) how many have a sec range in cnt, and b) how many sec range there are
// in cnt_dd.
s_nums_w := join(s_nums_w_1,s_nums_w_2,left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.zip = right.zip and
						left.predir = right.predir and
						left.suffix = right.suffix,count_dd(LEFT,RIGHT),local);


acnt := record
  dds.prim_range;
  dds.prim_name;
  dds.zip;
  dds.predir;
  dds.suffix;
  integer4 cnt;
  end;

acnt a_create(scnt L, scnt R) := transform
	self.cnt := if (R.cnt >= L.cnt*5,R.cnt_dd,L.cnt_dd);	
	self.prim_range := if (l.prim_range = '',R.prim_range, L.prim_range);
	self.prim_name := if (l.prim_name = '',R.prim_name, L.prim_name);
	self.zip := if (l.zip = '',R.zip, L.zip);
	self.predir := if (l.predir = '',R.predir,L.predir);
	self.suffix := if (l.suffix = '',r.suffix,l.suffix);
end;

a_numbers := join(s_nums_w,s_nums_wo,left.prim_range = right.prim_range and
								left.prim_name = right.prim_name and
								left.zip = right.zip and
								left.predir = right.predir and
								left.suffix = right.suffix,a_create(LEFT,RIGHT),full outer,local);


//a_numbers := table(dds,acnt,dds.prim_range,dds.prim_name,dds.zip,dds.predir,dds.suffix,local);

did_ds := dedup(sort(gds,did),did);

d_numbers := table(did_ds,scnt,dds.prim_range,dds.prim_name,dds.zip,dds.predir,dds.suffix,local);

res_type := record
  dds.prim_range;
  dds.predir;
  dds.prim_name;
  dds.zip;
  dds.suffix;
  integer4 apt_cnt;
  integer4 did_cnt;
  end;

res_type join_them(a_numbers le, d_numbers ri) := transform
  self.apt_cnt := le.cnt;
  self.did_cnt := ri.cnt;
  self := le;
  end;

j := join(a_numbers,d_numbers,left.prim_range=right.prim_range and
                              left.prim_name=right.prim_name and
                              left.zip=right.zip and
                              left.suffix=right.suffix and
                              left.predir=right.predir,
                              join_them(left,right),local);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
ofile := j ;
#ELSE
ofile := j : persist(if(isEN,'EN_','')+'fcra_ApartmentBuildings');
#END;
return ofile;

end;