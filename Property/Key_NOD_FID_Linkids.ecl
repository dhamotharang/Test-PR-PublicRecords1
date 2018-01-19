import doxie, BIPV2, Data_Services;

//property.file_nod_building_bdid
df := project(File_NOD_Building,
		transform({Layout_Fares_Foreclosure, 
							 BIPV2.IDlayouts.l_xlink_ids name1,
							 BIPV2.IDlayouts.l_xlink_ids name2,
							 BIPV2.IDlayouts.l_xlink_ids name3,
							 BIPV2.IDlayouts.l_xlink_ids name4},
			self := left));	

export Key_NOD_FID_Linkids := index(df,{string70 fid := foreclosure_id},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::nod::' + doxie.Version_SuperKey + '::fid::linkids');