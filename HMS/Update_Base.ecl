import Address, Ut, lib_STRINGlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility;

EXPORT Update_Base (STRING filedate, boolean pUseProd = false) := module

	EXPORT HashItem(STRING item, BOOLEAN lastItem = false) := 
		IF(lastItem, trim(item, LEFT, RIGHT), (trim(item, LEFT, RIGHT) + ','));

	
	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.record_type	:= 'H';
				SELF							:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;
	
	EXPORT Clean_addr (pBaseFile, pLayout_base)	:= FUNCTIONMACRO

		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
		AID.MacAppendFromRaw_2Line(pBaseFile,Prepped_addr1,Prepped_addr2,RawAID,cleanAddr, lFlags);

		pLayout_base addr(cleanAddr L)	:= TRANSFORM
			SELF.RawAID     := L.aidwork_rawaid;
			SELF.ACEAID			:= L.aidwork_acecache.aid;
			SELF.prim_range := STRINGlib.STRINGfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := STRINGlib.STRINGfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := STRINGlib.STRINGfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.v_city_name:= IF(LENGTH(STRINGlib.STRINGfilterout(STRINGlib.STRINGtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.p_city_name:= IF(LENGTH(STRINGlib.STRINGfilterout(STRINGlib.STRINGtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.zip        := L.aidwork_acecache.zip5;
			SELF.fips_st    := L.aidwork_acecache.county[1..2];
			SELF.fips_county:= L.aidwork_acecache.county[3..5];
			SELF.msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;
		RETURN PROJECT(cleanAddr, addr(LEFT));
	ENDMACRO;
	
	EXPORT Clean_name (pBaseFile, pLayout_base, useFull = false) := FUNCTIONMACRO
		#IF(useFull)
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														, clean_company_name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);
		#else
		NID.Mac_CleanParsedNames(pBaseFile, cleanNames
														, firstname:=first,middlename:=middle,lastname:=last,namesuffix:=suffix
														, includeInRepository:=TRUE, normalizeDualNames:=FALSE
													);	
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
			SELF.fname 				:= IF(l.nameType='P',L.cln_fname,'');
			SELF.mname 				:= IF(l.nameType='P',L.cln_mname,'');
			SELF.lname 				:= IF(l.nameType='P',L.cln_lname,'');
			SELF.name_suffix 	:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		RETURN PROJECT(cleanNames,tr(LEFT));
	ENDMACRO;

//////////////////////////////////////////////////////////
// Record Definition used by Individuals File processing
EXPORT	track_ancillaries:= record
						hms.Layouts.individual_base;
						integer addr	:= 0;
						integer	dob		:= 0;
						integer	ssn		:= 0;
						integer	lic		:= 0;
						integer	dea		:= 0;
						integer	npi		:= 0;
						integer	sanc	:= 0;
						integer num_c	:= 0;
		end;
//////////////////////////////////////////////////////////

//////////////function definition	////////////////////////////////////////////////////////////////////////////////////////////
		fn_individual_rollup(dataset(track_ancillaries) d):= FUNCTION
		
			d1:=distribute(d, hash(first, middle, last, npi_num));
			
			new_base_s := SORT(d1   // do not list hms_piid
				,first
				,middle
				,last
				,suffix
				,cred
				,practitioner_type
				,active
				,vendible
				,npi_num
				,npi_enumeration_date
				,npi_deactivation_date
				,npi_reactivation_date
				,npi_taxonomy_code
				,upin
				,medicare_participation_flag
				,date_born
				,date_died
				
				,firm_name
				,lid
				,agid
				
				,state_license_state
				,state_license_number
				,state_license_type
				,state_license_active
				,state_license_qualifier
				,state_license_sub_qualifier
				
				,dea_num
				,dea_bac
				,dea_sub_bac
				,dea_schedule
				
				,csr_number
				,csr_state
				,csr_expire_date
				,csr_issue_date
				,dsa_lvl_2
				,dsa_lvl_2n
				,dsa_lvl_3
				,dsa_lvl_3n
				,dsa_lvl_4
				,dsa_lvl_5
				,csr_raw1
				,csr_raw2
				,csr_raw3
				,csr_raw4
				
				,sanction_id
				,sanction_action_code
				,sanction_action_description
				,sanction_board_code
				,sanction_board_description
				,action_date
				,sanction_period_start_date
				,sanction_period_end_date
				,month_duration
				,fine_amount
				,offense_code
				,offense_description
				,offense_date

        ,gsa_sanction_id				
				,gsa_first
				,gsa_middle
				,gsa_last
				,gsa_suffix
				,gsa_city
				,gsa_state
				,gsa_zip
				,action_date
				//,date		//AKumar - Where is this coming from. Also not being used in Rollup
				,agency

				,fax
				
				,phone    
				
				,certification_code 
				,certification_description 
				,board_code 
				,board_description 
				
				,covered_recipient_id
				,cov_rcp_raw_state_code
				,cov_rcp_raw_full_name
				,cov_rcp_raw_attribute1
				,cov_rcp_raw_attribute2
				,cov_rcp_raw_attribute3
				,cov_rcp_raw_attribute4
				
				,hms_scid    
				,school_name 
				,grad_year   

				,lang_code
				,language 
				
				,specialty_description

				,LOCAL);

			track_ancillaries t_rollup(new_base_s L, new_base_s R) := TRANSFORM
				SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
				SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
				
				SELF.date_first_seen := 0; // vendors not reporting this value for hms_pm
				SELF.date_last_seen  := 0; // vendors not reporting this value for hms_pm
				
				sum_L := L.addr + L.dob + L.ssn + L.lic + L.dea + L.npi + L.sanc;
				sum_R := R.addr + R.dob + R.ssn + R.lic + R.dea + R.npi + R.sanc;
				
				SELF.hms_piid  := if(l.date_vendor_last_reported > r.date_vendor_last_reported, l.hms_piid, r.hms_piid);

				SELF	:= map(
									 l.record_type='C' and r.record_type='C' and sum_L > sum_R => L
									,l.record_type='C' and r.record_type='C' and sum_L < sum_R => R
									,l.record_type='H' and r.record_type='H' and sum_L > sum_R => L
									,l.record_type='H' and r.record_type='H' and sum_L < sum_R => R
									,l.record_type='C' => L
									, R
								);
				
				SELF	:= IF(L.record_type = 'C', L, R);
			END;
		
			base_indiv_rup := ROLLUP(new_base_s    // do not use hms_piid
				,		LEFT.first                      =RIGHT.first
				AND LEFT.middle                     =RIGHT.middle
				AND LEFT.last                       =RIGHT.last
				AND LEFT.suffix                     =RIGHT.suffix
				AND LEFT.cred                       =RIGHT.cred
				AND LEFT.practitioner_type          =RIGHT.practitioner_type
				AND LEFT.active                     =RIGHT.active
				AND LEFT.vendible                   =RIGHT.vendible
				AND LEFT.npi_num                    =RIGHT.npi_num
				AND LEFT.npi_enumeration_date       =RIGHT.npi_enumeration_date
				AND LEFT.npi_deactivation_date      =RIGHT.npi_deactivation_date
				AND LEFT.npi_reactivation_date      =RIGHT.npi_reactivation_date
				AND LEFT.npi_taxonomy_code          =RIGHT.npi_taxonomy_code
				AND LEFT.upin                       =RIGHT.upin
				AND LEFT.medicare_participation_flag=RIGHT.medicare_participation_flag
				AND LEFT.date_born                  =RIGHT.date_born
				AND LEFT.date_died                  =RIGHT.date_died
				                                      
				AND LEFT.firm_name                  =RIGHT.firm_name
				AND LEFT.lid                        =RIGHT.lid
				AND LEFT.agid                       =RIGHT.agid
				
				AND LEFT.state_license_state        =RIGHT.state_license_state
				AND LEFT.state_license_number       =RIGHT.state_license_number
				AND LEFT.state_license_type         =RIGHT.state_license_type
				AND LEFT.state_license_active       =RIGHT.state_license_active
				AND LEFT.state_license_qualifier    =RIGHT.state_license_qualifier
				AND LEFT.state_license_sub_qualifier=RIGHT.state_license_sub_qualifier
				
				AND LEFT.dea_num     =RIGHT.dea_num
				AND LEFT.dea_bac     =RIGHT.dea_bac
				AND LEFT.dea_sub_bac =RIGHT.dea_sub_bac
				AND LEFT.dea_schedule=RIGHT.dea_schedule
				
				AND LEFT.csr_number     =RIGHT.csr_number
				AND LEFT.csr_state      =RIGHT.csr_state
				AND LEFT.csr_expire_date=RIGHT.csr_expire_date
				AND LEFT.csr_issue_date =RIGHT.csr_issue_date
				AND LEFT.dsa_lvl_2      =RIGHT.dsa_lvl_2
				AND LEFT.dsa_lvl_2n     =RIGHT.dsa_lvl_2n
				AND LEFT.dsa_lvl_3      =RIGHT.dsa_lvl_3
				AND LEFT.dsa_lvl_3n     =RIGHT.dsa_lvl_3n
				AND LEFT.dsa_lvl_4      =RIGHT.dsa_lvl_4
				AND LEFT.dsa_lvl_5      =RIGHT.dsa_lvl_5
				AND LEFT.csr_raw1       =RIGHT.csr_raw1
				AND LEFT.csr_raw2       =RIGHT.csr_raw2
				AND LEFT.csr_raw3       =RIGHT.csr_raw3
				AND LEFT.csr_raw4       =RIGHT.csr_raw4
				
				AND LEFT.sanction_id                =RIGHT.sanction_id
				AND LEFT.sanction_action_code       =RIGHT.sanction_action_code
				AND LEFT.sanction_action_description=RIGHT.sanction_action_description
				AND LEFT.sanction_board_code        =RIGHT.sanction_board_code
				AND LEFT.sanction_board_description =RIGHT.sanction_board_description
				AND LEFT.action_date                =RIGHT.action_date
				AND LEFT.sanction_period_start_date =RIGHT.sanction_period_start_date
				AND LEFT.sanction_period_end_date   =RIGHT.sanction_period_end_date
				AND LEFT.month_duration             =RIGHT.month_duration
				AND LEFT.fine_amount                =RIGHT.fine_amount
				AND LEFT.offense_code               =RIGHT.offense_code
				AND LEFT.offense_description        =RIGHT.offense_description
				AND LEFT.offense_date               =RIGHT.offense_date

				AND LEFT.gsa_sanction_id=RIGHT.gsa_sanction_id
				AND LEFT.gsa_first      =RIGHT.gsa_first
				AND LEFT.gsa_middle     =RIGHT.gsa_middle
				AND LEFT.gsa_last       =RIGHT.gsa_last
				AND LEFT.gsa_suffix     =RIGHT.gsa_suffix
				AND LEFT.gsa_city       =RIGHT.gsa_city
				AND LEFT.gsa_state      =RIGHT.gsa_state
				AND LEFT.gsa_zip        =RIGHT.gsa_zip
				AND LEFT.action_date    =RIGHT.action_date
				AND LEFT.agency         =RIGHT.agency
				
				AND LEFT.fax       = RIGHT.fax
				
				AND LEFT.phone     = RIGHT.phone
				
				AND LEFT.certification_code        = RIGHT.certification_code
				AND LEFT.certification_description = RIGHT.certification_description
				AND LEFT.board_code                = RIGHT.board_code
				AND LEFT.board_description         = RIGHT.board_description
				
				AND LEFT.covered_recipient_id    =RIGHT.covered_recipient_id
				AND LEFT.cov_rcp_raw_state_code  =RIGHT.cov_rcp_raw_state_code
				AND LEFT.cov_rcp_raw_full_name   =RIGHT.cov_rcp_raw_full_name	
				AND LEFT.cov_rcp_raw_attribute1  =RIGHT.cov_rcp_raw_attribute1
				AND LEFT.cov_rcp_raw_attribute2  =RIGHT.cov_rcp_raw_attribute2
				AND LEFT.cov_rcp_raw_attribute3  =RIGHT.cov_rcp_raw_attribute3
				AND LEFT.cov_rcp_raw_attribute4  =RIGHT.cov_rcp_raw_attribute4
				                                 
				AND LEFT.hms_scid    =RIGHT.hms_scid    
				AND LEFT.school_name =RIGHT.school_name 
				AND LEFT.grad_year   =RIGHT.grad_year   

				AND LEFT.lang_code =RIGHT.lang_code
				AND LEFT.language  =RIGHT.language 
				
				AND LEFT.specialty_description =RIGHT.specialty_description

				,t_rollup(LEFT,RIGHT)
				,LOCAL);
									
			dist := DISTRIBUTE(base_indiv_rup, HASH(hms_piid));
			
			RETURN dist;
			END;
//////////////end function definition	//////////////////////////////////////////////////////////////


	EXPORT Individual_Base := FUNCTION
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
	  hist_base	:= Mark_history(HMS.Files(filedate,pUseProd).individual_base.built, layouts.individual_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual;
		
		//clean name
		cleanNames := Clean_name(std_input, Layouts.individual_base);

		expand_clean_names	:= project(cleanNames, track_ancillaries);

		exp_clean_names_dist := DISTRIBUTE(expand_clean_names, HASH(hms_piid));
		
		addr_file := DISTRIBUTE(Files().individual_addresses_base.built, HASH(hms_piid));
		base_addr	:= JOIN(fn_individual_rollup(exp_clean_names_dist), addr_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM(track_ancillaries
					,SELF.addr        := if(right.record_type in ['','C'],1,0)
					,SELF.firm_name   := RIGHT.firm_name
					,SELF.clean_company_name   := RIGHT.clean_company_name
					,SELF.lid         := RIGHT.lid
					,SELF.agid        := RIGHT.agid
					,SELF.address_std_code := RIGHT.address_std_code
					,SELF.latitude    := RIGHT.latitude
					,SELF.longitude   := RIGHT.longitude

					,SELF.prepped_addr1 := RIGHT.prepped_addr1
					,SELF.prepped_addr2 := RIGHT.prepped_addr2
          ,SELF.addr_type     := RIGHT.type
					
					,SELF.bdid := RIGHT.bdid;
					,SELF.bdid_score := RIGHT.bdid_score
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);

		//Add to previous base
    base_and_update := if(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_lBaseTemplate_built)) = 0
			,base_addr                                                      //Individuals built superfile has no subfiles
			,base_addr + project(hist_base, track_ancillaries)              //Individuals built superfile has subfiles
		)	; //end if


		// Deactivate And/Or Supercede Recs - Incorporate Piid_Migration file
		track_ancillaries DeactivateRecsTF(track_ancillaries lt, hms.layouts.piid_migration_base rt) := TRANSFORM
			SELF.rec_deactivated_date := if(rt.piid_action = 'DEACTIVATED' OR rt.piid_action = 'MIGRATED', filedate, lt.rec_deactivated_date);
			SELF.superceeding_piid := if(rt.piid_action = 'MIGRATED', rt.new_piid, lt.superceeding_piid);
			SELF := lt;
		END;

		piid_mig_file := DISTRIBUTE(Files().piid_migration_Base.built, HASH(old_piid));
		base_piid_mig := JOIN(fn_individual_rollup(base_and_update), piid_mig_file
									,LEFT.hms_piid = RIGHT.old_Piid
									,DeactivateRecsTF(LEFT,RIGHT)
									,LEFT OUTER
		)	; 


		dea_file	:= DISTRIBUTE(Files().individual_dea_base.built, HASH(hms_piid));
		base_d	:= JOIN(fn_individual_rollup(base_piid_mig), dea_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.dea:=if(right.record_type in ['','C'],1,0)
					,SELF.dea_num := RIGHT.dea_num
					,SELF.dea_bac := RIGHT.dea_bac
					,SELF.dea_sub_bac := RIGHT.dea_sub_bac
					,SELF.dea_schedule := RIGHT.dea_schedule
					,SELF.dea_expire := RIGHT.dea_expire
					,SELF.dea_active := RIGHT.dea_active
					,SELF.clean_dea_expire := RIGHT.clean_dea_expire
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);
	
		state_licenses_file	:= DISTRIBUTE(Files().individual_state_licenses_base.built, HASH(hms_piid));
		base_l	:= JOIN(fn_individual_rollup(base_d), state_licenses_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.lic:=if(right.record_type in ['','C'],1,0);
					,SELF.state_license_state := RIGHT.state_license_state
					,SELF.state_license_number := RIGHT.state_license_number
					,SELF.state_license_type := RIGHT.state_license_type
					,SELF.state_license_active := RIGHT.state_license_active
					,SELF.state_license_expire := RIGHT.state_license_expire
					,SELF.state_license_qualifier := RIGHT.state_license_qualifier
					,SELF.state_license_sub_qualifier := RIGHT.state_license_sub_qualifier
					,SELF.state_license_issued := RIGHT.state_license_issued
					,SELF.clean_state_license_expire := RIGHT.clean_state_license_expire
					,SELF.clean_state_license_issued := RIGHT.clean_state_license_issued
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);

		state_csr_file	:= DISTRIBUTE(Files().individual_state_csr_base.built, HASH(hms_piid));
		state_csr_prejoin_rup := fn_individual_rollup(base_l);
		base_c	:= JOIN(state_csr_prejoin_rup, state_csr_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.csr_number := RIGHT.csr_number
					,SELF.csr_state := RIGHT.csr_state
					,SELF.csr_expire_date := RIGHT.csr_expire_date
					,SELF.csr_issue_date := RIGHT.csr_issue_date
					,SELF.dsa_lvl_2 := RIGHT.dsa_lvl_2
					,SELF.dsa_lvl_2n := RIGHT.dsa_lvl_2n
					,SELF.dsa_lvl_3 := RIGHT.dsa_lvl_3
					,SELF.dsa_lvl_3n := RIGHT.dsa_lvl_3n
					,SELF.dsa_lvl_4 := RIGHT.dsa_lvl_4
					,SELF.dsa_lvl_5 := RIGHT.dsa_lvl_5
					,SELF.csr_raw1 := RIGHT.csr_raw1
					,SELF.csr_raw2 := RIGHT.csr_raw2
					,SELF.csr_raw3 := RIGHT.csr_raw3
					,SELF.csr_raw4 := RIGHT.csr_raw4
					,SELF.clean_csr_expire_date := RIGHT.clean_csr_expire_date
					,SELF.clean_csr_issue_date := RIGHT.clean_csr_issue_date
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);

		sanctions_file	:= DISTRIBUTE(Files().individual_sanctions_base.built, HASH(hms_piid));
		base_s	:= JOIN(fn_individual_rollup(base_c), sanctions_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.sanc:=if(right.record_type in ['','C'],1,0)
					,SELF.sanction_id := RIGHT.sanction_id
					,SELF.sanction_action_code := RIGHT.sanction_action_code
					,SELF.sanction_action_description := RIGHT.sanction_action_description
					,SELF.sanction_board_code        := RIGHT.sanction_board_code
					,SELF.sanction_board_description := RIGHT.sanction_board_description
					,SELF.action_date := RIGHT.action_date
					,SELF.sanction_period_start_date := RIGHT.sanction_period_start_date
					,SELF.sanction_period_end_date := RIGHT.sanction_period_end_date
					,SELF.month_duration := RIGHT.month_duration
					,SELF.fine_amount := RIGHT.fine_amount
					,SELF.offense_code := RIGHT.offense_code
					,SELF.offense_description := RIGHT.offense_description
					,SELF.offense_date := RIGHT.offense_date
					
					,SELF.clean_offense_date := RIGHT.clean_offense_date
					,SELF.clean_action_date := RIGHT.clean_action_date
					,SELF.clean_sanction_period_start_date := RIGHT.clean_sanction_period_start_date
					,SELF.clean_sanction_period_end_date := RIGHT.clean_sanction_period_end_date
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);

		gsa_sanctions_file	:= DISTRIBUTE(Files().individual_gsa_sanctions_base.built, HASH(hms_piid));
		base_g	:= JOIN(fn_individual_rollup(base_s), gsa_sanctions_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
				,SELF.gsa_sanction_id := RIGHT.gsa_sanction_id
				,SELF.gsa_first := RIGHT.gsa_first
				,SELF.gsa_middle := RIGHT.gsa_middle
				,SELF.gsa_last := RIGHT.gsa_last
				,SELF.gsa_suffix := RIGHT.gsa_suffix
				,SELF.gsa_city := RIGHT.gsa_city
				,SELF.gsa_state := RIGHT.gsa_state
				,SELF.gsa_zip := RIGHT.gsa_zip
				,SELF.action_date := RIGHT.action_date
				,SELF.date := RIGHT.date
				,SELF.agency := RIGHT.agency
				,SELF.confidence := RIGHT.confidence
				,SELF.clean_gsa_first := RIGHT.gsa_first
				,SELF.clean_gsa_middle := RIGHT.gsa_middle
				,SELF.clean_gsa_last := RIGHT.gsa_last
				,SELF.clean_gsa_suffix := RIGHT.gsa_suffix
				,SELF.clean_gsa_city := RIGHT.gsa_city
				,SELF.clean_gsa_state := RIGHT.gsa_state
				,SELF.clean_gsa_zip := RIGHT.gsa_zip
				,SELF.clean_gsa_action_date := TRIM(
						TRIM(RIGHT.action_date)[7..10] + TRIM(RIGHT.action_date)[1..2] + TRIM(RIGHT.action_date)[4..5], ALL);
				,SELF.clean_gsa_date := RIGHT.date
				,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);
  
		faxes_file := DISTRIBUTE(Files().individual_address_faxes_base.built, HASH(hms_piid));
		pre_faxes_rup := fn_individual_rollup(base_g);
		base_faxes := JOIN(pre_faxes_rup, faxes_file
				,LEFT.hms_piid = RIGHT.hms_piid
				 AND LEFT.lid = RIGHT.fax_lid
				,TRANSFORM({base_addr}
					,SELF.fax := RIGHT.fax
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);
		
		phones_file := DISTRIBUTE(Files().individual_address_phones_base.built, HASH(hms_piid));
		pre_phones_rup := fn_individual_rollup(base_faxes);
		base_phones := JOIN(pre_phones_rup, phones_file
				,LEFT.hms_piid = RIGHT.hms_piid
				 AND LEFT.lid = RIGHT.phone_lid
				,TRANSFORM({base_addr}
					,SELF.phone := RIGHT.phone
					,SELF.clean_phone := RIGHT.clean_phone
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);

		certifications_file := DISTRIBUTE(Files().individual_certifications_base.built, HASH(hms_piid));
		pre_certifications_rup := fn_individual_rollup(base_phones);
		base_certifications := JOIN(pre_certifications_rup, certifications_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.certification_code := RIGHT.certification_code
					,SELF.certification_description := RIGHT.certification_description
					,SELF.board_code := RIGHT.board_code
					,SELF.board_description := RIGHT.board_description
					,SELF.expiration_year := RIGHT.expiration_year
					,SELF.issue_year := RIGHT.issue_year
					,SELF.renewal_year := RIGHT.renewal_year
					,SELF.lifetime_flag := RIGHT.lifetime_flag
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);

		covered_recipients_file := DISTRIBUTE(Files().individual_covered_recipients_base.built, HASH(hms_piid));
		pre_covered_recipients_rup := fn_individual_rollup(base_certifications);
		base_covered_recipients := JOIN(pre_covered_recipients_rup, covered_recipients_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.covered_recipient_id:=RIGHT.covered_recipient_id
					,SELF.cov_rcp_raw_state_code:=RIGHT.cov_rcp_raw_state_code
					,SELF.cov_rcp_raw_full_name:=RIGHT.cov_rcp_raw_full_name	
					,SELF.cov_rcp_raw_attribute1:=RIGHT.cov_rcp_raw_attribute1
					,SELF.cov_rcp_raw_attribute2:=RIGHT.cov_rcp_raw_attribute2
					,SELF.cov_rcp_raw_attribute3:=RIGHT.cov_rcp_raw_attribute3
					,SELF.cov_rcp_raw_attribute4:=RIGHT.cov_rcp_raw_attribute4
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);

		individual_education_file := DISTRIBUTE(Files().individual_education_Base.built, HASH(hms_piid));
		pre_individual_education_rup := fn_individual_rollup(base_covered_recipients);
		base_individual_education := JOIN(pre_individual_education_rup, individual_education_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.hms_scid    :=RIGHT.hms_scid    
					,SELF.school_name :=RIGHT.school_name 
					,SELF.grad_year   :=RIGHT.grad_year   
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);

		individual_languages_file := DISTRIBUTE(Files().individual_languages_Base.built, HASH(hms_piid));
		pre_individual_languages_rup := fn_individual_rollup(base_individual_education);
		base_individual_languages := JOIN(pre_individual_languages_rup, individual_languages_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.lang_code :=RIGHT.lang_code
					,SELF.language  :=RIGHT.language 
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);

		individual_specialty_file := DISTRIBUTE(Files().individual_specialty_Base.built, HASH(hms_piid));
		pre_individual_specialty_rup := fn_individual_rollup(base_individual_languages);
		base_individual_specialty := JOIN(pre_individual_specialty_rup, individual_specialty_file
				,LEFT.hms_piid = RIGHT.hms_piid
				,TRANSFORM({base_addr}
					,SELF.specialty_description :=RIGHT.specialty_description
					,SELF := LEFT)
				,LEFT OUTER
				,LOCAL);

	track_ancillaries GetSourceRID(base_individual_specialty L) := TRANSFORM
		SELF.source_rid := HASH64(hashmd5(
								 HashItem(L.first)
								,HashItem(L.middle)
								,HashItem(L.last)
								,HashItem(L.suffix)
								,HashItem(L.cred)
								,HashItem(L.practitioner_type)
								,HashItem(L.active)
								,HashItem(L.vendible)
								,HashItem(L.npi_num)  
								,HashItem(L.npi_enumeration_date)
								,HashItem(L.npi_deactivation_date)
								,HashItem(L.npi_reactivation_date)
								,HashItem(L.npi_taxonomy_code)
								,HashItem(L.upin)
								,HashItem(L.medicare_participation_flag)
								,HashItem(L.date_born)
								,HashItem(L.date_died)

	              ,HashItem(L.firm_name) 
								,HashItem(L.lid)
								,HashItem(L.agid)

								,HashItem(L.state_license_state)
								,HashItem(L.state_license_number)
								,HashItem(L.state_license_type)
								,HashItem(L.state_license_active)
								,HashItem(L.state_license_qualifier)
								,HashItem(L.state_license_sub_qualifier)
								
								,HashItem(L.dea_num)
								,HashItem(L.dea_bac)
								,HashItem(L.dea_sub_bac)
								,HashItem(L.dea_schedule)
								
								,HashItem(L.csr_number)
								,HashItem(L.csr_state)
								,HashItem(L.csr_expire_date)
								,HashItem(L.csr_issue_date)
								,HashItem(L.dsa_lvl_2)
								,HashItem(L.dsa_lvl_2n)
								,HashItem(L.dsa_lvl_3)
								,HashItem(L.dsa_lvl_3n)
								,HashItem(L.dsa_lvl_4)
								,HashItem(L.dsa_lvl_5)
								,HashItem(L.csr_raw1)
								,HashItem(L.csr_raw2)
								,HashItem(L.csr_raw3)
								,HashItem(L.csr_raw4)
								
								,HashItem(L.sanction_id)
								,HashItem(L.sanction_action_code)
								,HashItem(L.sanction_action_description)
								,HashItem(L.sanction_board_code)
								,HashItem(L.sanction_board_description)
 								,HashItem(L.action_date)
								,HashItem(L.sanction_period_start_date)
								,HashItem(L.sanction_period_end_date)
								,HashItem(L.month_duration)
								,HashItem(L.fine_amount)
								,HashItem(L.offense_code)
								,HashItem(L.offense_description)
								,HashItem(L.offense_date)
								
								,HashItem(L.gsa_sanction_id)
								,HashItem(L.gsa_first)
								,HashItem(L.gsa_middle)
								,HashItem(L.gsa_last)
								,HashItem(L.gsa_suffix)
								,HashItem(L.gsa_city)
								,HashItem(L.gsa_state)
								,HashItem(L.gsa_zip)
								,HashItem(L.action_date)
								,HashItem(L.agency)
								
								,HashItem(L.fax)
								,HashItem(L.phone)

								,HashItem(L.certification_code       )
								,HashItem(L.certification_description)
								,HashItem(L.board_code               )
								,HashItem(L.board_description        )

								,HashItem(L.covered_recipient_id  )
								,HashItem(L.cov_rcp_raw_state_code)
								,HashItem(L.cov_rcp_raw_full_name )
								,HashItem(L.cov_rcp_raw_attribute1)
								,HashItem(L.cov_rcp_raw_attribute2)
								,HashItem(L.cov_rcp_raw_attribute3)
								,HashItem(L.cov_rcp_raw_attribute4)
 								
								,HashItem(L.hms_scid    )
								,HashItem(L.school_name )
								,HashItem(L.grad_year   )
								
								,HashItem(L.lang_code)
								,HashItem(L.language )
								
								,HashItem(L.specialty_description, true)
							));
				SELF := L;
		END;                  // END GetSourceRid

		d_rid	:= PROJECT(fn_individual_rollup(base_individual_specialty), GetSourceRID(left));


		matchset := ['A','D'];
		did_add.MAC_Match_Flex
			(d_rid, matchset	
			,foo  
			,clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st, clean_phone, 
			DID, track_ancillaries, TRUE, did_score, 
			75, d_did);

		did_add.MAC_Add_SSN_By_DID(d_did, did,best_ssn, d_ssn, false);
		did_add.MAC_Add_DOB_By_DID(d_ssn, did, best_dob, d_dob0, false);
		

		d_dob:=project(d_dob0
							,transform({d_dob0}
							,self.did:=if(  left.clean_dob<>''
															and left.best_dob>0
															and left.clean_dob[1..4]<>left.best_dob[1..4]
															,0
															,left.did)
							,self.did_score:=if(self.did=0,0,left.did_score)
							,self:=left));

		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,firm_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,clean_phone
			,foo
			,bdid
			,track_ancillaries
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,p_city_name
			,fname
			,mname
			,lname
			,best_ssn 
			,src
			,source_rid
			,
			);
			
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			, 
			,clean_DOB
			,phone
			,state_license_state
			,state_license_number
			,
			,dea
			,HMS_Piid
			,NPI
			,UPIN
			,DID
			,BDID
			,
			,
			,result,false,38
			);

		RETURN project(fn_individual_rollup(result),hms.Layouts.individual_base);
		
	END;
		
 	EXPORT Individual_Addresses_Base := FUNCTION

   		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
   		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_addresses_base.built, layouts.individual_addresses_base);
   
   		//standardize input(update file)
   		stdInput := HMS.StandardizeInputFile(filedate, pUseProd).Address;

   		cleanAdd_a	:= Clean_addr(stdInput, layouts.individual_addresses_base);
				
   		//Add to previous base
   		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_addresses_lBaseTemplate_built)) = 0
   												 ,cleanAdd_a
   												 ,cleanAdd_a + hist_base);
		
   		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));
			
   		new_base_s := SORT(new_base_d
												,hms_piid
												,firm_name
												,lid
												,agid           
												,address_std_code
												,latitude
												,longitude
												,clean_company_name
												,prepped_addr1
												,prepped_addr2         
												,LOCAL);

   		Layouts.individual_addresses_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
   			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
   			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
				SELF						 								:= IF(L.record_type = 'C', L, R);
				SELF 														:= [];
   		END;
   
   		base_t := ROLLUP(new_base_s
							,   LEFT.hms_piid             =RIGHT.hms_piid
							AND LEFT.firm_name            =RIGHT.firm_name
							AND LEFT.lid                  =RIGHT.lid
							AND LEFT.agid                 =RIGHT.agid
							AND LEFT.address_std_code     =RIGHT.address_std_code    
							AND LEFT.latitude             =RIGHT.latitude            
							AND LEFT.longitude            =RIGHT.longitude           
							AND LEFT.clean_company_name   =RIGHT.clean_company_name  
							AND LEFT.type                 =RIGHT.type
							AND LEFT.prepped_addr1        =RIGHT.prepped_addr1       
							AND LEFT.prepped_addr2        =RIGHT.prepped_addr2       
							,t_rollup(LEFT,RIGHT)
							,LOCAL);
			
   		//Assign source_rid
   		Layouts.individual_addresses_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 	:= HASH64(HASHMD5(
																 HashItem(L.hms_piid)
																,HashItem(L.lid)
																,HashItem(L.agid)
																,HashItem(L.address_std_code    ) 
																,HashItem(L.clean_company_name  )
																,HashItem(L.firm_name   )         
																,HashItem(L.prepped_addr1)
																,HashItem(L.prepped_addr2, true)
																));
   			SELF						  := L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));	

   		bdid_matchset := ['A'];
   		Business_Header_SS.MAC_Add_BDID_Flex
   		(
			d_rid
			,bdid_matchset
			,firm_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,foo 
			,foo
			,bdid
			,hms.layouts.individual_addresses_base
			,TRUE
			,bdid_score
			,d_bdid
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,p_city_name
			,
			,
			,
			,
			,src
			,source_rid
			,
			);
			
	Health_Facility_Services.mac_get_best_lnpid_on_thor (
					d_bdid
					,LNPID
					,clean_company_name											
					,prim_range
					,PRIM_Name
					,SEC_RANGE
					,v_city_name
					,ST
					,ZIP
					,    
					,
					,
					,
					,
					,
					,
					,hms_piid
					,  
					,
					,
					,
					,
					,        
					,BDID
					,
					,
					,dLnpidOut
					,false
					,30
					);


		with_lnpid:=dLnpidOut(lnpid>0);
		no_lnpid:=dLnpidOut(lnpid=0);


		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			no_lnpid
			,LNPID
			,
			,

			,
			,
			,
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,
			,
			,
			,
			,
			,
			,
			,hms_piid  
			,
			,
			,
			,BDID
			,
			,
			,result,false,38
			);

		RETURN result + with_lnpid;
  END;
	
	EXPORT Individual_DEA_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_dea_base.built, layouts.individual_dea_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).DEA;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_dea_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,dea_num
										,dea_bac
										,dea_sub_bac
										,dea_schedule
										,dea_expire
										,dea_rank
										,dea_active
										,LOCAL);
										
		Layouts.individual_dea_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported	:= ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							  := IF(L.record_type = 'C', L, R);
		END;

		base_i := ROLLUP(new_base_s
										,   LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.dea_num=RIGHT.dea_num
										AND LEFT.dea_bac=RIGHT.dea_bac
										AND LEFT.dea_sub_bac=RIGHT.dea_sub_bac
										AND LEFT.dea_schedule=RIGHT.dea_schedule
										AND LEFT.dea_expire=RIGHT.dea_expire
										AND LEFT.dea_rank=RIGHT.dea_rank
										AND LEFT.dea_active=RIGHT.dea_active
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

		base_p := PROJECT(base_i
									,TRANSFORM({base_i}
										,SELF:=LEFT
										));


		RETURN base_p;
	END;
	
	EXPORT Individual_Sanctions_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_sanctions_base.built, layouts.individual_sanctions_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Sanction;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_sanctions_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);			
		
		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));
		
		new_base_s := SORT(new_base_d
										,hms_piid
										,offense_code
										,offense_date
										,sanction_action_code
										,action_date
										,sanction_period_start_date
										,sanction_period_end_date
										,fine_amount
										,sanction_board_description
										,LOCAL);

		Layouts.individual_sanctions_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		base_t := ROLLUP(new_base_s,
										    LEFT.hms_piid                        =RIGHT.hms_piid                        
										AND LEFT.sanction_id                     =RIGHT.sanction_id                     
										AND LEFT.sanction_action_code            =RIGHT.sanction_action_code            
										AND LEFT.sanction_action_description     =RIGHT.sanction_action_description     
										AND LEFT.sanction_board_code             =RIGHT.sanction_board_code             
										AND LEFT.sanction_board_description      =RIGHT.sanction_board_description      
										AND LEFT.action_date                     =RIGHT.action_date                     
										AND LEFT.sanction_period_start_date      =RIGHT.sanction_period_start_date      
										AND LEFT.sanction_period_end_date        =RIGHT.sanction_period_end_date        
										AND LEFT.month_duration                  =RIGHT.month_duration                  
										AND LEFT.fine_amount                     =RIGHT.fine_amount                     
										AND LEFT.offense_code                    =RIGHT.offense_code                    
										AND LEFT.offense_description             =RIGHT.offense_description             
										AND LEFT.offense_date                    =RIGHT.offense_date                                     
										AND LEFT.clean_offense_date              =RIGHT.clean_offense_date              
										AND LEFT.clean_action_date               =RIGHT.clean_action_date               
										AND LEFT.clean_sanction_period_start_date=RIGHT.clean_sanction_period_start_date
										AND LEFT.clean_sanction_period_end_date  =RIGHT.clean_sanction_period_end_date    
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	

		RETURN base_t;
	END;
	
	EXPORT Individual_GSA_Sanctions_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_gsa_sanctions_base.built, layouts.individual_gsa_sanctions_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).GSA_Sanctions;

