import header,ut,gong_build,Liens,Bankrupt;
h := header.File_Headers(zip IN equifax.ReqdZips);


htomatch := h(dt_last_seen=200206,src IN ['EQ','MI']);

rf := record
h.did;
h.tnt;
  end;

ts := table(htomatch,rf);
dids_req := dedup(sort(ts,did,-tnt),did);

count(dids_req);

typeof(header.File_Headers) take_these(h le) := transform
  self := le;
  end;

g := gong_build.File_Extra_Gong((integer)did<>0,publish_code='P');

typeof(header.file_headers) take_from_gong(g le) := transform
  self.did := (integer)le.did;
  self.rid := (integer)le.did;
  self.dt_first_seen := (integer)200207;
  self.dt_last_seen := (integer)200207;
  self.dt_nonglb_last_seen := (integer)200207;
  self.dt_vendor_first_reported := (integer)200207;
  self.dt_vendor_last_reported := (integer)200207;
  self.vendor_id := '';
  self.phone := le.phone10;
  self.src := 'GO';
  self.ssn := '';
  self.dob := 0;
  self.title := le.name_prefix;
  self.fname := le.name_first;
  self.lname := le.name_last;
  self.mname := le.name_middle;
  self.city_name := le.p_city_name;
  self.zip := le.z5;
  self.zip4 := le.z4;
  self.county := le.county_code;
  self.TNT := 'Y';
  self := le;
  end;

from_gong := join(g,dids_req,(integer)left.did=right.did,take_from_gong(left));

COUNT(from_gong);

// Get candidate data from Bankruptcies
Layout_BK_DID := RECORD
unsigned8 did;
string9      ssn;
string5      title;
string20      fname;
string20      mname;
string20      lname;
string5      name_suffix;
string10      prim_range;
string2      predir;
string28      prim_name;
string4      suffix;
string2      postdir;
string10      unit_desig;
string8      sec_range;
string25     city_name;
string2      st;
string5      zip;
string4      zip4;
string3      county;
string4      msa;
END;

// Normalize Bankruptcy debtor and spouse
Layout_BK_DID SplitBKParties(Bankrupt.Layout_BK L, INTEGER cnt) := TRANSFORM
SELF.did := CHOOSE(cnt, L.debtor_did, L.spouse_did);
SELF.ssn := CHOOSE(cnt, L.debtor_ssn, L.spouse_ssn);
SELF.title := '';
SELF.fname := CHOOSE(cnt, L.debtor_first_name, L.spouse_first_name);
SELF.mname := CHOOSE(cnt, L.debtor_middle_name, L.spouse_middle_name);
SELF.lname := CHOOSE(cnt, L.debtor_last_name, L.spouse_last_name);
SELF.name_suffix := CHOOSE(cnt, L.debtor_suffix, L.spouse_suffix);
SELF.prim_range := CHOOSE(cnt, L.prim_range, L.sp_prim_range);
SELF.predir := CHOOSE(cnt, L.predir, L.sp_predir);
SELF.prim_name := CHOOSE(cnt, L.prim_name, L.sp_prim_name);
SELF.suffix := CHOOSE(cnt, L.suffix, L.sp_suffix);
SELF.postdir := CHOOSE(cnt, L.postdir, L.sp_postdir);
SELF.unit_desig := CHOOSE(cnt, L.unit_desig, L.sp_unit_desig);
SELF.sec_range := CHOOSE(cnt, L.sec_range, L.sp_sec_range);
SELF.city_name := CHOOSE(cnt, L.p_city_name, L.sp_p_city_name);
SELF.st := CHOOSE(cnt, L.st, L.sp_st);
SELF.zip := CHOOSE(cnt, L.z5, L.sp_z5);
SELF.zip4 := CHOOSE(cnt, L.zip4, L.sp_zip4);
SELF.county := CHOOSE(cnt, L.county, L.sp_county);
SELF.msa := CHOOSE(cnt, L.msa, L.sp_msa);
SELF := L;
END;

BK_Init := NORMALIZE(Bankrupt.File_BK, 2, SplitBKParties(LEFT, COUNTER));

