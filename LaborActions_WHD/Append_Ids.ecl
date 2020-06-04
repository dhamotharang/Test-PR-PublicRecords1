import 	Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
				Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,mdr;

export Append_Ids :=	module

  export fAppendBdid(dataset(Layouts.keybuild) pDataset) :=	function

      BDID_Matchset := ['A']; /* Match on Address only */
			
      Business_Header_SS.MAC_Add_BDID_Flex(
          pDataset							// Input Dataset                 
         ,BDID_Matchset					// BDID Matchset what fields to match on           
         ,EmployerName					// company_name                 
         ,m_prim_range					// prim_range
         ,m_prim_name						// prim_name
				 ,m_zip									// zip5
         ,m_sec_range						// sec_range
         ,m_st									// state
         ,''										// phone                      
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
				 ,											// URL
				 ,											// email
				 ,m_p_city_name					// city
				 ,											// contact's first name
				 ,											// contact's middle name
				 ,											// contact's last name                 			 
				); 																			

			return dBDidOut;
      
   end;
   
export fAll(dataset(Layouts.keybuild)	pDataset) :=	function
	 
		  dAppendBdid    	:= 	fAppendBdid (pDataset);
		                                                                    
      return dAppendBdid;
   
   end;
	 
end;
