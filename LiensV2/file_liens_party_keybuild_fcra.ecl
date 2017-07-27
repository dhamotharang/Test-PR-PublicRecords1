import ut, BIPV2;

/* add integer did field */
d := table(LiensV2.file_liens_fcra_party, {LiensV2.file_liens_fcra_party, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
ds := project(o, transform({LiensV2.Layout_liens_party_ssn, BIPV2.IDlayouts.l_xlink_ids},
														 self.title := if(left.orig_name = 'SPENCER JAMES, ANGELA E','MS',left.title)
														,self.fname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','ANGELA',left.fname)
														,self.mname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','E',left.mname)
														,self.lname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','SPENCER JAMES',left.lname),self := left));

export file_liens_party_keybuild_fcra := ds; 