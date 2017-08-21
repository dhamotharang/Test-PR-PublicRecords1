IMPORT  did_add, ut, header_slimSORT, didville, business_header,business_header_ss, address,watchdog,standard,BIPV2;

Layout.Taxpro_standard_base Trans(Layout.Taxpro_base Pinput):=Transform
   Self.name						   :=pinput;
	 Self.name						   :=[];
	 Self.Addr.addr_suffix   :=pInput.suffix;
	 Self.Addr.fips_state    :=pInput.ace_fips_st;
	 self.Addr.fips_county   :=pInput.ace_fips_county;
	 Self.addr.cbsa          :=pInput.msa;
	 self.addr.addr_rec_type :=pInput.rec_type;
	 self.addr							 :=pInput;
	 self.addr							 :=[];
	 self										 :=pinput;
end;
	 
dIn:= Mapping_IRS_Enrolled_Agent+Mapping_Practitioner;
	 
matchset := ['A','Z'];

did_add.MAC_Match_Flex( dIn 
                       ,matchset
											 ,foo
											 ,foo
											 ,fname
											 ,mname
											 ,lname
											 ,name_suffix
											 ,prim_range
											 ,prim_name
											 ,sec_range
											 ,zip5
											 ,st
											 ,''
											 ,did
											 ,recordof(dIn)
											 ,true
											 ,did_score
											 ,75
											 ,dPostDID)

did_add.MAC_Add_SSN_By_DID(dPostDID, did, ssn, dAppendSSN, false)

dInC                   := dAppendSSN(company<>'');
sBDIDMatchSet		   		 := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(dInC									 			 									  // Input Dataset						
																		,sBDIDMatchSet                                 // BDID Matchset           
																		,company        		             		          // company_name	              
																		,prim_range		                               // prim_range		              
																		,prim_name		                         			// prim_name		              
																		,zip5 					                       		 // zip5					              
																		,sec_range		                            // sec_range		              
																		,st				                               // state				              
																		,foo			           										// phone				              
																		,foo                             			 // fein              
																		,bdid											 					  // bdid												
																		,Layout.Taxpro_base	   							 // Output Layout 
																		,false                         			// output layout has bdid score field?                       
																		,BDID_Score                        // bdid_score                 
																		,dPostFlex          						  // Output Dataset   
																		,																 // deafult threscold
																		,													 			// use prod version of superfiles
																		,															 // default is to hit prod from dataland, and on prod hit prod.		
																		,BIPV2.xlink_version_set 			// Create BIP Keys only
																		,           								 // Url
																		,								            // Email
																		,P_city_name							 // City
																		,fname							      // fname
																		,mname									 // mname
																		,lname						 			// lname
																	);
									 
dWithBusHdrSourceMatch          := dPostFlex(BDID != 0);
dWithNoBusHdrSourceMatch        := dPostFlex(BDID = 0);

business_header.MAC_Source_Match(dWithNoBusHdrSourceMatch  
                                 ,dPostBDID
                                 ,false
                                 ,BDID
                                 ,false
                                 ,'Ta'     
                                 ,FALSE
																 ,corp_key
                                 ,company
                                 ,prim_range
                                 ,prim_name
                                 ,sec_range
                                 ,zip5
                                 ,false
																 ,foo
																 ,false
																 ,foo
                                 ,FALSE
																 ,corp_key
                                );

dPostDIDandBDIDPersist	:=	dWithBusHdrSourceMatch +   
														dPostBDID +	
														dAppendSSN(company='');
														
dStandard               :=project(dPostDIDandBDIDPersist,trans(left)):persist(cluster.cluster_out+'persist::base::taxpro');

export Proc_Build_Base :=dStandard   ;