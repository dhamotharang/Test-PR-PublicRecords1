import bankruptcyv2, ut;

/* add integer did field */
d := table(BankruptcyV2.file_bankruptcy_search_v3_supp, {BankruptcyV2.file_bankruptcy_search_v3_supp, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,phone,st,o,true,idid);

/* removed extra field */
dp := project(o, transform(BankruptcyV2.layout_bankruptcy_search_v3_supp, self := left));

export file_bankruptcy_search_keybuild := dp;