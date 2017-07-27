import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices;

EXPORT Update_Base (string filedate, boolean pUseProd = false) := MODULE

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
			SELF.prim_range := stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.v_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.p_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
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
		#if(useFull)
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														, clean_company_name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);
		#else
		NID.Mac_CleanParsedNames(pBaseFile, cleanNames
														, firstname:=first_name,middlename:=middle_name,lastname:=last_name
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
			SELF.title 				:= IF(l.nameType='P' and L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.fname 				:= if(l.nameType='P',L.cln_fname,'');
			SELF.mname 				:= if(l.nameType='P',L.cln_mname,'');
			SELF.lname 				:= if(l.nameType='P',L.cln_lname,'');
			SELF.name_suffix 	:= if(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		RETURN PROJECT(cleanNames,tr(LEFT));
	ENDMACRO;
	
	EXPORT Facility_Base := FUNCTION
		// before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).facility_base.built, layouts.facility_base);

		//standardize input(update file)
		stdInput := Enclarity.StandardizeInputFile(filedate, pUseProd).Facility;
		
		//clean address	
		cleanAdd_a	:= Clean_addr(stdInput, layouts.facility_base)
			:PERSIST('~thor_data400::persist::enclarity::facility_addr');
			
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).facility_lBaseTemplate_built)) = 0
												 ,cleanAdd_a
												 ,cleanAdd_a + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d
											,group_key
											,dept_group_key
											,prac_company_name
											,addr_key
											,Prepped_addr1
											,Prepped_addr2
											,pv_addr_ind
											,phone1
											,fax1
											,dea_num
											,dea_num_exp
											,dea_bus_act_ind
											,lic_num_in
											,lic_state
											,lic_num
											,lic_type
											,lic_status
											,lic_begin_date
											,lic_end_date
											,lic_src_ind
											,npi_num
											,taxonomy
											,type1
											,classification
											,specialization
											,medicare_fac_num
											,oig_flag
											,sanc1_date
											,sanc1_code
										,LOCAL);
										
		Layouts.facility_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported 	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  	:= ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF.clean_last_verify_date   := ut.LatestDate	(L.clean_last_verify_date, R.clean_last_verify_date);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_f := ROLLUP(new_base_s
											,   left.group_key=right.group_key
											AND left.dept_group_key=right.dept_group_key
											AND left.prac_company_name=right.prac_company_name
											AND left.addr_key=right.addr_key
											AND left.Prepped_addr1=right.Prepped_addr1
											AND left.Prepped_addr2=right.Prepped_addr2
											AND left.pv_addr_ind=right.pv_addr_ind
											AND left.phone1=right.phone1
											AND left.fax1=right.fax1
											AND left.dea_num=right.dea_num
											AND left.dea_num_exp=right.dea_num_exp
											AND left.dea_bus_act_ind=right.dea_bus_act_ind
											AND left.lic_num_in=right.lic_num_in
											AND left.lic_state=right.lic_state
											AND left.lic_num=right.lic_num
											AND left.lic_type=right.lic_type
											AND left.lic_status=right.lic_status
											AND left.lic_begin_date=right.lic_begin_date
											AND left.lic_end_date=right.lic_end_date
											AND left.lic_src_ind=right.lic_src_ind
											AND left.npi_num=right.npi_num
											AND left.taxonomy=right.taxonomy
											AND left.type1=right.type1
											AND left.classification=right.classification
											AND left.specialization=right.specialization
											AND left.medicare_fac_num=right.medicare_fac_num
											AND left.oig_flag=right.oig_flag
											AND left.sanc1_date=right.sanc1_date
											AND left.sanc1_code=right.sanc1_code
											AND left.medicare_fac_num=right.medicare_fac_num
										,t_rollup(LEFT,RIGHT),LOCAL);	
										
		//Assign source_rid
		Layouts.facility_base GetSourceRID(base_f L)	:= TRANSFORM
			SELF.record_type 					:= if((unsigned)l.dea_num_exp >0 and l.dea_num_exp  < ut.GetDate
																			and (unsigned)l.lic_end_date>0 and l.lic_end_date < ut.GetDate
																				,'H'
																				,l.record_type);
			SELF.source_rid 					:= HASH64(hashmd5(
																	trim(l.dept_group_key)
																	,trim(l.prac_company_name)
																	,trim(l.addr_key)
																	,trim(l.Prepped_addr1)
																	,trim(l.Prepped_addr2)
																	,trim(l.pv_addr_ind)
																	,trim(l.phone1)
																	,trim(l.fax1)
																	,trim(l.dea_num)
																	,trim(l.dea_num_exp)
																	,trim(l.dea_bus_act_ind)
																	,trim(l.lic_num_in)
																	,trim(l.lic_state)
																	,trim(l.lic_num)
																	,trim(l.lic_type)
																	,trim(l.lic_status)
																	,trim(l.lic_begin_date)
																	,trim(l.lic_end_date)
																	,trim(l.lic_src_ind)
																	,trim(l.npi_num)
																	,trim(l.taxonomy)
																	,trim(l.type1)
																	,trim(l.classification)
																	,trim(l.specialization)
																	,trim(l.medicare_fac_num)
																	,trim(l.oig_flag)
																	,trim(l.sanc1_date)
																	,trim(l.sanc1_code)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(base_f, GetSourceRID(left));

		//BDID
		matchset 	:= ['A', 'P'];
		Business_Header_SS.MAC_Add_BDID_FLEX(
			d_rid
			,matchset
			,prac_company_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,clean_phone
			,foo
			,bdid
			,layouts.facility_base
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
			
		RETURN d_bdid;
	END;
	
	EXPORT Individual_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).individual_base.built, layouts.individual_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Individual;
		
		//clean name
		cleanNames := Clean_name(std_input, Layouts.individual_base)
			:PERSIST('~thor_data400::persist::enclarity::individual_names');

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_lBaseTemplate_built)) = 0
											 ,cleanNames
											 ,cleanNames + hist_base);

