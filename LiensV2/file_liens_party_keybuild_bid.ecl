import ut;

/* add integer did field */
d := table(Liensv2.file_liens_party, {Liensv2.file_liens_party, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
ds := project(o, transform(LiensV2.Layout_liens_party_ssn_bid, self := left));

export file_liens_party_keybuild_bid := ds ;