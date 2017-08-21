IMPORT business_header, business_header_SS, did_add, MDR, BIPV2, PromoteSupers;

dsIASalesTx_base := govdata.IA_Sales_Tax_Build_Base;

myrec := RECORD
	govdata.Layout_IA_SalesTax_Base;
	UNSIGNED1		score := 0;
	STRING10		prim_range;
	STRING28		prim_name;
	STRING10		sec_range;
	STRING5			zip;
	STRING2			st;
	STRING25  	p_city_name;
	STRING20 		owner_name_first;
	STRING20 		owner_name_middle;
	STRING20 		owner_name_last;
END;

// The macros will not accept multi-level attributes (mailingAddress, ownerName, etc.)
// Casting the values in to 1-level attributes
myrec fatten_for_macro(RECORDOF(dsIASalesTx_base) L) := TRANSFORM
	SELF.score 			        := 0;
	SELF.prim_range         := L.mailingAddress.prim_range;
	SELF.prim_name 	        := L.mailingAddress.prim_name;
	SELF.sec_range	        := L.mailingAddress.sec_range;
	SELF.zip 				        := L.mailingAddress.zip;
	SELF.st 				        := L.mailingAddress.st;
	SELF.p_city_name        := L.mailingAddress.p_city_name;
	SELF.owner_name_first   := L.ownerName.fname;
	SELF.owner_name_middle  := L.ownerName.mname;
	SELF.owner_name_last    := L.ownerName.lname;
	SELF                    := L;
	SELF                    := [];
END;

dsIASalesTx_base_fat := PROJECT(dsIASalesTx_base, fatten_for_macro(LEFT));

business_header.MAC_Source_Match(
				 dsIASalesTx_base_fat 																// infile
				,dPostSourceMatch												 						 // outfile
				,FALSE																							// bool_bdid_field_is_string12
				,bdid														 									 // bdid_field
				,FALSE																						// bool_infile_has_source_field
				,''						 		 															 // source_type_or_field
				,FALSE																					// bool_infile_has_source_group
				,foo										 									 		 // source_group_field
				,company_name_1																// company_name_field
				,prim_range								 	                 // prim_range_field
				,prim_name										              // prim_name_field
				,sec_range							 		               // sec_range_field
				,zip												              // zip_field
				,FALSE																	 // bool_infile_has_phone
				,foo			  														// phone_field
				,FALSE								 								 // bool_infile_has_fein
				,foo     															// fein_field
	);
							
//we want these at the top of the SORT order later.
myrec fake_score(myrec L) := TRANSFORM
	SELF.score := IF(l.bdid != 0,	101,0);
	SELF 			 := L;
END;
   
mid1_score := PROJECT(dPostSourceMatch, fake_score(LEFT));

myset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(
				 mid1_score 									 	  			        			// Input Dataset						
				,myset                                 				    	 // BDID Matchset           
				,company_name_1        		         									// company_name	              
				,prim_range		                                     // prim_range		              
				,prim_name		                                    // prim_name		              
				,zip 					                                   // zip5					              
				,sec_range		                                  // sec_range		              
				,st				                                     // state				              
				,foo			           										   		// phone				              
				,foo                             			    	 // fein              
				,bdid										 					       		// bdid												
				,myrec    		 			     									 // Output Layout 
				,TRUE                         			   		// output layout has bdid score field?                       
				,Score                                	 // bdid_score                 
				,dPostFlex             							 		// Output Dataset   
				,																    	 // deafult threscold
				,													 			   		// use prod version of superfiles
				,															    	 // default is to hit prod from dataland, and on prod hit prod.		
				,BIPV2.xlink_version_set 			   		// Create BIP Keys only
				,           								    	 // Url
				,								               		// Email
				,p_city_name			               // City
				,owner_name_first							  // first name
				,owner_name_middle						 // middle name
				,owner_name_last						  // last name
);

df3 := PROJECT(dPostFlex, govdata.Layout_IA_SalesTax_Base);

outf1 := DEDUP(SORT(DISTRIBUTE(df3, HASH(permit_nbr)), bdid, -issue_date, LOCAL), permit_nbr, LOCAL);

PromoteSupers.MAC_SF_BuildProcess(outf1,'~thor_data400::base::IA_Sales_Tax_AID',do1,2);

EXPORT Make_IA_SalesTax_BDID := do1;

