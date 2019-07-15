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

st2 := dedup(sort(tt,zip,fname,lname,mname,name_suffix,did,-dt_last_seen,local),
            zip,fname,lname,mname,name_suffix,did,local);

rc2 := record
	st2.fname;
	st2.mname;
	st2.lname;
	st2.name_suffix;
	st2.zip;
     unsigned4 dt_last_seen := max(group,st2.dt_last_seen);
     unsigned4 cnt := count(group);
     unsigned6 b_did := max(group,st2.did);
     unsigned6 l_did := min(group,st2.did);
end;

tbz2 := table(st2,rc2,zip,fname,lname,mname,name_suffix,local);

dx_Header.layouts.i_zip_did_full into_full(tbz2 le) := transform
  self.p_lname := metaphonelib.dmetaphone1(le.lname);
  self.p_fname  := datalib.preferredfirst(le.fname);
  self.zip := (unsigned3)le.zip;
  self.mi := ((string)Le.mname)[1];
  self := le;
  end;

key_cand_2 := project(tbz2,into_full(LEFT));

export data_Key_Prep_Zip_Did_Full := key_cand_2;
// index(key_cand_2,{p_lname,
// 							p_fname,zip,lname,fname},
// 							{mname,mi,
// 							name_suffix,dt_last_seen,
// 							cnt,b_did,l_did},'key::zip_did_full' + thorlib.WUID());