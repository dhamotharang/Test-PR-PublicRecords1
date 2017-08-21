import ut;
h := header.file_headers;

hslim := record
  h.did;
  h.prim_range;
  h.prim_name;
  h.zip;
  h.ssn;
  //h.sec_range;
  string30 fname := datalib.preferredfirst(h.fname);
  h.lname;
  string5 name_suffix := if(ut.is_unk(h.name_suffix),'',h.name_suffix);
  h.dob;
  boolean has_dif := false;
  end;

hs := table(h(prim_name<>'',lname<>'',(integer)ssn <> 0 or dob<>0 or name_suffix<>''),hslim);

hsd := distribute(hs,hash(fname,lname));

// In the following we propogate some DOBs
g_lfn := group(sort(hsd,fname,lname,ssn,local),fname,lname,ssn,local);

s_lfn := sort(g_lfn,-dob);

hslim do_dob(hslim le,hslim ri) := transform
  self.dob := if ( ri.dob=0, le.dob, ri.dob );
  self := ri;
  end;

proped_dob := iterate(s_lfn,do_dob(left,right));

un_grp := group(proped_dob(dob<>0 or name_suffix<>''));
//gs := group(hs,prim_range,prim_name,zip,sec_range,fname,lname,all);
// Slightly more cautious, cause deviance even if sec_ranges differ
gs := group(sort(un_grp,prim_range,prim_name,zip,fname,lname,local),
                        prim_range,prim_name,zip,fname,lname,local);

hslim spot_diff(hslim le, hslim ri) := transform
  self.has_dif := ri.has_dif or  le.has_dif or ~header.near_dob(le.dob,ri.dob) or ~ut.NNEQ_suffix(le.name_suffix,ri.name_suffix);
  self := ri;
  end;

// by not sorting we maximise the chance of finding a diff
pot_diffs := iterate(gs,spot_diff(left,right));

n_first := sort(pot_diffs,if(has_dif,0,1));

prop_diffs := iterate(n_first,spot_diff(left,right));

did_rec := record
  prop_diffs.did;
  end;

nasties := table(prop_diffs(has_dif),did_rec);

export JrSrAddresses := dedup(group(nasties),did,all) : persist('JrSrAdd');