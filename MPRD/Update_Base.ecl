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
    new_base_d := distribute(DEDUP(std_input, RECORD, ALL));
    RETURN new_base_d;
	END;
				  	 
END;