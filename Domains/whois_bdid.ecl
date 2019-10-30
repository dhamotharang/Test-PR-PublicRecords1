import ut, Business_Header, Business_Header_SS, did_add,mdr;

Layout_Whois_Temp := record
		string46 company_name;
		string34 source_group;
		Layout_Whois_Base_BIP - [global_sid,record_sid]; //Added for CCPA-357
		string2 source;
end;

// BDID the Whois File
Layout_Whois_Temp InitDomains(Layout_Whois l) := transform
		SELF.company_name := Stringlib.StringToUpperCase(l.registrant_name);
		SELF.source_group := l.domain_name;
		self.title 				:= '';
		self.fname 				:= '';
		self.mname 				:= '';
		self.lname 				:= '';
		self.name_suffix 	:= '';
		self.name_score 	:= '';
		self.source 			:= MDR.sourceTools.src_Whois_domains;
		self 							:= l;
END;

Domains_Init := project(File_Whois, InitDomains(left));

//Dec 19 2007 M.Lando swith 
/*Business_Header.MAC_Source_Match(Domains_Init, Domains_BDID_Init,
                        false, bdid,
                        false, 'W',
                        true, source_group,
                        company_name,
                        prim_range, prim_name, sec_range, zip,
                        false, phone_field,
                        false, fein_field) */
												
												
//--END OF mlando switch
	
BDID_Matchset := ['A'];
Business_Header_SS.MAC_Add_BDID_Flex(
																			 Domains_Init						  										// Input Dataset						
																			,BDID_Matchset                               // BDID Matchset           
																			,company_name        		             		    // company_name	              
																			,prim_range		                             // prim_range		              
																			,prim_name		                            // prim_name		              
																			,zip 					                           // zip5					              
																			,sec_range		                          // sec_range		              
																			,state				                         // state				              
																			,phone_field				           			  // phone				              
																			,fein_field                          // fein              
																			,bdid											 					// bdid												
																			,Layout_Whois_Temp 								 // Output Layout 
																			,false                         		// output layout has bdid score field?                       
																			,BDID_score_field              	 // bdid_score                 
																			,Post_Flex              				// Output Dataset   
																			,														   // deafult threscold
																			,													    // use prod version of superfiles
																			,													   // default is to hit prod from dataland, and on prod hit prod.		
																			,BIPV2.xlink_version_set    // Create BIP Keys only
																			,           						   // Url
																			,								          // Email
																			,p_City_name					   // City
																			,fname							    // fname
																			,mname							   // mname
																			,lname						    // lname
																			,                    //	ssn
																			,source             //sourceField
																			,source_rec_id     //persistent_rec_id
																			,false            //Call Flex macro before sourceMatch macro
															);

dWithBdids    := Post_Flex (BDID != 0);
dWithNoBdids  := Post_Flex (BDID = 0);

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
 
 /* mlando 12/19 BDID_Matchset := ['A']; */

//Dec 19 2007 M.Lando swith 
/*Business_Header_SS.MAC_Add_BDID_Flex(Domains_BDID_NoMatch,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, zip,
								                  sec_range, state,
                                  phone_field, fein_field,
                                  bdid, Layout_Whois_Temp,
                                  false, BDID_score_field,
                                  Domains_BDID_Rematch) */

//--END of mlando switch
Business_Header.MAC_Source_Match(dWithNoBdids, Domains_BDID_Rematch_0,
                                 false, bdid,
                                 false, MDR.sourceTools.src_Whois_domains,
                                 true, source_group,
                                 company_name,
                                 prim_range, prim_name, sec_range, zip,
                                 false, phone_field,
                                 false, fein_field);

Domains.Layout_Whois_Base_BIP FormatBase(Layout_Whois_Temp  L) := transform
//Added for CCPA-357
self.global_sid := 0;
self.record_sid := 0;
self            := l;
end;

Domains_BDID_All := project(Domains_BDID_Rematch_0 + dWithBdids, FormatBase(left));

export whois_bdid := Domains_BDID_All : persist('~thor_data400::persist::whois_bdid_swapped'); 