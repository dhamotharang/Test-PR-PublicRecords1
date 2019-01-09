import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,HMS_CSR,Scrubs;


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
	
	EXPORT CsrCredential_Base := FUNCTION
   				
			hist_base	:= Mark_history(HMS_CSR.Files(filedate,pUseProd).csrcredential_Base.built, HMS_CSR.Layouts.csrcredential_base);
			
			std_input := HMS_CSR.StandardizeInputFile(filedate, pUseProd).CsrCredential;
					  		
			cleanNames := Clean_name(std_input,HMS_CSR.Layouts.csrcredential_base,1)
									:PERSIST('~thor400_data::persist::hms_csr::csrcred_names');
			
			UniqueAddresses:=dedup(
									cleanNames(
										Prepped_addr1<>''
										,Prepped_addr2<>''
									),Prepped_addr1,Prepped_addr2,all);

			HMS_CSR.Layouts.csrcredential_base tr4(UniqueAddresses l) := transform
				Clean_Address := address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
				STRING28  v_prim_name 		:= Clean_Address[13..40];
				STRING5   v_zip       		:= Clean_Address[117..121];
				STRING4   v_zip4      		:= Clean_Address[122..125];
				SELF.prim_range  			:= Clean_Address[ 1..  10];
				SELF.predir      			:= Clean_Address[ 11.. 12];
				SELF.prim_name   			:= v_prim_name;
				SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
				SELF.postdir     			:= Clean_Address[ 45.. 46];
				SELF.unit_desig  			:= Clean_Address[ 47.. 56];
				SELF.sec_range   			:= Clean_Address[ 57.. 64];
				SELF.p_city_name 			:= Clean_Address[ 65.. 89];
				SELF.v_city_name 			:= Clean_Address[ 90..114];
				SELF.st          			:= Clean_Address[115..116];
				SELF.zip         			:= if(v_zip='00000','',v_zip);
				SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
				SELF.cart        			:= Clean_Address[126..129];
				SELF.cr_sort_sz  			:= Clean_Address[130..130];
				SELF.lot         			:= Clean_Address[131..134];
				SELF.lot_order   			:= Clean_Address[135..135];
				SELF.dbpc        			:= Clean_Address[136..137];
				SELF.chk_digit   			:= Clean_Address[138..138];
				SELF.rec_type    			:= Clean_Address[139..140];
				SELF.fips_st					:= Clean_Address[141..142];
				SELF.county      			:= Clean_Address[143..145];
				SELF.geo_lat     			:= Clean_Address[146..155];
				SELF.geo_long    			:= Clean_Address[156..166];
				SELF.msa         			:= Clean_Address[167..170];
				SELF.geo_blk     			:= Clean_Address[171..177];
				SELF.geo_match   			:= Clean_Address[178..178];
				SELF.err_stat    			:= Clean_Address[179..182];
				SELF := L;
			END;

			AddressClean := project(UniqueAddresses,tr4(left))
										:PERSIST('~thor400_data::persist::hms_csr::csrcred_uniq_addr');
			
			cleanAddr:=join(distribute(cleanNames,     hash(Prepped_addr1,Prepped_addr2))
								,distribute(AddressClean, hash(Prepped_addr1,Prepped_addr2))
								,left.Prepped_addr1=right.Prepped_addr1
								and left.Prepped_addr2=right.Prepped_addr2
								,transform(HMS_CSR.Layouts.csrcredential_base
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
									,self.fips_st			 :=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_st,'')
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
			

						
			base_and_update := IF(nothor(FileServices.SuperFileExists(HMS_CSR.Filenames(filedate, pUseProd).csrcredential_lBaseTemplate_built))
   												 ,cleanAddr  + hist_base
   												 ,cleanAddr
													 );
													 
	 		base_f := DISTRIBUTE(base_and_update, HASH(ln_key,entityid,id,hms_src)); 
			
			HMS_CSR.Layouts.csrcredential_base  GetSourceRID(base_f L)	:= TRANSFORM
   			SELF.source_rid 							:= HASH64(hashmd5(
																			  trim(L.license_state)+','
																			 +trim(L.license_number)+','
																			 +trim(L.license_class_type)+','
																			 +trim(L.status)+','
																			 +trim(L.issue_date)+','
																			 +trim(L.expiration_date)+','
   																	   +trim(L.name)+','
																			 +trim(L.first)+','
																			 +trim(L.middle)+','
																			 +trim(L.last)+','
																			 +trim(L.suffix)+','
																			 +trim(L.cred)+','
																			 +trim((string)L.age)+','
																			 +trim(L.dateofbirth)+','
																			 +trim(L.email)+','
																			 +trim(L.gender)+','
																			 +trim(L.dateofdeath)+','
																			 +trim(L.city)+','
																			 +trim(L.address_state)+','
																			 +trim(L.orig_zip)+','
																			 +trim(L.orig_county)+','
																			 +trim(L.country)+','
																			 +trim(L.phone_number)+','
																			 +trim(L.phone_type)+','
																			 +trim(L.csr_number)+','
																			 +trim(L.npi_number)+','
																			 +trim(L.dea_number)+','
																			 +trim(L.school)+','
																			 +trim(L.graduated)+','
																			 +trim(L.board)+','
																			 +trim(L.offense)+','
																			 +trim(L.action)+','
																			 +trim(L.location)+','
																			 +trim(L.specialty_class_type)+','
																			 +trim(L.description)
																			 ));
   			SELF											:= L;
   		END;
			
   		d_rid := project(base_f,GetSourceRID(left));		
			
   		new_base_s := SORT(d_rid
   										,ln_key
   										,hms_src
   										,key
   										,id
   										,entityid
   										,license_state
   										,license_number
   										,license_class_type
   										,status
											,issue_date
											,renewal_date
											,expiration_date
   										,name
											,prefix
   										,last
   										,middle
   										,first
   										,suffix
   										,cred
   										,age
											,dateofbirth
											,email
											,gender
											,dateofdeath
											,employer_identification_number
											,raw_full_address
											,prepped_addr1
											,prepped_addr2
   										,city
   										,address_state
											,orig_zip
   										,orig_county
   										,country
											,phone_number
											,phone_type
											,csr_number
											,CREDENTIAL_TYPE
											,CSR_STATUS
											,SUB_STATUS
											,CSR_STATE
											,CSR_ISSUE_DATE
											,EFFECTIVE_DATE
											,CSR_EXPIRATION_DATE
											,DISCIPLINE
											,ALL_SCHEDULES
											,SCHEDULE_1
											,SCHEDULE_2
											,SCHEDULE_2N
											,SCHEDULE_3
											,SCHEDULE_3N
											,SCHEDULE_4
											,SCHEDULE_5
											,SCHEDULE_6
											,RAW_STATUS
											,RAW_SUB_STATUS1
											,RAW_SUB_STATUS2
											,npi_number
											,REPLACEMENT_NUMBER
											,ENUMERATION_DATE
											,LAST_UPDATE_DATE
											,DEACTIVATION_DATE
											,REACTIVATION_DATE
											,DEACTIVATION_REASON
											,dea_number
											,SCHEDULES
											,DEA_EXPIRATION_DATE
											,ACTIVITY
											,BAC
											,BAC_SUBCODE
											,PAYMENT
											,language
											,degree
											,school
											,graduated
											,board
											,offense
											,action
											,fine
											,location
											,specialty_class_type
											,description
											,medicaid_number
											,medicaid_Status
											,medicaid_State
					            ,PARTICIPATION_FLAG
											,taxonomy_npi_number
											,taxonomy_code
											,taxonomy_order_number
											,license_number_state_code
											,taxonomy_switch
											,LOCAL);
   		
   		HMS_CSR.layouts.csrcredential_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
   			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
   			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
				self.source_rid           		:=if(L.dt_vendor_first_reported<R.dt_vendor_first_reported,L.source_rid,R.source_rid);
   			//SELF						 						:= IF(L.ln_record_type = 'C', L, R); 
				SELF 		 											:= IF(L.dt_vendor_last_reported>R.dt_vendor_last_reported,L,R);
			END;
   
   		csrcred_base := ROLLUP(new_base_s
   										,left.ln_key=right.ln_key
   										AND left.hms_src=right.hms_src
											AND left.key=right.key
											AND left.id=right.id
											AND left.entityid=right.entityid
   										AND left.license_state=right.license_state
											AND left.license_number=right.license_number
   										AND left.license_class_type=right.license_class_type
   										AND left.status=right.status
											AND left.issue_date=right.issue_date
											AND left.renewal_date=right.renewal_date
											AND left.expiration_date=right.expiration_date
   										AND left.name=right.name
											AND left.prefix=right.prefix
   										AND left.middle=right.middle
   										AND left.last=right.last
   										AND left.first=right.first
   										AND left.middle=right.middle
   										AND left.suffix=right.suffix
   										AND left.cred=right.cred
   										AND left.age=right.age
											AND left.clean_dateofbirth=right.clean_dateofbirth
											AND left.email=right.email
											AND left.gender=right.gender
											AND left.dateofdeath=right.dateofdeath
											AND left.employer_identification_number=right.employer_identification_number
											AND left.raw_full_address=right.raw_full_address
											AND left.prepped_addr1=right.prepped_addr1
											AND left.prepped_addr2=right.prepped_addr2
											AND left.city=right.city
   										AND left.address_state=right.address_state
											AND left.orig_zip=right.orig_zip
   										AND left.orig_county=right.orig_county
   										AND left.country=right.country
											AND left.phone_number=right.phone_number
											AND left.phone_type=right.phone_type
   										AND left.csr_number=right.csr_number
											AND left.CREDENTIAL_TYPE=right.CREDENTIAL_TYPE
											AND left.CSR_STATUS=right.CSR_STATUS
											AND left.SUB_STATUS=right.SUB_STATUS
											AND left.CSR_STATE=right.CSR_STATE
											AND left.CSR_ISSUE_DATE=right.CSR_ISSUE_DATE
											AND left.EFFECTIVE_DATE=right.EFFECTIVE_DATE
											AND left.CSR_EXPIRATION_DATE=right.CSR_EXPIRATION_DATE
											AND left.DISCIPLINE=right.DISCIPLINE
											AND left.ALL_SCHEDULES=right.ALL_SCHEDULES
											AND left.SCHEDULE_1=right.SCHEDULE_1
											AND left.SCHEDULE_2=right.SCHEDULE_2
											AND left.SCHEDULE_2N=right.SCHEDULE_2N
											AND left.SCHEDULE_3=right.SCHEDULE_3
											AND left.SCHEDULE_3N=right.SCHEDULE_3N
											AND left.SCHEDULE_4=right.SCHEDULE_4
											AND left.SCHEDULE_5=right.SCHEDULE_5
											AND left.SCHEDULE_6=right.SCHEDULE_6
											AND left.RAW_STATUS=right.RAW_STATUS
											AND left.RAW_SUB_STATUS1=right.RAW_SUB_STATUS1
											AND left.RAW_SUB_STATUS2=right.RAW_SUB_STATUS2
   										AND left.npi_number=right.npi_number
											AND left.REPLACEMENT_NUMBER=right.REPLACEMENT_NUMBER
											AND left.ENUMERATION_DATE=right.ENUMERATION_DATE
											AND left.LAST_UPDATE_DATE=right.LAST_UPDATE_DATE
											AND left.DEACTIVATION_DATE=right.DEACTIVATION_DATE
											AND left.REACTIVATION_DATE=right.REACTIVATION_DATE
											AND left.DEACTIVATION_REASON=right.DEACTIVATION_REASON
   										AND left.dea_number=right.dea_number
											AND left.SCHEDULES=right.SCHEDULES
											AND left.DEA_EXPIRATION_DATE=right.DEA_EXPIRATION_DATE
											AND left.ACTIVITY=right.ACTIVITY
											AND left.BAC=right.BAC
											AND left.BAC_SUBCODE=right.BAC_SUBCODE
											AND left.PAYMENT=right.PAYMENT
											AND left.language=right.language
											AND left.degree=right.degree
											AND left.school=right.school
											AND left.graduated=right.graduated
											AND left.board=right.board
											AND left.offense=right.offense
											AND left.action=right.action
											AND left.offense=right.offense
											AND left.action_date=right.action_date
											AND left.fine=right.fine
											AND left.location=right.location
											AND left.specialty_class_type=right.specialty_class_type
											AND left.description=right.description
											AND left.medicaid_number=right.medicaid_number
											AND left.medicaid_Status=right.medicaid_Status
											AND left.medicaid_State=right.medicaid_State
					            AND left.PARTICIPATION_FLAG=right.PARTICIPATION_FLAG
											AND left.taxonomy_npi_number=right.taxonomy_npi_number
											AND left.taxonomy_code=right.taxonomy_code
											AND left.taxonomy_order_number=right.taxonomy_order_number
											AND left.license_number_state_code=right.license_number_state_code
											AND left.taxonomy_switch=right.taxonomy_switch
											,t_rollup(LEFT,RIGHT),LOCAL);	
											
											
				matchset := ['A','Z','P'];
				did_add.MAC_Match_Flex
				(csrcred_base, matchset,					
				foo,foo1,first, middle, last, suffix, 
				street1, street2, street3, zip, address_state,phone_number, 
				did, HMS_CSR.layouts.csrcredential_base, true, did_score,
				75, d_did);

					did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,false);
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
				,HMS_CSR.Layouts.csrcredential_base
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
				
				Health_Facility_Services.mac_get_best_lnpid_on_thor (
										d_bdid
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
										,dLnpidOut
										,false
										,30 //30 for facilities
										);
					 
				with_lnpid:=dLnpidOut(lnpid>0);
				no_lnpid:=dLnpidOut(lnpid=0);


				Health_Provider_Services.mac_get_best_lnpid_on_thor (
									 no_lnpid 
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
									,result,false,38 //38 for providers
				);
				
				final_base := result + with_lnpid;
				
				// ********************************Set clean dates and phones to blank where all 0's and all 8's***************************
			
				HMS_CSR.Layouts.csrcredential_base DatePhoneMapping(HMS_CSR.Layouts.csrcredential_base L) := TRANSFORM
         							
											SELF.clean_phone								:= if(REGEXREPLACE('9',L.clean_phone,'') = '','',L.clean_phone);
         							SELF.clean_phone1								:= if(REGEXREPLACE('9',L.clean_phone1,'') = '','',L.clean_phone1);
         							SELF.clean_phone2								:= if(REGEXREPLACE('9',L.clean_phone2,'') = '','',L.clean_phone2);
         							SELF.clean_phone3								:= if(REGEXREPLACE('9',L.clean_phone3,'') = '','',L.clean_phone3);
         							SELF.clean_fax1   							:= if(REGEXREPLACE('9',L.clean_fax1,'') = '','',L.clean_fax1);
         							SELF.clean_fax2   							:= if(REGEXREPLACE('9',L.clean_fax2,'') = '','',L.clean_fax2);
         							SELF.clean_fax3   							:= if(REGEXREPLACE('9',L.clean_fax3,'') = '','',L.clean_fax3);
         							SELF.clean_other_phone1					:= if(REGEXREPLACE('9',L.clean_other_phone1,'') = '','',L.clean_other_phone1);
											SELF.clean_issue_date						:= if(REGEXREPLACE('0',trim(L.clean_issue_date,all),'') = '','',L.clean_issue_date); 
         							SELF.clean_expiration_date			:= if(REGEXREPLACE('0',trim(L.clean_expiration_date,all),'') = '','',L.clean_expiration_date);
         							SELF.clean_offense_date					:= if(REGEXREPLACE('0',trim(L.clean_offense_date,all),'') = '','',L.clean_offense_date);
         							SELF.clean_action_date					:= if(REGEXREPLACE('0',trim(L.clean_action_date,all),'') = '','',L.clean_action_date);
         							SELF.clean_dateofbirth					:= if(REGEXREPLACE('0',trim(L.clean_dateofbirth,all),'') = '','',L.clean_dateofbirth);
         							SELF.clean_dateofdeath					:= if(REGEXREPLACE('0',trim(L.clean_dateofdeath,all),'') = '','',L.clean_dateofdeath);
											SELF.clean_renewal_date 				:= if(REGEXREPLACE('0',trim(L.clean_renewal_date,all),'') = '','',L.clean_renewal_date); 
											SELF.clean_enumeration_date 		:= if(REGEXREPLACE('0',trim(L.clean_enumeration_date,all),'') = '','',L.clean_enumeration_date);
											SELF.clean_last_update_date 		:= if(REGEXREPLACE('0',trim(L.clean_last_update_date,all),'') = '','',L.clean_last_update_date);
											SELF.clean_deactivation_date 		:= if(REGEXREPLACE('0',trim(L.clean_deactivation_date,all),'') = '','',L.clean_deactivation_date);
											SELF.clean_reactivation_date 		:= if(REGEXREPLACE('0',trim(L.clean_reactivation_date,all),'') = '','',L.clean_reactivation_date);
											SELF.clean_csr_issue_date 			:= if(REGEXREPLACE('0',trim(L.clean_csr_issue_date,all),'') = '','',L.clean_csr_issue_date);
											SELF.clean_effective_date 			:= if(REGEXREPLACE('0',trim(L.clean_effective_date,all),'') = '','',L.clean_effective_date);
											SELF.clean_csr_expiration_date 	:= if(REGEXREPLACE('0',trim(L.clean_csr_expiration_date,all),'') = '','',L.clean_csr_expiration_date);
											SELF.clean_dea_expiration_date 	:= if(REGEXREPLACE('0',trim(L.clean_dea_expiration_date,all),'') = '','',L.clean_dea_expiration_date);
         						 	SELF := L;
					END;
					
							
					csrcred_base_result := PROJECT(final_base, DatePhoneMapping(LEFT));
				
				// ****************************************************************************************************
				
													
				RETURN csrcred_base_result;						

   END;

END;