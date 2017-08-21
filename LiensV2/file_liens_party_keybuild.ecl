import ut, BIPV2;

/* add integer did field */
Layout_liens_party_linkids := record
  LiensV2.Layout_liens_party_ssn;
	BIPV2.IDlayouts.l_xlink_ids;
end;

d_ := project(LiensV2.file_Liens_party_BIPV2,Layout_liens_party_linkids); 

d := table(d_, {d_, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
ds := project(o, transform(Layout_liens_party_linkids, 
														 self.title := if(left.orig_name = 'SPENCER JAMES, ANGELA E','MS',left.title)
														,self.fname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','ANGELA',left.fname)
														,self.mname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','E',left.mname)
														,self.lname := if(left.orig_name = 'SPENCER JAMES, ANGELA E','SPENCER JAMES',left.lname),self := left)) : independent;

export file_liens_party_keybuild := ds ;