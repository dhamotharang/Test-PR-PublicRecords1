import business_header,business_header_ss,did_add,PromoteSupers,mdr;

export Make_IRS_NonProfit_BDID(string filedate) :=  function

	df := govdata.Cleaned_IRS_NonProfit(filedate);
	
Temp_IRS_NonProfit_rec:=record
	govdata.Layouts_IRS_NonProfit.Base_AID;
	string2 source;
end;

	Temp_IRS_NonProfit_rec into_base(df l) := transform
		self.bdid 				 := 0;
		self.source_rec_id :=hash64(trim(l.Employer_ID_Number,left,right) +  trim(l.Primary_Name_Of_Organization,left,right) +  trim(l.In_Care_Of_Name,left,right) + 
																trim(l.Street_Address,left,right) +  trim(l.City,left,right) + trim(l.State,left,right) + trim(l.Zip_Code,left,right) +  trim(l.Group_Exemption_Number,left,right) +  trim(l.Subsection_Code,left,right) + 
																trim(l.Affiliation_Code,left,right) +  trim(l.Classification_Code,left,right) + trim(l.Ruling_Date,left,right) +  trim(l.Deductibility_Code,left,right) +  trim(l.Foundation_Code,left,right) + 
																trim(l.Activity_Codes,left,right) +  trim(l.Organization_Code,left,right) +  trim(l.Univ_Loc_Code,left,right) +  trim(l.Advance_Ruling_Exp_Date,left,right) +  trim(l.Tax_Period,left,right) + 
																trim(l.Asset_Code,left,right) +  trim(l.Income_Code,left,right) +  trim(l.Filing_Requirement_Code_part1,left,right) +  trim(l.Filing_Requirement_Code_part2,left,right) + 
																trim(l.Accounting_Period,left,right) +  trim(l.Asset_Amount,left,right) +  trim(l.Income_Amount,left,right) +  trim(l.Negative_Sign,left,right) +  trim(l.Form_990_Revenue_Amount,left,right) + 
																trim(l.Negative_Rev_Amount,left,right) +  trim(l.National_Taxonomy_Exempt,left,right) +  trim(l.Sort_Name,left,right));
	self.source 			  := MDR.sourceTools.src_IRS_Non_Profit;
	self 			  			  := l;	
end;

	df2 := project(df,into_base(LEFT));

	business_header.MAC_Source_Match(
				 df2    																							// infile
				,dPostSourceMatch												 						 // outfile
				,FALSE																							// bool_bdid_field_is_string12
				,BDID														 									 // bdid_field
				,false																						// bool_infile_has_source_field
				,MDR.sourceTools.src_IRS_Non_Profit 						 // source_type_or_field
				,FALSE																					// bool_infile_has_source_group
				,foo										 									 		 // source_group_field
				,Primary_Name_Of_Organization									// company_name_field
				,prim_range								 									 // prim_range_field
				,prim_name																	// prim_name_field
				,sec_range							 									 // sec_range_field
				,zip																			// zip_field
				,false																	 // bool_infile_has_phone
				,foo			  														// phone_field
				,false								 								 // bool_infile_has_fein
				,foo     															// fein_field
	);

	myset := ['A'];

	Business_Header_SS.MAC_Add_BDID_Flex(
					 dPostSourceMatch 									 	  			        // Input Dataset						
					,myset                                 				    	 // BDID Matchset           
					,Primary_Name_Of_Organization        		         		// company_name	              
					,prim_range		                                  	 // prim_range		              
					,prim_name		                         			   		// prim_name		              
					,zip 					                       		 	   		 // zip5					              
					,sec_range		                               		// sec_range		              
					,st				                                  	 // state				              
					,foo			           										   		// phone				              
					,foo                             			    	 // fein              
					,bdid										 					       		// bdid												
					,Temp_IRS_NonProfit_rec 				 			     // Output Layout 
					,false                         			   		// output layout has bdid score field?                       
					,Score                                	 // bdid_score                 
					,dPostFlex             							 		// Output Dataset   
					,																    	 // deafult threscold
					,													 			   		// use prod version of superfiles
					,															    	 // default is to hit prod from dataland, and on prod hit prod.		
					,BIPV2.xlink_version_set 			   		// Create BIP Keys only
					,           								    	 // Url
					,								               		// Email
					,p_city_name							    	 // City
					,fname							         		// fname
					,mname									    	 // mname
					,lname						 			   		// lname
					,                    				 //	ssn
					,source             		 	  //sourceField
					,source_rec_id             //persistent_rec_id
					,true            		 		  //Call sourceMatch before Flex 
	);

	dPostFlex_reformat:=project(dPostFlex,transform(govdata.Layouts_IRS_NonProfit.Base_AID,self:=left;));

	PromoteSupers.MAC_SF_BuildProcess(dPostFlex_reformat, '~thor_data400::base::IRS_NonProfit',do1,2,pCompress:=true);

	return do1;
end;		
