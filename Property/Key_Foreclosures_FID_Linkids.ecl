import doxie, ut, BIPV2;
/*
//property.file_foreclosure_building_bdid
df := 	project(file_foreclosure_building,*/

//Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];

//property.file_foreclosure_building_bdid
df := 	project(file_foreclosure_building(Trim(foreclosure_id, left, right) not in FC_ids),
		transform({Layout_Fares_Foreclosure, 
							 BIPV2.IDlayouts.l_xlink_ids name1,
							 BIPV2.IDlayouts.l_xlink_ids name2,
							 BIPV2.IDlayouts.l_xlink_ids name3,
							 BIPV2.IDlayouts.l_xlink_ids name4},
			self := left));

export Key_Foreclosures_FID_Linkids := index(df,{string70 fid := foreclosure_id},{df},'~thor_Data400::key::foreclosure_fid::Linkids_' + doxie.Version_SuperKey);

