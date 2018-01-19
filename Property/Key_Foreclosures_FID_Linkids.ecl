import doxie, BIPV2, Data_Services;

//property.file_foreclosure_building_bdid
df := 	project(file_foreclosure_building,
		transform({Layout_Fares_Foreclosure, 
							 BIPV2.IDlayouts.l_xlink_ids name1,
							 BIPV2.IDlayouts.l_xlink_ids name2,
							 BIPV2.IDlayouts.l_xlink_ids name3,
							 BIPV2.IDlayouts.l_xlink_ids name4},
			self := left));

export Key_Foreclosures_FID_Linkids := index(df,{string70 fid := foreclosure_id},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::foreclosure_fid::Linkids_' + doxie.Version_SuperKey);
