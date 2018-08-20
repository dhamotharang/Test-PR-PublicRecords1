export File_CA_Santa_Clara_in := module
	export raw 		 := dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Santa_Clara::Sprayed',Layout_File_CA_Santa_Clara_in.Sprayed,
                            CSV(HEADING(1),SEPARATOR(','),QUOTE('"')));
                            
	export cleaned := dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Santa_Clara::Cleaned',Layout_File_CA_Santa_Clara_in.Cleaned, flat);
	
	// export cleaned_old := dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Santa_Clara::Cleaned_Old_Patch',Layout_File_CA_Santa_Clara_in.Cleaned, flat);
	// export cleaned_old := project(dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Santa_Clara',Layout_File_CA_Santa_Clara_in.Cleaned_Old, flat),
																 // transform(FBNV2.Layout_File_CA_Santa_Clara_in.Cleaned,
																					 // self.prep_addr_line1 		:= address.Addr1FromComponents(
																																				// stringlib.stringtouppercase(trim(left.BUSINESS_ADDR1,left,right))
																																				// ,stringlib.stringtouppercase(trim(left.BUSINESS_ADDR2,left,right))
																																				// ,''
																																				// ,''
																																				// ,''
																																				// ,''
																																				// ,'');
																					 // self.prep_addr_line_last	:= address.Addr2FromComponents(
																																				// trim(left.BUS_CITY )
																																				// ,trim(left.BUS_ST)
																																				// ,left.BUS_zip[1..5]),
																					 // self.Owner_title 				:= left.Clean_name[1..5],
																					 // self.Owner_fname					:= left.Clean_name[6..25],
																					 // self.Owner_mname					:= left.Clean_name[26..45],
																					 // self.Owner_lname					:= left.Clean_name[46..65],
																					 // self.Owner_name_suffix		:= left.Clean_name[66..70],
																					 // self.Owner_name_score		:= left.Clean_name[71..73],
																					 // self 										:= left)):persist(Cluster.Cluster_In + 'persist::FBNv2::CA::Santa_Clara_Old');
end;
