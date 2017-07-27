import ut;

/* add integer did field */
d := table(bankruptcyv2.file_bankruptcy_search, {bankruptcyv2.file_bankruptcy_search, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
dp := project(o, transform(BankruptcyV2.layout_bankruptcy_search, self := left));

export file_bankruptcy_search_keybuild := dp;