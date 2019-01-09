/* ************************************************************************************************************ */	
//
// set version number (date of run) for proper input file handling.
//
/* ************************************************************************************************************ */	

import Prof_License,fieldstats,did_add,ut,header_slimsort,watchdog,didville,census_data,business_header,business_header_ss,mdr,header,BIPV2,BizLinkFull,Health_Provider_Services,
       Health_Facility_Services, BIPV2_Company_Names, HealthCareFacility, PromoteSupers;

	/* ***DID PROCESS--do_out************************************************************************************** */	

			infile := prof_license.File_prolic_in;

			mprd_input      := Prof_License.Mapping_Input.MPRD(license_type != '');
			hms_input       := Prof_License.Mapping_Input.HMS(license_type != '');
			alc_input       := Prof_License.Mapping_Input.ALC(license_type != '');
			infogroup_input := Prof_License.Mapping_Input.Infogroup(license_type != '');

      combined_input := infile + hms_input + mprd_input + alc_input + infogroup_input: INDEPENDENT;

			dAID	 := fPrepandCleanAID(combined_input);

			outrec := record
			  Prof_License.Layout_prolic_in_with_AID;
				string18  county_name := '';
				string12  did_string  := '';
				string3   did_score   := '';
				string9   ssn         := '';
				string12  bdid_string := '';
			end;

			//****** Add a temp field for carrying the DID
			rec := record
			  outrec;
			  unsigned6 did;
			  unsigned6 temp_did_score;
			  unsigned6	bdid := 0;
        unsigned8	source_rec_id  :=  0;
			  BIPV2.IDlayouts.l_xlink_ids;
				INTEGER2  xadl2_weight := 0;
				UNSIGNED2 xadl2_score := 0;
				INTEGER1  xadl2_distance := 0;
				UNSIGNED4 xadl2_keys_used := 0;
				STRING    xadl2_keys_desc := '';
				STRING60  xadl2_matches := '';
				STRING    xadl2_matches_desc := '';
			end;
	
			rec addtemp(dAID l) := transform	
			  self.did := 0;
			  self.temp_did_score := 0;
			  self := l;
			end;
	
			inmac := project(dAID, addtemp(left));

			//add src 
			src_rec := record
			  header_slimsort.Layout_Source;
        rec;
			end;

			DID_Add.Mac_Set_Source_Code(inmac, src_rec, 'PL', inmac_src);
			
			matchset := ['A','D','P'];
			
			//****** Add the DIDs
			did_Add.MAC_Match_Flex
                    (inmac_src, matchset,						
                    ssn, dob, fname, mname,lname, name_suffix, 
                    prim_range, prim_name, sec_range, zip, st, phone, 
                    DID,   			
                    src_rec, 
                    true, temp_DID_Score,
                    75,	
                    wdid_src,true,src);
	 
			//remove src	 
			wdid := project(wdid_src, transform(rec, self := left));

			//****** Add the SSN 
			did_add.MAC_Add_SSN_By_DID(wdid, DID, ssn, wssn)
      
			//****Source_rec_id logic
			Update_prolic_Base	    := dedup(sort(distribute(wssn,hash64(source_st,vendor,profession_or_board,license_number,company_name,orig_name)),record,local),record,local);
			Previous_prolic_Base	  := distribute(Prof_License.File_prof_license_base_AID ,hash64(source_st,vendor,profession_or_board,license_number,company_name,orig_name));			
      
			rec get_recID(rec l,Prof_License.layout_prolic_out_with_AID r):=transform
      	 self.source_rec_id := r.source_rec_id;
      	 self               := l;
			end;
			
			Append_recID := join(Update_prolic_Base, Previous_prolic_Base,
														trim(left.prolic_key,left,right)         						 =     trim(right.prolic_key,left,right)and
														trim(left.profession_or_board,left,right)         	 =     trim(right.profession_or_board,left,right)and
														trim(left.license_type,left,right)         					 =     trim(right.license_type,left,right)and
														trim(left.status,left,right)        								 =     trim(right.status,left,right)and
														trim(left.orig_license_number,left,right)         	 =     trim(right.orig_license_number,left,right)and
														trim(left.license_number,left,right)         				 =     trim(right.license_number,left,right)and
														trim(left.previous_license_number,left,right)     	 =     trim(right.previous_license_number,left,right)and
														trim(left.company_name,left,right)         					 =     trim(right.company_name,left,right)and
														trim(left.orig_name,left,right)         						 =     trim(right.orig_name,left,right)and
														trim(left.name_order,left,right)        				  	 =     trim(right.name_order,left,right)and
														trim(left.orig_former_name,left,right)         			 =     trim(right.orig_former_name ,left,right)and
														trim(left.former_name_order,left,right)         		 =     trim(right.former_name_order ,left,right)and
													  trim(left.orig_addr_1,left,right)             			 =     trim(right.orig_addr_1,left,right)and 
														trim(left.orig_addr_2,left,right)            				 =     trim(right.orig_addr_2,left,right)and 
														trim(left.orig_addr_3,left,right)             			 =     trim(right.orig_addr_3,left,right) and
														trim(left.orig_addr_4,left,right)             			 =     trim(right.orig_addr_4,left,right) and
														trim(left.orig_city,left,right)        					  	 =     trim(right.orig_city,left,right)and
														trim(left.orig_st,left,right)         							 =     trim(right.orig_st,left,right)and
														trim(left.orig_zip,left,right)         							 =     trim(right.orig_zip,left,right)and
														trim(left.county_str,left,right)         						 =     trim(right.county_str,left,right)and
														trim(left.country_str,left,right)         					 =     trim(right.country_str,left,right)and
														trim(left.business_flag,left,right)        					 =     trim(right.business_flag,left,right)and
														trim(left.phone,left,right)         								 =     trim(right.phone,left,right)and
														trim(left.sex,left,right)         									 =     trim(right.sex,left,right)and
														trim(left.dob,left,right)         									 =     trim(right.dob,left,right)and
														trim(left.issue_date,left,right)        						 =     trim(right.issue_date,left,right)and
														trim(left.expiration_date,left,right)         			 =     trim(right.expiration_date,left,right)and
														trim(left.last_renewal_date,left,right)         		 =     trim(right.last_renewal_date,left,right)and
														trim(left.license_obtained_by,left,right)         	 =     trim(right.license_obtained_by,left,right)and
														trim(left.source_st,left,right)         						 =     trim(right.source_st,left,right)and
														trim(left.vendor,left,right)         								 =     trim(right.vendor,left,right)and
														trim(left.board_action_indicator,left,right)         =     trim(right.board_action_indicator,left,right)and 
														trim(left.action_record_type,left,right)         		 =     trim(right.action_record_type,left,right)and
														trim(left.action_complaint_violation_cds,left,right) =     trim(right.action_complaint_violation_cds,left,right)and 
														trim(left.action_complaint_violation_desc,left,right)=     trim(right.action_complaint_violation_desc,left,right)and
														trim(left.additional_orig_name,left,right)           =     trim(right.additional_orig_name,left,right)and
														trim(left.additional_phone,left,right)         		   =     trim(right.additional_phone,left,right)and
														trim(left.additional_licensing_specifics,left,right) =     trim(right.additional_licensing_specifics,left,right)and													trim(left.action_complaint_violation_dt,left,right)  =     trim(right.action_complaint_violation_dt,left,right)and
														trim(left.misc_practice_type,left,right)        		 =     trim(right.misc_practice_type,left,right)and
														trim(left.misc_email,left,right)         						 =     trim(right.misc_email,left,right)and
														trim(left.misc_fax,left,right)         							 =     trim(right.misc_fax,left,right)and
														trim(left.misc_other_id,left,right)        					 =     trim(right.misc_other_id,left,right)and
														trim(left.misc_other_id_type,left,right)         		 =     trim(right.misc_other_id_type,left,right)and
														trim(left.action_case_number,left,right)         		 =     trim(right.action_case_number ,left,right)and
													  trim(left.action_effective_dt,left,right)         	 =     trim(right.action_effective_dt ,left,right)and
													  trim(left.action_cds,left,right)         						 =     trim(right.action_cds ,left,right)and
													  trim(left.action_desc,left,right)         					 =     trim(right.action_desc ,left,right)and
													  trim(left.action_final_order_no,left,right)          =     trim(right.action_final_order_no ,left,right)and
													  trim(left.action_status,left,right)         				 =     trim(right.action_status ,left,right)and
													  trim(left.action_posting_status_dt,left,right)       =     trim(right.action_posting_status_dt ,left,right)and
													  trim(left.action_original_filename_or_url,left,right)=     trim(right.action_original_filename_or_url ,left,right)and
												    trim(left.additional_name_addr_type,left,right)      =     trim(right.additional_name_addr_type ,left,right)and
													  trim(left.additional_name_order,left,right)          =     trim(right.additional_name_order ,left,right)and
														trim(left.additional_orig_additional_1,left,right)   =     trim(right.additional_orig_additional_1 ,left,right)and
														trim(left.additional_orig_additional_2,left,right)   =     trim(right.additional_orig_additional_2 ,left,right)and
														trim(left.additional_orig_additional_3,left,right)   =     trim(right.additional_orig_additional_3 ,left,right)and
														trim(left.additional_orig_additional_4,left,right)   =     trim(right.additional_orig_additional_4 ,left,right)and
														trim(left.additional_orig_city,left,right)         	 =     trim(right.additional_orig_city ,left,right)and
														trim(left.additional_orig_st,left,right)         		 =     trim(right.additional_orig_st ,left,right)and
														trim(left.additional_orig_zip,left,right)         	 =     trim(right.additional_orig_zip ,left,right)and
														trim(left.misc_occupation,left,right)         			 =     trim(right.misc_occupation ,left,right)and
														trim(left.misc_practice_hours,left,right)         	 =     trim(right.misc_practice_hours ,left,right)and
														trim(left.misc_web_site,left,right)         				 =     trim(right.misc_web_site ,left,right)and
														trim(left.education_1_school_attended,left,right)    =     trim(right.education_1_school_attended,left,right)and
														trim(left.education_1_dates_attended,left,right)     =     trim(right.education_1_dates_attended,left,right)and
														trim(left.education_continuing_education,left,right) =     trim(right.education_continuing_education,left,right)and
														trim(left.education_1_curriculum,left,right)         =     trim(right.education_1_curriculum,left,right)and
														trim(left.education_1_degree,left,right)             =     trim(right.education_1_degree,left,right)and
														trim(left.education_2_school_attended,left,right)    =     trim(right.education_2_school_attended ,left,right)and
														trim(left.education_2_dates_attended,left,right)     =     trim(right.education_2_dates_attended ,left,right)and
														trim(left.education_2_curriculum,left,right)         =     trim(right.education_2_curriculum ,left,right)and
														trim(left.education_2_degree,left,right)         		 =     trim(right.education_2_degree ,left,right)and
														trim(left.education_3_school_attended,left,right)    =     trim(right.education_3_school_attended ,left,right)and
														trim(left.education_3_dates_attended,left,right)     =     trim(right.education_3_dates_attended ,left,right)and
														trim(left.education_3_curriculum,left,right)         =     trim(right.education_3_curriculum ,left,right)and
														trim(left.education_3_degree,left,right)         		 =     trim(right.education_3_degree ,left,right)and
														trim(left.personal_pob_cd,left,right)         			 =     trim(right.personal_pob_cd ,left,right)and
														trim(left.personal_pob_desc,left,right)         		 =     trim(right.personal_pob_desc ,left,right)and
														trim(left.personal_race_cd,left,right)         			 =     trim(right.personal_race_cd ,left,right)and
														trim(left.personal_race_desc,left,right)         		 =     trim(right.personal_race_desc ,left,right)and
														trim(left.status_status_cds,left,right)         		 =     trim(right.status_status_cds ,left,right)and
														trim(left.status_effective_dt,left,right)         	 =     trim(right.status_effective_dt ,left,right)and
														trim(left.status_renewal_desc,left,right)         	 =     trim(right.status_renewal_desc ,left,right)and
														trim(left.status_other_agency,left,right)         	 =     trim(right.status_other_agency ,left,right)and
														left.rawaid         														 		 =     right.rawaid  and                         
   													trim(left.prim_range,left,right)         	 					 =     trim(right.prim_range ,left,right)and
														trim(left.prim_name,left,right)         	 					 =     trim(right.prim_name ,left,right)and
														trim(left.p_city_name,left,right)         	 				 =     trim(right.p_city_name ,left,right)and
														trim(left.v_city_name,left,right)         	 				 =     trim(right.v_city_name ,left,right)and
														trim(left.st,left,right)         	 									 =     trim(right.st ,left,right)and
														trim(left.zip,left,right)         	 					 			 =     trim(right.Zip ,left,right)and
														trim(left.zip4,left,right)         	 					 			 =     trim(right.zip4 ,left,right),
   													get_recID(left,right),left outer,local); 
		
			Srt_prolic_Base 					:= sort(distribute(Append_recID ,hash64(source_st,vendor,profession_or_board,license_number,company_name,orig_name)),RECORD,EXCEPT date_first_seen,date_last_seen,source_rec_id,local);
			
			rec  rollupXform(rec  l, rec r) := transform
        self.date_first_seen		:= (string)ut.EarliestDate((integer)l.date_first_seen,(integer)r.date_first_seen);
        self.date_last_seen			:= (string)(MAX((integer)l.date_last_seen,(integer)r.date_last_seen));
        self.source_rec_id      := if(l.source_rec_id<>0 ,l.source_rec_id,r.source_rec_id);
        self                		:= l;
			end;
  
			prolic_Rollup_Base 	:= rollup(Srt_prolic_Base, rollupXform(LEFT,RIGHT), RECORD, EXCEPT date_first_seen,date_last_seen,source_rec_id,local);

			//****** Add the BDID
			business_header.MAC_Source_Match(
																			 prolic_Rollup_Base 			   													// infile
																			,dPostSourceMatch															       // outfile
																			,false																				      // bool_bdid_field_is_string12
																			,BDID																	       			 // bdid_field
																			,false																		        // bool_infile_has_source_field
																			,MDR.sourceTools.src_Professional_License        // source_type_or_field
																			,false																	        // bool_infile_has_source_group
																			,foo													           			 // source_group_field
																			,company_name											            // company_name_field
																			,prim_range											             // prim_range_field
																			,prim_name										              // prim_name_field
																			,sec_range									  						 // sec_range_field
																			,zip										   								// zip_field
																			,true										                 // bool_infile_has_phone
																			,phone		                  						// phone_field
																			,false							                   // bool_infile_has_fein
																			,foo    				                    	// fein_field
																		);
			
			myset := ['A','P'];
			
			dPostSourceMatch_source := table(dPostSourceMatch, {dPostSourceMatch;string2 source := MDR.sourceTools.src_Professional_License});   
	
			Business_Header_SS.MAC_Add_BDID_Flex(
																					 dPostSourceMatch_source									 // Input Dataset						
																					,myset                                    // BDID Matchset           
																					,company_name        		             		 // company_name	              
																					,prim_range		                          // prim_range		              
																					,prim_name		                         // prim_name		              
																					,zip 					                        // zip5					              
																					,sec_range		                       // sec_range		              
																					,st				                          // state				              
																					,phone				           					 // phone				              
																					,foo                              // fein              
																					,bdid											       // bdid												
																					,recordof(dPostSourceMatch_source)// Output Layout 
																					,false                         // output layout has bdid score field?                       
																					,foo                          // bdid_score                 
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
																					,                 //	ssn
																					,source          //sourceField
																					,source_rec_id  //persistent_rec_id
																					,true          //Call sourceMatch macro before Flex 
																				 )
		         
			//****** Transfer from the temp field to the outgoing DID field
			Prof_License.layout_prolic_out_with_AID tra(postbdid l) := transform
        self.did 			:= if (l.did = 0, '', intformat(l.DID, 12, 1));
        self.score    := intformat(l.temp_DID_score, 3, 1);
        self.bdid 	  := if (L.bdid = 0, '', intformat(L.bdid,12,1));
        self.best_ssn := l.ssn;
        self 					:= l;
			end;

			pre_outfile := project(postbdid, tra(left));

			census_data.MAC_Fips2County(pre_outfile,st,county,county_name,outfile); 
			
			//******Appending Source_rec_ID for  new update records 
			ut.MAC_Append_Rcid (outfile,source_rec_id,ds_Append_recID);

			//******Correcting Vendor field to reflect source name found in ORBIT
			VendorMod := Prof_License.fn_VendorCleanup(ds_Append_recID);

            VendorModProvider := VendorMod(company_name = '');
            
            Health_Provider_Services.mac_get_best_lnpid_on_thor(                                                                                             
                VendorModProvider          //infile                                            
                ,lnpid                     //IDL                                               
                ,fname                     //Input_FNAME                                       
                ,mname                     //Input_MNAME                                       
                ,lname                     //Input_LNAME                                       
                ,name_suffix               //Input_SNAME                                       
                ,sex                       //Input_GENDER                                      
                ,prim_range                //Input_PRIM_RANGE                                  
                ,prim_name                 //Input_PRIM_NAME                                   
                ,sec_range                 //Input_SEC_RANGE                                   
                ,v_city_name               //Input_V_CITY_Name                                 
                ,st                        //Input_ST                                          
                ,zip                       //Input_ZIP                                         
                ,                          //Input_SSN                                         
                ,dob                       //Input_DOB                                         
                ,phone                     //Input_PHONE                                       
                ,                          //Input_LIC_STATE                                   
                ,license_number            //Input_LIC_NBR                                     
                ,                          //Input_TAX_ID                                      
                ,                          //Input_DEA_NUMBER                                  
                ,prolic_key                //Input_VENDOR_ID                                   
                ,                          //Input_NPI_NUMBER                                  
                ,                          //Input_UPIN                                        
                ,did                       //Input_DID                                         
                ,bdid                      //Input_BDID                                        
                ,                          //Input_SRC                                         
                ,                          //Input_SOURCE_RID                                  
                ,appendlnpidProvider       //Output File                                           
                ,false                     //forcePull = false                                 
                ,38                        //score = 38                                        
                );                                                                             

            VendorModFacility := VendorMod(company_name <> '');
            
            Health_Facility_Services.mac_get_best_lnpid_on_thor(                               
                VendorModFacility          //infile                                            
                ,lnpid                     //IDL                                               
                ,company_name              //Input_CNAME                                       
                ,prim_range                //Input_PRIM_RANGE                                  
                ,prim_name                 //Input_PRIM_NAME                                   
                ,sec_range                 //Input_SEC_RANGE                                   
                ,v_city_name               //Input_V_CITY_Name                                 
                ,st                        //Input_ST                                          
                ,zip                       //Input_ZIP                                         
                ,                          //Input_TAX_ID                                      
                ,                          //Input_FEIN                                        
                ,phone                     //Input_PHONE                                       
                ,                          //Input_FAX                                         
                ,                          //Input_LIC_STATE                                   
                ,license_number            //Input_C_LIC_NBR                                   
                ,                          //Input_DEA_NUMBER                                  
                ,                          //Input_VENDOR_ID                                   
                ,                          //Input_NPI_NUMBER                                  
                ,                          //Input_CLIA_NUMBER                                 
                ,                          //Input_MEDICARE_FACILITY_NUMBER                    
                ,                          //Input_MEDICAID_NUMBER                             
                ,                          //Input_NCPDP_NUMBER                                
                ,                          //Input_Taxonomy                                    
                ,bdid                      //Input_BDID                                        
                ,                          //Input_SRC                                         
                ,                          //Input_SOURCE_RID                                  
                ,appendlnpidFacility       //Output File                                       
                ,false                     //forcePull = false                                 
                ,30                        //score = 38                                        
                );                                                                             

			appendLnpid := appendlnpidProvider + appendlnpidFacility;
			prepFPOS := dedup(appendLnpid,whole record, all); // : persist('~thor_data400::persist::prof_licenses');
			
			// INFUTOR data is no longer allowed/wanted.
      prepFPOS_cleaned := prepFPOS(vendor != 'INFUTOR');

      // The new sources should not extend the date first seen and date last seen fields.  Danny's
			//   function will take care of this for the new sources only.  Original PL data will not go
			//   through this functionality.
			new_sources := ['ALC', 'INFOGRO', 'ENC_PL_', 'HMS_PL_'];

      prepFPOS_new_sources := prepFPOS_cleaned(TRIM(vendor[1..7]) IN new_sources);
      prepFPOS_new_sources_fixed := Header.fn_set_dates_to_header_dates(prepFPOS_new_sources);
      prepFPOS_orig_PL := prepFPOS_cleaned(TRIM(vendor[1..7]) NOT IN new_sources);

      preFPOS_fixed0 := prepFPOS_orig_PL + prepFPOS_new_sources_fixed;

			preFPOS_fixed := Prof_License.fRemoveBadSource(preFPOS_fixed0);
			PromoteSupers.MAC_SF_BuildProcess(preFPOS_fixed,'~thor_data400::base::prof_licenses_AID',do_out,,,true);

/* ************************************************************************************************************ */

export proc_build_base := sequential(do_out);