import address, ut;

export File_CA_Ventura_in := module
	export raw 		 := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Ventura::Sprayed',Layout_File_CA_Ventura_in.Sprayed, 
																			csv(separator('~'),quote('"'),terminator('\r\n')));
	export cleaned := DATASET(Cluster.Cluster_In + 'in::FBNv2::CA::Ventura::Cleaned',Layout_File_CA_Ventura_in.Cleaned, thor);
	
	// export cleaned_old := project(dataset(Cluster.Cluster_In + 'in::FBNv2::CA::Ventura',Layout_File_CA_Ventura_in.Cleaned_Old, flat),
																 // transform(FBNV2.Layout_File_CA_Ventura_in.Cleaned,
																					 // self.mail_city						:= left.clean_mail_address[90..114],
																					 // self.prep_bus_addr_line1 := address.Addr1FromComponents(
																																								// stringlib.stringtouppercase(trim(left.business_street,left,right))
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''),
																					 // self.prep_bus_addr_line_last := address.Addr2FromComponents(
																																								// stringlib.stringtouppercase(trim(left.business_city ))
																																								// ,stringlib.stringtouppercase(trim(left.business_state))
																																								// ,left.business_zip5),
																						
																					 // self.prep_mail_addr_line1 := address.Addr1FromComponents(
																																								// stringlib.stringtouppercase(trim(left.mail_street,left,right))
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''),
																					 // self.prep_mail_addr_line_last := address.Addr2FromComponents(
																																								// stringlib.stringtouppercase(trim(left.clean_mail_address[90..114] ))
																																								// ,stringlib.stringtouppercase(trim(left.mail_state))
																																								// ,left.mail_zip5),
																																								
																					 // self.prep_owner_addr_line1 := address.Addr1FromComponents(
																																								// stringlib.stringtouppercase(trim(left.owner_address,left,right))
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''
																																								// ,''),
																					 // self.prep_owner_addr_line_last := address.Addr2FromComponents(
																																								// stringlib.stringtouppercase(trim(left.owner_city ))
																																								// ,stringlib.stringtouppercase(trim(left.owner_state))
																																								// ,left.owner_zipcode5),
																					 // self.Owner_cln_title 				:= left.pname[1..5],
																					 // self.Owner_cln_fname					:= left.pname[6..25],
																					 // self.Owner_cln_mname					:= left.pname[26..45],
																					 // self.Owner_cln_lname					:= left.pname[46..65],
																					 // self.Owner_cln_name_suffix		:= left.pname[66..70],
																					 // self.Owner_cln_name_score		:= left.pname[71..73],
																					 // self 										:= left)):persist(Cluster.Cluster_Out + 'persist::FBNv2::CA::Ventura_Old');

end;