fn_rollup(dataset(Layouts.individual_base) d):=function

		new_base_s := SORT(d
												,group_key
												,addr_key
												,orig_fullname
												,prefix_name
												,first_name
												,middle_name
												,last_name
												,suffix_name
												,suffix_other
												,oig_flag
												,opm_flag
												,state_restrict_flag
												,provider_status
												,birth_year
												,date_of_death
												,gender
												,upin
												,clean_company_name
												,normed_addr_rec_type
												,addr_key
												,primary_location
												,prac_addr_ind
												,bill_addr_ind
												,addr_conf_score
												,addr_rectype
												,Fax1
												,Phone1
												,Prac1_Phone_ind
												,Bill1_Phone_ind
												,Prac1_Fax_Ind
												,Bill1_Fax_ind
												,clean_dob
												,clean_ssn
												,suffix_other 
												,lic_num_in
												,lic_num
												,lic_state
												,Lic_Type
												,Lic_Status
												,Lic_begin_date
												,Lic_End_date
												,npi_num
												,taxonomy
												,type1
												,classification
												,taxonomy_primary_ind
												,npi_enum_date
												,npi_deact_date
												,dea_num
												,dea_num_exp
												,Dea_bus_Act_Ind
												,sanc1_date
												,sanc1_code
												,sanc1_state
												,sanc1_lic_num
												,sanc1_rein_date
												,LOCAL);

		Layouts.individual_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF.clean_last_verify_date		:= ut.LatestDate(L.clean_last_verify_date, R.clean_last_verify_date);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_i := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.orig_fullname=right.orig_fullname
										AND left.prefix_name=right.prefix_name
										AND left.first_name=right.first_name
										AND left.middle_name=right.middle_name
										AND left.last_name=right.last_name
										AND left.suffix_name=right.suffix_name
										AND left.suffix_other=right.suffix_other
										AND left.oig_flag=right.oig_flag
										AND left.opm_flag=right.opm_flag
										AND left.state_restrict_flag=right.state_restrict_flag
										AND left.provider_status=right.provider_status
										AND left.birth_year=right.birth_year
										AND left.date_of_death=right.date_of_death
										AND left.gender=right.gender
										AND left.upin=right.upin
										AND left.clean_company_name=right.clean_company_name
										AND left.normed_addr_rec_type=right.normed_addr_rec_type
										AND left.addr_key=right.addr_key
										AND left.primary_location=right.primary_location
										AND left.prac_addr_ind=right.prac_addr_ind
										AND left.bill_addr_ind=right.bill_addr_ind
										AND left.addr_conf_score=right.addr_conf_score
										AND left.addr_rectype=right.addr_rectype
										AND left.Fax1=right.Fax1
										AND left.Phone1=right.Phone1
										AND left.Prac1_Phone_ind=right.Prac1_Phone_ind
										AND left.Bill1_Phone_ind=right.Bill1_Phone_ind
										AND left.Prac1_Fax_Ind=right.Prac1_Fax_Ind
										AND left.Bill1_Fax_ind=right.Bill1_Fax_ind
										AND left.clean_dob=right.clean_dob
										AND left.clean_ssn=right.clean_ssn
										AND left.suffix_other =right.suffix_other 
										AND left.lic_num_in=right.lic_num_in
										AND left.lic_num=right.lic_num
										AND left.lic_state=right.lic_state
										AND left.Lic_Type=right.Lic_Type
										AND left.Lic_Status=right.Lic_Status
										AND left.Lic_begin_date=right.Lic_begin_date
										AND left.Lic_End_date=right.Lic_End_date
										AND left.npi_num=right.npi_num
										AND left.taxonomy=right.taxonomy
										AND left.type1=right.type1
										AND left.classification=right.classification
										AND left.taxonomy_primary_ind=right.taxonomy_primary_ind
										AND left.npi_enum_date=right.npi_enum_date
										AND left.npi_deact_date=right.npi_deact_date
										AND left.dea_num=right.dea_num
										AND left.dea_num_exp=right.dea_num_exp
										AND left.Dea_bus_Act_Ind=right.Dea_bus_Act_Ind
										AND left.sanc1_date=right.sanc1_date
										AND left.sanc1_code=right.sanc1_code
										AND left.sanc1_state=right.sanc1_state
										AND left.sanc1_lic_num=right.sanc1_lic_num
										AND left.sanc1_rein_date=right.sanc1_rein_date
										,t_rollup(LEFT,RIGHT)
										,LOCAL);
	return base_i;
