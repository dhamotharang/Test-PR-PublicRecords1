IMPORT Business_Header, Business_Header_SS, ut, DID_Add, Address, MDR, BIPV2, PromoteSupers;

#workunit('name', 'Govt Phones Base Creation ' + govdata.Gov_Phones_Build_Date);

gov_in := dedup(govdata.File_Gov_Phones_In, all);

govdata.Layout_Gov_Phones_Base AddFields(gov_in l, INTEGER ct) := TRANSFORM
		SELF.bdid 				 := 0;
		SELF.unique_id 		 := govdata.Gov_Phones_Build_Date + INTFORMAT(ct, 12, 1);
		SELF.phone 				 := (UNSIGNED6) (if(length(trim(Stringlib.StringFilter(l.area_code_1, '0123456789'))) = 3, l.area_code_1, '000')
																			+ if((Address.CleanPhone(l.phone_1))[4..10] <> '', (Address.CleanPhone(l.phone_1))[4..10], '0000000'));
		SELF.agency 			 := stringlib.StringToUpperCase(l.agency);
		SELF.p_city_name 	 := if(l.p_city_name <> '', l.p_city_name, Stringlib.StringToUpperCase(l.city));  // Fix city field if address did not clean
		SELF.v_city_name   := if(l.v_city_name <> '', l.v_city_name, Stringlib.StringToUpperCase(l.city));
		SELF.st 					 := if(l.st <> '', l.st, l.state);  // Fix st field if address did not clean
		SELF 						   := l;
END;

gov_base := PROJECT(gov_in, AddFields(LEFT, COUNTER));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(gov_base, gov_base_BDID_Init,
																 FALSE, bdid,
																 FALSE, MDR.sourceTools.src_Employee_Directories,
																 FALSE, source_group_field,
																 agency,
																 prim_range, prim_name, sec_range, zip,
																 TRUE, phone,
																 FALSE, fein_field
																 );
// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];
Business_Header_SS.MAC_Add_BDID_Flex(gov_base_BDID_Init 									 	  	    // Input Dataset						
																		,BDID_Matchset                               // BDID Matchset           
																		,agency        		         								  // company_name	              
																		,prim_range		                             // prim_range		              
																		,prim_name		                         	  // prim_name		              
																		,zip 					                       		 // zip5					              
																		,sec_range		                          // sec_range		              
																		,st				                             // state				              
																		,phone			           								// phone				              
																		,fein_field                          // fein              
																		,bdid										 					  // bdid												
																		,govdata.Layout_Gov_Phones_Base 	 // Output Layout 
																		,false                         	  // output layout has bdid score field?                       
																		,BDID_score_field                // bdid_score                 
																		,dPostFlex             					// Output Dataset   
																		,															 // deafult threscold
																		,													 		// use prod version of superfiles
																		,														 // default is to hit prod from dataland, and on prod hit prod.		
																		,BIPV2.xlink_version_set 	  // Create BIP Keys only
																		,           							 // Url
																		,email								    // Email
																		,p_city_name						 // City
																		,name_first						  // fname
																		,name_middle					 // mname
																		,name_last						// lname
																	);

ut.mac_suppress_by_phonetype(dPostFlex,phone,st,cleaned_gov_base);

/* OUTPUT(gov_base_BDID_All,, 
'~thor_data400::BASE::gov_phones_' + govdata.Gov_Phones_Build_Date, OVERWRITE);*/

PromoteSupers.MAC_SF_BuildProcess(cleaned_gov_base,'~thor_data400::base::gov_phones',do1,2);

export Make_Gov_Phones_Base := do1;


	