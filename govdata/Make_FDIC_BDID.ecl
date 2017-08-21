import business_header,business_header_ss,did_add,PromoteSupers,ut,mdr;

export make_FDIC_BDID(string filedate) := function

df := govdata.Clean_FDIC(filedate);

Temp_FDIC_rec:=record
	govdata.Layouts_FDIC.Base_AID;
	string2 source;
end;

Temp_FDIC_rec into_bdid(df L) := transform
	self.bdid 				 := 0;
	self.source_rec_id :=	hash64(ut.CleanSpacesAndUpper(l.stname) + ut.CleanSpacesAndUpper(l.cert) + ut.CleanSpacesAndUpper(l.docket) + ut.CleanSpacesAndUpper(l.active) + 
															 ut.CleanSpacesAndUpper(l.address) + ut.CleanSpacesAndUpper(l.asset) + ut.CleanSpacesAndUpper(l.bkclass) + 
															 ut.CleanSpacesAndUpper(l.conserve) + ut.CleanSpacesAndUpper(l.city) + ut.CleanSpacesAndUpper(l.clcode) + ut.CleanSpacesAndUpper(l.dateupdt) + 
															 ut.CleanSpacesAndUpper(l.denovo) + ut.CleanSpacesAndUpper(l.dep) + ut.CleanSpacesAndUpper(l.effdate) + ut.CleanSpacesAndUpper(l.endefymd) + 
															 ut.CleanSpacesAndUpper(l.insfdic) + ut.CleanSpacesAndUpper(l.name) + ut.CleanSpacesAndUpper(l.newcert) + ut.CleanSpacesAndUpper(l.oakar) + 
															 ut.CleanSpacesAndUpper(l.occdist) + ut.CleanSpacesAndUpper(l.otsdist) + ut.CleanSpacesAndUpper(l.procdate) + ut.CleanSpacesAndUpper(l.qbprcoml) + 
															 ut.CleanSpacesAndUpper(l.roaq) + ut.CleanSpacesAndUpper(l.roe) + ut.CleanSpacesAndUpper(l.roeq) +  
															 ut.CleanSpacesAndUpper(l.stalp) + ut.CleanSpacesAndUpper(l.stcnty) + ut.CleanSpacesAndUpper(l.webaddr) + 
															 ut.CleanSpacesAndUpper(l.zip) + ut.CleanSpacesAndUpper(l.fldoff) + ut.CleanSpacesAndUpper(l.regagnt) + ut.CleanSpacesAndUpper(l.county)); 
	self.source 			 := MDR.sourceTools.src_FDIC;
	self 			  			 := l;	
end;

df2 := project(df,into_bdid(LEFT));

business_header.MAC_Source_Match(
				 df2    																							// infile
				,dPostBDID												 									 // outfile
				,FALSE																							// bool_bdid_field_is_string12
				,BDID														 									 // bdid_field
				,false																						// bool_infile_has_source_field
				,MDR.sourceTools.src_FDIC 						 					 // source_type_or_field
				,FALSE																					// bool_infile_has_source_group
				,foo										 									 		 // source_group_field
				,name																					// company_name_field
				,prim_range								 									 // prim_range_field
				,prim_name																	// prim_name_field
				,sec_range							 									 // sec_range_field
				,zip																			// zip_field
				,false																	 // bool_infile_has_phone
				,phone			  													// phone_field
				,false								 								 // bool_infile_has_fein
				,fein     														// fein_field
				);


myset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(
					 dPostBDID 									 	                        // Input Dataset						
					,myset                                 				    	 // BDID Matchset           
					,name        		         														// company_name	              
					,prim_range		                                  	 // prim_range		              
					,prim_name		                         			   		// prim_name		              
					,zip 					                       		 	   		 // zip5					              
					,sec_range		                               		// sec_range		              
					,st				                                  	 // state				              
					,phone			           										   	// phone				              
					,fein                           			    	 // fein              
					,bdid										 					       		// bdid												
					,Temp_FDIC_rec              							 // Output Layout 
					,false                         			   		// output layout has bdid score field?                       
					,bdidscore                               // bdid_score                 
					,dPostFlex             							 		// Output Dataset   
					,																    	 // deafult threscold
					,													 			   		// use prod version of superfiles
					,															    	 // default is to hit prod from dataland, and on prod hit prod.		
					,BIPV2.xlink_version_set 			   		// Create BIP Keys only
					,           								    	 // Url
					,								               		// Email
					,p_city_name							    	 // City
					,							         					// fname
					,									    	 			 // mname
					,						 			   					// lname
					,                    				 //	ssn
					,source             		 	  //sourceField
					,source_rec_id             //persistent_rec_id
					,true            		 		  //Call sourceMatch before Flex 
	);
dPostFlex_reformat:=project(dPostFlex,transform(govdata.layouts_FDIC.Base_AID,self:=left;));

PromoteSupers.MAC_SF_BuildProcess(dPostFlex_reformat,'~thor_data400::base::govdata_FDIC_BDID',do1,2);

return do1;

end;
