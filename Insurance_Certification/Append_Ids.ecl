import 	Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
				Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, mdr;

export Append_Ids :=	module

  /*--------------------------*/	
	/* Begin Certification Data */
	/*--------------------------*/
	export fAppendDid(dataset(Layouts_Certification.keybuild) pDataset) :=	function

			has_name				:=  pDataset.norm_firstname <> '' or pDataset.norm_last <> '';
			dWithNames			:=	pDataset(has_name);
			dWithOutNames		:=	pDataset(not has_name);
	
      Did_Matchset := ['A','P','Z'];
			
      DID_Add.MAC_Match_Flex(
          dWithNames								// Input DatasetL
         ,Did_Matchset              // Did_Matchset  what fields to match on
         ,''												// ssn
         ,''												// dob
         ,Norm_FirstName						// fname
         ,Norm_Middle 							// mname
         ,Norm_Last									// lname
         ,Norm_Suffix               // name_suffix
         ,m_prim_range							// prim_range
         ,m_prim_name								// prim_name
         ,m_sec_range								// sec_range
         ,m_zip											// zip5
         ,m_st											// state
         ,Norm_Phone  				    	// phone
         ,did                       // Did
         ,Layouts_Certification.keybuild	// output layout
         ,false                     // Does output record have the score
         ,did_score                 // did score field
         ,75                        // score threshold
         ,dDidOut		);							// output dataset       
					
					
		 dAppendDid := dDidOut + dWithOutNames;
		 
     return dAppendDid;
   end; 	
	
	export fAppendBdid(dataset(Layouts_Certification.keybuild) pDataset) :=	function

			has_bus_name		:=	pDataset.Norm_BusinessName<> '';
			dWithBNames			:=	pDataset(has_bus_name);			
			dWithoutBNames	:=	pDataset(not has_bus_name);

      BDID_Matchset := ['A','P']; /* Match on Address and Phone */
			
      Business_Header_SS.MAC_Add_BDID_Flex(
          dWithBNames											// Input Dataset                 
         ,BDID_Matchset										// BDID Matchset what fields to match on           
         ,Norm_BusinessName								// company_name                 
         ,m_prim_range										// prim_range
         ,m_prim_name											// prim_name
				 ,m_zip														// zip5
         ,m_sec_range											// sec_range
         ,m_st														// state
         ,Norm_Phone											// phone                      
         ,''															// fein              
         ,bdid														// bdid                                    
         ,Layouts_Certification.keybuild	// Output Layout 
         ,false														// output layout has bdid score field?                       
         ,bdid_score											// bdid_score                 
         ,dBdidOut	  										// Output Dataset
				 ,																// default threscold
				 ,																// use prod version of superfiles
				 ,																// default is to hit prod from dataland, and on prod hit prod.		
				 ,BIPV2.xlink_version_set 				// Create BIP Keys only
				 ,           					   					// Url				 	
				 ,email1													// pEmail
				 ,norm_city 											// pCity									 
				 ,norm_firstname									// pContact_fname					 
				 ,norm_middle											// pContact_mname					 
				 ,norm_last					);  					// pContact_lname		
					
					
		  dAppendBdid := dBdidOut + dWithoutBNames;
		 
			return dAppendBdid;
   end;
   
   export fAllCert(dataset(Layouts_Certification.keybuild)	pDataset) :=	function
	 
      dAppend_Did    		:= 	fAppendDid  (pDataset 	); 	 
		  dAppend_Bdid    	:= 	fAppendBdid (dAppend_Did);
			
			return dAppend_Bdid;
				
   end;  /* End Certification Data */
	 	
  /*-----------------------------------*/	
	/* Begin Policy Data                 */
	/*-----------------------------------*/
	export fAppendBDIDPol(dataset(Layouts_Policy.keybuild) pDataset) :=	function

			has_prov_name		:=	pDataset.InsuranceProvider<> '';
			dWithPNames			:=	pDataset(has_prov_name);			
			dWithoutPNames	:=	pDataset(not has_prov_name);
			
      BDID_Matchset := ['A','P']; /* Match on Address & Phone */
			
      Business_Header_SS.MAC_Add_BDID_Flex(
          dWithPNames							// Input Dataset                 
         ,BDID_Matchset						// BDID Matchset what fields to match on           
         ,InsuranceProvider				// company_name                 
         ,m_prim_range						// prim_range
         ,m_prim_name							// prim_name
				 ,m_zip										// zip5
         ,m_sec_range							// sec_range
         ,m_st										// state
         ,InsuranceProviderPhone 	// phone                      
         ,''											// fein              
         ,bdid										// bdid                                    
         ,Layouts_Policy.keybuild	// Output Layout 
         ,false										// output layout has bdid score field?                       
         ,bdid_score							// bdid_score                 
         ,dPolBdidOut	  					// Output Dataset ); 
				 ,												// default threscold
				 ,											  // use prod version of superfiles
				 ,												// default is to hit prod from dataland, and on prod hit prod.		
				 ,BIPV2.xlink_version_set // Create BIP Keys only
				 ,           					   	// Url
				 ,								        // Email
				 ,m_p_city_name			  		// City
				 ,              		      // fname
         ,              	      	// mname
	       ,              	        // lname
         );			

		  dAppendBDIDPol := dPolBdidOut + dWithoutPNames;
		 
			return dAppendBDIDPol;
   end;
   
   export fAllPolicy(dataset(Layouts_Policy.keybuild)	pDataset) :=	function
	 
		  dAppendBdid    	:= 	fAppendBDIDPol (pDataset);
						                                                                    
      return dAppendBdid;
   end;  /* End Policy Data */
	 	
end;