end;

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		add_file	:= distribute(Files().address_base.built, hash(group_key));
		base_a	:= JOIN(fn_rollup(new_base_d), add_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM(Layouts.individual_base
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.bdid:=right.bdid
											,SELF.bdid_score:=right.bdid_score
											,SELF.clean_company_name:=right.clean_company_name
											,SELF.normed_addr_rec_type:=right.normed_addr_rec_type
											,SELF.prim_range:=right.prim_range
											,SELF.predir:=right.predir
											,SELF.prim_name:=right.prim_name
											,SELF.addr_suffix:=right.addr_suffix
											,SELF.postdir:=right.postdir
											,SELF.unit_desig:=right.unit_desig
											,SELF.sec_range:=right.sec_range
											,SELF.p_city_name:=right.p_city_name
											,SELF.v_city_name:=right.v_city_name
											,SELF.st:=right.st
											,SELF.zip:=right.zip
											,SELF.zip4:=right.zip4
											,SELF.cart:=right.cart
											,SELF.cr_sort_sz:=right.cr_sort_sz
											,SELF.lot:=right.lot
											,SELF.lot_order:=right.lot_order
											,SELF.dbpc:=right.dbpc
											,SELF.chk_digit:=right.chk_digit
											,SELF.rec_type:=right.rec_type
											,SELF.fips_st:=right.fips_st
											,SELF.fips_county:=right.fips_county
											,SELF.geo_lat:=right.geo_lat
											,SELF.geo_long:=right.geo_long
											,SELF.msa:=right.msa
											,SELF.geo_blk:=right.geo_blk
											,SELF.geo_match:=right.geo_match
											,SELF.err_stat:=right.err_stat
											,SELF.rawaid:=right.rawaid
											,SELF.aceaid:=right.aceaid
											,SELF.addr_key:=right.addr_key
											,SELF.primary_location:=right.primary_location
											,SELF.prac_addr_ind:=right.prac_addr_ind
											,SELF.bill_addr_ind:=right.bill_addr_ind
											,SELF.addr_conf_score:=right.addr_conf_score
											,SELF.addr_rectype:=right.addr_rectype
											,SELF.clean_last_verify_date:=right.clean_last_verify_date
											,SELF.Fax1:=right.Fax1
											,SELF.Phone1:=right.Phone1
											,SELF.Prac1_Phone_ind:=right.Prac1_Phone_ind
											,SELF.Bill1_Phone_ind:=right.Bill1_Phone_ind
											,SELF.Prac1_Fax_Ind:=right.Prac1_Fax_Ind
											,SELF.Bill1_Fax_ind:=right.Bill1_Fax_ind
											,SELF.dotid:=right.dotid
											,SELF.dotscore:=right.dotscore
											,SELF.dotweight:=right.dotweight
											,SELF.empid:=right.empid
											,SELF.empscore:=right.empscore
											,SELF.empweight:=right.empweight
											,SELF.powid:=right.powid
											,SELF.powscore:=right.powscore
											,SELF.powweight:=right.powweight
											,SELF.proxid:=right.proxid
											,SELF.proxscore:=right.proxscore
											,SELF.proxweight:=right.proxweight
											,SELF.seleid:=right.seleid
											,SELF.selescore:=right.selescore
											,SELF.seleweight:=right.seleweight
											,SELF.orgid:=right.orgid
											,SELF.orgscore:=right.orgscore
											,SELF.orgweight:=right.orgweight
											,SELF.ultid:=right.ultid
											,SELF.ultscore:=right.ultscore
											,SELF.ultweight:=right.ultweight
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		dob_file	:= distribute(Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key));
		base_d	:= JOIN(fn_rollup(base_a), dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({base_a}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		ssn_file	:= distribute(Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key));
		base_s	:= JOIN(fn_rollup(base_d), ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({base_a}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		lic_file	:= distribute(Files().license_base.built, hash(group_key));
		base_l	:= JOIN(fn_rollup(base_s), lic_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({base_a}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.suffix_other  := RIGHT.suffix_other 
											,SELF.lic_num_in := RIGHT.lic_num_in
											,SELF.lic_num := RIGHT.lic_num
											,SELF.lic_state := RIGHT.lic_state
											,SELF.Lic_Type := RIGHT.Lic_Type
											,SELF.Lic_Status := RIGHT.Lic_Status
											,SELF.Lic_begin_date := RIGHT.Lic_begin_date
											,SELF.Lic_End_date := RIGHT.Lic_End_date
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		dea_file	:= distribute(Files().dea_base.built, hash(group_key));
		base_e	:= JOIN(fn_rollup(base_l), dea_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({base_a}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.dea_num := RIGHT.dea_num
											,SELF.dea_num_exp:=right.dea_num_exp
											,SELF.Dea_bus_Act_Ind:=right.Dea_bus_Act_Ind
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		npi_file	:= distribute(Files().npi_base.built, hash(group_key));
		base_n	:= JOIN(fn_rollup(base_e), npi_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({base_a}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.npi_num := RIGHT.npi_num
											,SELF.taxonomy := RIGHT.taxonomy
											,SELF.type1 := RIGHT.type1
											,SELF.classification := RIGHT.classification
											,SELF.taxonomy_primary_ind := RIGHT.taxonomy_primary_ind
											,SELF.npi_enum_date := RIGHT.npi_enum_date
											,SELF.npi_deact_date := RIGHT.npi_deact_date
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		sanc_file	:= distribute(Files().sanction_base.built, hash(group_key));
		base_z	:= JOIN(fn_rollup(base_n), sanc_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({base_a}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.sanc1_date := RIGHT.sanc1_date
											,SELF.sanc1_code := RIGHT.sanc1_code
											,SELF.sanc1_state := RIGHT.sanc1_state
											,SELF.sanc1_lic_num := RIGHT.sanc1_lic_num
											,SELF.sanc1_rein_date := RIGHT.sanc1_rein_date
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);


		//Assign source_rid
		Layouts.individual_base GetSourceRID(base_z L)	:= TRANSFORM
			SELF.source_rid 					:= HASH64(hashmd5(
																	trim(l.orig_fullname)
																	,trim(l.prefix_name)
																	,trim(l.first_name)
																	,trim(l.middle_name)
																	,trim(l.last_name)
																	,trim(l.suffix_name)
																	,trim(l.suffix_other)
																	,trim(l.oig_flag)
																	,trim(l.opm_flag)
																	,trim(l.state_restrict_flag)
																	,trim(l.provider_status)
																	,trim(l.birth_year)
																	,trim(l.date_of_death)
																	,trim(l.gender)
																	,trim(l.upin)
																	,trim(l.clean_company_name)
																	,trim(l.normed_addr_rec_type)
																	,trim(l.addr_key)
																	,trim(l.primary_location)
																	,trim(l.prac_addr_ind)
																	,trim(l.bill_addr_ind)
																	,(l.addr_conf_score)
																	,trim(l.addr_rectype)
																	,trim(l.Fax1)
																	,trim(l.Phone1)
																	,trim(l.Prac1_Phone_ind)
																	,trim(l.Bill1_Phone_ind)
																	,trim(l.Prac1_Fax_Ind)
																	,trim(l.Bill1_Fax_ind)
																	,(l.clean_last_verify_date)
																	,trim(l.clean_dob)
																	,trim(l.clean_ssn)
																	,trim(l.suffix_other )
																	,trim(l.lic_num_in)
																	,trim(l.lic_num)
																	,trim(l.lic_state)
																	,trim(l.Lic_Type)
																	,trim(l.Lic_Status)
																	,trim(l.Lic_begin_date)
																	,trim(l.Lic_End_date)
																	,trim(l.npi_num)
																	,trim(l.taxonomy)
																	,trim(l.type1)
																	,trim(l.classification)
																	,trim(l.taxonomy_primary_ind)
																	,trim(l.npi_enum_date)
																	,trim(l.npi_deact_date)
																	,trim(l.dea_num)
																	,trim(l.dea_num_exp)
																	,trim(l.Dea_bus_Act_Ind)
																	,trim(l.sanc1_date)
																	,trim(l.sanc1_code)
																	,trim(l.sanc1_state)
																	,trim(l.sanc1_lic_num)
																	,trim(l.sanc1_rein_date)
																	,trim(l.fname)
																	,trim(l.lname)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(fn_rollup(base_z), GetSourceRID(left));
		
		//DID
		matchset := ['A','D','S'];
		did_add.MAC_Match_Flex
			(d_rid, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st, '', 
			DID, Layouts.individual_base, TRUE, did_score,
			75, d_did);

		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);

		d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>left.best_dob[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));

		//BDID
		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,orig_fullname
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,''
			,foo
			,bdid
			,layouts.individual_base
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
			,clean_ssn
			,src
			,source_rid
			,
			);

		RETURN d_bdid;
	END;
			
	EXPORT Associate_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).associate_base.built, layouts.associate_base);

		//standardize input(update file) (and normalize)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Associate;

		//clean name
		cleanNames := Clean_name(std_input, Layouts.associate_base,true);

		//clean address	
		cleanAdd_a	:= Clean_addr(cleanNames, layouts.associate_base)
			:PERSIST('~thor_data400::persist::enclarity::associate_addr');

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).associate_lBaseTemplate_built)) = 0
												 ,cleanAdd_a
												 ,cleanAdd_a + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));  

		dob_file	:= distribute(Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key));
		base_d	:= JOIN(new_base_d, dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		ssn_file	:= distribute(Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key));
		base_s	:= JOIN(base_d, ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		fac_file	:= Files().facility_base.built;
		base_f	:= JOIN( distribute(base_s,hash(sloc_group_key)), fac_file
										,LEFT.sloc_group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.sloc_type	:= RIGHT.type1
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		base_f1	:= JOIN( distribute(base_f,hash(billing_group_key)), fac_file
										,LEFT.billing_group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.billing_type	:= RIGHT.type1
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		new_base_s := SORT(distribute(base_f1,hash(group_key))
									,group_key
									,Prepped_name
									,prac_addr_confidence_score
									,bill_addr_confidence_score
									,addr_key
									,Prepped_addr1
									,Prepped_addr2
									,normed_name_rec_type
									,prepped_name
									,addr_phone
									,sloc_phone
									,sloc_group_key
									,billing_group_key
									,bill_npi
									,bill_tin
									,cam_latest
									,cam_earliest
									,cbm1
									,cbm3
									,cbm6
									,cbm12
									,cbm18
									,pgk_works_for
									,pgk_is_affiliated_to
									,clean_dob
									,clean_ssn
									,sloc_type
									,billing_type
									,LOCAL);
									
		Layouts.associate_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_n := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.Prepped_name=right.Prepped_name
										AND left.prac_addr_confidence_score=right.prac_addr_confidence_score
										AND left.bill_addr_confidence_score=right.bill_addr_confidence_score
										AND left.addr_key=right.addr_key
										AND left.Prepped_addr1=right.Prepped_addr1
										AND left.Prepped_addr2=right.Prepped_addr2
										AND left.normed_name_rec_type=right.normed_name_rec_type
										AND left.prepped_name=right.prepped_name
										AND left.addr_phone=right.addr_phone
										AND left.sloc_phone=right.sloc_phone
										AND left.sloc_group_key=right.sloc_group_key
										AND left.billing_group_key=right.billing_group_key
										AND left.bill_npi=right.bill_npi
										AND left.bill_tin=right.bill_tin
										AND left.cam_latest=right.cam_latest
										AND left.cam_earliest=right.cam_earliest
										AND left.cbm1=right.cbm1
										AND left.cbm3=right.cbm3
										AND left.cbm6=right.cbm6
										AND left.cbm12=right.cbm12
										AND left.cbm18=right.cbm18
										AND left.pgk_works_for=right.pgk_works_for
										AND left.pgk_is_affiliated_to=right.pgk_is_affiliated_to
										AND left.clean_dob=right.clean_dob
										AND left.clean_ssn=right.clean_ssn
										AND left.sloc_type=right.sloc_type
										AND left.billing_type=right.billing_type
										,t_rollup(LEFT,RIGHT),LOCAL);

		//Assign source_rid
		Layouts.associate_base GetSourceRID(base_n L)	:= TRANSFORM
			SELF.source_rid :=   HASH64(hashmd5(
																	trim(l.prac_addr_confidence_score)
																	,trim(l.bill_addr_confidence_score)
																	,trim(l.addr_key)
																	,trim(l.Prepped_addr1)
																	,trim(l.Prepped_addr2)
																	,trim(l.normed_name_rec_type)
																	,trim(l.prepped_name)
																	,trim(l.addr_phone)
																	,trim(l.sloc_phone)
																	,trim(l.sloc_group_key)
																	,trim(l.billing_group_key)
																	,trim(l.bill_npi)
																	,trim(l.bill_tin)
																	,trim(l.cam_latest)
																	,trim(l.cam_earliest)
																	,(l.cbm1)
																	,(l.cbm3)
																	,(l.cbm6)
																	,(l.cbm12)
																	,(l.cbm18)
																	,trim(l.pgk_works_for)
																	,trim(l.clean_dob)
																	,trim(l.clean_ssn)
																	,trim(l.fname)
																	,trim(l.lname)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(base_n, GetSourceRID(left));

		//DID
		matchset := ['A','S','Z','P'];
		did_add.MAC_Match_Flex
			(d_rid, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st,clean_phone, 
			DID, Layouts.associate_base, TRUE, did_score,
			75, d_did);
	
		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);

		d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>left.best_dob[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));
		
		//BDID
		bdid_matchset := ['A','P'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,prepped_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,clean_phone
			,bill_tin
			,bdid
			,layouts.associate_base
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
			,clean_ssn
			,src
			,source_rid
			,
			);

		RETURN d_bdid;
	END;
	
 	EXPORT Address_Base := FUNCTION
   		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
   		hist_base	:= Mark_history(Files(filedate,pUseProd).address_base.built, layouts.address_base);
   
   		//standardize input(update file)
   		stdInput := Enclarity.StandardizeInputFile(filedate, pUseProd).Address;

   		cleanAdd_a	:= Clean_addr(stdInput, layouts.address_base)
   			:PERSIST('~thor_data400::persist::enclarity::address_addr');	
				
   		//Add to previous base
   		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).address_lBaseTemplate_built)) = 0
   												 ,cleanAdd_a
   												 ,cleanAdd_a + hist_base);

   		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

   		new_base_s := SORT(new_base_d
												,group_key
												,addr_key
												,Prepped_addr1
												,Prepped_addr2
												,prac_addr_ind
												,bill_addr_ind
												,phone1
												,prac1_phone_ind
												,bill1_phone_ind
												,phone1_last_contact_date
												,phone2
												,prac2_phone_ind
												,bill2_phone_ind
												,phone2_last_contact_date
												,phone3
												,prac3_phone_ind
												,bill3_phone_ind
												,phone3_last_contact_date
												,fax1
												,prac1_fax_ind
												,bill1_fax_ind
												,fax2
												,prac2_fax_ind
												,bill2_fax_ind
												,fax3
												,prac3_fax_ind
												,bill3_fax_ind
												,prac_company_name
												,last_verified_date
												,addr_conf_score
												,addr_rectype
												,primary_location
												,LOCAL);
   										
   		Layouts.address_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
   			SELF.dt_vendor_first_reported 	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
   			SELF.dt_vendor_last_reported  	:= ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 									:= IF(L.record_type = 'C', L, R);
   		END;
   
   		base_t := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.addr_key=right.addr_key
										AND left.Prepped_addr1=right.Prepped_addr1
										AND left.Prepped_addr2=right.Prepped_addr2
										AND left.prac_addr_ind=right.prac_addr_ind
										AND left.bill_addr_ind=right.bill_addr_ind
										AND left.phone1=right.phone1
										AND left.prac1_phone_ind=right.prac1_phone_ind
										AND left.bill1_phone_ind=right.bill1_phone_ind
										AND left.phone1_last_contact_date=right.phone1_last_contact_date
										AND left.phone2=right.phone2
										AND left.prac2_phone_ind=right.prac2_phone_ind
										AND left.bill2_phone_ind=right.bill2_phone_ind
										AND left.phone2_last_contact_date=right.phone2_last_contact_date
										AND left.phone3=right.phone3
										AND left.prac3_phone_ind=right.prac3_phone_ind
										AND left.bill3_phone_ind=right.bill3_phone_ind
										AND left.phone3_last_contact_date=right.phone3_last_contact_date
										AND left.fax1=right.fax1
										AND left.prac1_fax_ind=right.prac1_fax_ind
										AND left.bill1_fax_ind=right.bill1_fax_ind
										AND left.fax2=right.fax2
										AND left.prac2_fax_ind=right.prac2_fax_ind
										AND left.bill2_fax_ind=right.bill2_fax_ind
										AND left.fax3=right.fax3
										AND left.prac3_fax_ind=right.prac3_fax_ind
										AND left.bill3_fax_ind=right.bill3_fax_ind
										AND left.prac_company_name=right.prac_company_name
										AND left.last_verified_date=right.last_verified_date
										AND left.addr_conf_score=right.addr_conf_score
										AND left.addr_rectype=right.addr_rectype
										AND left.primary_location=right.primary_location
										,t_rollup(LEFT,RIGHT)
										,LOCAL);								
   		
   		//Assign source_rid
   		Layouts.address_base GetSourceRID(base_t L)	:= TRANSFORM
   			SELF.source_rid 					:= HASH64(hashmd5(
																		trim(l.addr_key)
																		,trim(l.Prepped_addr1)
																		,trim(l.Prepped_addr2)
																		,trim(l.prac_addr_ind)
																		,trim(l.bill_addr_ind)
																		,trim(l.phone1)
																		,trim(l.prac1_phone_ind)
																		,trim(l.bill1_phone_ind)
																		,trim(l.phone1_last_contact_date)
																		,trim(l.phone2)
																		,trim(l.prac2_phone_ind)
																		,trim(l.bill2_phone_ind)
																		,trim(l.phone2_last_contact_date)
																		,trim(l.phone3)
																		,trim(l.prac3_phone_ind)
																		,trim(l.bill3_phone_ind)
																		,trim(l.phone3_last_contact_date)
																		,trim(l.fax1)
																		,trim(l.prac1_fax_ind)
																		,trim(l.bill1_fax_ind)
																		,trim(l.fax2)
																		,trim(l.prac2_fax_ind)
																		,trim(l.bill2_fax_ind)
																		,trim(l.fax3)
																		,trim(l.prac3_fax_ind)
																		,trim(l.bill3_fax_ind)
																		,trim(l.prac_company_name)
																		,trim(l.last_verified_date)
																		,(l.addr_conf_score)
																		,trim(l.addr_rectype)
																		,trim(l.primary_location)
																		));
   			SELF											:= L;
   		END;
   		
   		d_rid	:= PROJECT(base_t, GetSourceRID(left));
   	
   		//BDID
   		bdid_matchset := ['A','P'];
   		Business_Header_SS.MAC_Add_BDID_Flex
   		(
			d_rid
			,bdid_matchset
			,prac_company_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,clean_phone
			,foo
			,bdid
			,layouts.address_base
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

   		RETURN d_bdid;
   	END;
		
	EXPORT DEA_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).dea_base.built, layouts.dea_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).DEA;
		
		cleanAdd_a	:= clean_addr(std_input, layouts.dea_base)
			:PERSIST('~thor_data400::persist::enclarity::dea_addr');
			
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).dea_lBaseTemplate_built)) = 0
												 ,cleanAdd_a
												 ,cleanAdd_a + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d
										,group_key
										,dea_num
										,dea_num_exp
										,dea_bus_act_ind
										,dea_bus_act_ind_sub
										,dea_drug_schedule
										,dea_num_deact_date
										,addr_key
										,Prepped_addr1
										,Prepped_addr2
										,LOCAL);
										
		Layouts.dea_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_i := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.dea_num=right.dea_num
										AND left.dea_num_exp=right.dea_num_exp
										AND left.dea_bus_act_ind=right.dea_bus_act_ind
										AND left.dea_bus_act_ind_sub=right.dea_bus_act_ind_sub
										AND left.dea_drug_schedule=right.dea_drug_schedule
										AND left.dea_num_deact_date=right.dea_num_deact_date
										AND left.addr_key=right.addr_key
										AND left.Prepped_addr1=right.Prepped_addr1
										AND left.Prepped_addr2=right.Prepped_addr2
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

		base_p:=PROJECT(base_i
									,transform({base_i}
										,SELF.record_type:= if((unsigned)left.dea_num_exp > 0 and left.dea_num_exp < ut.GetDate,'H',left.record_type)
										,SELF:=LEFT
										));

		RETURN base_p;
	END;
	
	EXPORT License_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).license_base.built, layouts.license_base);
	
		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).License;

		//clean name
		cleanNames := Clean_name(std_input, Layouts.license_base);

		//clean address	
		cleanAdd_a	:= Clean_addr(cleanNames, layouts.license_base)
			:PERSIST('~thor_data400::persist::enclarity::license_addr');
			
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).license_lBaseTemplate_built)) = 0
											 ,cleanAdd_a
											 ,cleanAdd_a + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));  

		dob_file	:= distribute(Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key));
		base_d	:= JOIN(new_base_d, dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		ssn_file	:= distribute(Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key));
		base_s	:= JOIN(base_d, ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		new_base_s := SORT(base_s
										,group_key
										,orig_fullname
										,prefix_name
										,first_name
										,middle_name
										,last_name
										,suffix_name
										,suffix_other
										,lic_num_in
										,lic_state
										,lic_num
										,lic_type
										,lic_status
										,lic_begin_date
										,lic_end_date
										,addr_key
										,Prepped_addr1
										,Prepped_addr2
										,clean_dob
										,clean_ssn
										,LOCAL);
		
		Layouts.license_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_i := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.orig_fullname=right.orig_fullname
										AND left.prefix_name=right.prefix_name
										AND left.first_name=right.first_name
										AND left.middle_name=right.middle_name
										AND left.last_name=right.last_name
										AND left.suffix_name=right.suffix_name
										AND left.suffix_other=right.suffix_other
										AND left.lic_num_in=right.lic_num_in
										AND left.lic_state=right.lic_state
										AND left.lic_num=right.lic_num
										AND left.lic_type=right.lic_type
										AND left.lic_status=right.lic_status
										AND left.lic_begin_date=right.lic_begin_date
										AND left.lic_end_date=right.lic_end_date
										AND left.addr_key=right.addr_key
										AND left.Prepped_addr1=right.Prepped_addr1
										AND left.Prepped_addr2=right.Prepped_addr2
										AND left.clean_dob=right.clean_dob
										AND left.clean_ssn=right.clean_ssn
										,t_rollup(LEFT,RIGHT),LOCAL);																																			
										
		//Assign source_rid
		Layouts.license_base GetSourceRID(base_i L)	:= TRANSFORM
			SELF.record_type 					:= if((unsigned)l.lic_end_date>0 and l.lic_end_date < ut.GetDate,'H',l.record_type);
			SELF.source_rid 					:= HASH64(hashmd5(
																	trim(l.orig_fullname)
																	,trim(l.prefix_name)
																	,trim(l.first_name)
																	,trim(l.middle_name)
																	,trim(l.last_name)
																	,trim(l.suffix_name)
																	,trim(l.suffix_other)
																	,trim(l.lic_num_in)
																	,trim(l.lic_state)
																	,trim(l.lic_num)
																	,trim(l.lic_type)
																	,trim(l.lic_status)
																	,trim(l.lic_begin_date)
																	,trim(l.lic_end_date)
																	,trim(l.addr_key)
																	,trim(l.Prepped_addr1)
																	,trim(l.Prepped_addr2)
																	,trim(l.clean_dob)
																	,trim(l.clean_ssn)
																	,trim(l.fname)
																	,trim(l.lname)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(base_i, GetSourceRID(left));

		//DID
		matchset := ['A','S','Z'];
		did_add.MAC_Match_Flex
			(d_rid, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st,'', 
			DID, Layouts.license_base, true, did_score,
			75, d_did);
	
		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);

		d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>left.best_dob[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));
		
		//BDID
		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,orig_fullname
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,''
			,foo
			,bdid
			,layouts.license_base
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
			,clean_ssn
			,src
			,source_rid
			,
			);

		RETURN d_bdid;
	END;
	
	EXPORT Taxonomy_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).taxonomy_base.built, layouts.taxonomy_base);
		
		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Taxonomy;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).taxonomy_lBaseTemplate_built)) = 0
										   ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		npi_file	:= distribute(Files().npi_base.built, hash(group_key));
		base_n	:= JOIN(new_base_d, npi_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.taxonomy_primary_ind := RIGHT.taxonomy_primary_ind
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		new_base_s := SORT(base_n
										,group_key
										,taxonomy
										,type1
										,classification
										,specialization
										,taxonomy_primary_ind
										,LOCAL);
										
		Layouts.taxonomy_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.group_key 			= RIGHT.group_key 			AND 
										LEFT.taxonomy 			= RIGHT.taxonomy 				AND				
										LEFT.type1 					= RIGHT.type1 					AND						
										LEFT.classification = RIGHT.classification 	AND	
										LEFT.specialization = RIGHT.specialization  AND
										LEFT.taxonomy_primary_ind = RIGHT.taxonomy_primary_ind,
										t_rollup(LEFT,RIGHT),LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT NPI_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).npi_base.built, layouts.npi_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).npi;

		//clean name
		cleanNames := Clean_name(std_input, Layouts.npi_base);

		//clean address	
		cleanAdd_a	:= Clean_addr(cleanNames, layouts.npi_base)
			:PERSIST('~thor_data400::persist::enclarity::npi_addr');
			
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).npi_lBaseTemplate_built)) = 0
											 ,cleanAdd_a
											 ,cleanAdd_a + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		dob_file	:= distribute(Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key));
		base_d	:= JOIN(new_base_d, dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		ssn_file	:= distribute(Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key));
		base_s	:= JOIN(base_d, ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		new_base_s := SORT(base_s
											,group_key
											,npi_num
											,taxonomy
											,type1
											,classification
											,specialization
											,taxonomy_primary_ind
											,last_name
											,first_name
											,middle_name
											,other_last_name
											,other_first_name
											,other_middle_name
											,other_name_type
											,company_name
											,other_company_name
											,other_company_name_type
											,parent_organization_name
											,addr_key
											,Prepped_addr1
											,Prepped_addr2
											,phone1
											,npi_type
											,npi_sole_proprietor
											,npi_deact_date
											,npi_enum_date
										,LOCAL);
						
		Layouts.npi_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_i := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.npi_num=right.npi_num
										AND left.taxonomy=right.taxonomy
										AND left.type1=right.type1
										AND left.classification=right.classification
										AND left.specialization=right.specialization
										AND left.taxonomy_primary_ind=right.taxonomy_primary_ind
										AND left.last_name=right.last_name
										AND left.first_name=right.first_name
										AND left.middle_name=right.middle_name
										AND left.other_last_name=right.other_last_name
										AND left.other_first_name=right.other_first_name
										AND left.other_middle_name=right.other_middle_name
										AND left.other_name_type=right.other_name_type
										AND left.company_name=right.company_name
										AND left.other_company_name=right.other_company_name
										AND left.other_company_name_type=right.other_company_name_type
										AND left.parent_organization_name=right.parent_organization_name
										AND left.addr_key=right.addr_key
										AND left.Prepped_addr1=right.Prepped_addr1
										AND left.Prepped_addr2=right.Prepped_addr2
										AND left.phone1=right.phone1
										AND left.npi_type=right.npi_type
										AND left.npi_sole_proprietor=right.npi_sole_proprietor
										AND left.npi_deact_date=right.npi_deact_date
										AND left.npi_enum_date=right.npi_enum_date
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	
		
		//Assign source_rid
		Layouts.npi_base GetSourceRID(base_i L)	:= TRANSFORM
			SELF.source_rid 	:= HASH64(hashmd5(
																	trim(l.npi_num)
																	,trim(l.taxonomy)
																	,trim(l.type1)
																	,trim(l.classification)
																	,trim(l.specialization)
																	,trim(l.taxonomy_primary_ind)
																	,trim(l.last_name)
																	,trim(l.first_name)
																	,trim(l.middle_name)
																	,trim(l.other_last_name)
																	,trim(l.other_first_name)
																	,trim(l.other_middle_name)
																	,trim(l.other_name_type)
																	,trim(l.company_name)
																	,trim(l.other_company_name)
																	,trim(l.other_company_name_type)
																	,trim(l.parent_organization_name)
																	,trim(l.addr_key)
																	,trim(l.Prepped_addr1)
																	,trim(l.Prepped_addr2)
																	,trim(l.phone1)
																	,trim(l.npi_type)
																	,trim(l.npi_sole_proprietor)
																	,trim(l.npi_deact_date)
																	,trim(l.npi_enum_date)
																	,trim(l.fname)
																	,trim(l.lname)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(base_i, GetSourceRID(left));
																														
		//DID
		matchset := ['A','S','Z'];
		did_add.MAC_Match_Flex
			(d_rid, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st,'', 
			DID, Layouts.npi_base, TRUE, did_score,
			75, d_did);
			
		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);

		d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>left.best_dob[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));

		//BDID
		bdid_matchset := ['A','P'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			d_dob
			,bdid_matchset
			,company_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,phone1
			,foo
			,bdid
			,layouts.npi_base
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
			,clean_ssn
			,src
			,source_rid
			,
			);

		RETURN d_bdid;
	END;
	
	EXPORT Medschool_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).medschool_base.built, layouts.medschool_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).medschool;

		//Add to previous base			
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).medschool_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										medschool,						
										medschool_year,							
										LOCAL);
										
		Layouts.medschool_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := rollup(new_base_s,
										LEFT.group_key 			= RIGHT.group_key 			AND 
										LEFT.medschool 			= RIGHT.medschool 			AND				
										LEFT.medschool_year = RIGHT.medschool_year,						
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			
		RETURN base_t;
	END;
	
	EXPORT Tax_Codes_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).tax_codes_base.built, layouts.tax_codes_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Tax_Codes;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).tax_codes_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(taxonomy, type1, classification, specialization));

		new_base_s := SORT(new_base_d
										,taxonomy
										,type1
										,classification
										,specialization
										,definition
										,effect_date
										,deact_date
										,last_mod_date
										,notes
										,LOCAL);
										
		Layouts.tax_codes_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s
										,   left.taxonomy=right.taxonomy
										AND left.type1=right.type1
										AND left.classification=right.classification
										AND left.specialization=right.specialization
										AND left.definition=right.definition
										AND left.effect_date=right.effect_date
										AND left.deact_date=right.deact_date
										AND left.last_mod_date=right.last_mod_date
										AND left.notes=right.notes
										,t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT Prov_SSN_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).prov_ssn_base.built, layouts.prov_ssn_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Prov_SSN;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).prov_ssn_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										ssn,						
										LOCAL);
										
		Layouts.prov_ssn_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.group_key 		= RIGHT.group_key AND
										LEFT.ssn 					= RIGHT.ssn,			
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT Specialty_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).specialty_base.built, layouts.specialty_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).specialty;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).specialty_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										spec_code,						
										spec_desc,
										LOCAL);
						
		Layouts.specialty_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.group_key 		= RIGHT.group_key 	AND
										LEFT.spec_code 		= RIGHT.spec_code 	AND		
										LEFt.spec_desc 		= RIGHT.spec_desc,
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT Sanc_Prov_type_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).sanc_prov_type_base.built, layouts.sanc_prov_type_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).sanc_prov_type;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).sanc_prov_type_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(prov_type_code, prov_type_desc));

		new_base_s := SORT(new_base_d,
										prov_type_code,						
										prov_type_desc,
										LOCAL);
						
		base_dedup	:= DEDUP(new_base_s, RECORD, LOCAL);
		
		Layouts.sanc_prov_type_base t_rollup(base_dedup L, base_dedup R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(base_dedup,
										LEFT.prov_type_code = RIGHT.prov_type_code AND
										LEFT.prov_type_desc = RIGHT.prov_type_desc,
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT Sanc_Codes_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).sanc_codes_base.built, layouts.sanc_codes_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).sanc_codes;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).sanc_codes_lBaseTemplate_built)) = 0
										 ,std_input
										 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(sanc_code, sanc_desc));

		new_base_s := SORT(new_base_d,
										sanc_code,						
										sanc_desc,
										LOCAL);
										
		Layouts.sanc_codes_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(l.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.sanc_code 		= RIGHT.sanc_code 	AND
										LEFT.sanc_desc 		= RIGHT.sanc_desc,
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT DEA_BACodes_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).dea_BAcodes_base.built, layouts.dea_BAcodes_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).dea_BAcodes;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).dea_BAcodes_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(dea_bus_act_ind, dea_bus_act_ind_sub));

		new_base_s := SORT(new_base_d
										,dea_bus_act_ind
										,dea_bus_act_ind_sub
										,desc
										,LOCAL);
										
		Layouts.dea_BAcodes_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.dea_bus_act_ind 			= RIGHT.dea_bus_act_ind 		AND				
										LEFT.dea_bus_act_ind_sub 	= RIGHT.dea_bus_act_ind_sub AND
										LEFT.desc 								= RIGHT.desc,
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT Prov_birthdate_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).prov_birthdate_base.built, layouts.prov_birthdate_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Prov_birthdate;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).prov_birthdate_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										date_of_birth,						
										LOCAL);
			
		Layouts.prov_birthdate_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.group_key 			= RIGHT.group_key 		AND 
										LEFT.date_of_birth 	= RIGHT.date_of_birth,			
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;

	EXPORT Sanction_Base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).sanction_base.built, layouts.sanction_base);

		//standardize input(update file)
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).sanction;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).sanction_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d
											,group_key
											,sanc1_date
											,sanc1_code
											,sanc1_state
											,sanc1_lic_num
											,sanc1_prof_type
											,sanc1_rein_date
										,LOCAL);
		
		Layouts.sanction_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := ut.LatestDate	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.group_key 				= RIGHT.group_key 			AND 
										LEFT.sanc1_date 			= RIGHT.sanc1_date 			AND				
										LEFT.sanc1_code 			= RIGHT.sanc1_code 			AND
										LEFT.sanc1_state 			= RIGHT.sanc1_state 		AND
										LEFT.sanc1_lic_num 		= RIGHT.sanc1_lic_num 	AND
										LEFT.sanc1_prof_type 	= RIGHT.sanc1_prof_type AND
										LEFT.sanc1_rein_date 	= RIGHT.sanc1_rein_date,
										t_rollup(LEFT,RIGHT)
										,LOCAL);																																			

		RETURN base_t;
	END;
	
	EXPORT Collapse_Base := FUNCTION
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Collapse;
		new_base_d := dedup(std_input, record, all);
		RETURN new_base_d;
	END;

	EXPORT Split_Base := FUNCTION
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Split;
		new_base_d := dedup(std_input, record, all);
		RETURN new_base_d;
	END;

	EXPORT Drop_Base := FUNCTION
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Drop;
		new_base_d := dedup(std_input, record, all);
		RETURN new_base_d;
	END;

END;