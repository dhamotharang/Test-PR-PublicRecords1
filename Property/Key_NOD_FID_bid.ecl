import doxie, ut;

df := property.file_nod_building_bid;

export Key_NOD_FID_bid := index(df,{string70 fid := foreclosure_id},{df},'~thor_Data400::key::nod::' + doxie.Version_SuperKey + '::fid_bid');