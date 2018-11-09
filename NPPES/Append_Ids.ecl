import Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, MDR,Health_Provider_Services;


export Append_Ids :=	module
 
   ///////////////////////////////////////////////////////////////////////////////////////
   // -- function: fAppendDid
   // -- Append DID
   //////////////////////////////////////////////////////////////////////////////////////
   export fAppendDid(dataset(nppes.Layouts.TempKeyBuild) pDataset) :=	function
  	  
      Did_Matchset := ['A','P'];
		
	  //First try to get a DID using Mailing Address	
      DID_Add.MAC_Match_Flex(
          pDataset									// Input Dataset
         ,Did_Matchset              // Did_Matchset  what fields to match on
         ,''												// ssn
         ,''												// dob
         ,provider_fname											// fname
         ,provider_mname											// mname
         ,provider_lname											// lname
         ,provider_name_suffix										// name_suffix
         ,mailing_prim_range								// prim_range
         ,mailing_prim_name									// prim_name
         ,mailing_sec_range									// sec_range		 
         ,mailing_zip												// zip5
         ,mailing_st												// state
         ,cleanMailingPhone										// phone
         ,did                       // Did
         ,nppes.Layouts.TempKeyBuild					// output layout
         // ,false                     // Does output record have the score
         ,true                     // Does output record have the score
         ,did_score                 // did score field
         ,75                        // score threshold
         ,dDidOut1										// output dataset    );
          );
 
		did_desc1 := project (dDidOut1,transform (recordof(dDidOut1), 
             self.xadl2_keys_desc := InsuranceHeader_xLink.Process_xIDL_Layouts(false).KeysUsedToText (left.xadl2_keys_used); 
             self.xadl2_matches_desc := InsuranceHeader_xLink.fn_MatchesToText(left.xadl2_matches);
             self := left;));

    foundDID1		 :=	did_desc1(did <> 0);
		missingDID1      :=	did_desc1(did = 0);			
		
		//Next try to get a DID using Location Address
		DID_Add.MAC_Match_Flex(
          missingDID1									// Input Dataset
         ,Did_Matchset              // Did_Matchset  what fields to match on
         ,''												// ssn
         ,''												// dob
         ,provider_fname											// fname
         ,provider_mname											// mname
         ,provider_lname											// lname
         ,provider_name_suffix										// name_suffix
         ,location_prim_range								// prim_range
         ,location_prim_name									// prim_name
         ,location_sec_range									// sec_range
         ,location_zip												// zip5
         ,location_st												// state
         ,cleanLocationPhone										// phone
         ,did                       // Did
         ,nppes.Layouts.TempKeyBuild					// output layout
         // ,false                     // Does output record have the score
         ,true                    // Does output record have the score
         ,did_score                 // did score field
         ,75                        // score threshold
         ,dDidOut2										// output dataset    );
          );
 
		did_desc2 := project (dDidOut2,transform (recordof(dDidOut2), 
            self.xadl2_keys_desc := InsuranceHeader_xLink.Process_xIDL_Layouts(false).KeysUsedToText (left.xadl2_keys_used); 
            self.xadl2_matches_desc := InsuranceHeader_xLink.fn_MatchesToText(left.xadl2_matches);
            self := left;));
														
		foundDID2			:=	did_desc2(did <> 0);
		missingDID2   :=	did_desc2(did = 0);

    //If there were no missingDID1 records, then all records will be in foundDID1 
    return if(exists(missingDID1),
				foundDID1 + foundDID2 + missingDID2,
				foundDID1);
   end;
	 
   //////////////////////////////////////////////////////////////////////////////////////
   // -- function: fAppendBdid
   // -- Append BDID
   //////////////////////////////////////////////////////////////////////////////////////
   export fAppendBdid(dataset(nppes.Layouts.TempKeyBuild) pDataset) :=	function

      BDID_Matchset := ['A','P','N'];
			
      Business_Header_SS.MAC_Add_BDID_Flex(
          pDataset															// Input Dataset                 
         ,BDID_Matchset													// BDID Matchset what fields to match on           
         ,Provider_Organization_Name						// company_name                 
         ,location_prim_range										// prim_range                   
         ,location_prim_name										// prim_name                    
         ,location_zip													// zip5                            
         ,location_sec_range										// sec_range                    
         ,location_st														// state                        
         ,cleanLocationPhone										// phone                        
         ,''																		// fein              
         ,bdid																	// bdid                                    
         ,Layouts.TempKeyBuild									// Output Layout 
         ,false																	// output layout has bdid score field?                       
         ,bdid_score														// bdid_score                 
         ,dBdidOut															// Output Dataset
				 ,																			// score_threshold
				 ,																			// file version (prod)
				 ,																			// use other environment?
				 ,BIPV2.xlink_version_set  							// BIP2 ids
				 ,																			// URL
				 ,																			// email
				 ,location_p_city_name									// city
				 ,provider_fname												// fname
         ,provider_mname												// mname
         ,provider_lname												// lname
				 ,																			// contact ssn
				 ,source																// source
				 ,source_rec_id													// source_record_id
				 ,false	 																// does MAC_Source_Match exist before Flex macro			                                        				 
      );                                         
                                        
      return dBdidOut;
      
   end;
	 
	 export fAppendLNpid(dataset(nppes.layouts.TempKeyBuild) pDataset)	:= function
	 		Health_Provider_Services.mac_get_best_lnpid_on_thor (
				pDataset
				,lnpid
				,provider_fname//FNAME
				,provider_mname//MNAME
				,provider_lname//LNAME
				,provider_name_suffix//name_suffix
				,provider_gender_code//GENDER
				,location_prim_range
				,location_prim_name
				,location_sec_range
				,location_p_city_name
				,location_st
				,location_zip
				,//clean_SSN
				,//clean_DOB
				,cleanLocationPhone
				,Provider_License_Number_State_Code_1//LIC_STATE
				,Provider_License_Number_1//LIC_Num_in
				,Employer_Identification_Number//TAX_ID
				,//DEA_NUM
				,//group_key
				,NPI
				,//UPIN
				,DID
				,BDID
				,//source//SRC - do not use this field, as it will restrict the search to NPPES only
				,//SOURCE_RID
				,result,false,38
			);
			
			
			// lnpids are only wanted for npi type 1 so zero-out any others
			result type1only(result l)	:= transform
				self.lnpid							:= if(L.entity_type_code='1',L.lnpid,0);
				self										:= l;
			end;

			end_file:=	project(result, type1only(left));

		RETURN end_file;
   END;

   export fAll(dataset(nppes.Layouts.KeyBuildFirst)	pDataset) :=	function
	        
			//DID macro does not like references to embedded layout fields, so project to a temp layout
			nppes.Layouts.TempKeyBuild popFields(pDataset L) := transform
				self.provider_fname       := L.clean_name_provider.fname;
				self.provider_mname       := L.clean_name_provider.mname;
				self.provider_lname       := L.clean_name_provider.lname;
				self.provider_name_suffix := L.clean_name_provider.name_suffix;
				self.mailing_prim_range   := L.clean_mailing_address.prim_range;								
        self.mailing_prim_name	  := L.clean_mailing_address.prim_name;							
				self.mailing_sec_range	  := L.clean_mailing_address.sec_range;								
				self.mailing_st			  		:= L.clean_mailing_address.st;						
				self.mailing_zip		  		:= L.clean_mailing_address.zip;				
				self.location_prim_range  := L.clean_location_address.prim_range;								
        self.location_prim_name	  := L.clean_location_address.prim_name;							
				self.location_sec_range	  := L.clean_location_address.sec_range;
				self.location_p_city_name := L.clean_location_address.p_city_name;					
				self.location_st		  		:= L.clean_location_address.st;						
				self.location_zip		  		:= L.clean_location_address.zip;
				self.source								:= mdr.sourceTools.src_NPPES;
				self.source_rec_id				:= L.source_rec_id;  	
				self.lnpid								:= 0;
				self                      := L;
				end;
  
			inDataset := project(pDataset,popFields(left));
			
			//dWithDIDs			    :=	inDataset(did!=0);
			//dWithoutDIDs		  :=	inDataset(did=0);
   
			dAppendDid    		:= 	fAppendDid	(inDataset);
			
			//dCombinedDIDs		  :=	dAppendDid + dWithDIDs;
			
			dAppendBdid    		:= 	fAppendBdid (dAppendDid);
			
			dCombinedBDIDs		:=	dAppendBdid;		
			
			dWithLNpids				:=  fAppendLNpid (dCombinedBDIDs);
  
			//project back to the same layout that was passed into this function
			outDataset := project(/* dCombinedBDIDs*/dWithLNpids,nppes.Layouts.KeyBuildFirst) : persist ('Final_NPI_DID::nppes');
							
      return outDataset;
   
   end;
end;
