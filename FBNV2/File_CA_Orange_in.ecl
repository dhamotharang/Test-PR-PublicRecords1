import address;
export File_CA_Orange_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Orange::Sprayed',Layout_File_CA_Orange_in.Sprayed, csv(Separator(','), quote('"'), Terminator('\n'), heading(35)));
	export cleaned := DATASET(Cluster.Cluster_In + 'in::fbnv2::ca::orange::cleaned',Layout_File_CA_Orange_in.Cleaned, thor);
	// export cleaned := DATASET(Cluster.Cluster_In + 'thor_data400::in::fbnv2::ca::orange::cleaned',Layout_File_CA_Orange_in.Cleaned, thor);
	
	// export cleaned_Old := project(DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Orange',Layout_File_CA_Orange_in.Cleaned_Old, thor),
																 // transform(FBNV2.Layout_File_CA_Orange_in.Cleaned,
																					 // self.prep_bus_addr_line1 := address.Addr1FromComponents(
																																					// stringlib.stringtouppercase(trim(left.ADDRESS,left,right))
																																					// ,''
																																					// ,''
																																					// ,''
																																					// ,''
																																					// ,''
																																					// ,''),
																					 // self.prep_bus_addr_line_last := address.Addr2FromComponents(
																																						// stringlib.stringtouppercase(trim(left.CITY ))
																																						// ,stringlib.stringtouppercase(trim(left.STATE))
																																						// ,left.ZIP_CODE[1..5]),
																					 // self.prep_owner_addr_line1	 := address.Addr1FromComponents(
																																								// stringlib.stringtouppercase(trim(left.OWNER_ADDRESS,left,right))
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''),
																					 // self.prep_owner_addr_line_last := address.Addr2FromComponents(
																																								// stringlib.stringtouppercase(trim(left.OWNER_CITY ))
																																								// ,stringlib.stringtouppercase(trim(left.OWNER_STATE))
																																								// ,left.OWNER_ZIP_CODE[1..5]),
																					 // self.title 			:= left.pname[1..5],
																					 // self.fname				:= left.pname[6..25],
																					 // self.mname				:= left.pname[26..45],
																					 // self.lname				:= left.pname[46..65],
																					 // self.name_suffix	:= left.pname[66..70],
																					 // self.name_score	:= left.pname[71..73],
																					 // self 						:= left)):persist(Cluster.Cluster_In + 'persist::FBNv2::CA::Orange_Old');
end;