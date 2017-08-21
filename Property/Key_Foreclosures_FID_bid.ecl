import doxie, ut;

df := property.file_foreclosure_building_bid;

export Key_Foreclosures_FID_bid := index(df,{string70 fid := foreclosure_id},{df},'~thor_Data400::key::foreclosure_fid_bid_' + doxie.Version_SuperKey);
