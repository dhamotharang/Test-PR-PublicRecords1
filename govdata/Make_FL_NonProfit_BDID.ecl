import business_header,business_header_ss,did_add,mdr,PromoteSupers;

df := govdata.File_FL_Non_Profit_Corp_In;

govdata.Layout_FL_Non_Profit_Corp_Base into_base(df L) := transform
	self.bdid := 0;
	self 			:= l;
end;

df2 := project(df,into_base(LEFT));

business_header.MAC_Source_Match(df2,outf,	
						false, bdid,
						false,MDR.sourceTools.src_FL_Non_Profit,
						false,foo,
						ANNUAL_COR_NAME,
						corp_prim_range,corp_prim_name,corp_sec_range,corp_zip,
						false,corp_phone,
						true,ANNUAL_COR_FEI_NUMBER);
						
myset := ['A','F'];
					
Business_Header_SS.MAC_Add_BDID_Flex(outf       									 					   // Input Dataset						
																		,myset                                    // BDID Matchset           
																		,annual_cor_name        		             // company_name	              
																		,corp_prim_range		                    // prim_range		              
																		,corp_prim_name		                     // prim_name		              
																		,corp_zip						                  // zip5					              
																		,corp_sec_range		                   // sec_range		              
																		,corp_st				                    // state				              
																		,phone								           	 // phone				              
																		,annual_cor_fei_number						// fein              
																		,bdid											       // bdid												
																		,govdata.Layout_FL_Non_Profit_Corp_Base		// Output Layout 
																		,false                         // output layout has bdid score field?                       
																		,score            						// bdid_score                 
																		,postFlex                    // Output Dataset   
																		,														// deafult threscold
																		,													 // use prod version of superfiles
																		,													// default is to hit prod from dataland, and on prod hit prod.		
																		,BIPV2.xlink_version_set // Create BIP Keys only
																		,           						// Url
																		,								       // Email
																		,corp_p_city_name		  // City
																		,princ1_fname				 // First Name
																		,princ1_mname				// Middle Name
																		,princ1_lname      // Last Name
																	);

PromoteSupers.MAC_SF_BuildProcess(postFlex,'~thor_data400::base::FL_NonProfit_bdid',do1,2);

export Make_FL_NonProfit_BDID := do1;

