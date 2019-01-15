import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,HMS_STLIC,Scrubs_HMS_STLIC,Scrubs;


EXPORT Update_Base (string filedate, boolean pUseProd = false) := MODULE

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				//SELF.ln_record_type	:= 'H';
				SELF								:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;
	
	EXPORT Clean_addr (pBaseFile, pLayout_base)	:= FUNCTIONMACRO

		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
		AID.MacAppendFromRaw_2Line(pBaseFile,Prepped_addr1,Prepped_addr2,RawAID,cleanAddr, lFlags);

		pLayout_base addr(cleanAddr L)	:= TRANSFORM
			SELF.RawAID     := L.aidwork_rawaid;
			SELF.ACEAID			:= L.aidwork_acecache.aid;
			SELF.prim_range := stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.v_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.p_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.zip        := L.aidwork_acecache.zip5;
			SELF.fips_st    := L.aidwork_acecache.county[1..2];
			SELF.county:= L.aidwork_acecache.county[3..5];
			SELF.msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;
		RETURN PROJECT(cleanAddr, addr(LEFT));
	ENDMACRO;
	
	EXPORT Clean_name (pBaseFile, pLayout_base, useFull = false) := FUNCTIONMACRO
		
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														,name
														,includeInRepository:=FALSE, normalizeDualNames:=TRUE);
																					
		pLayout_base tr(cleanNames L) := TRANSFORM
			SELF.title 				:= IF(l.nameType='P' and L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.fname 				:= if(l.nameType='P',L.cln_fname,'');
			SELF.mname 				:= if(l.nameType='P',L.cln_mname,'');
			SELF.lname 				:= if(l.nameType='P',L.cln_lname,'');
			SELF.name_suffix 	:= if(l.nameType='P',ut.fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		RETURN PROJECT(cleanNames,tr(LEFT));
	ENDMACRO;
	
	EXPORT StateLicense_Base := FUNCTION
   				
			hist_base	:= Mark_history(HMS_STLIC.Files(filedate,pUseProd).statelicense_Base.built, HMS_STLIC.Layouts.statelicense_base);
			
			std_input := HMS_STLIC.StandardizeInputFile(filedate, pUseProd).StLicense;
			
			cleanNames := Clean_name(std_input,HMS_STLIC.Layouts.statelicense_base,1)
									:PERSIST('~thor400_data::persist::hms_stl::stlic_names');
			
			UniqueAddresses:=dedup(
									cleanNames(
										Prepped_addr1<>''
										,Prepped_addr2<>''
									),Prepped_addr1,Prepped_addr2,all);

			HMS_STLIC.Layouts.statelicense_base tr4(UniqueAddresses l) := transform
				Clean_Address 										:= address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
				STRING28  v_prim_name 		:= Clean_Address[13..40];
				STRING5   v_zip       		:= Clean_Address[117..121];
				STRING4   v_zip4      		:= Clean_Address[122..125];
				SELF.prim_range  							:= Clean_Address[ 1..  10];
				SELF.predir      							:= Clean_Address[ 11.. 12];
				SELF.prim_name   							:= v_prim_name;
				SELF.addr_suffix 							:= Clean_Address[ 41.. 44];
				SELF.postdir     							:= Clean_Address[ 45.. 46];
				SELF.unit_desig  							:= Clean_Address[ 47.. 56];
				SELF.sec_range   							:= Clean_Address[ 57.. 64];
				SELF.p_city_name 							:= Clean_Address[ 65.. 89];
				SELF.v_city_name 							:= Clean_Address[ 90..114];
				SELF.st          							:= Clean_Address[115..116];
				SELF.zip         							:= if(v_zip='00000','',v_zip);
				SELF.zip4       	 						:= if(v_zip4='0000','',v_zip4);
				SELF.cart        							:= Clean_Address[126..129];
				SELF.cr_sort_sz  							:= Clean_Address[130..130];
				SELF.lot         							:= Clean_Address[131..134];
				SELF.lot_order   							:= Clean_Address[135..135];
				SELF.dbpc        							:= Clean_Address[136..137];
				SELF.chk_digit   							:= Clean_Address[138..138];
				SELF.rec_type    							:= Clean_Address[139..140];
				SELF.fips_st												:= Clean_Address[141..142];
				SELF.county      							:= Clean_Address[143..145];
				SELF.geo_lat     							:= Clean_Address[146..155];
				SELF.geo_long    							:= Clean_Address[156..166];
				SELF.msa         							:= Clean_Address[167..170];
				SELF.geo_blk     							:= Clean_Address[171..177];
				SELF.geo_match   							:= Clean_Address[178..178];
				SELF.err_stat    							:= Clean_Address[179..182];
				SELF 																			:= L;
			END;

			AddressClean := project(UniqueAddresses,tr4(left))
										:PERSIST('~thor400_data::persist::hms_stl::stlic_uniq_addr');
			
			cleanAddr:=join(distribute(cleanNames,     hash(Prepped_addr1,Prepped_addr2))
								,distribute(AddressClean, hash(Prepped_addr1,Prepped_addr2))
								,left.Prepped_addr1=right.Prepped_addr1
								and left.Prepped_addr2=right.Prepped_addr2
								,transform(HMS_STLIC.Layouts.statelicense_base
									,self.prim_range   :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_range,'')
									,self.predir       :=if(left.Prepped_addr1=right.Prepped_addr1,right.predir,'')
									,self.prim_name    :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_name,'')
									,self.addr_suffix  :=if(left.Prepped_addr1=right.Prepped_addr1,right.addr_suffix,'')
									,self.postdir      :=if(left.Prepped_addr1=right.Prepped_addr1,right.postdir,'')
									,self.unit_desig   :=if(left.Prepped_addr1=right.Prepped_addr1,right.unit_desig,'')
									,self.sec_range    :=if(left.Prepped_addr1=right.Prepped_addr1,right.sec_range,'')
									,self.p_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.p_city_name,'')
									,self.v_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.v_city_name,'')
									,self.st           :=if(left.Prepped_addr1=right.Prepped_addr1,right.st,'')
									,self.zip          :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip,'')
									,self.zip4         :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip4,'')
									,self.cart         :=if(left.Prepped_addr1=right.Prepped_addr1,right.cart,'')
									,self.cr_sort_sz   :=if(left.Prepped_addr1=right.Prepped_addr1,right.cr_sort_sz,'')
									,self.lot          :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot,'')
									,self.lot_order    :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot_order,'')
									,self.dbpc         :=if(left.Prepped_addr1=right.Prepped_addr1,right.dbpc,'')
									,self.chk_digit    :=if(left.Prepped_addr1=right.Prepped_addr1,right.chk_digit,'')
									,self.rec_type     :=if(left.Prepped_addr1=right.Prepped_addr1,right.rec_type,'')
									,self.fips_st			 		:=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_st,'')
									,self.county       :=if(left.Prepped_addr1=right.Prepped_addr1,right.county,'')
									,self.geo_lat      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_lat,'')
									,self.geo_long     :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_long,'')
									,self.msa          :=if(left.Prepped_addr1=right.Prepped_addr1,right.msa,'')
									,self.geo_blk      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_blk,'')
									,self.geo_match    :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_match,'')
									,self.err_stat     :=if(left.Prepped_addr1=right.Prepped_addr1,right.err_stat,'')
									,self:=left)
								,left outer
								,local);
			
			base_and_update := IF(nothor(FileServices.SuperFileExists(HMS_STLIC.Filenames(filedate, pUseProd).statelicense_lBaseTemplate_built))
   												 ,cleanAddr  + hist_base
   												 ,cleanAddr
													 );
													 
	 		base_f := DISTRIBUTE(base_and_update, HASH(ln_key,entityid,id,hms_src)); 
			
			HMS_STLIC.Layouts.statelicense_base  GetSourceRID(base_f L)	:= TRANSFORM
   			SELF.source_rid 							:= HASH64(hashmd5(
																					trim(L.license_number)+','
																				 +trim(L.license_state)+','
																				 +trim(L.license_class_type)+','
																				 +trim(L.status)+','
																				 +trim(L.qualifier1)+','
																				 +trim(L.qualifier2)+','
																				 +trim(L.qualifier3)+','
																				 +trim(L.qualifier4)+','
																				 +trim(L.qualifier5)+','
																				 +trim(L.issue_date)+','
																				 +trim(L.expiration_date)+','
																				 +trim(L.name)+','
																				 +trim(L.first)+','
																				 +trim(L.middle)+','
																				 +trim(L.last)+','
																				 +trim(L.suffix)+','
																				 +trim(L.cred)+','
																				 +L.age+','
																				 +trim(L.dateofbirth)+','
																				 +trim(L.email)+','
																				 +trim(L.gender)+','
																				 +trim(L.dateofdeath)+','
																				 +trim(L.street1)+','
																				 +trim(L.street2)+','
																				 +trim(L.street3)+','
																				 +trim(L.city)+','
																				 +trim(L.address_state)+','
																				 +trim(L.address_type)+','
																				 +trim(L.orig_zip)+','
																				 +trim(L.orig_county)+','
																				 +trim(L.country)+','
																				 +trim(L.phone_number)+','
																				 +trim(L.phone_type)+','
																				 +trim(L.phone1)+','
																				 +trim(L.phone2)+','
																				 +trim(L.phone3)+','
																				 +trim(L.fax1)+','
																				 +trim(L.fax2)+','
																				 +trim(L.fax3)+','
																				 +trim(L.other_phone1)+','
																				 +trim(L.csr_number)+','
																				 +trim(L.npi_number)+','
																				 +trim(L.dea_number)+','
																				 +trim(L.school)+','
																				 +trim(L.language)+','
																				 +trim(L.graduated)+','
																				 +trim(L.board)+','
																				 +trim(L.offense)+','
																				 +trim(L.offense_date)+','
																				 +trim(L.action)+',' 
																				 +trim(L.action_date)+','
																				 +trim(L.action_start)+','
																				 +trim(L.action_end)+','
																				 +trim(L.location)+','
																				 +trim(L.specialty_class_type)+','
																				 +trim(L.description)
																				 ));
   			SELF	:= L;
   		END;
			
   		d_rid := project(base_f,GetSourceRID(left));		
			
   		new_base_s := SORT(d_rid
   									,ln_key
												,hms_src
												,key
												,id
												,entityid
												,license_number
												,license_state
												,license_class_type
												,status
												,issue_date
												,expiration_date
												,name
												,last
												,middle
												,first
												,suffix
												,street1
												,street2
												,street3
												,city
												,address_state
												,orig_zip
												,orig_county
												,country
												,phone_number
												,phone_type
												,phone1
												,phone2
												,phone3
												,fax1
												,fax2
												,fax3
												,other_phone1
												,cred
												,age
												,dateofbirth
												,email
												,gender
												,dateofdeath
												,csr_number
												,npi_number
												,dea_number
												,specialty_class_type
												,school
												,graduated
												,board
												,offense
												,offense_date
												,action
												,action_date
												,action_start
												,action_end
												,location
												,language
												,description
											,LOCAL);
   		
   		HMS_STLIC.layouts.statelicense_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
   			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
   			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
						self.source_rid           				:=	if(L.dt_vendor_first_reported<R.dt_vendor_first_reported,L.source_rid,R.source_rid);
						SELF 		 																						:= IF(L.dt_vendor_last_reported>R.dt_vendor_last_reported,L,R);
					END;
   
   		stlic_base := ROLLUP(new_base_s
												,		 trim(left.ln_key)														= trim(right.ln_key)
												AND trim(left.hms_src)													= trim(right.hms_src)
												AND trim(left.key)																	= trim(right.key)
												AND trim(left.id)																		= trim(right.id)
												AND trim(left.entityid)												= trim(right.entityid)
												AND trim(left.license_number)						= trim(right.license_number)
												and trim(left.license_state)							= trim(right.license_state)
												and trim(left.license_class_type)		= trim(right.license_class_type)
												and trim(left.status)														= trim(right.status)
												and trim(left.issue_date)										= trim(right.issue_date)
												and trim(left.expiration_date)					= trim(right.expiration_date)
												AND trim(left.name)																= trim(right.name)
												AND trim(left.last)																= trim(right.last)
												AND trim(left.middle)														= trim(right.middle)
												AND trim(left.first)															= trim(right.first)
												AND trim(left.suffix)														= trim(right.suffix)
												and trim(left.street1)													= trim(right.street1)
												and trim(left.street2)													= trim(right.street2)
												and trim(left.street3)													= trim(right.street3)
												and trim(left.city)																= trim(right.city)
												and trim(left.address_state)							= trim(right.address_state)
												and trim(left.orig_zip)												= trim(right.orig_zip)
												and trim(left.orig_county)									= trim(right.orig_county)
												AND trim(left.country)													= trim(right.country)
												and trim(left.phone_number)								= trim(right.phone_number)
												AND trim(left.phone_type)										= trim(right.phone_type)
												AND trim(left.phone1)														= trim(right.phone1)
												AND trim(left.phone2)														= trim(right.phone2)
												AND trim(left.phone3)														= trim(right.phone3)
												AND trim(left.fax1)																= trim(right.fax1)
												AND trim(left.fax2)																= trim(right.fax2)
												AND trim(left.fax3)																= trim(right.fax3)
												AND trim(left.other_phone1)								= trim(right.other_phone1)
												AND trim(left.cred)																= trim(right.cred)
												AND left.age																							= right.age
												AND trim(left.dateofbirth)									= trim(right.dateofbirth)
												AND trim(left.email)															= trim(right.email)
												AND trim(left.gender)														= trim(right.gender)
												AND trim(left.dateofdeath)									= trim(right.dateofdeath)
												AND trim(left.csr_number)										= trim(right.csr_number)
												AND trim(left.npi_number)										= trim(right.npi_number)
												AND trim(left.dea_number)										= trim(right.dea_number)
												AND trim(left.specialty_class_type)= trim(right.specialty_class_type)
												AND trim(left.school)														= trim(right.school)
												AND trim(left.graduated)											= trim(right.graduated)
												AND trim(left.board)															= trim(right.board)
												AND trim(left.offense)													= trim(right.offense)
												AND trim(left.offense_date)								= trim(right.offense_date)
												AND trim(left.action)														= trim(right.action)
												AND trim(left.action_date)									= trim(right.action_date)
												AND trim(left.action_start)								= trim(right.action_start)
												AND trim(left.action_end)										= trim(right.action_end)
												AND trim(left.location)												= trim(right.location)
												AND trim(left.language)												= trim(right.language)
												AND trim(left.description)									= trim(right.description)
											,t_rollup(LEFT,RIGHT),LOCAL);	
																				
				matchset := ['A','Z','P'];
				did_add.MAC_Match_Flex(
							stlic_base, matchset,					
							'','',first, middle, last, suffix, 
							street1, street2, street3, zip, address_state,phone_number, 
							did, {stlic_base}, true, did_score,
							75, d_did);

				did_desc1 := project (d_did,transform (recordof(d_did), 
                       self.xadl2_keys_desc := InsuranceHeader_xLink.Process_xIDL_Layouts(false).KeysUsedToText (left.xadl2_keys_used); 
                       self.xadl2_matches_desc := InsuranceHeader_xLink.fn_MatchesToText(left.xadl2_matches);
                       self := left;));

				did_add.MAC_Add_SSN_By_DID(did_desc1,did,best_ssn,d_ssn,false);
				did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0,false);
					
				d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dateofbirth<>''
																			and left.best_dob>0
																			and left.clean_dateofbirth[1..4]<>left.best_dob[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));

				bdid_matchset := ['A'];
				Business_Header_SS.MAC_Add_BDID_Flex
				(
				d_dob 
				,bdid_matchset
				,firmname
				,prim_range
				,prim_name
				,zip 
				,sec_range
				,license_state
				,phone_number
				,foo
				,bdid
				,HMS_STLIC.Layouts.statelicense_base
				,TRUE
				,bdid_score
				,d_bdid
				,
				,
				,
				,BIPV2.xlink_version_set
				,
				,email
				,p_city_name
				,fname
				,mname
				,lname
				,best_ssn
				,src
				,source_rid
				,
				,
				);
				
				Health_Provider_Services.mac_get_best_lnpid_on_thor (
									 d_bdid
									,lnpid
									,fname
									,mname
									,lname
									,name_suffix
									,gender
									,prim_range
									,prim_name
									,sec_range
									,v_city_name
									,st
									,zip 
									,best_ssn
									,best_dob
									,clean_phone
									,license_state
									,license_number
									,//tin1
									,dea_Number
									,//group_key
									,npi_number
									,//UPIN
									,DID
									,BDID
									,SRC
									,SOURCE_RID
									,dLnpidOut,false,38 //38 for providers
				);
				
				with_lnpid:=dLnpidOut(lnpid>0);
				no_lnpid:=dLnpidOut(lnpid=0);
				
				Health_Facility_Services.mac_get_best_lnpid_on_thor (
										no_lnpid
										,lnpid
										,clean_company_name											
										,prim_range
										,prim_name
										,sec_range
										,v_city_name
										,st
										,zip
										,//sanc_tin
										,//tin1
										,phone1
										,fax1
										,license_state
										,license_number
										,dea_number
										,//group_key
										,npi_number
										,//clia_num
										,//medicare_fac_num
										,//Input_MEDICAID_NUMBER
										,//ncpdp_id
										,taxonomy_code
										,BDID
										,SRC
										,SOURCE_RID
										,result
										,false
										,30 //30 for facilities
										);
					 
				
			
				final_base := with_lnpid + result;
				
				// ********************************Set clean dates and phones to blank where all 0's and all 8's***************************
			
				HMS_STLIC.Layouts.statelicense_base DatePhoneMapping(HMS_STLIC.Layouts.statelicense_base L) := TRANSFORM					
						SELF.clean_phone										:= if(REGEXREPLACE('9',L.clean_phone,'') = '','',L.clean_phone);
         		SELF.clean_phone1										:= if(REGEXREPLACE('9',L.clean_phone1,'') = '','',L.clean_phone1);
         		SELF.clean_phone2										:= if(REGEXREPLACE('9',L.clean_phone2,'') = '','',L.clean_phone2);
         		SELF.clean_phone3										:= if(REGEXREPLACE('9',L.clean_phone3,'') = '','',L.clean_phone3);
         		SELF.clean_fax1   									:= if(REGEXREPLACE('9',L.clean_fax1,'') = '','',L.clean_fax1);
         		SELF.clean_fax2   									:= if(REGEXREPLACE('9',L.clean_fax2,'') = '','',L.clean_fax2);
         		SELF.clean_fax3   									:= if(REGEXREPLACE('9',L.clean_fax3,'') = '','',L.clean_fax3);
         		SELF.clean_other_phone1							:= if(REGEXREPLACE('9',L.clean_other_phone1,'') = '','',L.clean_other_phone1);
						SELF.clean_issue_date								:= if(REGEXREPLACE('0',trim(L.clean_issue_date,all),'') = '','',L.clean_issue_date); 
         		SELF.clean_expiration_date					:= if(REGEXREPLACE('0',trim(L.clean_expiration_date,all),'') = '','',L.clean_expiration_date);
         		SELF.clean_offense_date							:= if(REGEXREPLACE('0',trim(L.clean_offense_date,all),'') = '','',L.clean_offense_date);
         		SELF.clean_action_date							:= if(REGEXREPLACE('0',trim(L.clean_action_date,all),'') = '','',L.clean_action_date);
         		SELF.clean_dateofbirth							:= if(REGEXREPLACE('0',trim(L.clean_dateofbirth,all),'') = '','',L.clean_dateofbirth);
         		SELF.clean_dateofdeath							:= if(REGEXREPLACE('0',trim(L.clean_dateofdeath,all),'') = '','',L.clean_dateofdeath);
         		SELF 																:= L;
					END;
											
					stlic_base_result := PROJECT(final_base, DatePhoneMapping(LEFT));
				
				// ********************** Mark expiration dates for MO APNs ******************************************************************************
				
					selected_classes				:= ['APN','CNS','CNM','NPR','CNA'];
					mo_only									:= stlic_base_result(license_state = 'MO');
					mo_apns_only						:= mo_only(mapped_class in selected_classes);
					no_mo_only							:= stlic_base_result(license_state <> 'MO');
					mo_no_apns							:= mo_only(mapped_class not in selected_classes);
					base_no_mo_apns					:= no_mo_only + mo_no_apns;
								
					max_dvlr 		:= max(mo_apns_only, dt_vendor_last_reported);
				
					mo_apns_only add_exp (mo_apns_only L) := transform
							self.clean_expiration_date := if(((((unsigned4)L.clean_expiration_date = 0) or ((unsigned4)L.clean_expiration_date > L.dt_vendor_last_reported))
																									and L.dt_vendor_last_reported < max_dvlr), 
																								(string)L.dt_vendor_last_reported, (string)L.clean_expiration_date);
							self	:= L;
					end;
				
					mo_apns_w_exp	:= project(mo_apns_only, add_exp(left));
				
					base_w_mo_apns_exp := base_no_mo_apns + mo_apns_w_exp;
													
			RETURN base_w_mo_apns_exp;						

   END;
	 
	 EXPORT stlicrollup_Base := FUNCTION
   				
			base_a := distribute(Files().statelicense_Base.Built,hash(license_number,license_state,license_class_type));
					 	
			HMS_STLIC.Layouts.statelicense_base NullAddressesAndReset(HMS_STLIC.Layouts.statelicense_base L) := transform
							self.Email := NullBadAddrValue(L.Email);
							self.Street1 := NullBadAddrValue(L.Street1);
							self.Street2 := NullBadAddrValue(L.Street2);
							self.Street3 := NullBadAddrValue(L.Street3);
							self.City := NullBadAddrValue(L.City);
							self.Address_state := NullBadAddrValue(L.Address_state);
							self.Orig_zip := NullBadAddrValue(L.Orig_zip);
							self.Phone1 := NullBadAddrValue(L.Phone1);
							self.prepped_addr1 := NullBadAddrValue(L.prepped_addr1);
							self.prepped_addr2 := NullBadAddrValue(L.prepped_addr2);
							self.prim_name := NullBadAddrValue(L.prim_name);
							self.p_city_name := NullBadAddrValue(L.p_city_name);
							self.v_city_name := NullBadAddrValue(L.v_city_name);
							self.clean_zip5 := NullBadAddrValue(L.clean_zip5);
							self.clean_company_name := NullBadAddrValue(L.clean_company_name);
							self.Mapped_pdma := regexreplace('-',L.Mapped_pdma,'');
							self.clean_issue_date := fn_IsValidDate(L.clean_issue_date);//if(L.clean_issue_date in ['19010101','19000101','18000101','18010101'],'0',L.clean_issue_date);
							self.clean_expiration_date := fn_IsValidDate(L.clean_expiration_date);//if(L.clean_expiration_date in ['19010101','19000101','18000101','18010101'],'0',L.clean_expiration_date);
							self.clean_dateofbirth := fn_IsValidDate(if(L.clean_dateofbirth[5..]='0000',_Validate.Date.fCorrectedDateString(L.clean_dateofbirth,true),L.clean_dateofbirth));
							self.source_rid := 0;
							// self.lnpid := 0;
							self := L;
			
			end;
				
			base_t_sub := project(base_a,NullAddressesAndReset(LEFT));
			
			HMS_STLIC.Layouts.statelicense_base xcmpCleanDobExpDte(base_t_sub L) := TRANSFORM
					SELF.clean_dateofbirth := fn_chkdobDate(L.clean_issue_date,L.clean_expiration_date,L.clean_dateofbirth);
					SELF := L;
			END;

			base_t := project(base_t_sub,xcmpCleanDobExpDte(LEFT));
			
			HMS_STLIC.Layouts.statelicense_base  GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 							:= HASH64(hashmd5(
																					trim(L.license_number)+','
																				 +trim(L.license_state)+','
																				 +trim(L.license_class_type)+','
																				 +trim(L.status)+','
																				 +trim(L.qualifier1)+','
																				 +trim(L.qualifier2)+','
																				 +trim(L.qualifier3)+','
																				 +trim(L.qualifier4)+','
																				 +trim(L.qualifier5)+','
																				 +trim(L.issue_date)+','
																				 +trim(L.expiration_date)+','
																				 +trim(L.name)+','
																				 +trim(L.first)+','
																				 +trim(L.middle)+','
																				 +trim(L.last)+','
																				 +trim(L.suffix)+','
																				 +trim(L.cred)+','
																				 +L.age+','
																				 +trim(L.dateofbirth)+','
																				 +trim(L.email)+','
																				 +trim(L.gender)+','
																				 +trim(L.dateofdeath)+','
																				 +trim(L.street1)+','
																				 +trim(L.street2)+','
																				 +trim(L.street3)+','
																				 +trim(L.city)+','
																				 +trim(L.address_state)+','
																				 +trim(L.address_type)+','
																				 +trim(L.orig_zip)+','
																				 +trim(L.orig_county)+','
																				 +trim(L.country)+','
																				 +trim(L.phone_number)+','
																				 +trim(L.phone_type)+','
																				 +trim(L.phone1)+','
																				 +trim(L.phone2)+','
																				 +trim(L.phone3)+','
																				 +trim(L.fax1)+','
																				 +trim(L.fax2)+','
																				 +trim(L.fax3)+','
																				 +trim(L.other_phone1)+','
																				 +trim(L.csr_number)+','
																				 +trim(L.npi_number)+','
																				 +trim(L.dea_number)+','
																				 +trim(L.school)+','
																				 +trim(L.language)+','
																				 +trim(L.graduated)+','
																				 +trim(L.board)+','
																				 +trim(L.offense)+','
																				 +trim(L.offense_date)+','
																				 +trim(L.action)+',' 
																				 +trim(L.action_date)+','
																				 +trim(L.action_start)+','
																				 +trim(L.action_end)+','
																				 +trim(L.location)+','
																				 +trim(L.specialty_class_type)+','
																				 +trim(L.description)
																				 ));
   			SELF	:= L;
   		END;
			
   		base := project(base_t,GetSourceRID(left));
			
					new_base_s := SORT(base
   									,license_number
												,license_state
												,license_class_type
												,status
												,issue_date
												,expiration_date
												,name
												,last
												,middle
												,first
												,suffix
												,street1
												,street2
												,street3
												,city
												,address_state
												,orig_zip
												,orig_county
												,country
												,phone_number
												,phone_type
												,phone1
												,phone2
												,phone3
												,fax1
												,fax2
												,fax3
												,other_phone1
												,cred
												,age
												,dateofbirth
												,email
												,gender
												,dateofdeath
												,csr_number
												,npi_number
												,dea_number
												,specialty_class_type
												,school
												,graduated
												,board
												,offense
												,offense_date
												,action
												,action_date
												,action_start
												,action_end
												,location
												,language
												,description
												,clean_expiration_date
											,LOCAL
											);
   		
   		HMS_STLIC.layouts.statelicense_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
   			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
   			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
				SELF.source_rid           		:= if(L.dt_vendor_first_reported<R.dt_vendor_first_reported,L.source_rid,R.source_rid);
   			SELF 		 											:= IF(L.dt_vendor_last_reported>R.dt_vendor_last_reported,L,R);
			END;
   
   		stlic_base_s := ROLLUP(new_base_s
											,trim(left.license_number)=trim(right.license_number)
											and trim(left.license_state)=trim(right.license_state)
											and trim(left.license_class_type)=trim(right.license_class_type)
											and trim(left.status)=trim(right.status)
											and trim(left.issue_date)=trim(right.issue_date)
											and trim(left.expiration_date)=trim(right.expiration_date)
											AND trim(left.name)=trim(right.name)
											AND trim(left.last)=trim(right.last)
											AND trim(left.middle)=trim(right.middle)
											AND trim(left.first)=trim(right.first)
											AND trim(left.suffix)=trim(right.suffix)
											and trim(left.street1)=trim(right.street1)
											and trim(left.street2)=trim(right.street2)
											and trim(left.street3)=trim(right.street3)
											and trim(left.city)=trim(right.city)
											and trim(left.address_state)=trim(right.address_state)
											and trim(left.orig_zip)=trim(right.orig_zip)
											and trim(left.orig_county)=trim(right.orig_county)
											AND trim(left.country)=trim(right.country)
											and trim(left.phone_number)=trim(right.phone_number)
											AND trim(left.phone_type)=trim(right.phone_type)
											AND trim(left.phone1)=trim(right.phone1)
											AND trim(left.phone2)=trim(right.phone2)
											AND trim(left.phone3)=trim(right.phone3)
											AND trim(left.fax1)=trim(right.fax1)
											AND trim(left.fax2)=trim(right.fax2)
											AND trim(left.fax3)=trim(right.fax3)
											AND trim(left.other_phone1)=trim(right.other_phone1)
											AND trim(left.cred)=trim(right.cred)
											AND left.age=right.age
											AND trim(left.dateofbirth)=trim(right.dateofbirth)
											AND trim(left.email)=trim(right.email)
											AND trim(left.gender)=trim(right.gender)
											AND trim(left.dateofdeath)=trim(right.dateofdeath)
											AND trim(left.csr_number)=trim(right.csr_number)
											AND trim(left.npi_number)=trim(right.npi_number)
											AND trim(left.dea_number)=trim(right.dea_number)
											AND trim(left.specialty_class_type)=trim(right.specialty_class_type)
											AND trim(left.school)=trim(right.school)
											AND trim(left.graduated)=trim(right.graduated)
											AND trim(left.board)=trim(right.board)
											AND trim(left.offense)=trim(right.offense)
											AND trim(left.offense_date)=trim(right.offense_date)
											AND trim(left.action)=trim(right.action)
											AND trim(left.action_date)=trim(right.action_date)
											AND trim(left.action_start)=trim(right.action_start)
											AND trim(left.action_end)=trim(right.action_end)
											AND trim(left.location)=trim(right.location)
											AND trim(left.language)=trim(right.language)
											AND trim(left.description)=trim(right.description)
											AND trim(left.clean_expiration_date)=trim(right.clean_expiration_date)
											,t_rollup(LEFT,RIGHT)
											,LOCAL
											);	
																		
				RETURN stlic_base_s;//stlic_base;						

   END;

END;