typeof(header.file_headers) take_from_bankruptcy(Layout_BK_DID le) := transform
  self.did := (integer)le.did;
  self.rid := (integer)le.did;
  self.dt_first_seen := (integer)200207;
  self.dt_last_seen := (integer)200207;
  self.dt_nonglb_last_seen := (integer)200207;
  self.dt_vendor_first_reported := (integer)200207;
  self.dt_vendor_last_reported := (integer)200207;
  self.vendor_id := '';
  self.phone := '';
  self.src := 'BO';
  self.ssn := le.ssn;
  self.dob := 0;
  self.rec_type := '1';
  self := le;
  end;

from_bankruptcy := join(BK_Init(did<>0),dids_req,(integer)left.did=right.did,take_from_bankruptcy(left));

COUNT(from_bankruptcy);

// Get candidate data from Liens
Layout_Liens_DID := RECORD
unsigned8 did;
string9      ssn;
string5      title;
string20      fname;
string20      mname;
string20      lname;
string5      name_suffix;
string10      prim_range;
string2      predir;
string28      prim_name;
string4      suffix;
string2      postdir;
string10      unit_desig;
string8      sec_range;
string25     city_name;
string2      st;
string5      zip;
string4      zip4;
string3      county;
string4      msa;
END;

// Normalize Lien Defendant and CO-Defendant
Layout_Liens_DID SplitDefendants(Liens.Layout_Liens L, INTEGER cnt) := TRANSFORM
SELF.did := CHOOSE(cnt, L.def_did, L.codef_did);
SELF.ssn := CHOOSE(cnt, L.def_ssn, L.codef_ssn);
SELF.title := '';
SELF.fname := CHOOSE(cnt, L.def_first_name, L.codef_first_name);
SELF.mname := CHOOSE(cnt, L.def_middle_name, L.codef_middle_name);
SELF.lname := CHOOSE(cnt, L.def_last_name, L.codef_last_name);
SELF.name_suffix := CHOOSE(cnt, L.def_suffix, L.codef_suffix);
SELF.city_name := L.p_city_name;
SELF.zip := L.z5;
SELF := L;
END;

Liens_Init := NORMALIZE(Liens.File_Liens, 2, SplitDefendants(LEFT, COUNTER));

typeof(header.file_headers) take_from_liens(Layout_Liens_DID le) := transform
  self.did := (integer)le.did;
  self.rid := (integer)le.did;
  self.dt_first_seen := (integer)200207;
  self.dt_last_seen := (integer)200207;
  self.dt_nonglb_last_seen := (integer)200207;
  self.dt_vendor_first_reported := (integer)200207;
  self.dt_vendor_last_reported := (integer)200207;
  self.vendor_id := '';
  self.phone := '';
  self.src := 'LO';
  self.ssn := le.ssn;
  self.dob := 0;
  self.rec_type := '1';
  self := le;
  end;

from_liens := join(Liens_Init(did<>0),dids_req,(integer)left.did=right.did,take_from_liens(left));

COUNT(from_liens);

from_all := from_gong+from_bankruptcy+from_liens;

new_recs := group(from_all,did,all);

d_lseen := if ( new_recs.dt_last_seen=0, new_recs.dt_vendor_last_reported, 
                                         new_recs.dt_last_seen );
tnt_gd := if ( new_recs.tnt='Y',1,0 );

srt_h := sort(new_recs,-d_lseen,-tnt_gd,-dt_first_seen,-dt_vendor_first_reported);

Equifax.Layout_Wide_Hdr into_out(srt_h le) := transform
  self.uid := (string)le.did;
  self.dob := (string)le.dob;
  self := le;
  end;

re_jig := project(srt_h,into_out(left));

