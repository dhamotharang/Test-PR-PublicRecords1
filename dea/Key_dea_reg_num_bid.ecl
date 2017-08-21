import doxie;

df := dea.File_DEA_bid(Dea_Registration_Number != '');

export Key_dea_reg_num_bid := index(df,{Dea_Registration_Number},{df},'~thor_data400::key::dea::' + doxie.Version_SuperKey + '::bid::reg_num');
