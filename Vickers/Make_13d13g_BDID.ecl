import business_header,business_header_ss,ut,did_add,MDR;

df := vickers.File_13d13g_In;

outrec := Vickers.layout_13d13g_base;

outrec into_out(df L) := transform
	self.bdid := 0;
	self 			:= l;
end;

df2 := project(df,into_out(LEFT));

business_header.MAC_Source_Match( df2,outf1,
																	false,bdid,
																	false,'V',
																	false,foo,
																	filer_name,
																	prim_range,prim_name,sec_range,zip,
																	true,contact_phone,
																	false,foo);
							
myset := ['A','P'];
Business_Header_SS.MAC_Add_BDID_Flex( outf1									 			  									// Input Dataset						
																			,myset                                				 // BDID Matchset           
																			,filer_name        		             		        // company_name	              
																			,prim_range		                               // prim_range		              
																			,prim_name		                         			// prim_name		              
																			,zip 					                       		 	 // zip5					              
																			,sec_range		                            // sec_range		              
																			,st				                               // state				              
																			,contact_phone			           					// phone				              
																			,foo                             			 // fein              
																			,bdid											 					  // bdid												
																			,outrec	   													 // Output Layout 
																			,false                       			  // output layout has bdid score field?                       
																			,foo                         			 // bdid_score                 
																			,dPostFlex          						  // Output Dataset   
																			,																 // deafult threscold
																			,													 			// use prod version of superfiles
																			,															 // default is to hit prod from dataland, and on prod hit prod.		
																			,BIPV2.xlink_version_set 			// Create BIP Keys only
																			,           								 // Url
																			,								            // Email
																			,P_city_name							 // City
																			,contact_name_first			  // fname
																			,contact_name_middle		 // mname
																			,contact_name_last			// lname
																		);							
ut.MAC_SF_BuildProcess(dPostFlex,'~thor_data400::base::vickers_13d13g_base',do1,2);

export Make_13d13g_BDID := do1;