Equifax.Layout_Wide_Hdr roll_into_efx(re_jig le, re_jig ri) := transform
  self.fname_2 := if ( le.lname_2='' and (ri.fname<>le.fname or ri.lname<>le.lname), ri.fname, le.fname_2 );
  self.lname_2 := if ( le.lname_2='' and (ri.fname<>le.fname or ri.lname<>le.lname), ri.lname, le.lname_2 );
  self.mname_2 := if ( le.lname_2='' and (ri.fname<>le.fname or ri.lname<>le.lname), ri.mname, le.mname_2 );
  self.title_2 := if ( le.lname_2='' and (ri.fname<>le.fname or ri.lname<>le.lname), ri.title, le.title_2 );
  self.name_suffix_2 := if ( le.lname_2='' and (ri.fname<>le.fname or ri.lname<>le.lname), ri.name_suffix, le.name_suffix_2 );
  self.fname_3 := if ( le.lname_3='' and le.lname_2<>'' and (ri.fname<>le.fname_2 or ri.lname<>le.lname_2) and (ri.fname<>le.fname or ri.lname<>le.lname), ri.fname, le.fname_3 );
  self.lname_3 := if ( le.lname_3='' and le.lname_2<>'' and (ri.fname<>le.fname_2 or ri.lname<>le.lname_2) and (ri.fname<>le.fname or ri.lname<>le.lname), ri.lname, le.lname_3 );
  self.mname_3 := if ( le.lname_3='' and le.lname_2<>'' and (ri.fname<>le.fname_2 or ri.lname<>le.lname_2) and (ri.fname<>le.fname or ri.lname<>le.lname), ri.mname, le.mname_3 );
  self.title_3 := if ( le.lname_3='' and le.lname_2<>''  and (ri.fname<>le.fname_2 or ri.lname<>le.lname_2)and (ri.fname<>le.fname or ri.lname<>le.lname), ri.title, le.title_3 );
  self.name_suffix_3 := if ( le.lname_3='' and le.lname_2<>''  and (ri.fname<>le.fname_2 or ri.lname<>le.lname_2) and (ri.fname<>le.fname or ri.lname<>le.lname), ri.name_suffix, le.name_suffix_3 );
  self.prim_range_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.prim_range, le.prim_range_2 );
  self.prim_name_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.prim_name, le.prim_name_2 );
  self.zip_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.zip, le.zip_2 );
  self.zip4_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.zip4, le.zip4_2 );
  self.st_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.st, le.st_2 );
  self.predir_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.predir, le.predir_2 );
  self.suffix_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.suffix, le.suffix_2 );
  self.postdir_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.postdir, le.postdir_2 );
  self.unit_desig_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.unit_desig, le.unit_desig_2 );
  self.sec_range_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.sec_range, le.sec_range_2 );
  self.city_name_2 := if ( le.prim_name_2='' and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.city_name, le.city_name_2 );
  self.prim_range_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range ) and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.prim_range, le.prim_range_3 );
  self.prim_name_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.prim_name, le.prim_name_3 );
  self.zip_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.zip, le.zip_3 );
  self.zip4_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.zip4, le.zip4_3 );
  self.st_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.st, le.st_3 );
  self.predir_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.predir, le.predir_3 );
  self.suffix_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.suffix, le.suffix_3 );
  self.postdir_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.postdir, le.postdir_3 );
  self.unit_desig_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.unit_desig, le.unit_desig_3 );
  self.sec_range_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.sec_range, le.sec_range_3 );
  self.city_name_3 := if ( le.prim_name_3='' and le.prim_name_2<>'' and (le.prim_name_2<>ri.prim_name or le.prim_range_2<>ri.prim_range )and (le.prim_name<>ri.prim_name or le.prim_range<>ri.prim_range ), ri.city_name, le.city_name_3 );
  self.ssn := if ( (integer)le.ssn=0,ri.ssn,le.ssn );
  self.dob := if ( (integer)le.dob=0,ri.dob,le.dob );
  self.phone := if ( (integer)le.phone=0,ri.phone,le.phone );
  self := le;
  end;

res := rollup(re_jig,left.uid=right.uid,roll_into_efx(left,right));

output(res,,'DBTEMP::Intermed_EFX_File');

layout_hitlist := record
from_all.did;
from_all.tnt;
  end;

hitlist := dedup(sort( table(from_all,layout_hitlist),did,-tnt),did);

COUNT(hitlist);

hit_rec := record
  integer8 did;
  boolean matched;
  boolean tnt_match;
  end;

hit_rec cop(rf le, layout_hitlist ri) := transform
  self.did := le.did;
  self.tnt_match := ri.tnt='Y' or le.tnt='Y';
  self.matched := ri.did=le.did;
  end;

hits := join(dids_req,hitlist,left.did=right.did,cop(left,right),left outer);

count(hits(matched,tnt_match));
count(hits(matched,~tnt_match));
count(hits(~matched,tnt_match));
count(hits(~matched,~tnt_match));