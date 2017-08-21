import did_add, Business_Header_SS, Business_Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville, bipv2, MDR;

infile := AMIDIR.Cleaned_AMIDIR_DID_SSN;

Pre_BDID_Rec := record
	unsigned6	bdid	:= 0;
	//unsigned1	bdid_score := 0;
	recordof(infile);
	unsigned8 source_rec_id:=0;
	Bipv2.IDlayouts.l_xlink_ids;
	string2 source;
end;

infile_withSource:= project(infile,transform(Pre_BDID_Rec, self.source:=MDR.sourceTools.src_AMIDIR; self:=left;));

//Appending source_Rec_id's to AMIDIR records
ut.MAC_Append_Rcid(infile_withSource,source_rec_id,AMIDIR_infile_Recid);

matchset := ['A','P','N'];

Business_Header_SS.MAC_Add_BDID_Flex(
			 AMIDIR_infile_Recid 									 	  			        		 // Input Dataset						
			,matchset                                 				    	  // BDID Matchset           
			,Business_Name        		         											 // company_name	              
			,Business_Address_Clean_prim_range		                  // prim_range		              
			,Business_Address_Clean_prim_name		                   // prim_name		              
			,Business_Address_Clean_zip 					                // zip5					              
			,Business_Address_Clean_sec_range		                 // sec_range		              
			,Business_Address_Clean_st				                  // state				              
			,Business_Phone			           										 // phone				              
			,''                            			    	 				// fein              
			,bdid										 					       				 // bdid												
			,Pre_BDID_Rec 				 			     								// Output Layout 
			,false                         			   		     // output layout has bdid score field?                       
			,bdid_score                                	  // bdid_score                 
			,dPostFlex             							 				 // Output Dataset   
			,																    	 		  // deafult threscold
			,													 			   				 // use prod version of superfiles
			,															    	 		  // default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set 			   				 // Create BIP Keys only
			,           								    	 			// Url
			,								               				 // Email
			,Business_Address_Clean_p_city_name		// City
			,Physician_Name_Clean_fname					 // fname
			,Physician_Name_Clean_mname					// mname
			,Physician_Name_Clean_lname				 // lname
			,                    				 			// ssn
			,source             		 	 			 //sourceField
			,source_rec_id          				//persistent_rec_id
			,               		 		  		 //Call sourceMatch before Flex 
);

AMIDIR.Layout_AMIDIR_Base_BIP tBdid(Pre_BDID_Rec L) := transform
	self.bdid		    := if(L.bdid = 0, '', intformat(L.bdid,12,1));
	//self.BDID_SCORE	:= (string3)L.bdid_score;
	self            := L;
	self            :=[];
end;
	
ds_AMIDIR_BDID := project(dPostFlex, tBdid(left)); 

export Cleaned_AMIDIR_BDID := ds_AMIDIR_BDID : persist(AMIDIR.Cluster + 'persist::Cleaned_AMIDIR_bdid');
