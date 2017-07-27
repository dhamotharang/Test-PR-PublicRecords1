import dnb, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address,mdr,standard,BIPV2,bizlink2;

export DNB_FEIN_BDID(dataset(DNB_FEINV2.layout_DNB_fein_base_main_new) pMappedFeinFile) := function 

    PreBDID_Rec := record
      qstring34   vendor_id := '';   //unique per record 
      DNB_FEINV2.layout_DNB_fein_base_main_new;
      integer8	temp_BDID    	    := 0;
    end;

    PreBDID_Rec taddBDID(pMappedFeinFile L):= transform
      self.vendor_id := 'DF'+ trim(L.CASE_DUNS_NUMBER,left,right) + trim(L.FEIN ,left,right);
      self					 :=	L;
    end;

    Prefile	:= project(pMappedFeinFile,taddbDID(left));

    preBDID := prefile(orig_company_name <> '');

    //append BDID 

    business_header.MAC_Source_Match(
       preBDID			   																	    // infile
      ,dPostSourceMatch															       // outfile
      ,FALSE																				      // bool_bdid_field_is_string12
      ,temp_BDID																	       // bdid_field
      ,FALSE																		        // bool_infile_has_source_field
      ,mdr.sourceTools.src_Dunn_Bradstreet_Fein        // source_type_or_field
      ,TRUE																	          // bool_infile_has_source_group
      ,vendor_id													           // source_group_field
      ,clean_cname											            // company_name_field
      ,prim_range											             // prim_range_field
      ,prim_name										              // prim_name_field
      ,sec_range									  						 // sec_range_field
      ,zip										   								// zip_field
      ,TRUE										                 // bool_infile_has_phone
      ,telephone_number			                  // phone_field
      ,true							                     // bool_infile_has_fein
      ,fein     				                    // fein_field
      ,TRUE						 										 // bool_infile_has_vendor_id	 
      ,vendor_id		  										// vendor_id_field	
      ,																	 // default to use prod version of superfiles
      ,																	// default is to hit prod on dataland, and on prod hit prod
      ,BIPV2.xlink_version_set			 	 // Create BIP Keys only
      ,source_rec_id;								  //Persistent Record id
    );
               
    dPostSourceMatchPersist	:=	dPostSourceMatch : persist('~thor_data400::persist::DnbFein_PostSourceMatch');

    /*********Below macro examines the BIP IDs coming out of the source match routine and
    will decide which records still need an ID and therefore should be passed on to the BDID Flex macro
    **********/

    BIPV2.IDmacros.mac_SelectRecordForXLink(dPostSourceMatchPersist, Dnb_Fein_bdid_Rematch, Dnb_Fein_bdid_match	);

    myset := ['A', 'N', 'F', 'P'];

    Business_Header_SS.MAC_Add_BDID_Flex(
       Dnb_Fein_bdid_Rematch										 // Input Dataset						
      ,myset                                    // BDID Matchset           
      ,clean_cname        		             		 // company_name	              
      ,prim_range		                          // prim_range		              
      ,prim_name		                         // prim_name		              
      ,zip 					                        // zip5					              
      ,sec_range		                       // sec_range		              
      ,st				                          // state				              
      ,telephone_number				           // phone				              
      ,fein                             // fein              
      ,temp_bdid											 // bdid												
      ,PreBDID_Rec	                  // Output Layout 
      ,false                         // output layout has bdid score field?                       
      ,BDID_Score_field             // bdid_score                 
      ,postbdid                    // Output Dataset   
      ,														// deafult threscold
      ,													 // use prod version of superfiles
      ,													// default is to hit prod from dataland, and on prod hit prod.		
      ,BIPV2.xlink_version_set // Create BIP Keys only
      ,           						// Url
      ,								       // Email
      ,p_City_name					// City
      ,fname							 // fname
      ,mname							// mname
      ,lname						 // lname
    );

    post_BDID 		:=  postbdid + Dnb_Fein_bdid_match;

    DNB_FEINV2.layout_DNB_fein_base_main_new tBdid(post_BDID L):=transform
      self.BDID		    :=	intformat(L.temp_BDID,12,1);
      self 						:= L;
    end;

     returndataset := project(post_BDID , tBdid(left)): persist('~thor_data400::persist::DNB_FEIN::BDID');
     return returndataset;

end;