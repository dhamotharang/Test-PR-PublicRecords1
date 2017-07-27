import doxie,ut;

df := faa.searchFile_bid(n_number != '');

export Key_Aircraft_Reg_NNum_bid := index(df,{n_number,aircraft_id},{df},'~thor_Data400::key::aircraft_reg_nnum_bid_' + doxie.Version_SuperKey);
