import business_header,business_header_ss,ut,did_add,TopBusiness_External,MDR;

df := vickers.File_insider_filing_In;

outrec := vickers.Layout_insider_filing_base;

outrec into_out(df L) := transform
	self.bdid := 0;
	self := l;
end;

df2 := project(df,into_out(LEFT));

business_header.MAC_Source_Match( df2,outf1,
																	false,bdid,
																	false,'V',
																	false,foo,
																	filer_name,
																	prim_range,prim_name,sec_range,zip,
																	false,foo,
																	false,foo);
myset := ['A'];
							
Business_Header_SS.MAC_Add_BDID_Flex( outf1									 			  									// Input Dataset						
																			,myset                                				 // BDID Matchset           
																			,filer_name        		             		        // company_name	              
																			,prim_range		                               // prim_range		              
																			,prim_name		                         			// prim_name		              
																			,zip 					                       		 	 // zip5					              
																			,sec_range		                            // sec_range		              
																			,st				                               // state				              
																			,foo			           										// phone				              
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
																			,name_first  							// fname
																			,name_middle		 				 // mname
																			,name_last							// lname
																		);							
							
ut.MAC_SF_BuildProcess(dPostFlex,'~thor_data400::base::vickers_insider_filing_base',do1,2);

export make_insider_filing_bdid := do1;