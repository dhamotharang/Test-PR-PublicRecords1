//MPRD Update_Base
IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID,Health_Provider_Services, 
Health_Facility_Services, HealthCareFacility, MPRD, BIPV2_Company_Names;

EXPORT Update_Base (STRING filedate, BOOLEAN pUseProd = false) := MODULE

	EXPORT Clean_name (pBaseFile, pLayout_base, useFull = false) := FUNCTIONMACRO
		#IF(useFull)
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														, clean_company_name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);
		#else
		NID.Mac_CleanParsedNames(pBaseFile, cleanNames
														, firstname:=first_name,middlename:=middle_name,lastname:=last_name,namesuffix:=maturity_suffix
														, includeInRepository:=TRUE, normalizeDualNames:=FALSE);	
		#end
		setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
		STRING fGetSuffix(STRING SuffixIn)	:=		MAP(SuffixIn = '1' => 'I'
																							,SuffixIn IN ['2','ND'] => 'II'
																							,SuffixIn IN ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn IN setValidSuffix => SuffixIn
																							,'');
																			
		pLayout_base tr(cleanNames L) := TRANSFORM
			SELF.title 				:= IF(l.nameType='P' AND L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.fname 				:= IF(l.nameType='P',L.cln_fname,'');
			SELF.mname 				:= IF(l.nameType='P',L.cln_mname,'');
			SELF.lname 				:= IF(l.nameType='P',L.cln_lname,'');
			SELF.name_suffix 	:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		RETURN PROJECT(cleanNames,tr(LEFT));
	ENDMACRO;
	
	EXPORT Clean_addr (pBaseFile, pLayout_base)	:= FUNCTIONMACRO

		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
		AID.MacAppendFromRaw_2Line(pBaseFile,Prepped_addr1,Prepped_addr2,RawAID,cleanAddr, lFlags);

		pLayout_base addr(cleanAddr L)	:= TRANSFORM
			SELF.RawAID     				:= L.aidwork_rawaid;
			SELF.ACEAID							:= L.aidwork_acecache.aid;
			SELF.clean_prim_range 	:= stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.clean_predir				:= stringlib.stringfilterout(L.aidwork_acecache.predir,'.^!$+<>@=%?*\'');
			SELF.clean_prim_name  	:= stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.clean_addr_suffix 	:= stringlib.stringfilterout(L.aidwork_acecache.addr_suffix,'.^!$+<>@=%?*\'');
			SELF.clean_postdir			:= stringlib.stringfilterout(L.aidwork_acecache.postdir,'.^!$+<>@=%?*\'');
			SELF.clean_sec_range  	:= stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.clean_unit_desig  	:= L.aidwork_acecache.unit_desig;
			SELF.clean_v_city_name	:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.clean_p_city_name	:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.clean_zip       		:= L.aidwork_acecache.zip5;
			SELF.clean_zip4					:= L.aidwork_acecache.zip4;
			SELF.clean_cart     	  := L.aidwork_acecache.cart;
			SELF.clean_cr_sort_sz 	:= L.aidwork_acecache.cr_sort_sz;
			SELF.clean_lot        	:= L.aidwork_acecache.lot;
			SELF.clean_lot_order  	:= L.aidwork_acecache.lot_order;
			SELF.clean_chk_digit  	:= L.aidwork_acecache.chk_digit;
			SELF.clean_rec_type   	:= L.aidwork_acecache.rec_type;
			SELF.clean_st        	  := L.aidwork_acecache.st;
			SELF.clean_fips_st    	:= L.aidwork_acecache.county[1..2];
			SELF.clean_fips_county	:= L.aidwork_acecache.county[3..5];
			SELF.clean_geo_lat     	:= L.aidwork_acecache.geo_lat;
			SELF.clean_geo_long    	:= L.aidwork_acecache.geo_long;
			SELF.clean_msa        	:= IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF.clean_geo_blk     	:= L.aidwork_acecache.geo_blk;
			SELF.clean_geo_match   	:= L.aidwork_acecache.geo_match;
			SELF.clean_err_stat    	:= L.aidwork_acecache.err_stat;
			SELF.clean_dbpc        	:= L.aidwork_acecache.dbpc;
			SELF            				:= L.aidwork_acecache;
			SELF           					:= L;
		END;
		RETURN PROJECT(cleanAddr, addr(LEFT));
	ENDMACRO;

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.record_type	:= 'H';
				SELF							:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;

	EXPORT invalid_dates:=['','0000-00-00','\\N'];

	EXPORT invalid_values:=['\\N','|','\\','','0000-00-00'];

	EXPORT individual_base:=FUNCTION

		base_file := Mark_history(MPRD.Files(filedate,pUseProd).individual_base.built(isTest = false), MPRD.layouts.individual_base);

		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).Individual;// join back to previous build based on groupkey and others, bring forward cleaned fields - carry over source rid
		// distribute base and new - on groupkey - do local join for cleaning, etc		
		cleanNames := Clean_name(std_input, MPRD.Layouts.individual_base):PERSIST('~thor_data400::persist::mprd::individual1_names'); // only clean records that have not been cleaned - join back in

		cleanAdd_t	:= Clean_addr(cleanNames,  MPRD.Layouts.individual_base):PERSIST('~thor_data400::persist::cleaned_practice_addr1_indv');

		base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).individual_lBaseTemplate_built)) = 0 // move after standardize and distribute
								 ,cleanAdd_t,cleanAdd_t + base_file);

		MPRD.layouts.Individual_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   			SELF.source_rec_id 					:= HASH64(hashmd5(
   																	    TRIM(l.full_name)+','
																			 +TRIM(l.pre_name)+','
																			 +TRIM(l.first_name)+','
																			 +TRIM(l.middle_name)+','
																			 +TRIM(l.last_name)+','
																			 +TRIM(l.maturity_suffix)+','
																			 +TRIM(l.other_suffix)+','
																			 +TRIM(l.gender)+','
																			 +TRIM(l.prac_company1_name)+','
																			 +TRIM(l.birthdate)+','
																			 +TRIM(l.hashed_ssn)+','
																			 +TRIM(l.prac_phone1)+','
																			 +TRIM(l.bill_phone1)+','
																			 +TRIM(l.prac_fax1)+','
																			 +TRIM(l.bill_fax1)+','
																			 +TRIM(l.email_addr)+','
																			 +TRIM(l.web_site)+','
																			 +TRIM(l.upin)+','
																			 +TRIM(l.tin1)+','
																			 +TRIM(l.dea_num1)+','
																			 +TRIM(l.dea_num1_exp)+','
																			 +TRIM(l.dea_num1_sch)+','
																			 +TRIM(l.dea_num1_bus_act_ind)+','
																			 +TRIM(l.specialty1)+','
																			 +TRIM(l.specialty2)+','
																			 +TRIM(l.lic1_num_in)+','
	                                     +TRIM(l.lic1_state)+','
																			 +TRIM(l.lic1_num)+','
																			 +TRIM(l.lic1_type)+','
																			 +TRIM(l.lic1_status)+','
																			 +TRIM(l.lic1_begin_date)+','
																			 +TRIM(l.lic1_end_date)+','
																			 +TRIM(l.lic2_num_in)+','
																			 +TRIM(l.lic2_state)+','
																			 +TRIM(l.lic2_num)+','
																			 +TRIM(l.lic2_type)+','
																			 +TRIM(l.lic2_status)+','
																			 +TRIM(l.lic2_begin_date)+','
																			 +TRIM(l.lic2_end_date)+','
																			 +TRIM(l.lic3_num_in)+','
																			 +TRIM(l.lic3_state)+','
																			 +TRIM(l.lic3_num)+','
																			 +TRIM(l.lic3_type)+','
																			 +TRIM(l.lic3_status)+','
																			 +TRIM(l.lic3_begin_date)+','
																			 +TRIM(l.lic3_end_date)+','
																			 +TRIM(l.normed_addr_rec_type)+','
																			 +TRIM(l.orig_adresss)+','
			                                 +TRIM(l.orig_state)+','
																			 +TRIM(l.orig_city)+','
																			 +TRIM(l.orig_zip)+','
																			 +TRIM(l.aff_code_mg)+','
																			 +TRIM(l.sanc1_state)+','
																			 +TRIM(l.sanc1_date)+','
																			 +TRIM(l.sanc1_case)+','
																			 +TRIM(l.sanc1_source)+','
																			 +TRIM(l.sanc1_complaint)+','
                                       +TRIM(l.kil_code)+','
																			 +TRIM(l.date_of_death)+','
																			 +TRIM(l.filecode)+','
																			 +TRIM(l.medschool1)+','
																			 +TRIM(l.medschool1_year)+','
																			 +TRIM(l.npi_num)+','
																			 +TRIM(l.taxonomy)
																					));
   		SELF											:= L;
   	END;
   			
		d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));
	
		new_base_d := DISTRIBUTE(d_rid, HASH(TRIM(first_name),TRIM(middle_name),TRIM(last_name),orig_adresss, orig_state,orig_city,orig_zip)); 
		new_base_s := SORT(new_base_d,
                     full_name,
										 name_in,
										 pre_name,
										 first_name,
										 middle_name, 
										 last_name,
										 maturity_suffix,
										 other_suffix,
										 gender,
										 prac_company1_name,
										 birthdate,
										 hashed_ssn,
										 prac_phone1,
										 bill_phone1,
										 prac_fax1,
										 bill_fax1,
										 email_addr,
										 web_site,
										 upin,
										 tin1,
										 dea_num1,
										 dea_num1_exp,
										 dea_num1_sch,
										 dea_num1_bus_act_ind,
										 dea_num1_bus_subcode,
										 dea_num1_payment_ind,
										 specialty1,
										 specialty2,
										 lic1_num_in,
                     lic1_state,
										 lic1_num,
										 lic1_type,
										 lic1_status,
										 lic1_begin_date,
										 lic1_end_date,
										 lic1_drug_schedule,
										 lic2_num_in,
										 lic2_state,
										 lic2_num,
										 lic2_type,
										 lic2_status,
										 lic2_begin_date,
										 lic2_end_date,
										 lic2_drug_schedule,
                     lic3_num_in,
										 lic3_state,
										 lic3_num,
										 lic3_type,
										 lic3_status,
										 lic3_begin_date,
										 lic3_end_date,
										 lic3_drug_schedule,
										 normed_addr_rec_type,
										 orig_adresss,
                     orig_state,
										 orig_city,
										 orig_zip,
										 aff_code_mg, 
										 sanc1_state,
										 sanc1_date, 
										 sanc1_case,
										 sanc1_source, 
										 sanc1_complaint,
                     kil_code,
										 date_of_death,
										 sequence_num,
										 project_num,
										 filecode,
										 state_mask,
										 provider_id,
										 medschool1,
										 medschool1_year,
										 npi_num,
									   taxonomy,
										 abms_certificate_id,
										 abms_certificate_type,
										 abms_occurrence_type,
										 abms_duration_type,
										 abms_start_eff_date,
										 abms_end_eff_date,
										 medicare_optout_flag,
										 medicare_optout_eff_date,
										 medicare_optout_end_date,
										 medicare_assign_ind,
										 isTest,
					 LOCAL);
		
		MPRD.Layouts.individual_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			SELF.date_first_seen            := (STRING) ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			SELF.	source_rec_id             := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			SELF						 							  := IF(Le.record_type = 'C', Le, Ri);
		END;

		base_f := rollup(
							new_base_s,
									LEFT.full_name								= RIGHT.full_name
							AND LEFT.name_in									= RIGHT.name_in
							AND LEFT.pre_name									= RIGHT.pre_name
							AND LEFT.first_name								= RIGHT.first_name
							AND LEFT.middle_name							= RIGHT.middle_name
							AND LEFT.last_name								= RIGHT.last_name
							AND LEFT.maturity_suffix					= RIGHT.maturity_suffix
							AND LEFT.other_suffix							= RIGHT.other_suffix
							AND LEFT.gender										= RIGHT.gender
							AND LEFT.prac_company1_name				= RIGHT.prac_company1_name
							AND LEFT.birthdate								= RIGHT.birthdate
							AND LEFT.hashed_ssn								= RIGHT.hashed_ssn
							AND LEFT.prac_phone1							= RIGHT.prac_phone1
							AND LEFT.bill_phone1							= RIGHT.bill_phone1
							AND LEFT.prac_fax1								= RIGHT.prac_fax1
							AND LEFT.bill_fax1								= RIGHT.bill_fax1
							AND LEFT.email_addr								= RIGHT.email_addr
							AND LEFT.web_site									= RIGHT.web_site
							AND LEFT.upin											= RIGHT.upin
							AND LEFT.tin1											= RIGHT.tin1
							AND LEFT.dea_num1									= RIGHT.dea_num1
							AND LEFT.dea_num1_exp							= RIGHT.dea_num1_exp
							AND LEFT.dea_num1_sch							= RIGHT.dea_num1_sch
							AND LEFT.dea_num1_bus_act_ind			= RIGHT.dea_num1_bus_act_ind
							AND LEFT.dea_num1_bus_subcode 		= RIGHT.dea_num1_bus_subcode
							AND LEFT.dea_num1_payment_ind			= RIGHT.dea_num1_payment_ind
							AND LEFT.specialty1								= RIGHT.specialty1
							AND LEFT.specialty2								= RIGHT.specialty2
							AND LEFT.lic1_num_in							= RIGHT.lic1_num_in
							AND LEFT.lic1_state								= RIGHT.lic1_state
							AND LEFT.lic1_num									= RIGHT.lic1_num
							AND LEFT.Lic1_Type								= RIGHT.Lic1_Type
							AND LEFT.lic1_status							= RIGHT.lic1_status
							AND LEFT.Lic1_begin_date					= RIGHT.Lic1_begin_date
							AND LEFT.Lic1_End_date						= RIGHT.Lic1_End_date
							AND LEFT.lic1_drug_schedule				= RIGHT.lic1_drug_schedule
							AND LEFT.lic2_num_in							= RIGHT.lic2_num_in
							AND LEFT.lic2_state								= RIGHT.lic2_state
							AND LEFT.lic2_num									= RIGHT.lic2_num
							AND LEFT.Lic2_Type								= RIGHT.Lic2_Type
							AND LEFT.lic2_status							= RIGHT.lic2_status
							AND LEFT.Lic2_begin_date					= RIGHT.Lic2_begin_date
							AND LEFT.Lic2_End_date						= RIGHT.Lic2_End_date
							AND LEFT.lic2_drug_schedule				= RIGHT.lic2_drug_schedule
							AND LEFT.lic3_num_in							= RIGHT.lic3_num_in
							AND LEFT.lic3_state								= RIGHT.lic3_state
							AND LEFT.lic3_num									= RIGHT.lic3_num
							AND LEFT.Lic3_Type								= RIGHT.Lic3_Type
							AND LEFT.lic3_status							= RIGHT.lic3_status
							AND LEFT.Lic3_begin_date					= RIGHT.Lic3_begin_date
							AND LEFT.Lic3_End_date						= RIGHT.Lic3_End_date
							AND LEFT.lic3_drug_schedule				= RIGHT.lic3_drug_schedule
							AND LEFT.normed_addr_rec_type			= RIGHT.normed_addr_rec_type
							AND LEFT.orig_adresss							= RIGHT.orig_adresss
							AND LEFT.orig_state								= RIGHT.orig_state
							AND LEFT.orig_city								= RIGHT.orig_city
							AND LEFT.orig_zip									= RIGHT.orig_zip
							AND LEFT.aff_code_mg							= RIGHT.aff_code_mg
							AND LEFT.sanc1_state							= RIGHT.sanc1_state
							AND LEFT.sanc1_date								= RIGHT.sanc1_date
							AND LEFT.sanc1_case								= RIGHT.sanc1_case
							AND LEFT.sanc1_source							= RIGHT.sanc1_source
							AND LEFT.sanc1_complaint					= RIGHT.sanc1_complaint
							AND LEFT.kil_code									= RIGHT.kil_code
							AND LEFT.date_of_death						= RIGHT.date_of_death
							AND LEFT.sequence_num							= RIGHT.sequence_num
							AND LEFT.project_num							= RIGHT.project_num
							AND LEFT.filecode									= RIGHT.filecode
							AND LEFT.state_mask								= RIGHT.state_mask
							AND LEFT.provider_id							= RIGHT.provider_id
							AND LEFT.medschool1								= RIGHT.medschool1
							AND LEFT.medschool1_year					= RIGHT.medschool1_year
							AND LEFT.npi_num									= RIGHT.npi_num
							AND LEFT.taxonomy									= RIGHT.taxonomy
							AND LEFT.abms_certificate_id			= RIGHT.abms_certificate_id
							AND LEFT.abms_certificate_type 		= RIGHT.abms_certificate_type
							AND LEFT.abms_occurrence_type 		= RIGHT.abms_occurrence_type
							AND LEFT.abms_duration_type				= RIGHT.abms_duration_type
							AND LEFT.abms_start_eff_date			= RIGHT.abms_start_eff_date
							AND LEFT.abms_end_eff_date				= RIGHT.abms_end_eff_date
							AND LEFT.medicare_optout_flag			= RIGHT.medicare_optout_flag
							AND LEFT.medicare_optout_eff_date	= RIGHT.medicare_optout_eff_date
							AND LEFT.medicare_optout_end_date	= RIGHT.medicare_optout_end_date
							AND LEFT.medicare_assign_ind			= RIGHT.medicare_assign_ind
							AND LEFT.isTest										= RIGHT.isTest
            ,t_rollup(LEFT, RIGHT),LOCAL);

		matchset := ['A','Z','P'];
		did_add.MAC_Match_Flex
		(base_f, matchset,					
		foo,foo1,first_name, middle_name, last_name, pre_name, 
		clean_prim_range, clean_prim_name, clean_sec_range, clean_zip, clean_st,prac_phone1, 
		DID, mprd.Layouts.individual_base, true, did_score,
		75, d_did);

    did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,false);// dump this
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0,false);

		bdid_matchset := ['A']; // replace this with BIP 
		Business_Header_SS.MAC_Add_BDID_Flex(
			d_dob0
			,bdid_matchset
			,full_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,''
			,foo
			,bdid
			,mprd.layouts.individual_base
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,
			,
			,
			,
			,
			,src
			,
			,
			);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,LNPID
			,First_name
			,Middle_name
			,Last_NAME
			,maturity_suffix
			,//GENDER
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_v_city_name
			,clean_ST
			,clean_ZIP
			,//SSN
			,//DOB
			,clean_prac_phone1
			,LIC1_STATE
			,LIC1_num
			,tin1
			,DEA_NUM1
			,group_key
			,
			,UPIN
			,DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);

		final_result:=distribute(MPRD.MAC_Derive_Sanctions(result,mprd.layouts.individual_base,sanc1_complaint,lic1_status));
		RETURN final_result; 
	END;

	// EXPORT facility_base:=FUNCTION
		// base_file := Mark_history(MPRD.Files(filedate,pUseProd).facility_base.built(isTest = false), MPRD.layouts.facility_base);

		// std_input := MPRD.StandardizeInputFile(filedate, pUseProd).Facility;
																						
		// cleanAdd_t	:= Clean_addr(std_input,  MPRD.Layouts.facility_base):PERSIST('~thor_data400::persist::cleaned_practice_addr_fac');
	
		// base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).facility_lBaseTemplate_built)) = 0
								 // ,cleanAdd_t,cleanAdd_t + base_file);

		// MPRD.layouts.facility_base GetSourceRID(base_and_update l):=TRANSFORM
            // SELF.source_rec_id		:= HASH64(hashmd5(
																	       // TRIM(l.prac_company1_name)+','
																				// +TRIM(l.prac_phone1)+','
																				// +TRIM(l.bill_phone1)+','
																				// +TRIM(l.prac_fax1)+','
																				// +TRIM(l.bill_fax1)+','
																				// +TRIM(l.email_addr)+','
																				// +TRIM(l.web_site)+','
																				// +TRIM(l.tin1)+','
																				// +TRIM(l.dea_num1)+','
																				// +TRIM(l.dea_num1_exp)+','	
   		                                  // +TRIM(l.dea_num1_sch)+','	
   		                                  // +TRIM(l.dea_num1_bus_act_ind)+','
																				// +TRIM(l.lic1_num_in)+','
																			  // +TRIM(l.lic1_state)+','
																			  // +TRIM(l.lic1_num)+','
																			  // +TRIM(l.lic1_type)+','
																			  // +TRIM(l.lic1_status)+','
																			  // +TRIM(l.lic1_begin_date)+','
																			  // +TRIM(l.lic1_end_date)+','
																			  // +TRIM(l.lic2_num_in)+','
																			  // +TRIM(l.lic2_state)+','
																			  // +TRIM(l.lic2_num)+','
																			  // +TRIM(l.lic2_type)+','
																			  // +TRIM(l.lic2_status)+','
																			  // +TRIM(l.lic2_begin_date)+','
																			  // +TRIM(l.lic2_end_date) +','
																			  // +TRIM(l.lic3_num_in)+','
																			  // +TRIM(l.lic3_state)+','
																			  // +TRIM(l.lic3_num)+','
																			  // +TRIM(l.lic3_type)+','
																			  // +TRIM(l.lic3_status)+','
																			  // +TRIM(l.lic3_begin_date)+','
																			  // +TRIM(l.lic3_end_date)+','
																			  // +TRIM(l.normed_addr_rec_type)+','
																			  // +TRIM(l.orig_adresss)+','
																			  // +TRIM(l.orig_state)+','
																			  // +TRIM(l.orig_city)+','
																			  // +TRIM(l.orig_zip)+','
																				// +TRIM(l.filecode)+','
																				// +TRIM(l.dept_code)+','
																				// +TRIM(l.provider_id)+','
																				// +TRIM(l.npi_num)+','
																				// +TRIM(l.medicare_fac_num)+','
																				// +TRIM(l.medicaid_fac_num)+','
																				// +TRIM(l.facility_type)+','
																				// +TRIM(l.taxonomy)+','
																				// +TRIM(l.ncpdp_id)+','
																				// +TRIM(l.sanc1_state)+','
																				// +TRIM(l.sanc1_date)+','
				                                // +TRIM(l.sanc1_case)+','	
   		                                  // +TRIM(l.sanc1_source)+','	
																				// +TRIM(l.sanc1_complaint)+','	   
 																			  // +TRIM(l.dba_name)+','	
																				// +TRIM(l.bill_company1_name)+','	
																				// +TRIM(l.taxonomy_primary_ind)+','	   	
																				// +TRIM(l.dea_num1_deact_date)+','	
																				// +TRIM(l.npi_deact_date)+','	
																				// +TRIM(l.sanc1_rein_date)+','	
																				// +TRIM(l.clia_num)+','	
																				// +TRIM(l.clia_status_code)+','	
																				// +TRIM(l.clia_cert_type_code)+','	
																				// +TRIM(l.clia_cert_eff_date)+','	
																				// +TRIM(l.clia_end_date)));
			// SELF											:= L;
		// END;											

		// d_rid	:= PROJECT(base_and_update, GetSourceRID(LEFT));

		// new_base_d := DISTRIBUTE(d_rid, HASH( prac_company1_name,orig_adresss, orig_state,orig_city,orig_zip));  
		// new_base_s := SORT(new_base_d,
	                    // prac_company1_name,
											// orig_adresss,
											// orig_state,
											// orig_city,
											// orig_zip,
											// prac_phone1,
											// bill_phone1,
											// prac_fax1,
											// bill_fax1,
											// email_addr,
											// web_site,
											// tin1,
											// dea_num1,
											// dea_num1_exp,
											// dea_num1_sch,
											// dea_num1_bus_act_ind,
											// lic1_num_in,
											// lic1_state,
											// lic1_num,
											// lic1_type,
											// lic1_status,
											// lic1_begin_date,
											// lic1_end_date,
											// lic2_num_in,
											// lic2_state,
											// lic2_num,
											// lic2_type,
											// lic2_status,
											// lic2_begin_date,
											// lic2_end_date,
											// lic3_num_in,
											// lic3_state,
											// lic3_num,
											// lic3_type,
											// lic3_status,
											// lic3_begin_date,
											// lic3_end_date,
											// normed_addr_rec_type,
											// filecode,
											// dept_code,
											// provider_id,
											// npi_num,
											// medicare_fac_num,
											// medicare_fac_num_term_date,
											// medicaid_fac_num,
											// facility_type,
											// taxonomy,
											// ncpdp_id,
											// sanc1_state,
											// sanc1_date,
											// sanc1_case,
											// sanc1_source,
											// sanc1_complaint, 
										  // dba_name,
											// bill_company1_name,
											// taxonomy_primary_ind, 
											// dea_num1_deact_date,
											// npi_deact_date,
											// sanc1_rein_date,
											// clia_num,
											// clia_status_code,
											// clia_cert_type_code,
											// clia_cert_eff_date,
											// clia_end_date,
											// clia_test_vol_accredited,
											// clia_test_vol_annual,
											// clia_test_vol_ppm,
											// clia_test_vol_survey,
											// clia_test_vol_waived
	                    // ,LOCAL);
		
		// MPRD.Layouts.facility_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			// SELF.date_first_seen             :=(STRING) ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			// SELF.date_last_seen              := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			// SELF.date_vendor_first_reported  := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			// SELF.date_vendor_last_reported   := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			// SELF.	source_rec_id              :=IF(le.date_vendor_first_reported <ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			// SELF						 							   := IF(Le.record_type = 'C', Le, Ri);
		// END;

		// base_f := rollup(new_base_s,
								// LEFT.prac_company1_name		= RIGHT.prac_company1_name
						// AND LEFT.orig_adresss					= RIGHT.orig_adresss
						// AND LEFT.orig_state						= RIGHT.orig_state
						// AND LEFT.orig_city						= RIGHT.orig_city
						// AND LEFT.orig_zip							= RIGHT.orig_zip
						// AND LEFT.prac_phone1					= RIGHT.prac_phone1
						// AND LEFT.bill_phone1					= RIGHT.bill_phone1
						// AND LEFT.prac_fax1						= RIGHT.prac_fax1
						// AND LEFT.bill_fax1						= RIGHT.bill_fax1
						// AND LEFT.email_addr						= RIGHT.email_addr
						// AND LEFT.web_site							= RIGHT.web_site
						// AND LEFT.tin1									= RIGHT.tin1
						// AND LEFT.dea_num1							= RIGHT.dea_num1
						// AND LEFT.dea_num1_exp					= RIGHT.dea_num1_exp
						// AND LEFT.dea_num1_sch					= RIGHT.dea_num1_sch
						// AND LEFT.dea_num1_bus_act_ind = RIGHT.dea_num1_bus_act_ind
						// AND LEFT.lic1_num_in 					= RIGHT.lic1_num_in
            // AND LEFT.lic1_state						= RIGHT.lic1_state					  
						// AND LEFT.lic1_num							= RIGHT.lic1_num
						// AND LEFT.Lic1_Type						= RIGHT.Lic1_Type
						// AND LEFT.lic1_status					= RIGHT.lic1_status
            // AND LEFT.Lic1_begin_date			= RIGHT.Lic1_begin_date
            // AND LEFT.Lic1_End_date				= RIGHT.Lic1_End_date
						// AND LEFT.lic2_num_in 					= RIGHT.lic2_num_in
            // AND LEFT.lic2_state						= RIGHT.lic2_state					  
						// AND LEFT.lic2_num							= RIGHT.lic2_num
						// AND LEFT.Lic2_Type						= RIGHT.Lic2_Type
						// AND LEFT.lic2_status					= RIGHT.lic2_status
            // AND LEFT.Lic2_begin_date			= RIGHT.Lic2_begin_date
            // AND LEFT.Lic2_End_date				= RIGHT.Lic2_End_date
						// AND LEFT.lic3_num_in 					= RIGHT.lic3_num_in
            // AND LEFT.lic3_state						= RIGHT.lic3_state					  
						// AND LEFT.lic3_num							= RIGHT.lic3_num
						// AND LEFT.Lic3_Type						= RIGHT.Lic3_Type
						// AND LEFT.lic3_status					= RIGHT.lic3_status
            // AND LEFT.Lic3_begin_date			= RIGHT.Lic3_begin_date
            // AND LEFT.Lic3_End_date				= RIGHT.Lic3_End_date
						// AND LEFT.normed_addr_rec_type	= RIGHT.normed_addr_rec_type
						// AND LEFT.filecode							= RIGHT.filecode
						// AND LEFT.dept_code						= RIGHT.dept_code
						// AND LEFT.provider_id					= RIGHT.provider_id
						// AND LEFT.npi_num							= RIGHT.npi_num
						// AND LEFT.medicare_fac_num			= RIGHT.medicare_fac_num
						// AND LEFT.medicare_fac_num_term_date = RIGHT.medicare_fac_num_term_date
						// AND LEFT.medicaid_fac_num			= RIGHT.medicaid_fac_num
						// AND LEFT.facility_type				= RIGHT.facility_type
						// AND LEFT.taxonomy							= RIGHT.taxonomy
						// AND LEFT.ncpdp_id							= RIGHT.ncpdp_id
						// AND LEFT.sanc1_state					= RIGHT.sanc1_state
						// AND LEFT.sanc1_date						= RIGHT.sanc1_date
            // AND LEFT.sanc1_case						= RIGHT.sanc1_case
            // AND LEFT.sanc1_source					= RIGHT.sanc1_source
						// AND LEFT.sanc1_complaint 			= RIGHT.sanc1_complaint
						// AND LEFT.dba_name							= RIGHT.dba_name
						// AND LEFT.bill_company1_name		= RIGHT.bill_company1_name
						// AND LEFT.taxonomy_primary_ind	= RIGHT.taxonomy_primary_ind 
						// AND LEFT.dea_num1_deact_date	= RIGHT.dea_num1_deact_date
						// AND LEFT.npi_deact_date				= RIGHT.npi_deact_date
						// AND LEFT.sanc1_rein_date			= RIGHT.sanc1_rein_date						
						// AND LEFT.clia_num							= RIGHT.clia_num
						// AND LEFT.clia_status_code			= RIGHT.clia_status_code
						// AND LEFT.clia_cert_type_code	= RIGHT.clia_cert_type_code
						// AND LEFT.clia_cert_eff_date		= RIGHT.clia_cert_eff_date
						// AND LEFT.clia_end_date				= RIGHT.clia_end_date
						// AND LEFT.clia_test_vol_accredited = RIGHT.clia_test_vol_accredited
						// AND LEFT.clia_test_vol_annual = RIGHT.clia_test_vol_annual
						// AND LEFT.clia_test_vol_ppm	  = RIGHT.clia_test_vol_ppm
						// AND LEFT.clia_test_vol_survey = RIGHT.clia_test_vol_survey
						// AND LEFT.clia_test_vol_waived = RIGHT.clia_test_vol_waived
						// AND LEFT.surrogate_key				= RIGHT.surrogate_key
						// AND LEFT.isTest								= RIGHT.isTest
						// ,t_rollup(LEFT, RIGHT),LOCAL);
														
		// bdid_matchset := ['A','P'];
		// Business_Header_SS.MAC_Add_BDID_Flex
			// (base_f
			// ,bdid_matchset
			// ,prac_company1_name
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_zip
			// ,clean_sec_range
			// ,clean_st
			// ,clean_phone
			// ,foo
			// ,bdid
			// ,mprd.layouts.facility_base
			// ,true
			// ,bdid_score
			// ,d_bdid
			// ,
			// ,
			// ,
			// ,BIPV2.xlink_version_set
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,src
			// ,
			// ,
			// );

		// Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// d_bdid
			// ,LNPID
			// ,//First_name
			// ,//Middle_name
			// ,//Last_NAME
			// ,//maturity_suffix
			// ,//GENDER
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_sec_range
			// ,clean_v_city_name
			// ,clean_ST
			// ,clean_ZIP
			// ,//SSN
			// ,//DOB
			// ,clean_phone
			// ,LIC1_STATE
			// ,LIC1_num
			// ,tin1
			// ,DEA_NUM1
			// ,group_key
			// ,
			// ,//UPIN
			// ,DID
			// ,BDID
			// ,//SRC
			// ,//SOURCE_RID
			// ,result,false,38
			// );
		
		// final_result:=MPRD.MAC_Derive_Sanctions(result,mprd.layouts.facility_base,sanc1_complaint,lic1_status);	

		// RETURN final_result;
	// END;

	// choice pioint is called basc_cp
	// EXPORT choice_point_base:=FUNCTION
		// base_file := Mark_history(MPRD.Files(filedate,pUseProd).basc_cp_base.built(isTest = false), MPRD.layouts.choice_point_base);

		// std_input := MPRD.StandardizeInputFile(filedate, pUseProd).choice_point;
					
		// cleanNames := Clean_name(std_input, MPRD.Layouts.choice_point_base):PERSIST('~thor_data400::persist::mprd::choice_point_names');

		// cleanAdd_t	:= Clean_addr(cleanNames, MPRD.Layouts.choice_point_base):PERSIST('~thor_data400::persist::Choice_Point_cleaned_practice_addr_cp');

		// base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).basc_cp_lBaseTemplate_built)) = 0
								 // ,cleanAdd_t,cleanAdd_t + base_file);
											 
		// MPRD.layouts.choice_point_base  GetSourceRID(base_and_update L)	:= TRANSFORM
			// SELF.source_rec_id 					      := HASH64(hashmd5(
																				// TRIM(l.full_name)+','
																			// +TRIM(l.pre_name)+','
																			// +TRIM(l.first_name)+','
																			// +TRIM(l.middle_name)+','
																			// +TRIM(l.last_name)+','
																			// +TRIM(l.maturity_suffix)+','
																			// +TRIM(l.other_suffix)+','
																			// +TRIM(l.gender)+','
																			// +TRIM(l.prac_company1_name)+','
																			// +TRIM(l.birthdate)+','
																			// +TRIM(l.hashed_ssn)+','
																			// +TRIM(l.prac_phone1)+','
																			// +TRIM(l.prac_fax1)+','
																			// +TRIM(l.email_addr)+','
																			// +TRIM(l.web_site)+','
																			// +TRIM(l.upin)+','
																			// +TRIM(l.tin1)+','
																			// +TRIM(l.filecode)+','
																			// +TRIM(l.specialty1)+','
																			// +TRIM(l.specialty2)+','
																			// +TRIM(l.lic1_num_in)+','
																			// +TRIM(l.lic1_num)+','
																			// +(string)(l.lic1_st)+','
																			// +TRIM(l.Lic1_Type)+','
																			// +TRIM(l.Lic1_Status)+','
																			// +TRIM(l.Lic1_begin_date)+','
																			// +TRIM(l.Lic1_End_date)+','
																			// +TRIM(l.orig_adresss)+','
																			// +TRIM(l.orig_state)+','
																			// +TRIM(l.orig_city)+','
																			// +TRIM(l.orig_zip)+','
																			// +TRIM(l.npi_num)+','
																			// +TRIM(l.taxonomy)+','
																			// +TRIM(l.dea_num1)+','
																			// +TRIM(l.dea_num1_exp)+','
																			// +TRIM(l.Dea_num1_bus_Act_Ind)+','
																			// +TRIM(l.sanc1_date)+','
																			// +TRIM(l.sanc1_state)+','
																			// +TRIM(l.sanc1_rein_date)+','
																			// +TRIM(l.kil_code)+','
																			// +TRIM(l.provider_id)+','
																			// +TRIM(l.medschool1)));
			// SELF											:= L;
		// END;
			 			
		// d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));

		// new_base_d := DISTRIBUTE(d_rid, HASH( TRIM(first_name),TRIM(middle_name),TRIM(last_name),orig_adresss,orig_state,orig_city,orig_zip));  
		// new_base_s := SORT(new_base_d,
					// full_name
					// ,pre_name
					// ,first_name
					// ,middle_name
					// ,last_name
					// ,maturity_suffix
					// ,other_suffix
					// ,gender
					// ,prac_company1_name
					// ,birthdate
					// ,hashed_ssn
					// ,prac_phone1
					// ,prac_fax1
					// ,email_addr
					// ,web_site
					// ,upin
					// ,tin1
					// ,filecode
					// ,specialty1
					// ,specialty2
					// ,lic1_num_in
					// ,lic1_num
					// ,lic1_st
					// ,Lic1_Type
					// ,Lic1_Status
					// ,Lic1_begin_date
					// ,Lic1_End_date
					// ,orig_adresss
					// ,orig_state
					// ,orig_city
					// ,orig_zip
					// ,npi_num
					// ,taxonomy
					// ,dea_num1
					// ,dea_num1_exp
					// ,Dea_num1_bus_Act_Ind
					// ,sanc1_date
					// ,sanc1_state
					// ,sanc1_rein_date
					// ,kil_code
					// ,provider_id
					// ,medschool1
					// ,LOCAL);
		
		// MPRD.Layouts.choice_point_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			// SELF.date_first_seen            := (STRING) ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			// SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			// SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			// SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			// SELF.did := 0;
			// SELF.	source_rec_id              := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			// SELF						 							   := IF(Le.record_type = 'C', Le, Ri);
		// END;

		// base_f := rollup(new_base_s,	
								// LEFT.full_name						= RIGHT.full_name
						// AND LEFT.pre_name							= RIGHT.pre_name
						// AND LEFT.first_name						= RIGHT.first_name
						// AND LEFT.middle_name					= RIGHT.middle_name
						// AND LEFT.last_name						= RIGHT.last_name
						// AND LEFT.maturity_suffix			= RIGHT.maturity_suffix
						// AND LEFT.other_suffix					= RIGHT.other_suffix
						// AND LEFT.gender								= RIGHT.gender
						// AND LEFT.prac_company1_name		= RIGHT.prac_company1_name
						// AND LEFT.birthdate						= RIGHT.birthdate
						// AND LEFT.hashed_ssn						= RIGHT.hashed_ssn
						// AND LEFT.prac_phone1					= RIGHT.prac_phone1
						// AND LEFT.prac_fax1						= RIGHT.prac_fax1
						// AND LEFT.email_addr						= RIGHT.email_addr
						// AND LEFT.web_site							= RIGHT.web_site
						// AND LEFT.upin									= RIGHT.upin
						// AND LEFT.tin1									= RIGHT.tin1
						// AND LEFT.filecode							= RIGHT.filecode
						// AND LEFT.specialty1						= RIGHT.specialty1
						// AND LEFT.specialty2						= RIGHT.specialty2
						// AND LEFT.lic1_num_in					= RIGHT.lic1_num_in
						// AND LEFT.lic1_num							= RIGHT.lic1_num
						// AND LEFT.lic1_st							= RIGHT.lic1_st
						// AND LEFT.Lic1_Type						= RIGHT.Lic1_Type
						// AND LEFT.Lic1_Status					= RIGHT.Lic1_Status
						// AND LEFT.Lic1_begin_date			= RIGHT.Lic1_begin_date
						// AND LEFT.Lic1_End_date				= RIGHT.Lic1_End_date
						// AND LEFT.orig_adresss					= RIGHT.orig_adresss
						// AND LEFT.orig_state						= RIGHT.orig_state
						// AND LEFT.orig_city						= RIGHT.orig_city
						// AND LEFT.orig_zip							= RIGHT.orig_zip
						// AND LEFT.npi_num							= RIGHT.npi_num
						// AND LEFT.taxonomy							= RIGHT.taxonomy
						// AND LEFT.dea_num1							= RIGHT.dea_num1
						// AND LEFT.dea_num1_exp					= RIGHT.dea_num1_exp
						// AND LEFT.Dea_num1_bus_Act_Ind	= RIGHT.Dea_num1_bus_Act_Ind
						// AND LEFT.sanc1_date						= RIGHT.sanc1_date
						// AND LEFT.sanc1_state					= RIGHT.sanc1_state
						// AND LEFT.sanc1_rein_date			= RIGHT.sanc1_rein_date
						// AND LEFT.kil_code							= RIGHT.kil_code
						// AND LEFT.provider_id					= RIGHT.provider_id
						// AND LEFT.medschool1						= RIGHT.medschool1
						// AND LEFT.isTest								= RIGHT.isTest
						// ,t_rollup(LEFT, RIGHT),LOCAL);

		// DID
		// matchset := ['A','Z','P'];
		// did_add.MAC_Match_Flex
			// (base_f, matchset,					
			// foo,foo1,first_name, middle_name, last_name, pre_name, 
			// clean_prim_range, clean_prim_name, clean_sec_range, clean_zip4, clean_st,clean_prac1_Phone, 
			// DID, mprd.layouts.choice_point_base , true, did_score,
			// 75, d_did);

		// bdid_matchset := ['A'];
		// Business_Header_SS.MAC_Add_BDID_Flex
			// (d_did
			// ,bdid_matchset
			// ,full_name
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_zip4
			// ,clean_sec_range
			// ,clean_st
			// ,''
			// ,foo
			// ,bdid
			// ,mprd.layouts.choice_point_base 
			// ,true
			// ,bdid_score
			// ,d_bdid
			// ,
			// ,
			// ,
			// ,BIPV2.xlink_version_set
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,src
			// ,
			// ,
			// );
			
		// Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// d_bdid
			// ,LNPID
			// ,first_name
			// ,middle_name
			// ,last_name
			// ,maturity_suffix
			// ,//GENDER
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_sec_range
			// ,clean_v_city_name
			// ,clean_st
			// ,clean_zip
			// ,//SSN
			// ,//DOB
			// ,clean_prac1_phone
			// ,lic1_state
			// ,lic1_num
			// ,tin1
			// ,dea_num1
			// ,group_key
			// ,
			// ,upin
			// ,did
			// ,bdid
			// ,//,SRC
			// ,//SOURCE_RID
			// ,result,false,38);
			
			// RETURN result;
	// END;

	// EXPORT basc_claim_base:=FUNCTION
		// base_file := Mark_history(MPRD.Files(filedate,pUseProd).basc_claims_base.built(isTest = false), MPRD.layouts.basc_claims_base);

		// std_input := MPRD.StandardizeInputFile(filedate, pUseProd).basc_claims;
				
	 	// cleanNames 	:= Clean_name(std_input, MPRD.Layouts.basc_claims_base):PERSIST('~thor_data400::persist::mprd::basc_claims_names');																			
		
		// cleanAdd_t	:= Clean_addr(cleanNames, MPRD.Layouts.basc_claims_base):PERSIST('~thor_data400::persist::cleaned_practice_addr_claims');
	
		// base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).basc_claims_lBaseTemplate_built )) = 0
								        // ,cleanAdd_t,cleanAdd_t + base_file);
																						
		// MPRD.Layouts.basc_claims_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   			// SELF.source_rec_id 					:= HASH64(hashmd5(
																			// TRIM(l.full_name)+','
																			// +TRIM(l.pre_name)+','
																			// +TRIM(l.first_name)+','
																			// +TRIM(l.middle_name)+','
																			// +TRIM(l.last_name)+','
																			// +TRIM(l.maturity_suffix)+','
																			// +TRIM(l.other_suffix)+','
																			// +TRIM(l.gender)+','
																			// +TRIM(l.preferred_name)+','
																			// +TRIM(l.prac_company1_name)+','
																			// +TRIM(l.normed_addr_rec_type)+','
																			// +TRIM(l.orig_adresss)+','
			                                // +TRIM(l.orig_state)+','
																			// +TRIM(l.orig_city)+','
																			// +TRIM(l.orig_zip)+','
																			// +TRIM(l.prac_phone1)+','
																			// +TRIM(l.prac_fax1)+','
																			// +TRIM(l.bill_phone1)+','
																			// +TRIM(l.bill_fax1)+','
																			// +TRIM(l.upin)+','
																			// +TRIM(l.tin1)+','
																			// +TRIM(l.lic1_num_in)+','
																			// +TRIM(l.lic1_state)+','
																			// +TRIM(l.lic1_num)+','
																			// +TRIM(l.lic1_type)+','
																			// +TRIM(l.lic1_status)+','
																			// +TRIM(l.lic1_begin_date)+','
																			// +TRIM(l.lic1_end_date)+','
																			// +TRIM(l.filecode)+','
												  						// +TRIM(l.npi_num)+','
																			// +TRIM(l.taxonomy)+','
																			// +TRIM(l.taxonomy_primary_ind)+','
																			// +TRIM(l.male_female)+','
																			// +TRIM(l.npi_deact_date)));
   		// SELF											:= L;
   	// END;
   			
		// d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));
													
		// new_base_d := DISTRIBUTE(d_rid, HASH(TRIM(first_name),TRIM(middle_name),TRIM(last_name),orig_adresss,orig_state,orig_city,orig_zip));  
		// new_base_s := SORT(new_base_d,
	                     // full_name,
											 // pre_name,
											 // first_name,
											 // middle_name,
											 // last_name,
											 // maturity_suffix,
											 // other_suffix,
											 // gender,
											 // preferred_name,
											 // prac_company1_name,
											 // normed_addr_rec_type,
											 // orig_adresss,
											 // orig_state,
											 // orig_city,
											 // orig_zip,
											 // prac_phone1,
											 // prac_fax1,
											 // bill_phone1,
											 // bill_fax1,
											 // upin,
											 // tin1,
											 // lic1_num_in,
											 // lic1_state,
											 // lic1_num,
											 // lic1_type,
											 // lic1_status,
											 // lic1_begin_date,
											 // lic1_end_date,
											 // filecode,
											 // npi_num,
											 // taxonomy,
											 // taxonomy_primary_ind,
											 // male_female,
											 // npi_deact_date, LOCAL);
		
		// MPRD.Layouts.basc_claims_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			// SELF.date_first_seen            := (STRING) ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			// SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			// SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			// SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			// SELF.	source_rec_id             := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			// SELF						 							  := IF(Le.record_type = 'C', Le, Ri);
		// END;

		// base_f := rollup(new_base_s,
								// LEFT.full_name						= RIGHT.full_name
            // AND LEFT.pre_name 						= RIGHT.pre_name
						// AND LEFT.first_name 					= RIGHT.first_name 
						// and	LEFT.middle_name 					= RIGHT.middle_name 
						// and	LEFT.last_name 						= RIGHT.last_name 
						// and	LEFT.maturity_suffix 			= RIGHT.maturity_suffix 
						// and	LEFT.other_suffix 				= RIGHT.other_suffix 
						// AND LEFT.gender								= RIGHT.gender
						// AND LEFT.preferred_name 			= RIGHT.preferred_name
						// AND LEFT.prac_company1_name		= RIGHT.prac_company1_name
						// AND LEFT.normed_addr_rec_type	= RIGHT.normed_addr_rec_type
						// AND LEFT.orig_adresss					= RIGHT.orig_adresss
						// AND LEFT.orig_state						= RIGHT.orig_state
						// AND LEFT.orig_city						= RIGHT.orig_city
						// AND LEFT.orig_zip							= RIGHT.orig_zip
						// AND LEFT.prac_phone1					= RIGHT.prac_phone1
						// AND LEFT.prac_fax1						= RIGHT.prac_fax1
						// AND LEFT.bill_phone1					= RIGHT.bill_phone1
						// AND LEFT.bill_fax1						= RIGHT.bill_fax1
						// AND LEFT.upin									= RIGHT.upin
						// AND LEFT.tin1									= RIGHT.tin1
						// AND LEFT.lic1_num_in					= RIGHT.lic1_num_in
						// AND LEFT.lic1_state						= RIGHT.lic1_state
						// AND LEFT.lic1_num							= RIGHT.lic1_num
						// AND LEFT.Lic1_Type						= RIGHT.Lic1_Type
						// AND LEFT.Lic1_Status					= RIGHT.Lic1_Status
						// AND LEFT.Lic1_begin_date			= RIGHT.Lic1_begin_date
						// AND LEFT.Lic1_End_date				= RIGHT.Lic1_End_date
						// AND LEFT.filecode							= RIGHT.filecode
						// AND LEFT.npi_num							= RIGHT.npi_num
						// AND LEFT.taxonomy							= RIGHT.taxonomy
						// AND LEFT.taxonomy_primary_ind	= RIGHT.taxonomy_primary_ind
            // AND LEFT.male_female 					= RIGHT.male_female
						// AND LEFT.npi_deact_date 			= RIGHT.npi_deact_date
						// AND LEFT.isTest								= RIGHT.isTest
						// ,t_rollup(LEFT, RIGHT),LOCAL);
	// DID
		// matchset := ['A','Z','P'];
		// did_add.MAC_Match_Flex
			// (base_f, matchset,					
			// foo,foo1,first_name, middle_name, last_name, pre_name, 
			// clean_prim_range, clean_prim_name, clean_sec_range, clean_zip, clean_st,prac_phone1, 
			// DID, mprd.Layouts.basc_claims_base, true, did_score,75, d_did);

		// bdid_matchset := ['A'];
		// Business_Header_SS.MAC_Add_BDID_Flex
			// (d_did
			// ,bdid_matchset
			// ,full_name
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_zip
			// ,clean_sec_range
			// ,clean_st
			// ,''
			// ,foo
			// ,bdid
			// ,mprd.Layouts.basc_claims_base
			// ,true
			// ,bdid_score
			// ,d_bdid
			// ,
			// ,
			// ,
			// ,BIPV2.xlink_version_set
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,src
			// ,
			// ,
		// );

		// Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// d_bdid
			// ,lnpid
			// ,first_name
			// ,middle_name
			// ,last_name
			// ,maturity_suffix
			// ,//GENDER
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_sec_range
			// ,clean_v_city_name
			// ,clean_st
			// ,clean_zip
			// ,//SSN
			// ,//DOB
			// ,clean_prac_phone1
			// ,lic1_state
			// ,lic1_num
			// ,tin1
			// ,//DEA_NUM1
			// ,//group_key
			// ,//
			// ,upin
			// ,did
			// ,bdid
			// ,//SRC
			// ,//SOURCE_RID
			// ,result,false,38);

		// RETURN result;
	// END;

	// EXPORT claims_address_master_base:=FUNCTION
		// base_file := Mark_history(MPRD.Files(filedate,pUseProd).claims_addr_master_base.built(isTest = false), MPRD.layouts.claims_address_master_base);

		// std_input := MPRD.StandardizeInputFile(filedate, pUseProd).claims_address_master;
				
		// cleanAdd_t	:= Clean_addr(std_input, MPRD.layouts.claims_address_master_base):PERSIST('~thor_data400::persist::cleaned_practice_addr_claims_addr_master');
	
		// base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).claims_addr_master_lBaseTemplate_built)) = 0
								       // ,cleanAdd_t,cleanAdd_t + base_file);
											 
		// MPRD.Layouts.claims_address_master_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   			// SELF.source_rec_id 					:= HASH64(hashmd5(
   																	 // TRIM(l.service_company)+','
                                     // +TRIM(l.bill_npi)+','
																		 // +TRIM(l.orig_adresss)+','
																		 // +TRIM(l.orig_state)+','
																		 // +TRIM(l.orig_city)+','
																		 // +TRIM(l.orig_zip)+','
																		 // +TRIM(l.bill_tin)+','
																		 // + TRIM(l.rendering_npi)));
   		// SELF											:= L;
   	// END;
   			
		// d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));

		// new_base_d := DISTRIBUTE(d_rid, HASH(service_company,orig_adresss,orig_city,orig_state,orig_zip));  
		// new_base_s := SORT(new_base_d
	                   // ,service_company
	                   // ,bill_npi
	                   // ,orig_adresss
										 // ,orig_state
										 // ,orig_city
										 // ,orig_zip
										 // ,bill_tin
										 // ,rendering_npi
										  // ,LOCAL);
		
		// MPRD.Layouts.claims_address_master_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			// SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			// SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			// SELF.	source_rec_id             := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);	
			// SELF						 							  := IF(Le.record_type = 'C', Le, Ri);
		// END;

		// base_f := rollup(new_base_s,
								// LEFT.service_company	= RIGHT.service_company 
						// AND LEFT.bill_npi					= RIGHT.bill_npi
		        // AND LEFT.bill_tin 				= RIGHT.bill_tin
						// AND LEFT.orig_adresss			= RIGHT.orig_adresss
						// AND LEFT.orig_state				= RIGHT.orig_state
						// AND LEFT.orig_city				= RIGHT.orig_city
						// AND LEFT.orig_zip					= RIGHT.orig_zip
						// AND LEFT.bill_tin					= RIGHT.bill_tin
            // AND LEFT.rendering_npi		= RIGHT.rendering_npi
						// AND LEFT.isTest						= RIGHT.isTest
						// ,t_rollup(LEFT, RIGHT),LOCAL);
		// bdid_matchset := ['A'];
		// Business_Header_SS.MAC_Add_BDID_Flex
			// (base_f
			// ,bdid_matchset
			// ,service_company
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_zip
			// ,clean_sec_range
			// ,clean_st
			// ,''
			// ,foo
			// ,bdid
			// ,mprd.Layouts.claims_address_master_base
			// ,true
			// ,bdid_score
			// ,d_bdid
			// ,
			// ,
			// ,
			// ,BIPV2.xlink_version_set
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,
			// ,src
			// ,//source_rid
			// ,
		// );

		// Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// d_bdid
			// ,lnpid
			// ,//First_name
			// ,//Middle_name
			// ,//Last_NAME
			// ,//maturity_suffix
			// ,//GENDER
			// ,clean_prim_range
			// ,clean_prim_name
			// ,clean_sec_range
			// ,clean_v_city_name
			// ,clean_st
			// ,clean_zip
			// ,//SSN
			// ,//DOB
			// ,//clean_prac_phone1
			// ,//LIC1_STATE
			// ,//LIC1_num
			// ,bill_tin
			// ,//DEA_NUM1
			// ,//group_key
			// ,//
			// ,//UPIN
			// ,did
			// ,bdid
			// ,//SRC
			// ,//SOURCE_RID
			// ,result,false,38);

		// RETURN result;
	// END;	

	// EXPORT npi_extension_base:=FUNCTION
		// base_file := Mark_history(MPRD.Files(filedate,pUseProd).npi_extension_base.built(isTest = false), MPRD.layouts.npi_extension_base);

		// std_input := MPRD.StandardizeInputFile(filedate, pUseProd).npi_extension;
			 
		// cleanNames := Clean_name(std_input, MPRD.Layouts.npi_extension_base):PERSIST('~thor_data400::persist::mprd::npi_extension_names');
																		
		// base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).npi_extension_lBaseTemplate_built)) = 0
								       // ,cleanNames,cleanNames + base_file);
											 
		// MPRD.Layouts.npi_extension_base  GetSourceRID(base_and_update L)	:= TRANSFORM
			// SELF.source_rec_id 					:= HASH64(hashmd5(
   																	// TRIM(l.npi_num)
																		// ,TRIM(l.other_first_name)
																		// ,TRIM(l.other_middle_name)
																		// ,TRIM(l.other_last_name)
																		// ,TRIM(l.authorized_first_name)
																		// ,TRIM(l.authorized_middle_name)
																		// ,TRIM(l.authorized_middle_name)
																		// ,TRIM(l.taxonomy)));
			// SELF											:= L;
		// END;
   			
		// d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));
		// new_base_s := SORT(DISTRIBUTE(d_rid,HASH(npi_num))
									// ,other_first_name
									// ,other_middle_name
									// ,other_last_name
									// ,authorized_first_name
									// ,authorized_middle_name
									// ,authorized_last_name
									// ,npi_num
									// ,taxonomy
									// ,LOCAL);
														
		// MPRD.Layouts.npi_extension_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			// SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			// SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			// SELF.	source_rec_id             := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);	
			// SELF 														:= le;
		// END;

		// base_f := rollup(new_base_s,
								// LEFT.other_first_name				= RIGHT.other_first_name
						// AND LEFT.other_middle_name 			= RIGHT.other_middle_name
						// AND LEFT.other_last_name				= RIGHT.other_last_name
						// AND LEFT.authorized_first_name	= RIGHT.authorized_first_name
            // AND LEFT.authorized_middle_name = RIGHT.authorized_middle_name
						// AND LEFT.authorized_middle_name	= RIGHT.authorized_last_name
						// AND LEFT.npi_num 								= RIGHT.npi_num
						// AND LEFT.taxonomy								= RIGHT.taxonomy
						// AND LEFT.isTest									= RIGHT.isTest
						// ,t_rollup(LEFT, RIGHT),LOCAL);
						
		// Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// base_f
			// ,lnpid
			// ,other_first_name//authorized_first_name
			// ,other_middle_name//authorized_middle_name
			// ,other_last_name//authorized_last_name
			// ,other_maturity_suffix//authorized_maturity_suffix
			// ,other_gender//GENDER
			// ,//clean_prim_range
			// ,//clean_prim_name
			// ,//clean_sec_range
			// ,//clean_v_city_name
			// ,//clean_ST
			// ,//clean_ZIP
			// ,//SSN
			// ,//DOB
			// ,//clean_prac_phone1
			// ,LIC1_STATE
			// ,LIC1_num
			// ,npi_num
			// ,//DEA_NUM1
			// ,//group_key
			// ,//
			// ,//UPIN
			// ,did
			// ,bdid
			// ,//SRC
			// ,//SOURCE_RID
			// ,result,false,38);

		// RETURN result;
	// END;	
	
	// EXPORT npi_extension_facility_base:=FUNCTION
		// base_file := Mark_history(MPRD.Files(filedate,pUseProd).npi_extension_facility_base.built(isTest = false), MPRD.layouts.npi_extension_facility_base);

		// std_input := MPRD.StandardizeInputFile(filedate, pUseProd).npi_extension_facility;
		
		// cleanNames := Clean_name(std_input, MPRD.Layouts.npi_extension_facility_base):PERSIST('~thor_data400::persist::mprd::npi_extension_facility_names');
		// base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).npi_extension_facility_lBaseTemplate_built)) = 0
								       // ,cleanNames,cleanNames + base_file);
											 
		// MPRD.Layouts.npi_extension_facility_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   		// SELF.source_rec_id 					:= HASH64(hashmd5(
   																	// TRIM(l.npi_num)
																		// ,TRIM(l.other_first_name)
																		// ,TRIM(l.other_middle_name)
																		// ,TRIM(l.other_last_name)
																		// ,TRIM(l.authorized_first_name)
																		// ,TRIM(l.authorized_middle_name)
																		// ,TRIM(l.authorized_middle_name)
																		// ,TRIM(l.taxonomy)));
   		// SELF											:= L;
   	// END;
   			
		// d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));											 
		// new_base_s := SORT(DISTRIBUTE(d_rid,HASH(npi_num))
									// ,other_first_name
									// ,other_middle_name
									// ,other_last_name
									// ,authorized_first_name
									// ,authorized_middle_name
									// ,authorized_last_name
									// ,npi_num
									// ,taxonomy
									// ,LOCAL);
		
		// MPRD.Layouts.npi_extension_facility_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			// SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			// SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			// SELF.source_rec_id	            := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);	
			// SELF 														:= le;
		// END;

		// base_f := rollup(new_base_s,
								// LEFT.other_first_name				= RIGHT.other_first_name
						// AND LEFT.other_middle_name 			= RIGHT.other_middle_name
						// AND LEFT.other_last_name				= RIGHT.other_last_name
						// AND LEFT.authorized_first_name	= RIGHT.authorized_first_name
            // AND LEFT.authorized_middle_name	= RIGHT.authorized_middle_name
						// AND LEFT.authorized_middle_name	= RIGHT.authorized_last_name
						// AND LEFT.npi_num 								= RIGHT.npi_num
						// AND LEFT.taxonomy								= RIGHT.taxonomy
						// AND LEFT.isTest									= RIGHT.isTest
						// ,t_rollup(LEFT, RIGHT),LOCAL);

		// Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// base_f
			// ,lnpid
			// ,authorized_first_name
			// ,authorized_middle_name
			// ,authorized_last_name
			// ,authorized_maturity_suffix
			// ,//GENDER
			// ,//clean_prim_range
			// ,//clean_prim_name
			// ,//clean_sec_range
			// ,//clean_v_city_name
			// ,//clean_ST
			// ,//clean_ZIP
			// ,//SSN
			// ,//DOB
			// ,//clean_prac_phone1
			// ,LIC1_STATE
			// ,LIC1_num
			// ,npi_num
			// ,//DEA_NUM1
			// ,//group_key
			// ,//
			// ,//UPIN
			// ,did
			// ,bdid
			// ,//SRC
			// ,//SOURCE_RID
			// ,result,false,38);

		// RETURN result;
	// END;	

 EXPORT taxonomy_equiv_base := FUNCTION
    
		taxonomy_equiv_input := MPRD.Files(filedate,pUseProd).taxonomy_equiv_file;
        
		mprd.layouts.taxonomy_equiv_base tMapping(MPRD.layouts.taxonomy_equiv_in L) := TRANSFORM
			SELF  :=  L;
    END;
        
    std_input :=PROJECT(taxonomy_equiv_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    RETURN new_base_d;
	END;
	 
	EXPORT claims_by_month_base := FUNCTION
    
		claims_by_month_input := MPRD.Files(filedate,pUseProd).claims_by_month_file;
        
		mprd.layouts.claims_by_month_base tMapping(MPRD.layouts.claims_by_month_in L) := TRANSFORM
			SELF  			:=  L;
		END;
		
		std_input :=PROJECT(claims_by_month_input, tMapping(LEFT));
		new_base_d := DEDUP(std_input, RECORD, ALL);
		RETURN new_base_d;
	END;
	
	 EXPORT npi_tin_xref_base := FUNCTION
		npi_tin_xref_input := MPRD.Files(filedate,pUseProd).npi_tin_xref_file;
		
		mprd.layouts.npi_tin_xref_base tMapping(MPRD.layouts.npi_tin_xref_in L) := TRANSFORM
			SELF  			:= L;
		END;				
	
		std_input :=PROJECT(npi_tin_xref_input, tMapping(LEFT));
		new_base_d := DEDUP(std_input, RECORD, ALL);
		RETURN new_base_d;
	END;
	
  EXPORT basc_deceased_base:=FUNCTION

  	base_file := Mark_history(MPRD.Files(filedate,pUseProd).basc_deceased_base.built(isTest = false), MPRD.layouts.basc_deceased_base);

		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).basc_deceased;
		
		cleanNames := Clean_name(std_input, MPRD.Layouts.basc_deceased_base):PERSIST('~thor_data400::persist::mprd::basc_deceased_names');

		base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).basc_deceased_lBaseTemplate_built)) = 0
								 ,cleanNames,cleanNames + base_file);
								 
		MPRD.layouts.basc_deceased_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   		SELF.source_rec_id 					:= HASH64(hashmd5(
   																	TRIM(l.full_name)+','
   																	+TRIM(l.pre_name)+','
   																	+TRIM(l.first_name)+','
   																	+TRIM(l.middle_name)+','
   																	+TRIM(l.last_name)+','
   																	+TRIM(l.maturity_suffix)+','
   																	+TRIM(l.other_suffix)+','
																		+TRIM(l.birthdate)+','
   																	+TRIM(l.date_of_death)+','
   																	+TRIM(l.gender)));
   		SELF											:= L;
   	END;
   			
		d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));								 

		new_base_d := DISTRIBUTE(d_rid, HASH( TRIM(first_name),TRIM(middle_name),TRIM(last_name)));  
		new_base_s := SORT(new_base_d,
					full_name,
					pre_name,
					first_name,
					middle_name,
					last_name,
					maturity_suffix,
					other_suffix,
					birthdate,
					date_of_death, 
					gender,
					LOCAL);
		
		MPRD.Layouts.basc_deceased_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			SELF.date_first_seen            := (STRING)ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			SELF.did 												:= 0;
			SELF.source_rec_id    	        := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			SELF 														:= le;
		END;

		base_f := rollup(new_base_s,
								LEFT.full_name				=	RIGHT.full_name
						AND LEFT.pre_name					=	RIGHT.pre_name
						AND LEFT.first_name 			= RIGHT.first_name 
						and	LEFT.middle_name 			= RIGHT.middle_name 
						and	LEFT.last_name 				= RIGHT.last_name 
						AND LEFT.birthdate				=	RIGHT.birthdate
						AND LEFT.date_of_death		=	RIGHT.date_of_death
						AND LEFT.gender						=	RIGHT.gender
						AND LEFT.isTest						= RIGHT.isTest
						,t_rollup(LEFT, RIGHT),LOCAL);
			
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			base_f
			,lnpid
			,first_name
			,middle_name
			,last_name
			,maturity_suffix
			,gender
			,//clean_prim_range
			,//clean_prim_name
			,//clean_sec_range
			,//clean_v_city_name
			,//clean_ST
			,//clean_ZIP
			,//SSN
			,clean_birthdate
			,//clean_prac_phone1
			,//LIC1_STATE
			,//LIC1_num
			,//tin1
			,//DEA_NUM1
			,group_key
			,
			,//UPIN
			,//DID
			,//BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38);

		RETURN result;
	END;

	EXPORT basc_addr_base:=FUNCTION

  	base_file := Mark_history(MPRD.Files(filedate,pUseProd).basc_addr_base.built, MPRD.layouts.basc_addr_base);

		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).basc_addr;
																		
		cleanAdd_t	:= Clean_addr(std_input,  MPRD.layouts.basc_addr_base):PERSIST('~thor_data400::persist::cleaned_practice_addr_basc_addr');
	
		base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).basc_addr_lBaseTemplate_built)) = 0
								 ,cleanAdd_t,cleanAdd_t + base_file);
 
		MPRD.layouts.basc_addr_base GetSourceRID(base_and_update l):=TRANSFORM
			SELF.source_rec_id		:= HASH64(hashmd5(
																	     TRIM(l.prac_company1_name)+','
																				+TRIM(l.prac_phone1)+','
																				+TRIM(l.bill_phone1)+','
																				+TRIM(l.prac_fax1)+','
																				+TRIM(l.bill_fax1)+','
																				+TRIM(l.email_addr)+','
																				+TRIM(l.web_site)+','
																				+TRIM(l.tin1)+','
																				+TRIM(l.dea_num1)+','
																				+TRIM(l.dea_num1_exp)+','	
   		                                  +TRIM(l.dea_num1_sch)+','	
   		                                  +TRIM(l.dea_num1_bus_act_ind)+','
																				+TRIM(l.lic1_num_in)+','
																			  +TRIM(l.lic1_state)+','
																			  +TRIM(l.lic1_num)+','
																			  +TRIM(l.lic1_type)+','
																			  +TRIM(l.lic1_status)+','
																			  +TRIM(l.lic1_begin_date)+','
																			  +TRIM(l.lic1_end_date)+','
																			  +TRIM(l.lic2_num_in)+','
																			  +TRIM(l.lic2_state)+','
																			  +TRIM(l.lic2_num)+','
																			  +TRIM(l.lic2_type)+','
																			  +TRIM(l.lic2_status)+','
																			  +TRIM(l.lic2_begin_date)+','
																			  +TRIM(l.lic2_end_date) +','
																			  +TRIM(l.lic3_num_in)+','
																			  +TRIM(l.lic3_state)+','
																			  +TRIM(l.lic3_num)+','
																			  +TRIM(l.lic3_type)+','
																			  +TRIM(l.lic3_status)+','
																			  +TRIM(l.lic3_begin_date)+','
																			  +TRIM(l.lic3_end_date)+','
																			  +TRIM(l.normed_addr_rec_type)+','
																			  +TRIM(l.orig_adresss)+','
																			  +TRIM(l.orig_state)+','
																			  +TRIM(l.orig_city)+','
																			  +TRIM(l.orig_zip)+','
																				+TRIM(l.filecode)+','
																				+TRIM(l.dept_code)+','
																				+TRIM(l.provider_id)+','
																				+TRIM(l.npi_num)+','
																				+TRIM(l.medicare_fac_num)+','
																				+TRIM(l.medicaid_fac_num)+','
																				+TRIM(l.facility_type)+','
																				+TRIM(l.taxonomy)+','
																				+TRIM(l.sanc1_state)+','
																				+TRIM(l.sanc1_date)+','
				                                +TRIM(l.sanc1_case)+','	
   		                                  +TRIM(l.sanc1_source)+','	
																				+TRIM(l.sanc1_complaint)+','	   
 																			  +TRIM(l.dba_name)+','	
																				+TRIM(l.bill_company1_name)+','	
																				+TRIM(l.taxonomy_primary_ind)+','	   	
																				+TRIM(l.dea_num1_deact_date)+','	
																				+TRIM(l.npi_deact_date)+','	
																				+TRIM(l.sanc1_rein_date)+','	
																				+TRIM(l.clia_num)+','	
																				+TRIM(l.clia_status_code)+','	
																				+TRIM(l.clia_cert_type_code)+','	
																				+TRIM(l.clia_cert_eff_date)+','	
																				+TRIM(l.clia_end_date)));
			SELF											:= L;
		END;											

		d_rid	:= PROJECT(base_and_update, GetSourceRID(LEFT));								 

		new_base_d := DISTRIBUTE(d_rid, HASH( prac_company1_name,orig_adresss, orig_state,orig_city,orig_zip));  
		new_base_s := SORT(new_base_d,
											prac_company1_name,
											prac_phone1,
											bill_phone1,
											prac_fax1,
											bill_fax1,
											email_addr,
											web_site,
											tin1,
											dea_num1,
											dea_num1_exp,
											dea_num1_sch,
											dea_num1_bus_act_ind,
											lic1_num_in,
											lic1_state,
											lic1_num,
											lic1_type,
											lic1_status,
											lic1_begin_date,
											lic1_end_date,
											lic2_num_in,
											lic2_state,
											lic2_num,
											lic2_type,
											lic2_status,
											lic2_begin_date,
											lic2_end_date,
											lic3_num_in,
											lic3_state,
											lic3_num,
											lic3_type,
											lic3_status,
											lic3_begin_date,
											lic3_end_date,
											normed_addr_rec_type,
											orig_adresss,
											orig_state,
											orig_city,
											orig_zip,
											filecode,
											dept_code,
											provider_id,
											npi_num,
											medicare_fac_num,
											medicare_fac_num_term_date,
											medicaid_fac_num,
											facility_type,
											taxonomy,
											sanc1_state,
											sanc1_date,
											sanc1_case,
											sanc1_source,
											sanc1_complaint, 
										  dba_name,
											bill_company1_name,
											taxonomy_primary_ind, 
											dea_num1_deact_date,
											npi_deact_date,
											sanc1_rein_date,
											clia_num,
											clia_status_code,
											clia_cert_type_code,
											clia_cert_eff_date,
											clia_end_date,
											clia_test_vol_accredited,
											clia_test_vol_annual,
											clia_test_vol_ppm,
											clia_test_vol_survey,
											clia_test_vol_waived
										,LOCAL);
		
		MPRD.Layouts.basc_addr_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			SELF.date_first_seen            := (STRING) ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			SELF.source_rec_id              := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			SELF						 							  := IF(Le.record_type = 'C', Le, Ri);
		END;

		base_f := rollup(new_base_s,
								LEFT.prac_company1_name		=	RIGHT.prac_company1_name
						AND LEFT.prac_phone1					=	RIGHT.prac_phone1
						AND LEFT.bill_phone1					=	RIGHT.bill_phone1
						AND LEFT.prac_fax1						=	RIGHT.prac_fax1
						AND LEFT.bill_fax1						=	RIGHT.bill_fax1
						AND LEFT.email_addr						=	RIGHT.email_addr
						AND LEFT.web_site							=	RIGHT.web_site
						AND LEFT.tin1									=	RIGHT.tin1
						AND LEFT.dea_num1							=	RIGHT.dea_num1
						AND LEFT.dea_num1_exp					=	RIGHT.dea_num1_exp
						AND LEFT.dea_num1_sch					=	RIGHT.dea_num1_sch
						AND LEFT.dea_num1_bus_act_ind =	RIGHT.dea_num1_bus_act_ind
						AND LEFT.lic1_num_in 					=	RIGHT.lic1_num_in
            AND LEFT.lic1_state						=	RIGHT.lic1_state					  
						AND LEFT.lic1_num							=	RIGHT.lic1_num
						AND LEFT.Lic1_Type						=	RIGHT.Lic1_Type
						AND LEFT.lic1_status					=	RIGHT.lic1_status
            AND LEFT.Lic1_begin_date			=	RIGHT.Lic1_begin_date
            AND LEFT.Lic1_End_date				=	RIGHT.Lic1_End_date
						AND LEFT.lic2_num_in 					=	RIGHT.lic2_num_in
            AND LEFT.lic2_state						=	RIGHT.lic2_state					  
						AND LEFT.lic2_num							=	RIGHT.lic2_num
						AND LEFT.Lic2_Type						=	RIGHT.Lic2_Type
						AND LEFT.lic2_status					=	RIGHT.lic2_status
            AND LEFT.Lic2_begin_date			=	RIGHT.Lic2_begin_date
            AND LEFT.Lic2_End_date				=	RIGHT.Lic2_End_date
						AND LEFT.lic3_num_in 					=	RIGHT.lic3_num_in
            AND LEFT.lic3_state						=	RIGHT.lic3_state					  
						AND LEFT.lic3_num							=	RIGHT.lic3_num
						AND LEFT.Lic3_Type						=	RIGHT.Lic3_Type
						AND LEFT.lic3_status					=	RIGHT.lic3_status
            AND LEFT.Lic3_begin_date			=	RIGHT.Lic3_begin_date
            AND LEFT.Lic3_End_date				=	RIGHT.Lic3_End_date
						AND LEFT.normed_addr_rec_type	=	RIGHT.normed_addr_rec_type
						AND LEFT.orig_adresss					=	RIGHT.orig_adresss
						AND LEFT.orig_state						=	RIGHT.orig_state
						AND LEFT.orig_city						=	RIGHT.orig_city
						AND LEFT.orig_zip							=	RIGHT.orig_zip
						AND LEFT.filecode							=	RIGHT.filecode
						AND LEFT.dept_code						=	RIGHT.dept_code
						AND LEFT.provider_id					=	RIGHT.provider_id
						AND LEFT.npi_num							=	RIGHT.npi_num
						AND LEFT.medicare_fac_num			=	RIGHT.medicare_fac_num
						AND LEFT.medicare_fac_num_term_date = RIGHT.medicare_fac_num_term_date
						AND LEFT.medicaid_fac_num			=	RIGHT.medicaid_fac_num
						AND LEFT.facility_type				=	RIGHT.facility_type
						AND LEFT.taxonomy							=	RIGHT.taxonomy
						AND LEFT.sanc1_state					=	RIGHT.sanc1_state
						AND LEFT.sanc1_date						=	RIGHT.sanc1_date
            AND LEFT.sanc1_case						=	RIGHT.sanc1_case
            AND LEFT.sanc1_source					=	RIGHT.sanc1_source
						AND LEFT.sanc1_complaint 			=	RIGHT.sanc1_complaint
						AND LEFT.dba_name							=	RIGHT.dba_name
						AND LEFT.bill_company1_name		=	RIGHT.bill_company1_name
						AND LEFT.taxonomy_primary_ind	=	RIGHT.taxonomy_primary_ind 
						AND LEFT.dea_num1_deact_date	=	RIGHT.dea_num1_deact_date
						AND LEFT.npi_deact_date				=	RIGHT.npi_deact_date
						AND LEFT.sanc1_rein_date			=	RIGHT.sanc1_rein_date						
						AND LEFT.clia_num							=	RIGHT.clia_num
						AND LEFT.clia_status_code			=	RIGHT.clia_status_code
						AND LEFT.clia_cert_type_code	=	RIGHT.clia_cert_type_code
						AND LEFT.clia_cert_eff_date		=	RIGHT.clia_cert_eff_date
						AND LEFT.clia_end_date				=	RIGHT.clia_end_date
						AND LEFT.clia_test_vol_accredited = RIGHT.clia_test_vol_accredited
						AND LEFT.clia_test_vol_annual	= RIGHT.clia_test_vol_annual
						AND LEFT.clia_test_vol_ppm		= RIGHT.clia_test_vol_ppm
						AND LEFT.clia_test_vol_survey = RIGHT.clia_test_vol_survey
						AND LEFT.clia_test_vol_waived = RIGHT.clia_test_vol_waived
						,t_rollup(LEFT, RIGHT),LOCAL);

		bdid_matchset := ['A','P'];
	  Business_Header_SS.MAC_Add_BDID_Flex
			(base_f
			,bdid_matchset
			,prac_company1_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,clean_phone
			,foo
			,bdid
			,mprd.layouts.basc_addr_base
			,true
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,
			,
			,
			,
			,
			,src
			,
			,
			);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,lnpid
			,//First_name
			,//Middle_name
			,//Last_NAME
			,//maturity_suffix
			,//GENDER
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_v_city_name
			,clean_st
			,clean_ZIP
			,//SSN
			,//DOB
			,clean_phone
			,lic1_state
			,lic1_num
			,tin1
			,dea_num1
			,group_key
			,
			,//UPIN
			,did
			,bdid
			,//SRC
			,//SOURCE_RID
			,result,false,38);
		
		RETURN result; 
	END;

	EXPORT client_data_base:=FUNCTION

  	base_file := Mark_history(MPRD.Files(filedate,pUseProd).client_data_base.built, MPRD.layouts.client_data_base);

		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).client_data;

		cleanNames := Clean_name(std_input, MPRD.Layouts.client_data_base):PERSIST('~thor_data400::persist::mprd::client_data_names');
															
		cleanAdd_t	:= Clean_addr(cleanNames,  MPRD.Layouts.client_data_base):PERSIST('~thor_data400::persist::cleaned_client_data_addr');
	
		base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).client_data_lBaseTemplate_built)) = 0
								 ,cleanAdd_t,cleanAdd_t + base_file);
		MPRD.layouts.client_data_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   			SELF.source_rec_id 					:= HASH64(hashmd5(
				                             TRIM(l.hashed_ssn)+','
																		+TRIM(l.filecode)+','
																		+TRIM(l.provider_id)+','
																		+TRIM(l.birthdate)+','
																		+TRIM(l.date_of_death)+','
   																	+TRIM(l.full_name)+','
   																	+TRIM(l.first_name)+','
   																	+TRIM(l.middle_name)+','
   																	+TRIM(l.last_name)+','
   																	+TRIM(l.maturity_suffix)+','
   																	+TRIM(l.email_addr)+','
																		+TRIM(l.web_site)+','
   																	+TRIM(l.upin)+','
																		+TRIM(l.dea_num)+','
																		+TRIM(l.npi_num)+','
																		+TRIM(l.lic_num_in)+','
                                    +TRIM(l.lic_state)+','
                                    +TRIM(l.lic_num)+','
                                    +TRIM(l.lic_type)+','
																		+TRIM(l.normed_addr_rec_type)+','
																		+TRIM(l.orig_adresss)+','
																		+TRIM(l.orig_state)+','
																		+TRIM(l.orig_city)+','
																		+TRIM(l.orig_zip)+','
   																	+TRIM(l.prac_Phone)+','
																		+TRIM(l.prac_fax)+','
																		+TRIM(l.medschool)+','
   																	+TRIM(l.taxonomy)));
   			SELF											:= L;
   		END;
   			
		d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));
									 
		new_base_d := DISTRIBUTE(d_rid, HASH( TRIM(first_name),TRIM(middle_name),TRIM(last_name),orig_adresss,orig_state,orig_zip));  
		new_base_s := SORT(new_base_d,
	        hashed_ssn
					,filecode
					,provider_id
					,birthdate
					,date_of_death
					,full_name
					,first_name
					,middle_name
					,last_name
					,maturity_suffix
          ,email_addr
					,web_site
   				,upin
					,dea_num
					,npi_num
					,lic_num_in
					,lic_state
					,lic_num
					,Lic_Type
					,normed_addr_rec_type
					,orig_adresss
					,orig_state
					,orig_city
					,orig_zip
					,prac_Phone
					,prac_fax
					,medschool
					,taxonomy
					,LOCAL);
		
		MPRD.Layouts.client_data_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			SELF.date_first_seen            := (STRING)ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			SELF.source_rec_id              := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			SELF						 							  := IF(Le.record_type = 'C', Le, Ri);	
		END;

		base_f := rollup(new_base_s,
							LEFT.hashed_ssn						=	RIGHT.hashed_ssn
					AND LEFT.filecode							=	RIGHT.filecode
					AND LEFT.provider_id					=	RIGHT.provider_id
					AND LEFT.birthdate						=	RIGHT.birthdate
					AND LEFT.date_of_death				=	RIGHT.date_of_death
					AND LEFT.full_name						=	RIGHT.full_name
					AND LEFT.first_name 					= RIGHT.first_name 
					AND	LEFT.middle_name 					= RIGHT.middle_name 
					AND	LEFT.last_name 						= RIGHT.last_name 
					AND LEFT.maturity_suffix			=	RIGHT.maturity_suffix
					AND LEFT.email_addr						=	RIGHT.email_addr
					AND LEFT.web_site							=	RIGHT.web_site
					AND LEFT.upin									=	RIGHT.upin
					AND LEFT.dea_num							=	RIGHT.dea_num
					AND LEFT.npi_num							=	RIGHT.npi_num
          AND LEFT.lic_num_in						=	RIGHT.lic_num_in
					AND LEFT.lic_state						=	RIGHT.lic_state
					AND LEFT.lic_num							=	RIGHT.lic_num
					AND LEFT.Lic_Type							=	RIGHT.Lic_Type
					AND LEFT.normed_addr_rec_type =	RIGHT.normed_addr_rec_type
					AND LEFT.orig_adresss					=	RIGHT.orig_adresss
					AND LEFT.orig_state						=	RIGHT.orig_state
					AND LEFT.orig_city						=	RIGHT.orig_city
					AND LEFT.orig_zip							=	RIGHT.orig_zip
					AND LEFT.prac_Phone						=	RIGHT.prac_Phone
					AND LEFT.prac_fax							=	RIGHT.prac_fax
					AND LEFT.medschool						=	RIGHT.medschool
					AND LEFT.taxonomy							=	RIGHT.taxonomy 
					AND LEFT.normed_addr_rec_type	=	RIGHT.normed_addr_rec_type
					,t_rollup(LEFT, RIGHT),LOCAL);

		matchset := ['A','Z','P'];
		did_add.MAC_Match_Flex
			(base_f, matchset,					
			foo,foo1,first_name, middle_name, last_name, maturity_suffix, 
			clean_prim_range, clean_prim_name, clean_sec_range, clean_zip, clean_st,prac_phone, 
			DID, mprd.Layouts.client_data_base, true, did_score,75, d_did);

		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(d_did
			,bdid_matchset
			,full_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,''
			,foo
			,bdid
			,mprd.layouts.client_data_base
			,true
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,
			,
			,
			,
			,
			,src
			,
			,
			);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,lnpid
			,first_name
			,middle_name
			,last_name
			,maturity_suffix
			,//GENDER
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_v_city_name
			,clean_st
			,clean_zip
			,//SSN
			,//DOB
			,clean_prac_phone
			,lic_state
			,lic_num
			,//tin
			,dea_num
			,group_key
			,
			,upin
			,did
			,bdid
			,//SRC
			,//SOURCE_RID
			,result,false,38);

		RETURN result;
	END;
	
	EXPORT office_attributes_base := FUNCTION
		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).office_attributes;
    new_base_d := DEDUP(std_input, RECORD, ALL);
    RETURN new_base_d;
	END;

	EXPORT office_attributes_facility_base := FUNCTION
		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).office_attributes_facility;
    new_base_d := DEDUP(std_input, RECORD, ALL);
    RETURN new_base_d;
	END;		
	
  EXPORT std_terms_lu_base := FUNCTION
    
		std_terms_lu_input := MPRD.Files(filedate,pUseProd).std_terms_lu_file;
        
		mprd.layouts.std_terms_lu_base tMapping(MPRD.layouts.std_terms_lu_in L) := TRANSFORM
			SELF  :=  L;
    END;
        
    std_input		:= PROJECT(std_terms_lu_input, tMapping(LEFT));
    new_base_d	:= DEDUP(std_input, RECORD, ALL);
    RETURN new_base_d;
	END;
		
	EXPORT taxonomy_full_lu_base := FUNCTION
    
		taxonomy_full_lu_input := MPRD.Files(filedate,pUseProd).taxonomy_full_lu_file;
        
		mprd.layouts.taxonomy_full_lu_base tMapping(MPRD.layouts.taxonomy_full_lu_in L) := TRANSFORM
			SELF.type1										:= TRIM(Stringlib.StringToUpperCase(L.type1), LEFT, RIGHT);
			SELF.classification						:= TRIM(Stringlib.StringToUpperCase(L.classification), LEFT, RIGHT);
			SELF.specialization						:= TRIM(Stringlib.StringToUpperCase(L.specialization), LEFT, RIGHT);
			SELF.fulllist									:= TRIM(Stringlib.StringToUpperCase(L.fulllist), LEFT, RIGHT);
			SELF  												:=  L;
    END;
        
    std_input	 := PROJECT(taxonomy_full_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    RETURN new_base_d;
	END;
			
	EXPORT dir_confidence_2010_lu_base := FUNCTION
    
		dir_confidence_2010_lu_input := MPRD.Files(filedate,pUseProd).dir_confidence_2010_lu_file;
        
		mprd.layouts.dirconfidence2010lu_base tMapping(MPRD.layouts.dirconfidence2010lu_in L) := TRANSFORM
			SELF  :=  L;
    END;
        
    std_input  := PROJECT(dir_confidence_2010_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    RETURN new_base_d;
	END;
	  
	EXPORT specialty_lu_base := FUNCTION
    
		specialty_lu_input := MPRD.Files(filedate,pUseProd).specialty_lu_file;
        
		mprd.layouts.specialty_lu_base tMapping(MPRD.layouts.specialty_lu_in L) := TRANSFORM
			SELF.specialty_desc						:= TRIM(Stringlib.StringToUpperCase(L.specialty_desc), LEFT, RIGHT);	       
			SELF  												:= L;
    END;
        
    std_input  := PROJECT(specialty_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	 END;
	
	EXPORT group_lu_base := FUNCTION
    
    group_lu_input := MPRD.Files(filedate,pUseProd).group_lu_file;
        
		mprd.layouts.group_lu_base tMapping(MPRD.layouts.group_lu_in L) := TRANSFORM
         SELF.description			:= TRIM(Stringlib.StringToUpperCase(L.description), LEFT, RIGHT);	  
				 SELF  								:= L;
         END;
				     
    std_input  := PROJECT(group_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	 END;
	 
	 EXPORT hospital_lu_base := FUNCTION
    
		hospital_lu_input := MPRD.Files(filedate,pUseProd).hospital_lu_file;
        
		mprd.layouts.hospital_lu_base tMapping(MPRD.layouts.hospital_lu_in L) := TRANSFORM
			SELF.description			:= TRIM(Stringlib.StringToUpperCase(L.description), LEFT, RIGHT);	 
			SELF  								:= L;
    END;
     
    std_input  := PROJECT(hospital_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	 END;
	 
  EXPORT dea_xref_base := FUNCTION
    
		dea_xref_input := MPRD.Files(filedate,pUseProd).dea_xref_file;
        
		mprd.layouts.dea_xref_base tMapping(MPRD.layouts.dea_xref_in L) := TRANSFORM
			SELF  :=  L;
    END;
        
    std_input  := PROJECT(dea_xref_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
	 	 
	EXPORT lic_xref_base := FUNCTION
	
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).lic_xref;

    cleanNames := Clean_name(std_input, MPRD.Layouts.lic_xref_base):PERSIST('~thor_data400::persist::mprd::lic_xref_names');
 		return cleanNames;
	END;
 
  EXPORT addr_name_xref_base := FUNCTION
    
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).addr_name_xref;

    cleanNames := Clean_name(std_input, MPRD.Layouts.address_name_xref_base):PERSIST('~thor_data400::persist::mprd::addr_name_xref_names');
		return cleanNames;
	END;
 
  EXPORT basc_facility_mme_base := FUNCTION
    
		basc_facility_mme_input := MPRD.Files(filedate,pUseProd).basc_facility_mme_file;
        
		mprd.layouts.basc_facility_mme_base tMapping(MPRD.layouts.basc_facility_mme_in L) := TRANSFORM
			SELF  			:= L;
    END;
		
    std_input  := PROJECT(basc_facility_mme_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
			
  EXPORT lic_filedate_base := FUNCTION
		lic_filedate_input := MPRD.Files(filedate,pUseProd).lic_filedate_file;
        
		mprd.layouts.lic_filedate_base tMapping(MPRD.layouts.lic_filedate_in L) := TRANSFORM
			SELF.clean_filedate       := IF(l.filedate NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.filedate,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');				 	      
  		SELF  										:= L;
    END;
		
    std_input  := PROJECT(lic_filedate_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	 END;
		
	EXPORT nanpa_base := FUNCTION
		nanpa_input := MPRD.Files(filedate,pUseProd).nanpa_file;
        
		mprd.layouts.nanpa_base tMapping(MPRD.layouts.nanpa_in L) := TRANSFORM
			SELF.carrier_name								   := IF(L.carrier_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.carrier_name), LEFT, RIGHT),'');	       
			SELF.clean_carrier_name 				   := IF(L.carrier_name<> '', ut.CleanCompany(L.carrier_name), '');
      SELF.clean_effective_date          := IF(l.effective_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.effective_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');				 
			SELF.clean_assign_date             := IF(l.assign_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.assign_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');				 
			SELF.clean_rate_center					   := IF(L.rate_center NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.rate_center), LEFT, RIGHT),'');	       
			SELF.clean_ocn								     := IF(L.ocn NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.ocn), LEFT, RIGHT),'');	       
			SELF  														 := L;
    END;
		    
    std_input  := PROJECT(nanpa_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
	  	 
	EXPORT last_name_stats_base := FUNCTION
    
		last_name_stats_input := MPRD.Files(filedate,pUseProd).last_name_stats_file;
        
		mprd.layouts.last_name_stats_base tMapping(MPRD.layouts.last_name_stats_in L) := TRANSFORM
			SELF.last_name					:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);	       
			SELF  									:= L;
    END;
        
    std_input  := PROJECT(last_name_stats_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
	  
  EXPORT facility_name_xref_base := FUNCTION
		facility_name_xref_input := MPRD.Files(filedate,pUseProd).facility_name_xref_file;
        
		mprd.layouts.facility_name_xref_base tMapping(MPRD.layouts.facility_name_xref_in L) := TRANSFORM
			SELF.prac_company1_name									:= IF(L.prac_company1_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT),'');	       
			SELF.dba_name									          := IF(L.dba_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.dba_name), LEFT, RIGHT),'');	       
			SELF.clean_prac_company1_name	          := IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.clean_dba_name	                    := IF(L.dba_name<> '', ut.CleanCompany(L.dba_name), '');
      SELF  																	:= L;
    END;
        
    std_input  := PROJECT(facility_name_xref_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
	  
	EXPORT best_hospital_base := FUNCTION
		best_hospital_input := MPRD.Files(filedate,pUseProd).best_hospital_file;
        
		mprd.layouts.best_hospital_base tMapping(MPRD.layouts.best_hospital_in L) := TRANSFORM
			SELF.prac_company1_name						:= IF(L.prac_company1_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT),'');	       
			SELF.clean_prac_company1_name	    := IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.clean_prac_phone1 						:= IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF  														:= L;
    END;
		   
    std_input  := PROJECT(best_hospital_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
		 
	EXPORT source_confidence_lu_base := FUNCTION
		source_confidence_lu_input := MPRD.Files(filedate,pUseProd).source_confidence_lu_file;
        
		mprd.layouts.source_confidence_lu_base tMapping(MPRD.layouts.source_confidence_lu_in L) := TRANSFORM
			SELF.clean_audit_date      := IF(l.audit_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.audit_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');				 	      
  		SELF  										 := L;
    END;
		    
    std_input  := PROJECT(source_confidence_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	 END;

   EXPORT ignore_terms_lu_base := FUNCTION
    
		ignore_terms_lu_input := MPRD.Files(filedate,pUseProd).ignore_terms_lu_file;
        
		mprd.layouts.ignore_terms_lu_base tMapping(MPRD.layouts.ignore_terms_lu_in L) := TRANSFORM
			SELF  :=  L;
    END;
        
    std_input  := PROJECT(ignore_terms_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;		 

	EXPORT taxon_lu_base := FUNCTION
		taxon_lu_input := MPRD.Files(filedate,pUseProd).taxon_lu_file;
        
		mprd.layouts.taxon_lu_base tMapping(MPRD.layouts.taxon_lu_in L) := TRANSFORM
			SELF.state	:= IF(l.state  NOT IN invalid_values,l.state ,'');;         
			SELF  			:= L;
    END;
        
    std_input :=PROJECT(taxon_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;		
	  
	EXPORT abbr_lu_base := FUNCTION
		abbr_lu_input := MPRD.Files(filedate,pUseProd).abbr_lu_file;
        
		mprd.layouts.abbr_lu_base tMapping(MPRD.layouts.abbr_lu_in L) := TRANSFORM             
			SELF  :=  L;
    END;
        
    std_input  := PROJECT(abbr_lu_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;		
	 
  EXPORT call_queue_bad_base := FUNCTION
		call_queue_bad_input := MPRD.Files(filedate,pUseProd).call_queue_bad_file;
        
		mprd.layouts.call_queue_bad_base tMapping(MPRD.layouts.call_queue_bad_in L) := TRANSFORM        
			SELF  :=  L;
    END;
        
    std_input  := PROJECT(call_queue_bad_input, tMapping(LEFT));
    new_base_d := DEDUP(std_input, RECORD, ALL);
    return new_base_d;
	END;
	
	EXPORT group_practice_base	:= FUNCTION

		base_file := Mark_history(MPRD.Files(filedate,pUseProd).group_practice_base.built, MPRD.layouts.group_practice_base);

		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).group_practice;

		cleanAdd_t:= Clean_addr(std_input,  MPRD.Layouts.group_practice_base):PERSIST('~thor_data400::persist::cleaned_practice_addr_grp_prac');

		base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).group_practice_lBaseTemplate_built)) = 0
								 ,cleanAdd_t,cleanAdd_t + base_file);

		MPRD.layouts.group_practice_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   			SELF.source_rec_id 					:= HASH64(hashmd5(
   																	    TRIM(l.group_name)+','
																			 +TRIM(l.prac_phone1)+','
																			 +TRIM(l.prac_fax1)+','
																			 +TRIM(l.prac_fax2)+','
																			 +TRIM(l.prac1_primary_address)+','
																			 +TRIM(l.prac1_secondary_address)+','
			                                 +TRIM(l.prac1_state)+','
																			 +TRIM(l.prac1_city)+','
																			 +TRIM(l.prac1_zip)+','
																			 +TRIM(l.prac1_rectype)+','
																			 +TRIM(l.taxonomy)+','
																			 +TRIM(l.first_created_date)+','
																			 +TRIM(l.last_load_date)+','
																			 +TRIM((string)l.active_status)));
   		SELF											:= L;
   	END;
   			
		d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));
	
		new_base_d := DISTRIBUTE(d_rid, HASH(TRIM(group_name),prac1_primary_address,prac1_secondary_address,prac1_state,prac1_city,prac1_zip)); 
		new_base_s := SORT(new_base_d,
                     group_name,
										 prac_phone1,
										 prac_fax1,
										 prac_fax2,
										 normed_addr_rec_type,
										 prac1_primary_address,
										 prac1_secondary_address,
                     prac1_state,
										 prac1_city,
										 prac1_zip,
										 taxonomy,										 
										 first_created_date,
										 last_load_date,
										 active_status,
					 LOCAL);
		
		MPRD.Layouts.group_practice_base t_rollup (new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_first_seen            := (STRING) ut.EarliestDate ((INTEGER)L.date_first_seen,(INTEGER) R.date_first_seen);
			SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)L.date_last_seen, (INTEGER)R.date_last_seen);
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF.source_rec_id  	          := IF(L.date_vendor_first_reported < R.date_vendor_first_reported, L.source_rec_id, R.source_rec_id);
			SELF						 							  := IF(L.record_type = 'C', L, R);
		END;

		base_f := rollup(
							new_base_s,
									LEFT.group_name								= RIGHT.group_name
							AND LEFT.prac_phone1							= RIGHT.prac_phone1
							AND LEFT.prac_fax1								= RIGHT.prac_fax1
							AND LEFT.prac_fax2								= RIGHT.prac_fax2
							AND LEFT.normed_addr_rec_type			= RIGHT.normed_addr_rec_type
							AND LEFT.prac1_primary_address		= RIGHT.prac1_primary_address
							AND LEFT.prac1_secondary_address	= RIGHT.prac1_secondary_address
              AND LEFT.prac1_state							= RIGHT.prac1_state
							AND LEFT.prac1_city								= RIGHT.prac1_city
							AND LEFT.prac1_zip								= RIGHT.prac1_zip
							AND LEFT.taxonomy									= RIGHT.taxonomy										 
							AND LEFT.first_created_date				= RIGHT.first_created_date
							AND LEFT.last_load_date						= RIGHT.last_load_date
							AND LEFT.active_status						= RIGHT.active_status
							,t_rollup(LEFT, RIGHT),LOCAL);

		matchset 	:= ['A', 'P'];
		Business_Header_SS.MAC_Add_BDID_Flex(
			base_f
			,matchset
			,clean_group_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,clean_prac_phone1
			,foo
			,bdid
			,mprd.layouts.group_practice_base
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,
			,
			,
			,
			,
			,src
			,
			,
			);

	Health_Facility_Services.mac_get_best_lnpid_on_thor (
			 d_bdid
			,LNPID
			,clean_group_name											
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_p_city_name
			,clean_st
			,clean_zip
			,//sanc_tin
			,//tin1
			,prac_phone1
			,prac_fax1
			,//sanc_sancst
			,//sanc_licnbr
			,//Input_DEA_NUMBER
			,prac1_key//group_key
			,//npi_num
			,//clia_num
			,//medicare_fac_num
			,//Input_MEDICAID_NUMBER
			,//ncpdp_id
			,taxonomy
			,BDID
			,//SRC
			,//SOURCE_RID
			,result
			,false
			,30
			);

		RETURN result; 
	END;
	
	EXPORT aci_schedule_base := FUNCTION   
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).aci_schedule;

		return std_input;
	END;

  EXPORT business_activities_lu_base := FUNCTION
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).business_activities_lu;

		return std_input;
	END;
	
	EXPORT cms_ecp_base	:= FUNCTION
		base_file := Mark_history(MPRD.Files(filedate,pUseProd).cms_ecp_base.built(isTest = false), MPRD.layouts.cms_ecp_base);

		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).cms_ecp;
				
		cleanAdd_t	:= Clean_addr(std_input,  MPRD.Layouts.cms_ecp_base):PERSIST('~thor_data400::persist::cleaned_cms_ecp_addr');

		base_and_update := IF(nothor(FileServices.GetSuperFileSubCount(MPRD.Filenames(filedate, pUseProd).cms_ecp_lBaseTemplate_built)) = 0
								 ,cleanAdd_t,cleanAdd_t + base_file);
								 
		MPRD.layouts.cms_ecp_base  GetSourceRID(base_and_update L)	:= TRANSFORM
   			SELF.source_rec_id 					:= HASH64(hashmd5(
																				l.seq_num+','
																			 +TRIM(l.filecode)+','
   																	   +TRIM(l.ecp_provider_name)+','
																			 +TRIM(l.ecp_site_name)+','
																			 +TRIM(l.ecp_org_name)+','
																			 +TRIM(l.ecp_org_ein)+','
																			 +TRIM(l.ecp_type_hosp)+','
																			 +TRIM(L.ecp_type_fqhc)+','
																			 +TRIM(l.ecp_type_rw)+','
																			 +TRIM(l.ecp_type_fp)+','
																			 +TRIM(l.ecp_type_ip)+','
																			 +TRIM(l.ecp_type_other)+','
																			 +l.ecp_type_all+','
																			 +TRIM(l.ecp_site_addr1)+','
																			 +TRIM(l.ecp_site_addr2)+','
																			 +TRIM(l.ecp_site_city)+','
																			 +TRIM(l.ecp_site_state)+','
																			 +TRIM(l.ecp_site_zip)+','
																			 +TRIM(l.ecp_site_county)+','
																			 +TRIM(l.ecp_org_addr1)+','
																			 +TRIM(l.ecp_org_addr2)+','
																			 +TRIM(l.ecp_org_city)+','
																			 +TRIM(l.ecp_org_state)+','
																			 +TRIM(l.ecp_org_zip)
																					));
   		SELF											:= L;
   	END;
   			
		d_rid:=PROJECT(base_and_update,GetSourceRID(LEFT));
		new_base_d := DISTRIBUTE(d_rid, HASH(seq_num,TRIM(filecode),TRIM(ecp_provider_name),TRIM(ecp_site_name),TRIM(ecp_org_name),TRIM(ecp_org_ein),
					ecp_site_addr1,ecp_site_addr2,ecp_site_city,ecp_site_state,ecp_org_zip)); 
					
		new_base_s := SORT(new_base_d,
                     seq_num,
										 filecode,
										 ecp_provider_name,
										 ecp_site_name,
										 ecp_org_name,
										 ecp_org_ein,
										 ecp_type_hosp,
										 ecp_type_fqhc,
										 ecp_type_rw,
										 ecp_type_fp,
										 ecp_type_ip,
										 ecp_type_other,
										 ecp_type_all,
										 ecp_site_addr1,
										 ecp_site_addr2,
										 ecp_site_city,
										 ecp_site_state,
										 ecp_site_zip,
										 ecp_site_county,
										 ecp_org_addr1,
										 ecp_org_addr2,
										 ecp_org_city,
										 ecp_org_state,
										 ecp_org_zip,
											LOCAL); 
		
		MPRD.Layouts.cms_ecp_base t_rollup (new_base_s  le, new_base_s ri) := TRANSFORM
			SELF.date_first_seen            := (STRING) ut.EarliestDate ((INTEGER)le.date_first_seen,(INTEGER) ri.date_first_seen);
			SELF.date_last_seen             := (STRING)ut.LatestDate ((INTEGER)le.date_last_seen, (INTEGER)ri.date_last_seen);
			SELF.date_vendor_first_reported := ut.EarliestDate(le.date_vendor_first_reported, ri.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate(le.date_vendor_last_reported, ri.date_vendor_last_reported);
			SELF.source_rec_id 	            := IF(le.date_vendor_first_reported<ri.date_vendor_first_reported,le.source_rec_id,ri.source_rec_id);
			SELF						 							  := IF(Le.record_type = 'C', Le, Ri);
		END;
		
		base_f := rollup(
							new_base_s,
									LEFT.seq_num							= RIGHT.seq_num
							AND LEFT.filecode							= RIGHT.filecode
							AND LEFT.ecp_provider_name		= RIGHT.ecp_provider_name
							AND LEFT.ecp_site_name				= RIGHT.ecp_site_name
							AND LEFT.ecp_org_name					= RIGHT.ecp_org_name
							AND LEFT.ecp_org_ein					= RIGHT.ecp_org_ein
							AND LEFT.ecp_type_hosp				= RIGHT.ecp_type_hosp
							AND LEFT.ecp_type_fqhc				= RIGHT.ecp_type_fqhc
							AND LEFT.ecp_type_rw					= RIGHT.ecp_type_rw
							AND LEFT.ecp_type_fp					= RIGHT.ecp_type_fp
							AND LEFT.ecp_type_ip					= RIGHT.ecp_type_ip
							AND LEFT.ecp_type_other				= RIGHT.ecp_type_other
							AND LEFT.ecp_type_all					= RIGHT.ecp_type_all
							AND LEFT.ecp_site_addr1				= RIGHT.ecp_site_addr1
							AND LEFT.ecp_site_addr2				= RIGHT.ecp_site_addr2
							AND LEFT.ecp_site_city				= RIGHT.ecp_site_city
							AND LEFT.ecp_site_state				= RIGHT.ecp_site_state
							AND LEFT.ecp_site_zip					= RIGHT.ecp_site_zip
							AND LEFT.ecp_site_county			= RIGHT.ecp_site_county
							AND LEFT.ecp_org_addr1				= RIGHT.ecp_org_addr1
							AND LEFT.ecp_org_addr2				= RIGHT.ecp_org_addr2
							AND LEFT.ecp_org_city					= RIGHT.ecp_org_city
							AND LEFT.ecp_org_state				= RIGHT.ecp_org_state
							AND LEFT.isTest								= RIGHT.isTest
            ,t_rollup(LEFT, RIGHT),LOCAL);
				
		bdid_matchset := ['A','F'];
		Business_Header_SS.MAC_Add_BDID_Flex(
			base_f
			,bdid_matchset
			,ecp_provider_name
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,''
			,ecp_org_ein
			,bdid
			,mprd.layouts.cms_ecp_base
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,clean_p_city_name
			,
			,
			,
			,
			,src
			,
			,
			);
			
	Health_Facility_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,LNPID
			,clean_ecp_provider_name
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,clean_p_city_name
			,clean_st
			,clean_zip
			,//sanc_tin
			,ecp_org_ein
			,poc_phone_fqhc
			,
			,//sanc_sancst
			,//sanc_licnbr
			,//Input_DEA_NUMBER
			,seq_num
			,//npi_num
			,//clia_num
			,//medicare_fac_num
			,//Input_MEDICAID_NUMBER
			,//ncpdp_id
			,//taxonomy
			,BDID
			,//SRC
			,//SOURCE_RID
			,dLnpidOut
			,false
			,30
					);
		return dLnpidOut;
	END;
	
	EXPORT opi_base := FUNCTION
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).opi;
		return std_input;
	END;
	
	EXPORT opi_facility_base := FUNCTION
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).opi_facility;
		return std_input;
	END;

	EXPORT abms_cert_lu_base := FUNCTION
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).abms_cert_lu;
		return std_input;
	END;

	EXPORT abms_cooked_base := FUNCTION
 		std_input := MPRD.StandardizeInputFile(filedate, pUseProd).abms_cooked;
		return std_input;
	END;

END;