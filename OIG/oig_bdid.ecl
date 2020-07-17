import Business_Header_SS, Business_Header, ut;

in_file:=OIG.AID_format_Input;

bdid_matchset := ['A'];

Business_Header_SS.MAC_Add_BDID_Flex(in_file       									 					 // Input Dataset
																		,bdid_matchset                            // BDID Matchset
																		,BUSNAME        		             		     // company_name
																		,prim_range		                          // prim_range
																		,prim_name		                         // prim_name
																		,zip						                      // zip5
																		,sec_range		                       // sec_range
																		,st				                          // state
																		,''								           			 // phone
																		,''						                    // fein
																		,bdid											       // bdid
																		,OIG.Layouts.KeyBuild						// Output Layout
																		,false                         // output layout has bdid score field?
																		,''            								// bdid_score
																		,postFlex                    // Output Dataset
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

export oig_bdid := postFlex;
