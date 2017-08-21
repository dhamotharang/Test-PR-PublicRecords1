// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import DriversV2, lib_stringlib, ut, versioncontrol;

export Preprocess_MN_RESTRICTED_Raw_Update(string pversion = '', boolean debug = false) := module
		//////////////////////////////////////////////////////////////////
		// -- Read in the six (6)logical files and rebuild the full
		//    driver's license update file.
		//////////////////////////////////////////////////////////////////			
		license := DriversV2.Files_MN_RESTRICTED_In().license.using;
		sort_license := sort(distribute(license,hash(operatorid)),operatorid,local);
		if (debug,output(sort_license,named('sort_licensebase')));
		if (debug,output(count(sort_license),named('cnt_sort_license')));

		addr := DriversV2.Files_MN_RESTRICTED_In().addr.using;
		sort_address := sort(distribute(addr,hash(operatorid)),operatorid,local);
		if (debug,output(sort_address,named('sort_address')));
		if (debug,output(count(sort_address),named('cnt_sort_address')));

		restriction := DriversV2.Files_MN_RESTRICTED_In().restriction.using;
		sort_restriction := sort(distribute(restriction,hash(operatorid)),operatorid,local);
		if (debug,output(sort_restriction,named('sort_restriction')));
		if (debug,output(count(sort_restriction),named('cnt_sort_restriction')));

		misc := DriversV2.Files_MN_RESTRICTED_In().misc.using;
		sort_misc := sort(distribute(misc,hash(operatorid)),operatorid,local);
		if (debug,output(sort_misc,named('sort_misc')));
		if (debug,output(count(sort_misc),named('cnt_sort_misc')));

		operator := DriversV2.Files_MN_RESTRICTED_In().operator.using;
		sort_operator := sort(distribute(operator,hash(operatorid)),operatorid,local);
		if (debug,output(sort_operator,named('sort_operator')));
		if (debug,output(count(sort_operator),named('cnt_sort_operator')));

		DriversV2.Layouts_DL_MN_RESTRICTED_In.violation_flat_rec xformViolation(DriversV2.layouts_dl_mn_restricted_in.violation_rec L, integer c) := transform
			self.violtextlineseq := L.textlinesegments[c].textlineseq;
			self.violsegmentseq  := L.textlinesegments[c].segmentseq;
			self.violdesctext    := L.textlinesegments[c].desctext;
			self.violdatatype    := L.textlinesegments[c].datatype;
			self.violcode        := L.textlinesegments[c].code;

			self := L;
		end;

		violation := DriversV2.Files_MN_RESTRICTED_In().violation.using;
		violation_dist := distribute(violation, hash(operatorid));
		norm_violation := normalize(violation_dist, left.textlinesegments, xformViolation(left, counter), local);
		sort_violation := sort(norm_violation,operatorid,local);
		if (debug,output(sort_violation,named('sort_violation')));
		if (debug,output(norm_violation,named('norm_violation')));
		if (debug,output(count(sort_violation),named('cnt_sort_violation')));

		//////////////////////////////////////////////////////////////////
		// -- Create the miscellaneous record
		//////////////////////////////////////////////////////////////////
		//only grab records with "TYPE" in desctext field
		//////////////////////////////////////////////////////////////////	
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec xfrmTYPE(DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_rec l, integer c) := transform,
			skip(lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'TYPE',1) = 0)
			donor_pos								:= lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'DONOR',1);
			type_desc			 					:= if (donor_pos <> 0
																		,ut.CleanSpacesAndUpper(regexreplace('TYPE|:',l.textlinesegments[c].desctext[1..donor_pos-1],''))
																		,ut.CleanSpacesAndUpper(regexreplace('TYPE|:',l.textlinesegments[c].desctext[1..],''))
																		);		
			self.operatorid 				:= ut.CleanSpacesAndUpper(l.operatorid);
			self.licensetype				:= DriversV2.Tables_DL_MN_RESTRICTED.License_RESTRICTED_Type(type_desc);
			self 										:= l;
			self										:= [];
		end;

		TYPE_norm 			:= normalize(sort_misc,LEFT.textlinesegments,xfrmTYPE(left,counter),local);
		TYPE_norm_sort 	:= sort(TYPE_norm,operatorid,local);
		if (debug,output(TYPE_norm_sort,named('TYPE_norm_sort')));
		if (debug,output(count(TYPE_norm_sort),named('cnt_TYPE_norm_sort')));
		
		//////////////////////////////////////////////////////////////////		
		//only grab records with "DONOR" in desctext field
		//////////////////////////////////////////////////////////////////	
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec xfrmDONOR(DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_rec l, integer c) := transform,
			skip(lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'DONOR',1) = 0)
			donor_pos					:= lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'DONOR',1);
			donor_desc			 	:= ut.CleanSpacesAndUpper(regexreplace('DONOR|:',l.textlinesegments[c].desctext[donor_pos..],''));			
			self.operatorid 	:= ut.CleanSpacesAndUpper(l.operatorid);
			self.donorflag		:= if (length(donor_desc) < 2,ut.CleanSpacesAndUpper(donor_desc),ut.CleanSpacesAndUpper(donor_desc[1..2]));
			self 							:= l;
			self							:= [];	
		end;

		DONOR_norm 				:= normalize(sort_misc,LEFT.textlinesegments,xfrmDONOR(left,counter),local);
		DONOR_norm_sort		:= sort(DONOR_norm,operatorid,local);
		if (debug,output(DONOR_norm_sort,named('DONOR_norm_sort')));
		if (debug,output(count(DONOR_norm_sort),named('cnt_DONOR_norm_sort')));
		
		//////////////////////////////////////////////////////////////////		
		//only grab records with "ENDORS" in desctext field
		//////////////////////////////////////////////////////////////////	
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec xfrmENDORS(DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_rec l, integer c) := transform,
			skip(lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'ENDORS',1) = 0)
			endors_pos							:= lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'ENDORS',1);
			endors_desc			 				:= ut.CleanSpacesAndUpper(regexreplace('ENDORS|:',l.textlinesegments[c].desctext[endors_pos..],''));					
			self.operatorid 				:= ut.CleanSpacesAndUpper(l.operatorid);
			self.lic_endorsement		:= DriversV2.Tables_DL_MN_RESTRICTED.License_RESTRICTED_Endorsement(endors_desc);												
			self 										:= l;
			self										:= [];		
		end;

		ENDORS_norm 			:= normalize(sort_misc,LEFT.textlinesegments,xfrmENDORS(left,counter),local);
		ENDORS_norm_sort	:= sort(ENDORS_norm,operatorid,local);
		if (debug,output(ENDORS_norm_sort,named('ENDORS_norm_sort')));
		if (debug,output(count(ENDORS_norm_sort),named('cnt_ENDORS_norm_sort')));
		
		//////////////////////////////////////////////////////////////////		
		//only grab records with "CDL STATUS" in desctext field
		//////////////////////////////////////////////////////////////////	
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec xfrmcdl_status(DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_rec l, integer c) := transform,
			skip(lib_stringlib.stringlib.stringfind(l.textlinesegments[c].desctext,'CDL STATUS',1) = 0)		 
			cdL_status_desc					:= ut.CleanSpacesAndUpper(regexreplace('CDL STATUS|:',l.textlinesegments[c].desctext,''));                                                                                                                                                                                                                                                                                                                                                                                            
			self.operatorid 				:= ut.CleanSpacesAndUpper(l.operatorid);
			self.cdl_status   			:= DriversV2.Tables_DL_MN_RESTRICTED.CDL_Status(cdL_status_desc);																 
			self 										:= l;
			self										:= [];	
		end;

		CDL_STATUS_norm 			:= normalize(sort_misc,LEFT.textlinesegments,xfrmcdl_status(left,counter),local);                                                                                                                                                                                  									
		CDL_STATUS_norm_sort	:= sort(CDL_STATUS_norm,operatorid,local);
		if (debug,output(CDL_STATUS_norm_sort,named('CDL_STATUS_norm_sort')));
		if (debug,output(count(CDL_STATUS_norm_sort),named('cnt_CDL_STATUS_norm_sort')));
		
		//////////////////////////////////////////////////////////////////		
		//Begin joining "TYPE" records and "DONOR" records to create
		//MISC file.
		//////////////////////////////////////////////////////////////////														
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec joinTypeDonor(TYPE_norm_sort l, DONOR_norm_sort r) := transform
			left_operatorid  := ut.CleanSpacesAndUpper(l.operatorid);
			right_operatorid := ut.CleanSpacesAndUpper(r.operatorid);

			self.operatorid 				:= map(left_operatorid = right_operatorid => left_operatorid,
																		 left_operatorid != ''              => left_operatorid,
																		 right_operatorid != ''             => right_operatorid,
																		 '');
			self.licensetype 				:= ut.CleanSpacesAndUpper(l.licensetype);
			self.cdl_status 				:= '';
			self.donorflag 					:= ut.CleanSpacesAndUpper(r.donorflag);
			self.lic_endorsement 		:= '';
		end;

		join_TYPE_DONOR := join(TYPE_norm_sort,DONOR_norm_sort
													 ,left.operatorid = right.operatorid
													 ,joinTypeDonor(left,right)
													 ,full outer
													 ,local
													 );
		if (debug,output(join_TYPE_DONOR,named('join_TYPE_DONOR')));
		if (debug,output(count(join_TYPE_DONOR),named('cnt_join_TYPE_DONOR')));
		
		//////////////////////////////////////////////////////////////////		
		//Join "ENORSE" records to the "MISC" file that is being built.
		//////////////////////////////////////////////////////////////////												 
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec joinENDORS(join_TYPE_DONOR l, ENDORS_norm_sort r) := transform
			left_operatorid  := ut.CleanSpacesAndUpper(l.operatorid);
			right_operatorid := ut.CleanSpacesAndUpper(r.operatorid);

			self.operatorid 				:= map(left_operatorid = right_operatorid => left_operatorid,
																		 left_operatorid != ''              => left_operatorid,
																		 right_operatorid != ''             => right_operatorid,
																		 '');
			self.licensetype 				:= l.licensetype;
			self.cdl_status 				:= '';
			self.donorflag 					:= l.donorflag;
			self.lic_endorsement 		:= ut.CleanSpacesAndUpper(r.lic_endorsement);
		end;											 
													 
		join_ENDORS 		:= join(join_TYPE_DONOR,ENDORS_norm
													 ,left.operatorid = right.operatorid
													 ,joinENDORS(left,right)
													 ,full outer
													 ,local											 
													 );										 
		if (debug,output(join_ENDORS,named('join_ENDORS')));
		if (debug,output(count(join_ENDORS),named('cnt_join_ENDORS')));
		
		//////////////////////////////////////////////////////////////////		
		//Join "CDL_STATUS" records to the "MISC" file that is being built.
		//////////////////////////////////////////////////////////////////
		DriversV2.Layouts_DL_MN_RESTRICTED_In.misc_normalized_rec joincdl_status(join_ENDORS l, CDL_STATUS_norm_sort r) := transform
			left_operatorid  := ut.CleanSpacesAndUpper(l.operatorid);
			right_operatorid := ut.CleanSpacesAndUpper(r.operatorid);

			self.operatorid 				:= map(left_operatorid = right_operatorid => left_operatorid,
																		 left_operatorid != ''              => left_operatorid,
																		 right_operatorid != ''             => right_operatorid,
																		 '');
			self.licensetype 				:= l.licensetype;
			self.cdl_status 				:= ut.CleanSpacesAndUpper(r.cdl_status);
			self.donorflag 					:= l.donorflag;
			self.lic_endorsement 		:= l.lic_endorsement;
		end;											 
													 
		join_cdl_status				:= join(join_ENDORS,CDL_STATUS_norm_sort
																 ,left.operatorid = right.operatorid
																 ,joincdl_status(left,right)
																 ,full outer
																 ,local														 
																 );
		if (debug,output(join_cdl_status,named('join_cdl_status')));
		if (debug,output(count(join_cdl_status),named('cnt_join_cdl_status')));
		
		//////////////////////////////////////////////////////////////////		
		//misc_rec represents the final built "MISC" file.
		//////////////////////////////////////////////////////////////////
		misc_rec := dedup(sort(distribute(join_cdl_status,hash(operatorid)),record,local),record,local);
		if (debug,output(misc_rec,named('misc_rec')));
		if (debug,output(count(misc_rec),named('cnt_misc_rec')));

		//////////////////////////////////////////////////////////////////
		// -- Create the full record - the full record contains derived
		//		fields along with the original raw data that will be used
		//    as input into the MN mapping and build process.
		//	  NOTE:  The license record is the primary record that the
		//		other files are merged with.		
		//////////////////////////////////////////////////////////////////		
		//This begins the building of the full record.  Join the primary
		//file license with the previously built misc_rec.
		//////////////////////////////////////////////////////////////////
		DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec joinem_license_misc(sort_license l, misc_rec r) := transform
				self.process_date 						:= pversion;
				self.operatorid 							:= ut.CleanSpacesAndUpper(l.operatorid);
				self.licensetype 					  	:= r.licensetype;
				self.cdl_status 							:= r.cdl_status;
				self.donorflag 								:= r.donorflag;
				self.lic_endorsement 					:= r.lic_endorsement;
				self													:= l;
				self													:= [];
		end;

		join_license_misc := join(sort_license,misc_rec
														 ,ut.CleanSpacesAndUpper(left.operatorid) = right.operatorid
														 ,joinem_license_misc(left,right)
														 ,left outer
														 ,local
														 );
		if (debug,output(join_license_misc,named('join_license_misc')));	
		if (debug,output(count(join_license_misc),named('cnt_join_license_misc')));	

		//////////////////////////////////////////////////////////////////		
		//Join the primary file license with the address file.
		//////////////////////////////////////////////////////////////////
		DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec joinem_address(join_license_misc l, sort_address r) := transform		
				self.address									:= ut.CleanSpacesAndUpper(r.address);
				self.city											:= ut.CleanSpacesAndUpper(r.city);
				self.statepostalcode					:= ut.CleanSpacesAndUpper(r.statepostalcode);
				self.zip											:= ut.CleanSpacesAndUpper(r.zip);
				self.countycode								:= ut.CleanSpacesAndUpper(r.countycode);
				self.cleanaddress.prim_range	:= ut.CleanSpacesAndUpper(r.cleanaddress.prim_range);
				self.cleanaddress.predir			:= ut.CleanSpacesAndUpper(r.cleanaddress.predir);
				self.cleanaddress.prim_name		:= ut.CleanSpacesAndUpper(r.cleanaddress.prim_name);
				self.cleanaddress.addr_suffix	:= ut.CleanSpacesAndUpper(r.cleanaddress.addr_suffix);
				self.cleanaddress.postdir			:= ut.CleanSpacesAndUpper(r.cleanaddress.postdir);
				self.cleanaddress.unit_desig	:= ut.CleanSpacesAndUpper(r.cleanaddress.unit_desig);
				self.cleanaddress.sec_range		:= ut.CleanSpacesAndUpper(r.cleanaddress.sec_range);
				self.cleanaddress.p_city_name	:= ut.CleanSpacesAndUpper(r.cleanaddress.p_city_name);
				self.cleanaddress.v_city_name	:= ut.CleanSpacesAndUpper(r.cleanaddress.v_city_name);
				self.cleanaddress.st					:= ut.CleanSpacesAndUpper(r.cleanaddress.st);
				self.cleanaddress.zip					:= ut.CleanSpacesAndUpper(r.cleanaddress.zip);
				self.cleanaddress.zip4				:= ut.CleanSpacesAndUpper(r.cleanaddress.zip4);
				self.cleanaddress.cart				:= ut.CleanSpacesAndUpper(r.cleanaddress.cart);
				self.cleanaddress.cr_sort_sz	:= ut.CleanSpacesAndUpper(r.cleanaddress.cr_sort_sz);
				self.cleanaddress.lot					:= ut.CleanSpacesAndUpper(r.cleanaddress.lot);
				self.cleanaddress.lot_order		:= ut.CleanSpacesAndUpper(r.cleanaddress.lot_order);
				self.cleanaddress.dbpc				:= ut.CleanSpacesAndUpper(r.cleanaddress.dbpc);
				self.cleanaddress.chk_digit		:= ut.CleanSpacesAndUpper(r.cleanaddress.chk_digit);
				self.cleanaddress.rec_type		:= ut.CleanSpacesAndUpper(r.cleanaddress.rec_type);
				self.cleanaddress.fips_state	:= ut.CleanSpacesAndUpper(r.cleanaddress.fips_state);
				self.cleanaddress.fips_county	:= ut.CleanSpacesAndUpper(r.cleanaddress.fips_county);
				self.cleanaddress.geo_lat			:= ut.CleanSpacesAndUpper(r.cleanaddress.geo_lat);
				self.cleanaddress.geo_long		:= ut.CleanSpacesAndUpper(r.cleanaddress.geo_long);
				self.cleanaddress.msa					:= ut.CleanSpacesAndUpper(r.cleanaddress.msa);
				self.cleanaddress.geo_blk			:= ut.CleanSpacesAndUpper(r.cleanaddress.geo_blk);
				self.cleanaddress.geo_match		:= ut.CleanSpacesAndUpper(r.cleanaddress.geo_match);
				self.cleanaddress.err_stat		:= ut.CleanSpacesAndUpper(r.cleanaddress.err_stat);
				self													:= l;
		end;

		join_lic_misc_addr := join(join_license_misc,sort_address
												 ,left.operatorid = right.operatorid
												 ,joinem_address(left,right)
												 ,left outer
												 ,local
												 );												 
		if (debug,output(join_lic_misc_addr,named('join_lic_misc_addr')));	
		if (debug,output(count(join_lic_misc_addr),named('cnt_join_lic_misc_addr')));	
				 
		//////////////////////////////////////////////////////////////////		
		//Preprocess the restriction file before joining to the primary
		//license file.  Multiple restrictions can exist for a driver, 
		//therefore the file needs denormalized.
		//////////////////////////////////////////////////////////////////	
		restriction_filt 	:= sort_restriction(restrictiondesc<>'');
		
		DriversV2.Layouts_DL_MN_RESTRICTED_In.temp_restrictions xRestrictions(DriversV2.Layouts_DL_MN_RESTRICTED_In.restriction_rec l) := transform
				temp_restriction_code					:= DriversV2.Tables_DL_MN_RESTRICTED.Restriction_RESTRICTED_Code(l.restrictiondesc);
				self.restrictioncode					:= ut.CleanSpacesAndUpper(l.restrictioncode);
				self.derived_restrictioncode	:= temp_restriction_code;
				self.applyall									:= ut.CleanSpacesAndUpper(l.applyall);
				self.restrictiondesc					:= ut.CleanSpacesAndUpper(l.restrictiondesc);
				self.restrictions 						:= temp_restriction_code;				
				self.restrictions_delimited		:= '';
				self													:= l;
		end;								 

		restriction_proj  := project(restriction_filt, xRestrictions(left));
		if (debug,output(restriction_proj,named('restriction_proj')));
		if (debug,output(count(restriction_proj),named('cnt_restriction_proj')));
		
		restriction_dedup := dedup(sort(restriction_proj,operatorid,local),operatorid,local);
		if (debug,output(restriction_dedup,named('restriction_dedup')));
		if (debug,output(count(restriction_dedup),named('cnt_restriction_dedup')));			
		
		
		DriversV2.Layouts_DL_MN_RESTRICTED_In.temp_restrictions denormrestrictions(DriversV2.Layouts_DL_MN_RESTRICTED_In.temp_restrictions l, DriversV2.Layouts_DL_MN_RESTRICTED_In.temp_restrictions r) := transform
				self.restrictions_delimited	:= if (ut.CleanSpacesAndUpper(l.restrictions_delimited) = ''
																					,ut.CleanSpacesAndUpper(r.restrictions)
																					,if (lib_stringlib.stringlib.stringfind(ut.CleanSpacesAndUpper(l.restrictions),ut.CleanSpacesAndUpper(r.restrictions),1) <> 0
																							,ut.CleanSpacesAndUpper(l.restrictions_delimited)
																							,ut.CleanSpacesAndUpper(l.restrictions_delimited) + ';' + ut.CleanSpacesAndUpper(r.restrictions)
																							)
																					);
				self.restrictions 					:= if (lib_stringlib.stringlib.stringfind(ut.CleanSpacesAndUpper(l.restrictions),ut.CleanSpacesAndUpper(r.restrictions),1) <> 0
																					,ut.CleanSpacesAndUpper(l.restrictions)
																					,ut.CleanSpacesAndUpper(l.restrictions) + ut.CleanSpacesAndUpper(r.restrictions)
																					); 		 
				self 												:= l;
				
		end;								 
										 
		DeNormedRecs := DENORMALIZE(restriction_dedup, restriction_proj,
																LEFT.operatorid = RIGHT.operatorid,
																denormrestrictions(LEFT,RIGHT),
																local);
		if (debug,output(DeNormedRecs,named('DeNormedRecs')));	
		if (debug,output(count(DeNormedRecs),named('cnt_DeNormedRecs')));

		//////////////////////////////////////////////////////////////////		
		//Join the primary file license with the preprocessed restriction
		//file.
		//////////////////////////////////////////////////////////////////
		DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec joinem_norm_restrictions(join_lic_misc_addr l, denormedrecs r) := transform
				self.derived_restrictioncode	:= ut.CleanSpacesAndUpper(r.derived_restrictioncode);		
				self.restrictions_delimited		:= ut.CleanSpacesAndUpper(r.restrictions_delimited);
				self.restrictions 						:= ut.CleanSpacesAndUpper(r.restrictions); 	
				self													:= l;
		end;

		join_lic_misc_addr_normres := join(join_lic_misc_addr,denormedrecs
												 ,left.operatorid = right.operatorid
												 ,joinem_norm_restrictions(left,right)
												 ,left outer
												 ,local
												 );
		if (debug,output(join_lic_misc_addr_normres,named('join_lic_misc_addr_normres')));	
		if (debug,output(count(join_lic_misc_addr_normres),named('cnt_join_lic_misc_addr_normres')));

		//////////////////////////////////////////////////////////////////		
		//Join the primary file license with the operator file.
		//////////////////////////////////////////////////////////////////		
		DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec joinem_operator(join_lic_misc_addr_normres l, sort_operator r) := transform
				self.dt_first_seen						:= (unsigned8)r.mvrrptdate div 100;
				self.dt_last_seen							:= (unsigned8)r.mvrrptdate div 100;
				self.dt_vendor_first_reported	:= (unsigned8)r.mvrrptdate div 100;
				self.dt_vendor_last_reported	:= (unsigned8)r.mvrrptdate div 100;
				self.donorflag  							:= ut.CleanSpacesAndUpper(l.donorflag);  //donorflag mapped from misc; all donorflag in operator are empty			
				self.loadid										:= ut.CleanSpacesAndUpper(r.loadid);
				self.filetype 								:= ut.CleanSpacesAndUpper(r.filetype);
				self.sourcetype   						:= ut.CleanSpacesAndUpper(r.sourcetype);
				self.sourcefrequency 					:= ut.CleanSpacesAndUpper(r.sourcefrequency);
				self.statepostalcode					:= ut.CleanSpacesAndUpper(r.statepostalcode);  
				self.title  									:= ut.CleanSpacesAndUpper(r.title);          
				self.lname 										:= ut.CleanSpacesAndUpper(r.lname);          
				self.fname 										:= ut.CleanSpacesAndUpper(r.fname);          
				self.mname 										:= ut.CleanSpacesAndUpper(r.mname);          
				self.sname 						  			:= ut.CleanSpacesAndUpper(r.sname);          
				self.ssn   										:= ut.CleanSpacesAndUpper(r.ssn);
				self.dob											:= r.dob;           
				self.gender 									:= ut.CleanSpacesAndUpper(r.gender);        
				self.height  						 			:= if (stringlib.stringfind(r.height,'-',1) <> 0,stringlib.stringfindreplace(ut.CleanSpacesAndUpper(r.height), '-',''),ut.CleanSpacesAndUpper(r.height));
				self.weight   								:= ut.CleanSpacesAndUpper(r.weight);
				self.eyecolor  								:= ut.CleanSpacesAndUpper(r.eyecolor);
				self.haircolor 					 			:= ut.CleanSpacesAndUpper(r.haircolor);
				self.aka  										:= ut.CleanSpacesAndUpper(r.aka);
				self.mvrrptdate  							:= r.mvrrptdate;    
				self.mvrsourcecode   					:= ut.CleanSpacesAndUpper(r.mvrsourcecode);
				self.mvrorigincode 						:= ut.CleanSpacesAndUpper(r.mvrorigincode);
				self.mvrstatuscode 						:= ut.CleanSpacesAndUpper(r.mvrstatuscode);
				self.privacyflag 							:= ut.CleanSpacesAndUpper(r.privacyflag);
				self.mvrtypelist 							:= ut.CleanSpacesAndUpper(r.mvrtypelist);
				self.driverstate 							:= ut.CleanSpacesAndUpper(r.driverstate);
				self.driverid 								:= ut.CleanSpacesAndUpper(r.driverid);
				self.idl 											:= r.idl;
				self.transactionid 			 			:= ut.CleanSpacesAndUpper(r.transactionid);
				self.account 									:= ut.CleanSpacesAndUpper(r.account);
				self.restrictedflag 					:= ut.CleanSpacesAndUpper(r.restrictedflag);
				self.amplified  							:= ut.CleanSpacesAndUpper(r.amplified);
				self.referencenumber 					:= ut.CleanSpacesAndUpper(r.referencenumber);
				self.uniquemvrid 							:= ut.CleanSpacesAndUpper(r.uniquemvrid);
				self.fulfilledby  						:= ut.CleanSpacesAndUpper(r.fulfilledby);
				self.businessline  						:= ut.CleanSpacesAndUpper(r.businessline);
				self.mvrrpttime 							:= r.mvrrpttime;
				self.modifieddate 						:= r.modifieddate;
				self.adversecondition 				:= ut.CleanSpacesAndUpper(r.adversecondition);
				self.derivedvalidpdl  				:= ut.CleanSpacesAndUpper(r.derivedvalidpdl);
				self.searchperiod 	 					:= ut.CleanSpacesAndUpper(r.searchperiod);
				self.mvrorderdatetime 				:= r.mvrorderdatetime;
				self.derivedmvrstatus 				:= ut.CleanSpacesAndUpper(r.derivedmvrstatus);
				self.permissiblepurposecode		:= ut.CleanSpacesAndUpper(r.permissiblepurposecode);
				self.eyecolordesc 						:= ut.CleanSpacesAndUpper(r.eyecolordesc);
				self.haircolordesc						:= ut.CleanSpacesAndUpper(r.haircolordesc);
				self.operator_DtFirstSeen     := r.DtFirstSeen;
				self													:= l;
		end;

		join_lic_misc_addr_res_oper := join(join_lic_misc_addr_normres,sort_operator
																 ,left.operatorid 	= right.operatorid
																 ,joinem_operator(left,right)
																 ,left outer
																 ,local														 
																 );
		if (debug,output(join_lic_misc_addr_res_oper,named('join_lic_misc_addr_res_oper')));	
		if (debug,output(count(join_lic_misc_addr_res_oper),named('cnt_join_lic_misc_addr_res_oper')));	

		//////////////////////////////////////////////////////////////////		
		//Join the primary file license with the violation file.
		//////////////////////////////////////////////////////////////////	
		DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec joinem_violation(join_lic_misc_addr_res_oper l, sort_violation r) := transform
				self.violationcode					:= ut.CleanSpacesAndUpper(r.violationcode);
				self.violationtype					:= ut.CleanSpacesAndUpper(r.violationtype);
				self.violsuspnsndate				:= r.violsuspnsndate;
				self.convreinstmtdate				:= r.convreinstmtdate;
				self.prescrsrchdate					:= r.prescrsrchdate;
				self.cdlflag								:= ut.CleanSpacesAndUpper(r.cdlflag);
				self.violationpoints				:= r.violationpoints;
				self.withdrawalstatus				:= ut.CleanSpacesAndUpper(r.withdrawalstatus);
				self.suppressdisplay				:= ut.CleanSpacesAndUpper(r.suppressdisplay);
				self.expandedsrchflag				:= ut.CleanSpacesAndUpper(r.expandedsrchflag);
				self.dispositioncode				:= ut.CleanSpacesAndUpper(r.dispositioncode);
				self.casestatus							:= ut.CleanSpacesAndUpper(r.casestatus);
				self.datasourcecode					:= ut.CleanSpacesAndUpper(r.datasourcecode);
				self.sentencecode						:= ut.CleanSpacesAndUpper(r.sentencecode);
				self.svc										:= ut.CleanSpacesAndUpper(r.svc);
				self.svcqualifiers					:= ut.CleanSpacesAndUpper(r.svcqualifiers);
				self.modifieddate						:= r.modifieddate;
				self.violtextlineseq				:= r.violtextlineseq;
				self.violsegmentseq					:= r.violsegmentseq;
				self.violdesctext						:= ut.CleanSpacesAndUpper(r.violdesctext);
				self.violdatatype						:= r.violdatatype;
				self.violcode								:= r.violcode;
				self.statepostalcode				:= l.statepostalcode;
				self.violation_DtFirstSeen  := r.DtFirstSeen;
				self												:= l;
		end;							 

		join_lic_misc_addr_res_oper_viol := join(join_lic_misc_addr_res_oper,sort_violation
													,left.operatorid 	= right.operatorid
													,joinem_violation(left,right)
													,left outer
													,local											
													);
													
		if (debug,output(join_lic_misc_addr_res_oper_viol,named('join_lic_misc_addr_res_oper_viol')));	
		if (debug,output(count(join_lic_misc_addr_res_oper_viol),named('cnt_join_lic_misc_addr_res_oper_viol')));	

		//////////////////////////////////////////////////////////////////		
		//Join the primary file license with the original miscellaneous
		//file in order to get the raw text segments and map it to the 
		//full record.
		//////////////////////////////////////////////////////////////////	
		DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec joinem_misc(join_lic_misc_addr_res_oper_viol l, sort_misc r) := transform
				self.MiscTextLineSegments		:= r.TextLineSegments;
				self												:= l;
		end;
						 
		ds_MN_DL_RESTRICTED_Current_Updates 	:= join(join_lic_misc_addr_res_oper_viol,sort_misc
																						,left.operatorid 	= right.operatorid
																						,joinem_misc(left,right)
																						,left outer
																						,local											
																						);

		DriversV2.Layouts_DL_MN_RESTRICTED_In.full_rec xformMiscText(DriversV2.Layouts_DL_MN_RESTRICTED_In.almost_full_rec L, integer c) := transform
			self.textlineseq := L.misctextlinesegments[c].textlineseq;
			self.segmentseq  := L.misctextlinesegments[c].segmentseq;
			self.desctext    := L.misctextlinesegments[c].desctext;
			self.datatype    := L.misctextlinesegments[c].datatype;
			self.code        := L.misctextlinesegments[c].code;

			self := L;
		end;

    ds_MN_DL_RESTRICTED_Current_Updates_norm := normalize(ds_MN_DL_RESTRICTED_Current_Updates, left.misctextlinesegments, xformMiscText(left, counter));

		if (debug,output(ds_MN_DL_RESTRICTED_Current_Updates,named('ds_MN_DL_RESTRICTED_Current_Updates')));	
		if (debug,output(count(ds_MN_DL_RESTRICTED_Current_Updates),named('cnt_ds_MN_DL_RESTRICTED_Current_Updates')));
		if (debug,output(ds_MN_DL_RESTRICTED_Current_Updates_norm,named('ds_MN_DL_RESTRICTED_Current_Updates_norm')));	
		if (debug,output(count(ds_MN_DL_RESTRICTED_Current_Updates_norm),named('cnt_ds_MN_DL_RESTRICTED_Current_Updates_norm')));
		
		//////////////////////////////////////////////////////////////////		
		//ds_MN_DL_RESTRICTED_Current_Updates contains a "snapshot" of our vendor's
		//database (MN OKC's).  A "historical" update file is kept that includes
		//any update that has been sent from the vendor.  The following sort
		//and rollup keeps the latest version of the record for MN DL build
		//processing.
		//////////////////////////////////////////////////////////////////
		ifHistoricalDataExists	:= if (nothor(fileservices.getsuperfilesubcount(DriversV2.Filenames(,'mn_restricted_raw_common_base').Base.qa))<>0,true,false);
		ds_MN_DL_RESTRICTED_Historical_Updates 							:= DriversV2.Files_MN_RESTRICTED_In().raw_common_base.qa;
		ds_MN_DL_RESTRICTED_Current_and_Historical_Updates 	:= if (ifHistoricalDataExists
																															,ds_MN_DL_RESTRICTED_Current_Updates_norm + ds_MN_DL_RESTRICTED_Historical_Updates
																															,ds_MN_DL_RESTRICTED_Current_Updates_norm
																															);

		ds_MN_RESTRICTED_Raw_Sort := sort(distribute(ds_MN_DL_RESTRICTED_Current_and_Historical_Updates,hash(dln)),
		                                  dln, violsuspnsndate, prescrsrchdate, textlineseq, segmentseq, desctext, datatype, code, violtextlineseq, violsegmentseq, violdesctext, violdatatype, violcode, record,
																			   except operatorid, mvrrptdate, dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
																				        AddRecID, RestRecID, LicRecID, ViolRecID, OperRecID, operator_DtFirstSeen, violation_DtFirstSeen,
																			local);


		DriversV2.layouts_dl_mn_restricted_in.full_rec rollup_raw_data(DriversV2.layouts_dl_mn_restricted_in.full_rec l, DriversV2.layouts_dl_mn_restricted_in.full_rec r) := transform
			self.process_date					:=	(string)max((unsigned6)l.process_date,(unsigned6)r.process_date);
			self.mvrrptdate						:=					max((unsigned6)l.mvrrptdate,(unsigned6)r.mvrrptdate);
			self.dt_first_seen				:=	ut.EarliestDate(
																			ut.EarliestDate(l.dt_first_seen, r.dt_first_seen),
																			ut.EarliestDate(l.dt_last_seen, r.dt_last_seen)
																		);
			self.dt_last_seen					:=	max(l.dt_last_seen, r.dt_last_seen);
			self.dt_vendor_first_reported	:=	ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
			self.dt_vendor_last_reported	:=	max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);	 
			self  			              := l;
		end;		

		ds_MN_RESTRICTED_Raw_Rollup 		:= rollup(
																							ds_MN_RESTRICTED_Raw_Sort
																						 ,rollup_raw_data(left, right)
																						 ,record
																						 ,except
																								 operatorid
																								,AddRecID
																								,RestRecID
																								,LicRecID
																								,ViolRecID
																								,OperRecID
																								,operator_DtFirstSeen
																								,violation_DtFirstSeen
																								,process_date
																								,mvrrptdate
																								,dt_first_seen
																								,dt_last_seen
																								,dt_vendor_first_reported
																								,dt_vendor_last_reported, local
																						);
																		
		VersionControl.macBuildNewLogicalFile(Filenames(pversion,'mn_restricted_raw_common_base').Base.logical,ds_MN_RESTRICTED_Raw_Rollup,build_MN_RESTRICTED_Raw);

end;