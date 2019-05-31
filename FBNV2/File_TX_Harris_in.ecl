import address, ut;

export File_TX_Harris_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::TX::Harris::Sprayed', Layout_File_TX_Harris_in.combinedSprayed, flat);
	export cleaned := dataset(Cluster.Cluster_In + 'in::FBNv2::TX::Harris::Cleaned', Layout_File_TX_Harris_in.Cleaned, thor);
	
	// export cleaned_old := project(dataset(Cluster.Cluster_In + 'in::FBNv2::TX::Harris',Layout_File_TX_Harris_in.Cleaned_Old, flat),
																 // transform(FBNV2.Layout_File_TX_Harris_in.Cleaned,
																					 // self.prep_addr1_line1 		 := address.Addr1FromComponents(
																																							// stringlib.stringtouppercase(trim(left.STREET_ADD1,left,right))
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''),
																					 // self.prep_addr1_line_last := address.Addr2FromComponents(
																																							// trim(left.CITY1 )
																																							// ,trim(left.STATE1)
																																							// ,left.ZIP1[1..5]),
																					
																					 // self.prep_addr2_line1 		 := address.Addr1FromComponents(
																																							// stringlib.stringtouppercase(trim(left.STREET_ADD2,left,right))
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''
																																							// ,''),
																					 // self.prep_addr2_line_last := address.Addr2FromComponents(
																																							// trim(left.CITY2 )
																																							// ,trim(left.STATE2)
																																							// ,left.ZIP2[1..5]),
																					 // self.name1_title 				:= left.pname[1..5],
																					 // self.name1_fname					:= left.pname[6..25],
																					 // self.name1_mname					:= left.pname[26..45],
																					 // self.name1_lname					:= left.pname[46..65],
																					 // self.name1_name_suffix		:= left.pname[66..70],
																					 // self.name1_name_score		:= left.pname[71..73],
																					 // self.name2_title 				:= left.pname1[1..5],
																					 // self.name2_fname					:= left.pname1[6..25],
																					 // self.name2_mname					:= left.pname1[26..45],
																					 // self.name2_lname					:= left.pname1[46..65],
																					 // self.name2_name_suffix		:= left.pname1[66..70],
																					 // self.name2_name_score		:= left.pname1[71..73],
																					 // self 										:= left,
																					 // self                     := [])):persist(Cluster.Cluster_Out + 'persist::FBNv2::TX::Harris_Old');

end;