fn_cleanName(dataset(HMS.layouts.individual_gsa_sanctions_base) d) := FUNCTION

  NID.Mac_CleanParsedNames(d
						, cleanNames
						, firstname:=gsa_first
						, middlename:=gsa_middle
						, lastname:=gsa_last
						, namesuffix:=gsa_suffix
						, includeInRepository:=FALSE, normalizeDualNames:=FALSE
					);	
					
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

	HMS.layouts.individual_gsa_sanctions_base tr(cleanNames L) := TRANSFORM
		SELF.fname 				:= if(l.nameType='P',L.cln_fname,'');
		SELF.mname 				:= if(l.nameType='P',L.cln_mname,'');
		SELF.lname 				:= if(l.nameType='P',L.cln_lname,''); 
		SELF.name_suffix 	:= if(l.nameType='P',fGetSuffix(L.cln_suffix),'');
		SELF            	:= L;
	END;
	RETURN PROJECT(cleanNames,tr(LEFT));
END;

    cleanNames := fn_cleanName(std_input);

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_gsa_sanctions_lBaseTemplate_built)) = 0
											,cleanNames
											,cleanNames + hist_base);			
		
		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));
		
		new_base_s := SORT(new_base_d
										,hms_piid
										,gsa_sanction_id
										,gsa_first
										,gsa_middle
										,gsa_last
										,gsa_suffix
										,gsa_city
										,gsa_state
										,gsa_zip
										,action_date
										,date
										,agency
										,confidence
  									,LOCAL);

		Layouts.individual_gsa_sanctions_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		base_t := ROLLUP(new_base_s,
										    LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.gsa_sanction_id=RIGHT.gsa_sanction_id
										AND LEFT.gsa_first=RIGHT.gsa_first
										AND LEFT.gsa_middle=RIGHT.gsa_middle
										AND LEFT.gsa_last=RIGHT.gsa_last
										AND LEFT.gsa_suffix=RIGHT.gsa_suffix
										AND LEFT.gsa_city=RIGHT.gsa_city
										AND LEFT.gsa_state=RIGHT.gsa_state
										AND LEFT.gsa_zip=RIGHT.gsa_zip
										AND LEFT.action_date=RIGHT.action_date
										AND LEFT.date=RIGHT.date
										AND LEFT.agency=RIGHT.agency
										AND LEFT.confidence=RIGHT.confidence
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	

		RETURN base_t;
	END;
	
	EXPORT Individual_State_Licenses_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_state_licenses_base.built, layouts.individual_state_licenses_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).State_Licenses;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_state_licenses_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);			
		
		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));
		
		new_base_s := SORT(new_base_d
										,hms_piid
										,state_license_state
										,state_license_number
										,state_license_type
										,state_license_active
										,state_license_expire
										,state_license_qualifier
										,state_license_sub_qualifier
										,state_license_issued
										,LOCAL);

		Layouts.individual_state_licenses_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		base_t := ROLLUP(new_base_s,
										    LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.state_license_state=RIGHT.state_license_state
										AND LEFT.state_license_number=RIGHT.state_license_number
										AND LEFT.state_license_type=RIGHT.state_license_type
										AND LEFT.state_license_active=RIGHT.state_license_active
										AND LEFT.state_license_expire=RIGHT.state_license_expire
										AND LEFT.state_license_qualifier=RIGHT.state_license_qualifier
										AND LEFT.state_license_sub_qualifier=RIGHT.state_license_sub_qualifier
										AND LEFT.state_license_issued=RIGHT.state_license_issued
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	

		RETURN base_t;
	END;
	
	EXPORT Individual_State_CSR_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_state_csr_base.built, layouts.individual_state_csr_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).State_CSR;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_state_csr_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);			
		
		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));
		
		new_base_s := SORT(new_base_d
										,hms_piid
										,csr_number
										,csr_state
										,csr_expire_date
										,csr_issue_date
										,dsa_lvl_2
										,dsa_lvl_2n
										,dsa_lvl_3
										,dsa_lvl_3n
										,dsa_lvl_4
										,dsa_lvl_5
										,csr_raw1
										,csr_raw2
										,csr_raw3
										,csr_raw4
										,LOCAL);

		Layouts.individual_state_csr_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		base_t := ROLLUP(new_base_s,
												LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.csr_number=RIGHT.csr_number
										AND LEFT.csr_state=RIGHT.csr_state
										AND LEFT.csr_expire_date=RIGHT.csr_expire_date
										AND LEFT.csr_issue_date=RIGHT.csr_issue_date
										AND LEFT.dsa_lvl_2=RIGHT.dsa_lvl_2
										AND LEFT.dsa_lvl_2n=RIGHT.dsa_lvl_2n
										AND LEFT.dsa_lvl_3=RIGHT.dsa_lvl_3
										AND LEFT.dsa_lvl_3n=RIGHT.dsa_lvl_3n
										AND LEFT.dsa_lvl_4=RIGHT.dsa_lvl_4
										AND LEFT.dsa_lvl_5=RIGHT.dsa_lvl_5
										AND LEFT.csr_raw1=RIGHT.csr_raw1
										AND LEFT.csr_raw2=RIGHT.csr_raw2
										AND LEFT.csr_raw3=RIGHT.csr_raw3
										AND LEFT.csr_raw4=RIGHT.csr_raw4
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	

		RETURN base_t;
	END;
	
		
	EXPORT State_License_Types_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).state_license_types_base.built, layouts.state_license_types_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).State_License_Types;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).state_license_types_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);			
		
 		new_base_d := DISTRIBUTE(base_and_update, HASH(stlic_type));

		new_base_s := SORT(new_base_d
										,stlic_type
										,stlic_desc
										,LOCAL);

		Layouts.state_license_types_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		base_t := ROLLUP(new_base_s,
										    LEFT.stlic_type=RIGHT.stlic_type
										AND LEFT.stlic_desc=RIGHT.stlic_desc
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	

		RETURN base_t;
	END;

	EXPORT Individual_Address_Faxes_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_address_faxes_base.built, layouts.individual_address_faxes_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Address_Faxes;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_address_faxes_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,fax
										,fax_lid
										,LOCAL);
										
		Layouts.individual_address_faxes_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,LEFT.hms_piid=RIGHT.hms_piid
										 AND LEFT.fax_lid=RIGHT.fax_lid
										 AND LEFT.fax=RIGHT.fax
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

   		Layouts.individual_address_faxes_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																		HashItem(l.fax_lid) 
																		,HashItem(l.fax, true)
																		));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;

	EXPORT Individual_Address_Phones_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_address_phones_base.built, layouts.individual_address_phones_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Address_Phones;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_address_phones_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,phone_lid
										,phone
										,LOCAL);
										
		Layouts.individual_address_phones_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,LEFT.hms_piid=RIGHT.hms_piid
										 AND LEFT.phone_lid=RIGHT.phone_lid
										 AND LEFT.phone=RIGHT.phone
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

   		Layouts.individual_address_phones_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																		HashItem(l.phone_lid) 
																		,HashItem(l.phone, true)
																		));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;

	EXPORT Individual_Certifications_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_certifications_base.built, layouts.individual_certifications_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Certifications;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_certifications_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,certification_code
										,certification_description
										,board_code
										,board_description
										,expiration_year
										,issue_year
										,renewal_year
										,lifetime_flag
										,LOCAL);
										
		Layouts.individual_certifications_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.certification_code=RIGHT.certification_code
										AND LEFT.certification_description=RIGHT.certification_description
										AND LEFT.board_code=RIGHT.board_code
										AND LEFT.board_description=RIGHT.board_description
										AND LEFT.expiration_year=RIGHT.expiration_year
										AND LEFT.issue_year=RIGHT.issue_year
										AND LEFT.renewal_year=RIGHT.renewal_year
										AND LEFT.lifetime_flag=RIGHT.lifetime_flag
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

   		Layouts.individual_certifications_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																		HashItem(l.certification_code)
																		,HashItem(l.certification_description)
																		,HashItem(l.board_code)
																		,HashItem(l.board_description)
																		,HashItem(l.expiration_year)
																		,HashItem(l.issue_year)
																		,HashItem(l.renewal_year)
																		,HashItem(l.lifetime_flag, true)
																		));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;
	
		EXPORT Individual_Covered_Recipients_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_covered_recipients_base.built, layouts.individual_covered_recipients_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Covered_Recipients;

		//Clean name
		cleanNames := Clean_name(std_input, Layouts.individual_covered_recipients_base);
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_covered_recipients_lBaseTemplate_built)) = 0
												 ,cleanNames
												 ,cleanNames + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,covered_recipient_id
										,cov_rcp_raw_state_code
										,cov_rcp_raw_full_name
										,first		//raw_first_name
										,middle		//raw_middle_name
										,last			//raw_last_name
										,suffix		//raw_suffix      
										,cov_rcp_raw_attribute1
										,cov_rcp_raw_attribute2 
										,cov_rcp_raw_attribute3
										,cov_rcp_raw_attribute4
										,LOCAL);
										
		Layouts.individual_covered_recipients_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
										
		base_t := ROLLUP(new_base_s
										,LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.covered_recipient_id=RIGHT.covered_recipient_id
										AND LEFT.cov_rcp_raw_state_code=RIGHT.cov_rcp_raw_state_code
										AND LEFT.cov_rcp_raw_full_name=RIGHT.cov_rcp_raw_full_name
										AND LEFT.first=RIGHT.first
										AND LEFT.middle=RIGHT.middle
										AND LEFT.last=RIGHT.last
										AND LEFT.suffix=RIGHT.suffix
										AND LEFT.cov_rcp_raw_attribute1=RIGHT.cov_rcp_raw_attribute1
										AND LEFT.cov_rcp_raw_attribute2=RIGHT.cov_rcp_raw_attribute2 
										AND LEFT.cov_rcp_raw_attribute3=RIGHT.cov_rcp_raw_attribute3
										AND LEFT.cov_rcp_raw_attribute4=RIGHT.cov_rcp_raw_attribute4
									,t_rollup(LEFT,RIGHT)
									,LOCAL);

   		Layouts.individual_covered_recipients_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																			HashItem(l.hms_piid)
																			,HashItem(l.covered_recipient_id)
																			,HashItem(l.cov_rcp_raw_state_code)
																			,HashItem(l.cov_rcp_raw_full_name)
																			,HashItem(l.first)			//raw_first_name
																			,HashItem(l.middle)			//raw_middle_name
																			,HashItem(l.last)				//raw_last_name
																			,HashItem(l.suffix)			//raw_suffix
																			,HashItem(l.cov_rcp_raw_attribute1)
																			,HashItem(l.cov_rcp_raw_attribute2 )
																			,HashItem(l.cov_rcp_raw_attribute3)
																			,HashItem(l.cov_rcp_raw_attribute4, true)
																		));
   			SELF											:= L;
   		END;

   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;
	
	EXPORT Individual_Education_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_education_base.built, layouts.individual_education_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Education;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_education_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,hms_scid
										,school_name
										,grad_year
										,LOCAL);

										
		Layouts.individual_education_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.hms_scid=RIGHT.hms_scid
										AND LEFT.school_name=RIGHT.school_name
										AND LEFT.grad_year=RIGHT.grad_year
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

   		Layouts.individual_education_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																		HashItem(l.hms_piid)
																		,HashItem(l.hms_scid)
																		,HashItem(l.school_name)
																		,HashItem(l.grad_year, true)
																	));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;

	EXPORT Individual_Languages_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_languages_base.built, layouts.individual_languages_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Languages;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_languages_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,lang_code
										,language
										,LOCAL);
										
		Layouts.individual_languages_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,   LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.lang_code=RIGHT.lang_code
										AND LEFT.language=RIGHT.language
										,t_rollup(LEFT,RIGHT)
										,LOCAL);


   		Layouts.individual_languages_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																			 HashItem(l.hms_piid)
																			,HashItem(l.lang_code)
																			,HashItem(l.language, true)
																	));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;

	EXPORT Individual_Specialty_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_specialty_base.built, layouts.individual_specialty_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Individual_Specialty;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_specialty_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(hms_piid));

		new_base_s := SORT(new_base_d
										,hms_piid
										,specialty_description
										,LOCAL);

		Layouts.individual_specialty_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,LEFT.hms_piid=RIGHT.hms_piid
										AND LEFT.specialty_description=RIGHT.specialty_description
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

   		Layouts.individual_specialty_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																		 HashItem(l.hms_piid)
																		,HashItem(l.specialty_description, true)
																	));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;

	EXPORT Piid_Migration_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).piid_migration_base.built, layouts.piid_migration_base);

		//standardize input(update file)
		std_input := HMS.StandardizeInputFile(filedate, pUseProd).Piid_Migration;
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).piid_migration_lBaseTemplate_built)) = 0
												 ,std_input
												 ,std_input + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(new_piid));

		new_base_s := SORT(new_base_d
										,old_piid
										,new_piid
										,piid_action
										,LOCAL);
										
		Layouts.piid_migration_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,   LEFT.old_piid=RIGHT.old_piid
										AND LEFT.new_piid=RIGHT.new_piid
										AND LEFT.piid_action=RIGHT.piid_action
										,t_rollup(LEFT,RIGHT)
										,LOCAL);


   		Layouts.piid_migration_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																			 HashItem(l.old_piid)
																			,HashItem(l.new_piid)
																			,HashItem(l.piid_action, true)
																	));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		RETURN d_rid;
	END;

END;