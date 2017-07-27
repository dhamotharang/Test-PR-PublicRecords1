Check_b10(file,stri,num) := macro
#uniquename(b)
%b% := 2;
stri + ' (Should be '+ num + ' records): '+(string)count(file);
endmacro;

TotalNodes := _Certification.Setup.NodeMult1 * _Certification.Setup.NodeMult2;

//base_flpszanbm := _Certification.DataFile;
base_flpszanbm := distribute(_Certification.DataFile,random());
base_flpszanbm_1 := distribute(base_flpszanbm,hash32(fname,lname, prange,street,zips,age,birth_state,birth_month));

tbl_flpszanbm := table(base_flpszanbm,
                       {base_flpszanbm.fname,
                        base_flpszanbm.lname,
                        base_flpszanbm.prange,
                        base_flpszanbm.street,
                        base_flpszanbm.zips,
                        base_flpszanbm.age,
                        base_flpszanbm.birth_state,
                        base_flpszanbm.birth_month,
                        base_flpszanbm.one,
                        base_flpszanbm.id});
tbl_flpszanbm_1 := distribute(tbl_flpszanbm,hash32(fname,lname, prange,street,zips,age,birth_state,birth_month));

// Full global join
FullGlobalJoin := JOIN(base_flpszanbm,base_flpszanbm_1,left.id=right.id);
'Full Global Join - should = '+ TotalNodes + ' million : '+(string)count(FullGlobalJoin);
//'Full Global Join - should = '+ TotalNodes + ' million : '+(string)count(base_flpszanbm);

// local join
LocalJoin := JOIN(base_flpszanbm_1,base_flpszanbm_1,left.id=right.id,LOCAL);
'Local Join - should = '+ TotalNodes + ' million (local): '+(string)count(LocalJoin);
//'Local Join - should = '+ TotalNodes + ' million (local): '+(string)count(base_flpszanbm_1);

// dedup to verify there is only 1x2x3x4x5x6x7x8 records
res := dedup(base_flpszanbm+base_flpszanbm_1,fname,lname,prange,street,zips,age,birth_state,birth_month,all);
'Dedup - should = '+ TotalNodes + ' million (joined): ' + (string)count(res);

// to be used for testing compressed I/O
res1 := dedup(tbl_flpszanbm+tbl_flpszanbm_1,fname,lname,prange,street,zips,age,birth_state,birth_month,all) : persist('persist::res1');
'Complex I/O - should = '+ TotalNodes + ' million: ' + (string)count(res1);

r := record
  res.fname;
  unsigned4 cnt := count(GROUP);
  end;

//hash aggregate
tfew := table(res,r,res.fname,few);
//global aggregate
tfull := table(res,r,res.fname);
//local aggregate
tfl := table(distribute(res,hash32(fname)),r,res.fname,local);

check_b10(tfew,'Hash Aggregate',_Certification.Setup.NodeMult1)
check_b10(tfull,'Global Aggregate',_Certification.Setup.NodeMult1)
check_b10(tfl,'Local Aggregate',_Certification.Setup.NodeMult1)

fcount := record
  res.fname;
  res.lname;
  unsigned4 cnt := 1;
  end;

fres := table(res,fcount);

//global sort
sfres := sort(fres,fname,lname);

//local sort, distribute
//dfres := sort(distribute(fres,hash32(fname,lname)),fname,lname,local);
dfres := sort(distribute(fres,hash32(fname)),fname,lname,local);

//global group
gsfres := group(sfres,fname,lname);

//local group
gdfres := group(dfres,fname,lname,local);

fcount incr(fcount le, fcount ri) := transform
  self.cnt := le.cnt + ri.cnt;
  self := le;
  end;

//global rollup
rfull := rollup(sfres,left.fname=right.fname,incr(left,right));
//global grouped rollup
rgroup := rollup(gsfres,1,incr(left,right));
//local rollup
rlocal := rollup(dfres,left.fname=right.fname,incr(left,right),local);
//local grouped rollup
rlgrp := rollup(gdfres,1,incr(left,right));

check_b10(rfull,'Global Rollup',_Certification.Setup.NodeMult1)
check_b10(rgroup,'Global Grouped Rollup',TotalNodes)
check_b10(rlocal,'Local Rollup',_Certification.Setup.NodeMult1)
check_b10(rlgrp,'Local Grouped Rollup',TotalNodes)

fcount cnt(fcount le, fcount ri) := transform
  self.cnt := IF(le.fname=ri.fname and le.lname=ri.lname,le.cnt+ri.cnt,ri.cnt);
  self := ri;
  end;

//global iterate/sort/dedup
ifull := dedup(sort(iterate(sfres,cnt(left,right)),fname,lname,-cnt),fname,lname);
//global grouped iterate/sort/dedup
igroup := dedup(sort(iterate(gsfres,cnt(left,right)),fname,lname,-cnt),fname,lname);
//local iterate/sort/dedup
ilocal := dedup(sort(iterate(dfres,cnt(left,right),local),fname,lname,-cnt,local),fname,lname,local);
//local grouped iterate/sort/dedup
ilgrp := dedup(sort(iterate(gdfres,cnt(left,right)),fname,lname,-cnt),fname,lname);

check_b10(ifull,'Global It/Srt/Ddp',TotalNodes)
check_b10(igroup,'Global Grouped It/Srt/Ddp',TotalNodes)
check_b10(ilocal,'Local It/Srt/Ddp',TotalNodes)
check_b10(ilgrp,'Local Grouped It/Srt/Ddp',TotalNodes)

// strng search
'String Search Results: '+(string)count(base_flpszanbm(fname = 'DIRK', lname = 'BRYANT', prange = 1));