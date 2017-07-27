import bankruptcyv2, ut;

/* add integer did field */
d := table(bankruptcyv2.file_bankruptcy_main_v3, {bankruptcyv2.file_bankruptcy_main_v3, idid := (integer8)did});

/* suppress WA cellphones */
ut.mac_suppress_by_phonetype(d,trusteePhone,st,o,true,idid);

/* removed extra field */
dp := project(o, transform(BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing, self := left));

export file_bankruptcy_main_keybuild := dp;