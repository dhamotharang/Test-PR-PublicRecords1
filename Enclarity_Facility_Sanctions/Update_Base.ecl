IMPORT Address, Ut, lib_STRINGlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, Enclarity_facility_sanctions, Scrubs;

EXPORT Update_Base (STRING pVersion, BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.record_type		:= 'H';//IF(L.filecode in Enclarity_Facility_Sanctions.Filecode_Control(pVersion,pUseProd).fullrefresh_filecodes or
															     //	L.filecode in Enclarity_Facility_Sanctions.Filecode_Control(pVersion,pUseProd).fullwithrein_filecodes, 'H', 'C');
				SELF								:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;
		
	EXPORT Facility_Sanctions_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity_facility_sanctions.Files(pVersion,pUseProd).facility_sanctions_base.built, Enclarity_facility_sanctions.layouts.base.facility_sanctions);
		
		stdInput	:= Enclarity_facility_sanctions.StandardizeInputFile(pVersion,pUseProd).facility_sanctions;

		Enclarity_facility_sanctions.Layouts.base.facility_sanctions GetSourceRID(stdInput L)	:= TRANSFORM
			SELF.source_rid 					:= HASH64(HASHMD5(
																	 TRIM(l.surrogate_key) + ','
																	+TRIM(l.prac_company1_in) + ','
																	+TRIM(l.prac_company1_key) + ','
																	+TRIM(l.prac_company1_name) + ','
																	+TRIM(l.prac_company1_apcfirm1) + ','
																	+TRIM(l.prac_phone1) + ','
																	+TRIM(l.bill_phone1) + ','
																	+TRIM(l.prac_fax1) + ','
																	+TRIM(l.bill_fax1) + ','
																	+TRIM(l.email_addr) + ','
																	+TRIM(l.web_site) + ','
																	+TRIM(l.tin1) + ','
																	+TRIM(l.lic1_num_in) + ','
																	+TRIM(l.lic1_state) + ','
																	+TRIM(l.lic1_num) + ','
																	+TRIM(l.lic1_type) + ','
																	+TRIM(l.lic1_status) + ','
																	+TRIM(l.lic1_begin_date) + ','
																	+TRIM(l.lic1_end_date) + ','
																	+TRIM(l.lic1_drug_schedule) + ','
																	+TRIM(l.prac1_key) + ','
																	+TRIM(l.prac1_primary_address) + ','
																	+TRIM(l.prac1_secondary_address) + ','
																	+TRIM(l.prac1_city) + ','
																	+TRIM(l.prac1_state) + ','
																	+TRIM(l.prac1_zip) + ','
																	+TRIM(l.prac1_zip4) + ','
																	+TRIM(l.prac1_rectype) + ','
																	+TRIM(l.bill1_key) + ','
																	+TRIM(l.bill1_primary_address) + ','
																	+TRIM(l.bill1_secondary_address) + ','
																	+TRIM(l.bill1_city) + ','
																	+TRIM(l.bill1_state) + ','
																	+TRIM(l.bill1_zip) + ','
																	+TRIM(l.bill1_zip4) + ','
																	+TRIM(l.bill1_rectype) + ','
																	+TRIM((string)l.sequence_num) + ','
																	+TRIM(l.project_num) + ','
																	+TRIM(l.filecode) + ','
																	+TRIM(l.state_mask) + ','
																	+TRIM(l.dept_code) + ','
																	+TRIM(l.provider_id) + ','
																	+TRIM(l.npi_num) + ','
																	+TRIM(l.npi_deact_date) + ','
																	+TRIM(l.group_key)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(stdInput, GetSourceRID(LEFT));
		
		//assign a unique_id for NORMALIZE/DENORMALIZE (not denormalizing at this stage, but this may be needed later)
		ut.MAC_Sequence_Records(d_rid,record_sequence,d_rid_seq);

		Enclarity_Facility_Sanctions.Layouts.base.Facility_Sanctions tNormCompany(Enclarity_Facility_Sanctions.Layouts.base.facility_sanctions L, unsigned cnt) := TRANSFORM, SKIP ((cnt = 1 AND L.prac_company1_name = '') OR (cnt = 2 AND L.dba_name = '') OR (cnt = 3 AND L.bill_company1_name = ''))
			SELF.record_sequence					:= L.record_sequence;
			SELF.normed_company_type			:= cnt;
			prep_company_name 						:= CHOOSE(cnt, l.prac_company1_name, l.dba_name, l.bill_company1_name);
			SELF.clean_company_name 			:= ut.CleanCompany(prep_company_name);
			SELF													:= L;
		END;
		
		cleanedNames := NORMALIZE(d_rid_seq, 3, tNormCompany(LEFT,counter));
		
		cleanedAddr	:= Enclarity_facility_sanctions.Proc_Get_AID.facility_sanctions(cleanedNames);
			
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity_facility_sanctions.Filenames(pVersion, pUseProd).facility_sanctions_lBaseTemplate_built)) = 0
												 ,cleanedAddr
												 ,cleanedAddr + hist_base);	
												 
		//get BDID, lnfid	
		withBDID	:= Enclarity_facility_sanctions.Proc_Get_Company_IDs.facility_sanctions(base_and_update);		

		temp_add_severity	:= RECORD
			{withBDID};
			string1 severity	:= '0';
		END;
		
		base_expanded	:= PROJECT(withBDID, transform(temp_add_severity
										,self.ln_derived_rein_date:=if(left.record_type = 'C',''   ,left.ln_derived_rein_date)
										,self.ln_derived_rein_flag:=if(left.record_type = 'C',false,left.ln_derived_rein_flag)
										,self:=left
										));

		// split base file by sanction level to derive reinstatement date for the appropriate record
		ds_cumulative 	:= base_expanded(level = 1);
		ds_fullrefresh	:= base_expanded(level = 2);
		ds_fullwithrein	:= base_expanded(level = 3);

		sort_cumulative := SORT(ds_cumulative
											,lnfid
											,filecode
											,TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
											,sanc1_complaint
											,sanc1_state
											,lic1_num
											,lic1_type
											,TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
											// ,lic_status
										,LOCAL);

		sort_cumulative t_rollup(sort_cumulative L, sort_cumulative R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 								:= IF(L.record_type = 'C', L, R);
		END;
		
		cumulative_update := ROLLUP(sort_cumulative,
										LEFT.lnfid		 						= RIGHT.lnfid			 			AND 
										LEFT.filecode							= RIGHT.filecode				AND
										TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
													= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) 			AND				
										LEFT.sanc1_complaint 			= RIGHT.sanc1_complaint	AND
										LEFT.sanc1_state 					= RIGHT.sanc1_state 		AND
										LEFT.lic1_num 						= RIGHT.lic1_num 				AND
										LEFT.lic1_type 						= RIGHT.lic1_type 			AND
										TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
												= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) AND
										LEFT.sanc1_description_ef	= RIGHT.sanc1_description_ef,
										t_rollup(LEFT,RIGHT)
										,LOCAL);	

		cumulative_wseverity := JOIN(cumulative_update, Enclarity_facility_sanctions.Sanction_Code_Lookup.dsSancLookup,
										LEFT.sanc1_complaint=RIGHT.code,
										transform({cumulative_update}, 
												SELF.severity	:= RIGHT.severity,
												SELF					:= LEFT),
												LEFT OUTER, LOOKUP);

		cumulative_temp:=project(cumulative_wseverity,{
														 cumulative_wseverity
														,string8 temp_st_revoke_dt := ''
														,string8 temp_mcd_revoke_dt	:= ''
														,string8 temp_st_rein_dt:=''
														,string8 temp_mcd_rein_dt:=''
														});
														
		st_rein_codes			:= ['OTHR'];
		st_revoke_codes		:= ['CandDP','DEB','OTHE','LICD','REV','TERM','EXP','SUX','SMEP',
													'SMEPO','LL','PROB','SUSP'];
		mcd_rein_codes		:= ['SMR'];
		mcd_revoke_codes	:= ['SME'];
		
		cumulative_temp_dst :=distribute(cumulative_temp,hash(lnfid,filecode,sanc1_state));
		cumulative_temp_srt :=sort(cumulative_temp_dst,lnfid,filecode,sanc1_state,local);
		cumulative_temp_grp :=group(cumulative_temp_srt,lnfid,filecode,sanc1_state);
		cumulative_temp_std	:=sort(cumulative_temp_grp
										,-sanc1_date
										,map(
 										 sanc1_complaint in st_rein_codes		=>2
										,sanc1_complaint in st_revoke_codes	=>4
										,sanc1_complaint in mcd_rein_codes	=>6
										,sanc1_complaint in mcd_revoke_codes=>8
										,99)
										);

		cumulative_temp tr_iter(cumulative_temp_std l, cumulative_temp_std r) :=transform
			self.temp_st_rein_dt  	:= if(r.sanc1_complaint in st_rein_codes, 	r.clean_sanc1_date,l.temp_st_rein_dt);
			self.temp_st_revoke_dt  := if(r.sanc1_complaint in st_revoke_codes, r.clean_sanc1_date,l.temp_st_revoke_dt);
			self.temp_mcd_rein_dt   := if(r.sanc1_complaint in mcd_rein_codes,	r.clean_sanc1_date,l.temp_mcd_rein_dt);
			self.temp_mcd_revoke_dt := if(r.sanc1_complaint in mcd_revoke_codes,r.clean_sanc1_date,l.temp_mcd_revoke_dt);
			self.LN_derived_rein_date:=map(
																 r.sanc1_complaint in st_rein_codes
																											=> self.temp_st_rein_dt

																,r.sanc1_complaint in st_revoke_codes
																											=> self.temp_st_rein_dt

																,r.sanc1_complaint in mcd_rein_codes
																											=> self.temp_mcd_rein_dt

																,r.sanc1_complaint in mcd_revoke_codes
																											=> self.temp_mcd_rein_dt

																,r.LN_derived_rein_date
																);
			self.LN_derived_rein_flag:=if(
																		 r.sanc1_complaint not in [st_rein_codes,mcd_rein_codes]
																		 and (unsigned)self.LN_derived_rein_date>0
																				,true
																				,r.LN_derived_rein_flag
																		);
			self:=r;
		end;

		it1:=iterate(cumulative_temp_std(record_type = 'C'),tr_iter(left,right)) + cumulative_temp_std(record_type = 'H');
		flags_set	:= ungroup(project(it1, Enclarity_facility_sanctions.Layouts.base.facility_sanctions));
		
		flags_sort := SORT(flags_set,
	                    prac_company1_name,
											prac1_primary_address,
											prac1_secondary_address, 
											prac1_state, 
											prac1_city, 
											prac1_zip,
											filecode,
											normed_company_type,
											prac_phone1,
											bill_phone1,
											prac_fax1,
											bill_fax1,
											email_addr,
											web_site,
											tin1,
											lic1_num_in,
											lic1_state,
											lic1_num,
											lic1_type,
											lic1_status,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											prac1_zip4,
											dept_code,
											provider_id,
											npi_num,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											medicare_fac_num,
											medicaid_fac_num,
											facility_type,
											taxonomy,
											sanc1_state,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											sanc1_case,
											sanc1_source,
											sanc1_complaint, 
										  dba_name,
											bill_company1_name,
											clia_num,
											clia_status_code,
											clia_cert_type_code,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											contact_name_ef,
											contact_first_ef,	
											contact_middle_ef,
											contact_last_ef,
											sanc1_board_name,
											sanc1_board_type,
											sanc1_type,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											sanc1_description_ef,  
											sanc1_terms_ef,
											sanc1_condition_ef,
											sanc1_fine_ef,
											sanc1_case_num_ef,	
											provider_status_ef,
											LN_derived_rein_date,
											LN_derived_rein_flag,
										LOCAL);

		flags_sort derived_rollup(flags_sort  L, flags_sort R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 								:= IF(L.record_type = 'C', L, R);
		END;
		
		cumulative_set := ROLLUP(flags_sort,
								LEFT.prac_company1_name				= RIGHT.prac_company1_name
						AND LEFT.prac1_primary_address		= RIGHT.prac1_primary_address
						AND LEFT.prac1_secondary_address 	= RIGHT.prac1_secondary_address
						AND LEFT.prac1_state							= RIGHT.prac1_state
						AND LEFT.prac1_city								= RIGHT.prac1_city
						AND LEFT.prac1_zip								= RIGHT.prac1_zip
						AND LEFT.filecode									= RIGHT.filecode
						AND LEFT.normed_company_type			= RIGHT.normed_company_type
						AND LEFT.prac_phone1							= RIGHT.prac_phone1
						AND LEFT.bill_phone1							= RIGHT.bill_phone1
						AND LEFT.prac_fax1								= RIGHT.prac_fax1
						AND LEFT.bill_fax1								= RIGHT.bill_fax1
						AND LEFT.email_addr								= RIGHT.email_addr
						AND LEFT.web_site									= RIGHT.web_site
						AND LEFT.tin1											= RIGHT.tin1
						AND LEFT.lic1_num_in 							= RIGHT.lic1_num_in
            AND LEFT.lic1_state								= RIGHT.lic1_state					  
						AND LEFT.lic1_num									= RIGHT.lic1_num
						AND LEFT.Lic1_Type								= RIGHT.Lic1_Type
						AND LEFT.lic1_status							= RIGHT.lic1_status
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.Lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.Lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.Lic1_End_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.Lic1_End_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND	LEFT.normed_company_type			= RIGHT.normed_company_type
						AND LEFT.prac1_zip4								= RIGHT.prac1_zip4
						AND LEFT.dept_code								= RIGHT.dept_code
						AND LEFT.provider_id							= RIGHT.provider_id
						AND LEFT.npi_num									= RIGHT.npi_num
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND LEFT.medicare_fac_num					= RIGHT.medicare_fac_num
						AND LEFT.medicaid_fac_num					= RIGHT.medicaid_fac_num
						AND LEFT.facility_type						= RIGHT.facility_type
						AND LEFT.taxonomy									= RIGHT.taxonomy
						AND LEFT.sanc1_state							= RIGHT.sanc1_state
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND LEFT.sanc1_case								= RIGHT.sanc1_case
            AND LEFT.sanc1_source							= RIGHT.sanc1_source
						AND LEFT.sanc1_complaint 					= RIGHT.sanc1_complaint
						AND LEFT.dba_name									= RIGHT.dba_name
						AND LEFT.bill_company1_name				= RIGHT.bill_company1_name
						AND LEFT.clia_num									= RIGHT.clia_num
						AND LEFT.clia_status_code					= RIGHT.clia_status_code
						AND LEFT.clia_cert_type_code			= RIGHT.clia_cert_type_code
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND LEFT.contact_name_ef 					= RIGHT.contact_name_ef
						AND LEFT.contact_first_ef 				= RIGHT.contact_first_ef
						AND LEFT.contact_middle_ef	  		= RIGHT.contact_middle_ef		
						AND LEFT.contact_last_ef 					= RIGHT.contact_last_ef
						AND LEFT.sanc1_board_name 				= RIGHT.sanc1_board_name
						AND LEFT.sanc1_board_type 				= RIGHT.sanc1_board_type
						AND LEFT.sanc1_type 							= RIGHT.sanc1_type
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND LEFT.sanc1_description_ef 		= RIGHT.sanc1_description_ef
						AND LEFT.sanc1_terms_ef 					= RIGHT.sanc1_terms_ef
						AND LEFT.sanc1_condition_ef 			= RIGHT.sanc1_condition_ef
						AND LEFT.sanc1_fine_ef			 			= RIGHT.sanc1_fine_ef
						AND LEFT.sanc1_case_num_ef 				= RIGHT.sanc1_case_num_ef
						AND LEFT.provider_status_ef 			= RIGHT.provider_status_ef
						AND LEFT.LN_derived_rein_date			= RIGHT.LN_derived_rein_date
						AND LEFT.LN_derived_rein_flag			= RIGHT.LN_derived_rein_flag
						,derived_rollup(LEFT,RIGHT)
										,LOCAL);	
		
		noncumulative_set	:= ds_fullrefresh + ds_fullwithrein;
		
		all_together	:= project(noncumulative_set,enclarity_facility_sanctions.Layouts.base.facility_sanctions) + cumulative_set;
		
		dist_all := DISTRIBUTE(all_together, HASH(prac_company1_name, prac1_primary_address, prac1_secondary_address, prac1_state, prac1_city, prac1_zip, filecode, normed_company_type));  
		sort_all := SORT(dist_all,
	                    prac_company1_name,
											prac1_primary_address,
											prac1_secondary_address, 
											prac1_state, 
											prac1_city, 
											prac1_zip,
											filecode,
											normed_company_type,
											prac_phone1,
											bill_phone1,
											prac_fax1,
											bill_fax1,
											email_addr,
											web_site,
											tin1,
											lic1_num_in,
											lic1_state,
											lic1_num,
											lic1_type,
											lic1_status,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											prac1_zip4,
											dept_code,
											provider_id,
											npi_num,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											medicare_fac_num,
											medicaid_fac_num,
											facility_type,
											taxonomy,
											sanc1_state,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											sanc1_case,
											sanc1_source,
											sanc1_complaint, 
										  dba_name,
											bill_company1_name,
											clia_num,
											clia_status_code,
											clia_cert_type_code,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											contact_name_ef,
											contact_first_ef,	
											contact_middle_ef,
											contact_last_ef,
											sanc1_board_name,
											sanc1_board_type,
											sanc1_type,
											TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT),         	
											sanc1_description_ef,  
											sanc1_terms_ef,
											sanc1_condition_ef,
											sanc1_fine_ef,
											sanc1_case_num_ef,	
											provider_status_ef,
											LN_derived_rein_date,
											LN_derived_rein_flag,
	                    LOCAL);
		
		Enclarity_facility_sanctions.Layouts.base.facility_sanctions t_rollall (sort_all L, sort_all R) := TRANSFORM
			SELF.date_first_seen             := (STRING)ut.EarliestDate ((INTEGER)L.date_first_seen, (INTEGER)R.date_first_seen);
			SELF.date_last_seen              := (STRING)ut.LatestDate ((INTEGER)L.date_last_seen, (INTEGER)R.date_last_seen);
			SELF.date_vendor_first_reported  := ut.EarliestDate(L.date_vendor_first_reported, L.date_vendor_first_reported);
			SELF.date_vendor_last_reported   := ut.LatestDate(L.date_vendor_last_reported, L.date_vendor_last_reported);
			SELF.source_rid		          	   := IF(L.date_vendor_first_reported < R.date_vendor_first_reported, L.source_rid, R.source_rid);
			SELF						 							   := IF(L.record_type = 'C', L, R);
		END;

		roll_all := rollup(sort_all,
								LEFT.prac_company1_name				= RIGHT.prac_company1_name
						AND LEFT.prac1_primary_address		= RIGHT.prac1_primary_address
						AND LEFT.prac1_secondary_address 	= RIGHT.prac1_secondary_address
						AND LEFT.prac1_state							= RIGHT.prac1_state
						AND LEFT.prac1_city								= RIGHT.prac1_city
						AND LEFT.prac1_zip								= RIGHT.prac1_zip
						AND LEFT.filecode									= RIGHT.filecode
						AND LEFT.normed_company_type			= RIGHT.normed_company_type
						AND LEFT.prac_phone1							= RIGHT.prac_phone1
						AND LEFT.bill_phone1							= RIGHT.bill_phone1
						AND LEFT.prac_fax1								= RIGHT.prac_fax1
						AND LEFT.bill_fax1								= RIGHT.bill_fax1
						AND LEFT.email_addr								= RIGHT.email_addr
						AND LEFT.web_site									= RIGHT.web_site
						AND LEFT.tin1											= RIGHT.tin1
						AND LEFT.lic1_num_in 							= RIGHT.lic1_num_in
            AND LEFT.lic1_state								= RIGHT.lic1_state					  
						AND LEFT.lic1_num									= RIGHT.lic1_num
						AND LEFT.Lic1_Type								= RIGHT.Lic1_Type
						AND LEFT.lic1_status							= RIGHT.lic1_status
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.Lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.Lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.Lic1_End_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.Lic1_End_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND	LEFT.normed_company_type			= RIGHT.normed_company_type
						AND LEFT.prac1_zip4								= RIGHT.prac1_zip4
						AND LEFT.dept_code								= RIGHT.dept_code
						AND LEFT.provider_id							= RIGHT.provider_id
						AND LEFT.npi_num									= RIGHT.npi_num
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND LEFT.medicare_fac_num					= RIGHT.medicare_fac_num
						AND LEFT.medicaid_fac_num					= RIGHT.medicaid_fac_num
						AND LEFT.facility_type						= RIGHT.facility_type
						AND LEFT.taxonomy									= RIGHT.taxonomy
						AND LEFT.sanc1_state							= RIGHT.sanc1_state
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND LEFT.sanc1_case								= RIGHT.sanc1_case
            AND LEFT.sanc1_source							= RIGHT.sanc1_source
						AND LEFT.sanc1_complaint 					= RIGHT.sanc1_complaint
						AND LEFT.dba_name									= RIGHT.dba_name
						AND LEFT.bill_company1_name				= RIGHT.bill_company1_name
						AND LEFT.clia_num									= RIGHT.clia_num
						AND LEFT.clia_status_code					= RIGHT.clia_status_code
						AND LEFT.clia_cert_type_code			= RIGHT.clia_cert_type_code
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND LEFT.contact_name_ef 					= RIGHT.contact_name_ef
						AND LEFT.contact_first_ef 				= RIGHT.contact_first_ef
						AND LEFT.contact_middle_ef	  		= RIGHT.contact_middle_ef		
						AND LEFT.contact_last_ef 					= RIGHT.contact_last_ef
						AND LEFT.sanc1_board_name 				= RIGHT.sanc1_board_name
						AND LEFT.sanc1_board_type 				= RIGHT.sanc1_board_type
						AND LEFT.sanc1_type 							= RIGHT.sanc1_type
            AND TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(LEFT.sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT) = 
								TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(RIGHT.sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT)
						AND LEFT.sanc1_description_ef 		= RIGHT.sanc1_description_ef
						AND LEFT.sanc1_terms_ef 					= RIGHT.sanc1_terms_ef
						AND LEFT.sanc1_condition_ef 			= RIGHT.sanc1_condition_ef
						AND LEFT.sanc1_fine_ef			 			= RIGHT.sanc1_fine_ef
						AND LEFT.sanc1_case_num_ef 				= RIGHT.sanc1_case_num_ef
						AND LEFT.provider_status_ef 			= RIGHT.provider_status_ef
						AND LEFT.LN_derived_rein_date			= RIGHT.LN_derived_rein_date
						AND LEFT.LN_derived_rein_flag			= RIGHT.LN_derived_rein_flag
						,t_rollall(LEFT, RIGHT),LOCAL);
																
		final_set	:= project(roll_all, Enclarity_facility_sanctions.Layouts.base.facility_sanctions);

		RETURN final_set;
	END;
END;