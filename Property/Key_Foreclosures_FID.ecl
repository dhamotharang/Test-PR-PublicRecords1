import doxie, ut, data_services;
//Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
df := property.file_foreclosure_building_bdid(Trim(foreclosure_id, left, right) not in FC_ids);

export Key_Foreclosures_FID := index(df,{string70 fid := foreclosure_id},{df}, Data_Services.Data_location.prefix('foreclosure') + 'thor_Data400::key::foreclosure_fid_' + doxie.Version_SuperKey);
