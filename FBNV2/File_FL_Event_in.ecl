import address, ut;

export File_FL_Event_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Event::Sprayed',Layout_File_FL_in.Sprayed.Event, flat);
	export cleaned := DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Event::Cleaned',Layout_File_FL_in.Cleaned.Event, flat);

	// export cleaned_old := project(dataset(Cluster.Cluster_In + 'in::FBNv2::FL::Event',Layout_File_FL_in.Cleaned.Event_Old, flat),
																 // transform(FBNV2.Layout_File_FL_in.Cleaned.Event,
																					 // self.ACTION_OLD_COUNTRY_DESC := left.ACTION_OLD_COUNTRY,
																					 // self.ACTION_NEW_COUNTRY_DESC := left.ACTION_NEW_COUNTRY,																					 
																					 // self.prep_old_addr_line1 := address.Addr1FromComponents(
																																							// stringlib.stringtouppercase(trim(left.ACTION_OLD_ADDR1,left,right))
																																							// ,stringlib.stringtouppercase(trim(left.ACTION_OLD_ADDR2,left,right))
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''),
																					 // self.prep_old_addr_line_last := address.Addr2FromComponents(
																																							// stringlib.stringtouppercase(trim(left.ACTION_OLD_CITY ))
																																							// ,stringlib.stringtouppercase(trim(left.ACTION_OLD_STATE))
																																							// ,left.ACTION_OLD_ZIP5),
																					
																					 // self.prep_new_addr_line1 := address.Addr1FromComponents(
																																							// stringlib.stringtouppercase(trim(left.ACTION_NEW_ADDR1,left,right))
																																							// ,stringlib.stringtouppercase(trim(left.ACTION_NEW_ADDR2,left,right))
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''),
																					 // self.prep_new_addr_line_last := address.Addr2FromComponents(
																																							// stringlib.stringtouppercase(trim(left.ACTION_NEW_CITY ))
																																							// ,stringlib.stringtouppercase(trim(left.ACTION_NEW_STATE))
																																							// ,left.ACTION_NEW_ZIP5),
																																							
																					 // self.prep_owner_addr_line1 := address.Addr1FromComponents(
																																							// stringlib.stringtouppercase(trim(left.ACTION_OWN_ADDRESS,left,right))
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''),
																					 // self.prep_owner_addr_line_last := address.Addr2FromComponents(
																																							// stringlib.stringtouppercase(trim(left.ACTION_OWN_CITY ))
																																							// ,stringlib.stringtouppercase(trim(left.ACTION_OWN_STATE))
																																							// ,left.ACTION_OWN_ZIP5),
																					 // self.Owner_title 				:= left.pname[1..5],
																					 // self.Owner_fname					:= left.pname[6..25],
																					 // self.Owner_mname					:= left.pname[26..45],
																					 // self.Owner_lname					:= left.pname[46..65],
																					 // self.Owner_name_suffix		:= left.pname[66..70],
																					 // self.Owner_name_score		:= left.pname[71..73],
																					 // self 										:= left)):persist(Cluster.Cluster_Out + 'persist::FBNv2::FL::Event_Old');

end;
 
