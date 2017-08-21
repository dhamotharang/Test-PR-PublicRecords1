import business_header,business_Header_SS,did_add,mdr,PromoteSupers;

df := govdata.File_SEC_Broker_Dealer_In;

govdata.Layout_SEC_Broker_Dealer_BDID into_BDID(DF L) := transform
	self := L;
	self.bdid := 0;
end;

df2 := project(df,into_bdid(LEFT));

business_header.MAC_Source_Match(df2,outf1,
																 false,bdid,
																 false,MDR.sourceTools.src_SEC_Broker_Dealer,
																 false,foo,
																 company_name,
																 prim_range,prim_name,sec_range,zip,
																 false,phone,
																 false,fein);

myset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(outf1 									 	  	                    // Input Dataset						
																		,myset                                           // BDID Matchset           
																		,company_name        		         								// company_name	              
																		,prim_range		                                 // prim_range		              
																		,prim_name		                         	      // prim_name		              
																		,zip 					                       		     // zip5					              
																		,sec_range		                              // sec_range		              
																		,st				                                 // state				              
																		,phone			           								    // phone				              
																		,fein                                    // fein              
																		,bdid										 					      // bdid												
																		,govdata.Layout_SEC_Broker_Dealer_BDID // Output Layout 
																		,false                         		    // output layout has bdid score field?                       
																		,bdscore                             // bdid_score                 
																		,dPostFlex             				      // Output Dataset   
																		,														       // deafult threscold
																		,													 	      // use prod version of superfiles
																		,													       // default is to hit prod from dataland, and on prod hit prod.		
																		,BIPV2.xlink_version_set 	      // Create BIP Keys only
																		,           				           // Url
																		,								              // Email
																		,p_city_name			           // City
																		,fname						          // fname
																		,mname					           // mname
																		,lname					          // lname
																	);						
//output(outf,,'~thor_data400::base::sec_broker_dealer_bdid_' + govdata.sec_bdid_date);

PromoteSupers.MAC_SF_BuildProcess(dPostFlex,'~thor_data400::base::sec_broker_dealer',do1,2);

export Make_SEC_Broker_Dealer_BDID := do1;


						