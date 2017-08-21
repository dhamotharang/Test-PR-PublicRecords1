import doxie, ut, NID;

layout_auto_phone := record
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
END;

layout_auto_phone proj(file_cwp_with_fdid le) := TRANSFORM
  SELF.p7 := le.phonenumber[4..10];
  SELF.p3 := le.phonenumber[1..3];
  SELF.dph_lname := metaphonelib.DMetaPhone1(le.lastname);
  SELF.pfname := NID.PreferredFirstVersionedStr(le.firstname, NID.version);
  SELF.st := le.province;
  SELF.did := le.fdid;
END;

p := PROJECT(file_cwp_with_fdid, proj(LEFT));

//concat phone for suppression macro
layout_phone_concat := record
p;
string10 phone;
end;

layout_phone_concat proj2(p le) := transform
self.phone 	:= le.p3 + le.p7;
self 		:= le;
end;

p2 := project(p, proj2(left));

//activate phone supression macro
ut.mac_suppress_by_phonetype(p2,phone,st,ph_p2_out,true,did);

//remove suppressed phones
layout_auto_phone proj3(ph_p2_out le) := transform
self.p3 := le.phone[1..3];
self.p7 := le.phone[4..10];
self	:= le;
end;

p3 := project(ph_p2_out, proj3(left));

//dedup phone records
recs := DEDUP(SORT(p3((integer)p7<>0),record),record);
  
export key_auto_phone := INDEX(recs, {recs}, '~thor_data400::key::canadianwp_phone_' + doxie.Version_SuperKey);