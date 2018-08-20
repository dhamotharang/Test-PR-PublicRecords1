import address, ut;

export File_FL_Filing_in := module
	export raw 		 			:= DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Filing::Sprayed',Layout_File_FL_in.Sprayed.Filing, flat);
	export cleaned 			:= DATASET(Cluster.Cluster_In + 'in::FBNv2::FL::Filing::Cleaned',Layout_File_FL_in.Cleaned.Filing, flat);

	// export cleaned_old := project(dataset(Cluster.Cluster_In + 'in::FBNv2::FL::Filing',Layout_File_FL_in.Cleaned.Filing_Old, flat),
																 // transform(FBNV2.Layout_File_FL_in.Cleaned.Filing,
																					 // self.FIC_FIL_COUNTRY_DEC				:= left.FIC_FIL_COUNTRY,	
																					 // self.FIC_OWNER_COUNTRY_DEC			:= left.FIC_OWNER_COUNTRY,	
																					 // self.C_OWNER_NAME							:= left.clean_name,	
																					 // self.prep_addr_line1 					:= address.Addr1FromComponents(
																																								// stringlib.stringtouppercase(trim(left.FIC_FIL_ADDR1,left,right))
																																								// ,stringlib.stringtouppercase(trim(left.FIC_FIL_ADDR2,left,right))
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''),
																					 // self.prep_addr_line_last 			:= address.Addr2FromComponents(
																																								// stringlib.stringtouppercase(trim(left.FIC_FIL_CITY ))
																																								// ,stringlib.stringtouppercase(trim(left.FIC_FIL_STATE))
																																								// ,trim(left.FIC_FIL_ZIP5)),
																																								
																					 // self.prep_owner_addr_line1 		:= address.Addr1FromComponents(
																																								// stringlib.stringtouppercase(trim(left.FIC_OWNER_ADDR,left,right))
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''),
																					 // self.prep_owner_addr_line_last:= address.Addr2FromComponents(
																																								// stringlib.stringtouppercase(trim(left.FIC_OWNER_CITY ))
																																								// ,stringlib.stringtouppercase(trim(left.FIC_OWNER_STATE))
																																								// ,left.FIC_OWNER_ZIP5),
																					 // self 										:= left)):persist(Cluster.Cluster_Out + 'persist::FBNv2::FL::Filing_Old');
end;
 