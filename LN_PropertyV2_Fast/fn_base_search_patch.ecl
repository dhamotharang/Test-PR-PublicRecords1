IMPORT 	ln_propertyv2, business_header, business_header_ss, mdr, BIPV2,Data_Services;
EXPORT	fn_base_search_patch := MODULE
				SHARED 	property_didAndbdid_second_pass(dataset(ln_propertyv2.Layout_DID_Out) search_in) := FUNCTION

								PreDID_Rec :=	record
										
									qstring34  source_group := '';
									qstring34  vendor_id := '';
									ln_propertyv2.Layout_DID_Out; 
									integer8	temp_DID		    := 0;
									integer8	temp_BDID 	    := 0;
									string9 appended_SSN := '';
									string9 appended_tax_id := '';
									string2 source := '';
									integer3 DID_Score := 0;
									integer3 BDID_Score := 0;
									
								 end;
									
								PreDID_Rec taddDID(search_in L) :=  transform

										self.vendor_id	:=  l.ln_fares_id + 'FA' + ((string)(hash(l.fname, l.lname, l.prim_name)))[1..4];
										self.source 		:= MDR.sourceTools.fProperty(l.ln_fares_id);
										self						:= L;

								end;

								Prefile	:= project(search_in,taddDID(left)); 

								//append SRC 
								preBDID := prefile(cname <> '');
									 
								//append BDID
								business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
																								false,temp_BDID,
																								true,source,
																								false,foo,
																								cname,
																								prim_Range,Prim_name,sec_range,zip,
																								true,phone_number,
																								false,foo,
																								false,vendor_id);	 

								myset := ['A'];

								//append BDID's and  BIPv2 xlinkids.
								Business_header_ss.MAC_Match_Flex(dPostSourceMatch
																									,myset
																									,cname
																									,prim_range
																									,prim_name
																									,zip
																									,sec_range
																									,st
																									,phone_number
																									,foo
																									,temp_bdid
																									,PreDID_Rec
																									,true
																									,BDID_Score
																									,postbdid											// macro output dataset
																									,
																									,															// deafult threscold
																									,													 		// use prod version of superfiles
																									,															// default is to hit prod from dataland, and on prod hit prod.
																									,BIPV2.xlink_version_set 			// Create BIP Keys only
																									,           								 	// Url
																									,								            	// Email
																									,p_city_name							 		// City
																									,fname							      		// fname
																									,mname												// mname
																									,lname						 						// lname
																									,															// contact_ssn
																									,source												// source
																									,source_rec_id								// source_rec_id
																									,true
																									);

								LN_PropertyV2.Layout_DID_Out reformattemp(postbdid L) :=  transform

										self.BDID		    						:= L.temp_BDID;
										self 												:= L;
										
								end;

								search_out := project(postbdid, reformattemp(left));

								RETURN search_out;

				END;

				EXPORT linkids(dataset(recordof(ln_propertyV2.Layout_DID_Out)) search_in) := FUNCTION

							ds_old_cname_mapping_file 		:= dataset(
																										Data_Services.Data_location.prefix('Property')+'thor_data400::mapping::ln_propertyv2::cname_changes',
																										{ln_propertyV2.Layout_DID_Out -[Addr_ind,Best_addr_ind,addr_tx_id,best_addr_tx_id,Location_id,best_locid]
																										,string80 old_cname},
																										thor
																									);
							
							// GRAB ONLY THE RECORDS WE NEED TO PATCH (try and re-link those with out a linkId)
							records_to_patch			:= search_in(DotID=0 AND EmpID=0 AND POWID=0 AND ProxID=0 AND SELEID=0 AND OrgID=0 AND UltID=0 );

							// RESTORE OLD CNAMES			
							recordof(records_to_patch) mapOldCname(records_to_patch L, ds_old_cname_mapping_file R) := transform
									SELF.cname 					:= if (R.old_cname <>'', R.old_cname, L.cname);
									SELF			 					:= L;
							end;

							records_to_patch_with_old_cname := join(
																				distribute(records_to_patch					,hash(ln_fares_id)),
																				distribute(ds_old_cname_mapping_file,hash(ln_fares_id)),
																				LEFT.ln_fares_id = RIGHT.ln_fares_id 	AND		LEFT.source_code = RIGHT.source_code AND
																				LEFT.which_orig = RIGHT.which_orig 		AND		LEFT.nameasis = RIGHT.nameasis,
																				mapOldCname(LEFT,RIGHT),													
																				LEFT OUTER, keep(1), local);
							
							// RE-RUN BIP MACRO TO RESTORE LOST LINKIDS
							patched_records_re_linked_with_old_cnames := property_didAndbdid_second_pass(records_to_patch_with_old_cname);


							// PATCH THE BAD SEARCH FILE (transfer old srouce_rec_id and restored LinkIds)
							recordof(search_in) mapPatchBadSearchFile(search_in L, patched_records_re_linked_with_old_cnames R) := TRANSFORM

																SELF.source_rec_id := if(R.source_rec_id<>0, R.source_rec_id ,L.source_rec_id);
																SELF.DotID := if(R.DotID<>0, R.DotID, L.DotID);
																SELF.DotScore := if(R.DotScore<>0, R.DotScore, L.DotScore);
																SELF.DotWeight := if(R.DotWeight<>0, R.DotWeight, L.DotWeight);
																SELF.EmpID := if(R.EmpID<>0, R.EmpID, L.EmpID);
																SELF.EmpScore := if(R.EmpScore<>0, R.EmpScore, L.EmpScore);
																SELF.EmpWeight := if(R.EmpWeight<>0, R.EmpWeight, L.EmpWeight);
																SELF.POWID := if(R.POWID<>0, R.POWID, L.POWID);
																SELF.POWScore := if(R.POWScore<>0, R.POWScore, L.POWScore);
																SELF.POWWeight := if(R.POWWeight<>0, R.POWWeight, L.POWWeight);
																SELF.ProxID := if(R.ProxID<>0, R.ProxID, L.ProxID);
																SELF.ProxScore := if(R.ProxScore<>0, R.ProxScore, L.ProxScore);
																SELF.ProxWeight := if(R.ProxWeight<>0, R.ProxWeight, L.ProxWeight);
																SELF.SELEID := if(R.SELEID<>0, R.SELEID, L.SELEID);
																SELF.SELEScore := if(R.SELEScore<>0, R.SELEScore, L.SELEScore);
																SELF.SELEWeight := if(R.SELEWeight<>0, R.SELEWeight, L.SELEWeight);
																SELF.OrgID := if(R.OrgID<>0, R.OrgID, L.OrgID);
																SELF.OrgScore := if(R.OrgScore<>0, R.OrgScore, L.OrgScore);
																SELF.OrgWeight := if(R.OrgWeight<>0, R.OrgWeight, L.OrgWeight);
																SELF.UltID := if(R.UltID<>0, R.UltID, L.UltID);
																SELF.UltScore := if(R.UltScore<>0, R.UltScore, L.UltScore);
																SELF.UltWeight := if(R.UltWeight<>0, R.UltWeight, L.UltWeight);
																SELF := L;

							end;

							search_out := join(	distribute(search_in,hash(ln_fares_id)),
																	distribute(patched_records_re_linked_with_old_cnames,hash(ln_fares_id)),
																	LEFT.ln_fares_id = RIGHT.ln_fares_id AND	LEFT.source_code = RIGHT.source_code AND
																	LEFT.which_orig = RIGHT.which_orig AND		LEFT.nameasis = RIGHT.nameasis,
																	mapPatchBadSearchFile(LEFT,RIGHT),
																	LEFT OUTER, keep(1), local);
										
							RETURN search_out;

				END;
END;