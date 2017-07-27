import doxie,ut;

df := faa.searchFile(bdid_out != '');

export Key_Aircraft_Reg_BDID := index(df,{unsigned6 bd := (integer)bdid_out},{n_number,aircraft_id},'~thor_data400::key::aircraft_reg_bdid_' + doxie.Version_SuperKey);
