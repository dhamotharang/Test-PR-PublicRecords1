import doxie,ut;

df := faa.searchFile_bid(bdid_out != '');

export Key_Aircraft_Reg_BID := index(df,{unsigned6 bd := (integer)bdid_out},{n_number,aircraft_id},'~thor_data400::key::aircraft_reg_bid_' + doxie.Version_SuperKey);
