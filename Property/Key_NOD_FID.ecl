import doxie, ut;

// df := property.file_nod_building_bdid;
// Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
df := Property.file_nod_building_bdid(Trim(foreclosure_id, left, right) not in FC_ids);

export Key_NOD_FID := index(df,{string70 fid := foreclosure_id},{df},'~thor_Data400::key::nod::' + doxie.Version_SuperKey + '::fid');