import bankruptcyv2, ut;

/* add integer did field */
d := table(bankruptcyv2.file_bankruptcy_search_v3, {bankruptcyv2.file_bankruptcy_search_v3, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
dp := project(o, transform(BankruptcyV2.layout_bankruptcy_search_v3, self := left));

export file_bankruptcy_search_keybuild := dp;