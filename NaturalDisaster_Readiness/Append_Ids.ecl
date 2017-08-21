import 	MDR, Address, Ut, lib_stringlib, _Control, business_header,_Validate,
				Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS;

export Append_Ids :=	module

    //////////////////////////////////////////////////////////////////////////////////////
   // -- function: fAppendBdid
   // -- Append BDID
   //////////////////////////////////////////////////////////////////////////////////////
   export fAppendBdid(dataset(Layouts.Keybuild) pDataset) :=	function

      BDID_Matchset := ['A','P'];  //'A' is for address matching
			
      Business_Header_SS.MAC_Add_BDID_Flex(
          pDataset							// Input Dataset                 
         ,BDID_Matchset					// BDID Matchset what fields to match on           
         ,Business_Name					// company_name                 
         ,m_prim_range					// prim_range
         ,m_prim_name						// prim_name
         ,m_zip									// zip5
         ,m_sec_range						// sec_range
         ,m_st									// state
         ,Business_Phone_No			// phone                      
         ,''										// fein              
         ,bdid									// bdid                                    
         ,Layouts.keybuild			// Output Layout 
         ,false									// output layout has bdid score field?                       
         ,bdid_score						// bdid_score                 
         ,dBdidOut							// Output Dataset 
				 ,											// score_threshold
				 ,											// file version (prod)
				 ,											// use other environment?
				 ,BIPV2.xlink_version_set  // BIP2 ids
				 ,Business_Website			// URL
				 ,Business_Email_Id			// email
				 ,Clean_Business_City		// city
				 ,											// contact's first name
				 ,											// contact's middle name
				 ,											// contact's last name                 			 
																					); 

			return dBDidOut;
      
   end;  // end fAppendBdid
 
   export fAll(dataset(Layouts.keybuild)	pDataset) :=	function
	 
			dWithBusinessName			:=	pDataset(Business_Name<>'');
			dWithoutBusinessName	:=	pDataset(Business_Name='');
			
      dAppendBdid    	:= 	fAppendBdid (dWithBusinessName);
			
			dCombinedBDIDs	:=	dAppendBdid + dWithoutBusinessName;

      return dCombinedBDIDs;
   end;  // end fAll
end;  // end Append_Ids