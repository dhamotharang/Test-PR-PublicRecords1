import doxie, ut,BIPV2;
// df_in := Property.File_NOD_Building;

// Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
df_in := Property.File_NOD_Building(Trim(foreclosure_id, left, right) not in FC_ids);


//property.file_nod_building_bdid
df := project(df_in,
		transform({Layout_Fares_Foreclosure, 
							 BIPV2.IDlayouts.l_xlink_ids name1,
							 BIPV2.IDlayouts.l_xlink_ids name2,
							 BIPV2.IDlayouts.l_xlink_ids name3,
							 BIPV2.IDlayouts.l_xlink_ids name4},
			self := left));	

export Key_NOD_FID_Linkids := index(df,{string70 fid := foreclosure_id},{df},'~thor_Data400::key::nod::' + doxie.Version_SuperKey + '::fid::linkids');