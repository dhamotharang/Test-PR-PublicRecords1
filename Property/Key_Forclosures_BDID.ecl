import doxie;

df := property.File_Forclosures_BDID(bdid != 0);

export Key_Forclosures_BDID := index(df,{bdid},{string70 fid := foreclosure_id},'~thor_Data400::key::property_forclosure_bdid_' + doxie.Version_SuperKey);
