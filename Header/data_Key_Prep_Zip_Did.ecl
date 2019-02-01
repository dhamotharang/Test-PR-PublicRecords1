import header, doxie, dx_Header, doxie_build;

//head := dataset('~thor_data400::Base::HeaderKey_Building',header.Layout_Header,flat);
//  Bug 12065, use blocked data filter on header instead of raw data
head := doxie_build.file_header_building; 

unsigned3 get_header_last_seen(header.Layout_Header L) :=  MAP ( l.dt_last_seen > 0 and l.dt_last_seen > l.dt_vendor_last_reported => l.dt_last_seen,
           l.dt_vendor_last_reported > 0 => l.dt_vendor_last_reported,
           l.dt_vendor_first_reported > l.dt_first_seen => l.dt_vendor_first_reported,
           l.dt_first_seen);

r := record
  head.did;
  head.zip;
  head.fname;
  head.lname;
  head.mname;
  head.name_suffix;
  unsigned4 dt_last_seen := get_header_last_seen(head);
  end;

tt := distribute(table(head(zip<>'',fname<>'',lname<>''),r),hash(zip));

st1 := dedup(sort(tt,zip,fname,lname,did,-dt_last_seen,local),
            zip,fname,lname,did,local);

rc := record
  st1.zip;  
  st1.fname;
  st1.lname;
  unsigned4 dt_last_seen := max(group,st1.dt_last_seen);
  unsigned4 cnt := count(group);
  unsigned6 b_did := max(group,st1.did);
  unsigned6 l_did := min(group,st1.did);
  end;

tbz := table(st1,rc,zip,fname,lname,local);

new_rec := record
  tbz.lname;
  string1	fi := tbz.fname[1];
  tbz.fname;
  unsigned3 zip := (unsigned3)tbz.zip;
  tbz.dt_last_seen;  
  tbz.cnt;
  tbz.b_did;
  tbz.l_did;
  end;

//formal projection
key_cand := PROJECT (table(tbz,new_rec), dx_Header.layouts.i_zip_did);

export data_Key_Prep_Zip_Did := PROJECT (table(tbz,new_rec), dx_Header.layouts.i_zip_did);
//INDEX(KEY_CAND,{key_cand},'key::zip_did'+ thorlib.WUID());