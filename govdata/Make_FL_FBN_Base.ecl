import business_header, business_header_ss, did_add, mdr, BIPV2, PromoteSupers;

df 		 := govdata.File_FL_FBN_In;
outrec := govdata.layout_fl_fbn_base;

outrec into_out(df L) := transform
	self.bdid := 0;
	self 			:= L;
end;

df2 := project(df,into_out(LEFT));

business_header.MAC_Source_Match(df2,outf1,
																 false,bdid,
																 false,MDR.sourceTools.src_FL_FBN,
																 false,foo,
																 fic_fil_name,
																 fic_fil_prim_range,fic_fil_prim_name,fic_fil_sec_range,fic_fil_zip,
																 false,foo,
																 true,fic_fil_fei_num);
							
myset := ['A','F'];

Business_Header_SS.MAC_Add_BDID_Flex(outf1       									 					   // Input Dataset						
																		,myset                                    // BDID Matchset           
																		,fic_fil_name        		             		 // company_name	              
																		,fic_fil_prim_range		                  // prim_range		              
																		,fic_fil_prim_name		                 // prim_name		              
																		,fic_fil_zip						              // zip5					              
																		,fic_fil_sec_range		               // sec_range		              
																		,fic_fil_st				                  // state				              
																		,foo								           	 	 // phone				              
																		,fic_fil_fei_num									// fein              
																		,bdid											       // bdid												
																		,outrec												  // Output Layout 
																		,false                         // output layout has bdid score field?                       
																		,foo            						  // bdid_score                 
																		,postFlex                    // Output Dataset   
																		,														// deafult threscold
																		,													 // use prod version of superfiles
																		,													// default is to hit prod from dataland, and on prod hit prod.		
																		,BIPV2.xlink_version_set // Create BIP Keys only
																		,           						// Url
																		,								       // Email
																		,fic_fil_p_city_name	// City
																		,fic_owner1_fname		 // First Name
																		,fic_owner1_mname		// Middle Name
																		,fic_owner1_lname  // Last Name
																	);

PromoteSupers.MAC_SF_BuildProcess(postFlex,'~thor_Data400::base::fl_fbn_base',do1,2);

export make_FL_FBN_Base := do1;

