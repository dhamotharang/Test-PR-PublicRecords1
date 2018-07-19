import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility, Std;

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
		hist_base	:= Mark_history(enclarity.Files(filedate,pUseProd).facility_base.built, Enclarity.layouts.facility_base);

		stdInput := Enclarity.StandardizeInputFile(filedate, pUseProd).Facility;
		
		cleanAdd_a	:= Clean_addr(stdInput, Enclarity.layouts.facility_base)
			:PERSIST('~thor_data400::persist::enclarity::facility_addr');
			
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).facility_lBaseTemplate_built)) = 0
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
											,clia_status_code
											,clia_num
											,clia_end_date
											,clia_cert_type_code
											,clia_cert_eff_date
											,ncpdp_id
											,tin1
										,LOCAL);
										
		Enclarity.Layouts.facility_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported 	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  	:= max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF.clean_last_verify_date   := max	(L.clean_last_verify_date, R.clean_last_verify_date);
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
											AND left.clia_status_code=right.clia_status_code
											AND left.clia_num=right.clia_num
											AND left.clia_end_date=right.clia_end_date
											AND left.clia_cert_type_code=right.clia_cert_type_code
											AND left.clia_cert_eff_date=right.clia_cert_eff_date
											AND left.ncpdp_id=right.ncpdp_id
											AND left.tin1=right.tin1
										,t_rollup(LEFT,RIGHT),LOCAL);	
										
		Enclarity.Layouts.facility_base GetSourceRID(base_f L)	:= TRANSFORM
			SELF.record_type 					:= if((unsigned)l.dea_num_exp >0 and l.dea_num_exp  < (string8)Std.Date.Today()
																			and (unsigned)l.lic_end_date>0 and l.lic_end_date < (string8)Std.Date.Today()
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
			,Enclarity.layouts.facility_base
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
					,//sanc_tin
					,tin1
					,phone1
					,fax1
					,//sanc_sancst
					,//sanc_licnbr
					,//Input_DEA_NUMBER
					,group_key
					,npi_num
					,clia_num
					,medicare_fac_num
					,//Input_MEDICAID_NUMBER
					,ncpdp_id
					,taxonomy
					,BDID
					,//SRC
					,//SOURCE_RID
					,dLnpidOut
					,false
					,30
					);

		with_lnpid:=dLnpidOut(lnpid>0);
		no_lnpid:=dLnpidOut(lnpid=0);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			no_lnpid
			,LNPID
			,//FNAME
			,//MNAME
			,//LNAME
			,//name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,//clean_SSN
			,//clean_DOB
			,clean_Phone
			,LIC_STATE
			,LIC_Num_in
			,//TAX_ID
			,DEA_NUM
			,group_key
			,NPI_NUM
			,//UPIN
			,//DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);
			
		RETURN result + with_lnpid;
	END;
	
	EXPORT Individual_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).individual_base.built, Enclarity.layouts.individual_base);
													
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Individual(Files(filedate,pUseProd).individual_input);
		sort_std	:= sort(distribute(std_input, hash(group_key, last_name, first_name, prefix_name, orig_fullname, suffix_name, suffix_other)), group_key, last_name, first_name, prefix_name, orig_fullname, suffix_name, suffix_other, local);
										
fn_cleanName(dataset(enclarity.Layouts.individual_base) d) := FUNCTION

	NID.Mac_CleanParsedNames(d, cleanNames
													, firstname:=first_name,middlename:=middle_name,lastname:=last_name
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
																			
	enclarity.layouts.individual_base tr(cleanNames L) := TRANSFORM
		SELF.title 				:= IF(l.nameType='P' and L.cln_title IN ['MR','MS'], L.cln_title, '');
		SELF.fname 				:= if(l.nameType='P',L.cln_fname,'');
		SELF.mname 				:= if(l.nameType='P',L.cln_mname,'');
		SELF.lname 				:= if(l.nameType='P',L.cln_lname,'');
		SELF.name_suffix 	:= if(l.nameType='P',fGetSuffix(L.cln_suffix),'');
		SELF            	:= L;
	END;
	RETURN PROJECT(cleanNames,tr(LEFT));
END;
		
		cleanNames := fn_cleanName(sort_std):PERSIST('~thor_data400::persist::enclarity::individual_names');
		
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).individual_lBaseTemplate_built)) = 0
											 ,cleanNames
											 ,cleanNames + hist_base);
											 
		track_ancillaries:= record
			enclarity.Layouts.individual_base;
			integer addr	:= 0;
			integer	dob		:= 0;
			integer	ssn		:= 0;
			integer	lic		:= 0;
			integer	dea		:= 0;
			integer	npi		:= 0;
			integer	sanc	:= 0;
			integer num_c	:= 0;
		end;
		
		expand_base_and_update	:= project(base_and_update, track_ancillaries);

fn_rollup(dataset(track_ancillaries) d):=function

		new_base_s := SORT(distribute(d, hash(group_key,last_name,first_name,prefix_name,orig_fullname,suffix_name,suffix_other))
												,group_key
												,last_name
												,first_name
												,prefix_name												
												,orig_fullname
												,suffix_name
												,suffix_other
												,middle_name
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
												,dea_num
												,dea_num_exp
												,Dea_bus_Act_Ind
												,sanc1_date
												,sanc1_code
												,sanc1_state
												,sanc1_lic_num
												,sanc1_rein_date
												,LOCAL);

		track_ancillaries t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF.clean_last_verify_date		:= max	(L.clean_last_verify_date, R.clean_last_verify_date);
			sum_L := L.addr + L.dob + L.ssn + L.lic + L.dea + L.npi + L.sanc;
			sum_R := R.addr + R.dob + R.ssn + R.lic + R.dea + R.npi + R.sanc;
			SELF						 							:= map(
																					l.record_type='C' and r.record_type='C' and sum_L > sum_R => L
																					,l.record_type='C' and r.record_type='C' and sum_L < sum_R => R
																					,l.record_type='H' and r.record_type='H' and sum_L > sum_R => L
																					,l.record_type='H' and r.record_type='H' and sum_L < sum_R => R
																					,l.record_type='C' => L
																					, R
																					);
		END;

		base_i := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.last_name=right.last_name
										AND left.first_name=right.first_name
										AND left.prefix_name=right.prefix_name										
										AND left.orig_fullname=right.orig_fullname
										AND left.suffix_name=right.suffix_name
										AND left.suffix_other=right.suffix_other
										AND left.middle_name=right.middle_name
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
		new_base_d := fn_rollup(expand_base_and_update);
		
		c_base_d	:= sort(distribute(new_base_d((record_type <> 'H') or (record_type = 'H' and addr_key = '')), hash(group_key)), group_key, local); // anything that is NOT historical
		h_base_d	:= sort(distribute(new_base_d(record_type = 'H' and addr_key <> ''), hash(group_key, addr_key)), group_key, addr_key, local);
		
		add_file	:= sort(distribute(enclarity.Files().address_base.built, hash(group_key)), group_key, local);
		c_base_a	:= JOIN(c_base_d, add_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM(track_ancillaries
											,SELF.addr:=if(right.record_type in ['','C'],1,0)
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
										
		h_base_a	:= JOIN(h_base_d,
											sort(distribute(add_file, hash(group_key, addr_key)), group_key, addr_key, local)
										,LEFT.group_key = RIGHT.group_key and
										 LEFT.addr_key  = RIGHT.addr_key
										,TRANSFORM(track_ancillaries
											,SELF.addr:=if(right.record_type in ['','C'],1,0)
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		all_addr	:= c_base_a + h_base_a;
		sort_addr	:= fn_rollup(all_addr);

		dob_file	:= sort(distribute(enclarity.Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key)), group_key, local);
		base_d	:= JOIN(sort(distribute(sort_addr, hash(group_key)), group_key, local), dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({sort_addr}
											,SELF.dob:=if(right.record_type in ['','C'],1,0);
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
		all_dob	:= base_d;
		sort_dob	:= fn_rollup(all_dob);

		ssn_file	:= sort(distribute(enclarity.Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key)), group_key, local);
		base_s	:= JOIN(sort(distribute(sort_dob, hash(group_key)), group_key, local), ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({sort_dob}
											,SELF.ssn:=if(right.record_type in ['','C'],1,0);
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
		all_ssn	:= base_s;
		sort_ssn	:= fn_rollup(all_ssn);

		c_sort_ssn	:= sort_ssn(record_type <> 'H' or (record_type = 'H' and lic_num = ''));
		h_sort_ssn	:= sort_ssn(record_type = 'H' and lic_num <> '');
		
		lic_file	:= sort(distribute(enclarity.Files().license_base.built(record_type = 'C' or (record_type = 'H' and lic_state <> 'MO')), hash(group_key)), group_key, local);
		c_base_l	:= JOIN(sort(distribute(c_sort_ssn, hash(group_key)), group_key, local), lic_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({sort_ssn}
											,SELF.lic:=if(right.record_type in ['','C'],1,0);
											,SELF.suffix_other  := RIGHT.suffix_other 
											,SELF.lic_num_in 		:= RIGHT.lic_num_in
											,SELF.lic_num 			:= RIGHT.lic_num
											,SELF.lic_state 		:= RIGHT.lic_state
											,SELF.Lic_Type 			:= RIGHT.Lic_Type
											,SELF.Lic_Status 		:= RIGHT.Lic_Status
											,SELF.Lic_begin_date:= RIGHT.Lic_begin_date
											,SELF.Lic_End_date 	:= RIGHT.Lic_End_date
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
										
				h_base_l	:= JOIN(sort(distribute(h_sort_ssn, hash(group_key, lic_num)), group_key, lic_num, local), 
													sort(distribute(lic_file, hash(group_key, lic_num)), group_key, lic_num, local)
										,   LEFT.group_key = RIGHT.group_key and
												LEFT.lic_num   = RIGHT.lic_num
										,TRANSFORM({h_sort_ssn}
											,SELF.lic:=if(right.record_type in ['','C'],1,0);
											,SELF.suffix_other  := RIGHT.suffix_other 
											,SELF.lic_num_in 		:= RIGHT.lic_num_in
											,SELF.lic_num 			:= RIGHT.lic_num
											,SELF.lic_state 		:= RIGHT.lic_state
											,SELF.Lic_Type 			:= RIGHT.Lic_Type
											,SELF.Lic_Status 		:= RIGHT.Lic_Status
											,SELF.Lic_begin_date:= RIGHT.Lic_begin_date
											,SELF.Lic_End_date 	:= RIGHT.Lic_End_date
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
								
		all_lic	:= c_base_l + h_base_l;
		sort_lic	:= fn_rollup(all_lic);
		
		c_sort_lic	:= sort_lic(record_type <> 'H' or(record_type = 'H' and dea_num = ''));
		h_sort_lic	:= sort_lic(record_type = 'H' and dea_num <> '');
		
		dea_file	:= sort(distribute(enclarity.Files().dea_base.built, hash(group_key)), group_key, local);
		c_base_e	:= JOIN(sort(distribute(c_sort_lic, hash(group_key)), group_key, local), dea_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({sort_lic}
											,SELF.dea:=if(right.record_type in ['','C'],1,0)
											,SELF.dea_num 				:= RIGHT.dea_num
											,SELF.dea_num_exp			:=right.dea_num_exp
											,SELF.Dea_bus_Act_Ind	:=right.Dea_bus_Act_Ind
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
										
		h_base_e	:= JOIN(sort(distribute(h_sort_lic, hash(group_key, dea_num)), group_key, dea_num, local), 
											sort(distribute(dea_file, hash(group_key, dea_num)), group_key, dea_num, local)
										,   LEFT.group_key = RIGHT.group_key and
												LEFT.dea_num	= RIGHT.dea_num
										,TRANSFORM({sort_lic}
											,SELF.dea:=if(right.record_type in ['','C'],1,0)
											,SELF.dea_num 				:= RIGHT.dea_num
											,SELF.dea_num_exp			:=right.dea_num_exp
											,SELF.Dea_bus_Act_Ind	:=right.Dea_bus_Act_Ind
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		all_dea := c_base_e + h_base_e;
		sort_dea	:= fn_rollup(all_dea);
		
		c_sort_dea	:= sort_dea(record_type <> 'H' or (record_type = 'H' and npi_num = ''));
		h_sort_dea	:= sort_dea(record_type = 'H' and npi_num <> '');
		npi_file	:= sort(distribute(enclarity.Files().npi_base.built, hash(group_key)), group_key, local);
		
		c_base_n	:= JOIN(sort(distribute(c_sort_dea, hash(group_key)), group_key, local), npi_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({sort_dea}
											,SELF.npi:=if(right.record_type in ['','C'],1,0)
											,SELF.npi_num 							:= RIGHT.npi_num
											,SELF.taxonomy 							:= RIGHT.taxonomy
											,SELF.type1 								:= RIGHT.type1
											,SELF.classification 				:= RIGHT.classification
											,SELF.taxonomy_primary_ind 	:= RIGHT.taxonomy_primary_ind
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
										
		h_base_n	:= JOIN(sort(distribute(h_sort_dea, hash(group_key, npi_num)), group_key, npi_num, local), 
											sort(distribute(npi_file, hash(group_key, npi_num)), group_key, npi_num, local)
										,   LEFT.group_key = RIGHT.group_key and
												LEFT.npi_num	 = RIGHT.npi_num
										,TRANSFORM({sort_dea}
											,SELF.npi:=if(right.record_type in ['','C'],1,0)
											,SELF.npi_num 							:= RIGHT.npi_num
											,SELF.taxonomy 							:= RIGHT.taxonomy
											,SELF.type1 								:= RIGHT.type1
											,SELF.classification 				:= RIGHT.classification
											,SELF.taxonomy_primary_ind 	:= RIGHT.taxonomy_primary_ind
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);

		all_npi	:= c_base_n + h_base_n;
		sort_npi	:= fn_rollup(all_npi);

		sanc_file	:= sort(distribute(enclarity.Files().sanction_base.built, hash(group_key)), group_key, local);
		base_z	:= JOIN(sort(distribute(sort_npi, hash(group_key)), group_key, local), sanc_file
										,   LEFT.group_key = RIGHT.group_key
										,TRANSFORM({sort_npi}
											,SELF.sanc:=if(right.record_type in ['','C'],1,0)
											,SELF.sanc1_date 			:= RIGHT.sanc1_date
											,SELF.sanc1_code 			:= RIGHT.sanc1_code
											,SELF.sanc1_state 		:= RIGHT.sanc1_state
											,SELF.sanc1_lic_num 	:= RIGHT.sanc1_lic_num
											,SELF.sanc1_rein_date := RIGHT.sanc1_rein_date
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL);
		all_sanc	:= base_z;
		sort_sanc	:= fn_rollup(all_sanc);
		
		track_ancillaries GetSourceRID(base_z L)	:= TRANSFORM
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
		
		d_rid	:= PROJECT(sort_sanc, GetSourceRID(left));
		sort_rid	:= fn_rollup(d_rid);
		has_did	:= sort_rid(did > 0);
		needs_did	:= sort_rid(did = 0);
		
		dedup_needs_did	:= dedup(sort(distribute(needs_did, hash(clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st)), clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st, local), clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st, local);
		
		matchset := ['A','D','S'];
		did_add.MAC_Match_Flex
			// (d_rid, matchset,					
			(dedup_needs_did, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st, '', 
			DID, track_ancillaries, TRUE, did_score,
			75, d_did);
			
			needs_did_srt	:= sort(distribute(needs_did,hash(group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st)), group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st, local);
												
			d_did_srt	:= sort(distribute(d_did,hash(group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st)), group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st, local);

			rejoin_did	:= join(needs_did_srt,d_did_srt,
							left.group_key		= right.group_key
					and	left.clean_ssn		= right.clean_ssn
					and left.clean_dob		= right.clean_dob
					and left.fname				= right.fname
					and left.mname				= right.mname
					and left.lname				= right.lname
					and left.name_suffix	= right.name_suffix
					and left.prim_range		= right.prim_range
					and left.prim_name		= right.prim_name
					and left.sec_range		= right.sec_range
					and left.zip					= right.zip
					and left.st						= right.st
			,TRANSFORM(track_ancillaries
					,SELF.did							:= right.did
					,SELF.did_score				:= right.did_score
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);		

		all_did	:= has_did + rejoin_did;
		sort_did	:= fn_rollup(all_did);

		// did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		// did_add.MAC_Add_SSN_By_DID(all_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_SSN_By_DID(sort_did,did,best_ssn,d_ssn);
	
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);
		sort_bestbd	:= fn_rollup(d_dob0);

		// d_dob:=project(d_dob0
		d_dob:=project(sort_bestbd
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>((STRING)left.best_dob)[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));

		has_bdid		:= d_dob(bdid > 0);
		needs_bdid	:= d_dob(bdid = 0);
		
		dedup_needs_bdid	:= dedup(sort(distribute(needs_bdid, hash(orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn)), orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn, local), orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn, local);
		
		bdid_matchset := ['A'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			dedup_needs_bdid
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
			,clean_ssn
			,src
			,source_rid
			,
			);

			needs_bdid_srt	:= sort(distribute(needs_bdid, hash(group_key, orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn)), group_key, orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn, local);
			
			d_bdid_srt	:= sort(distribute(d_bdid, hash(group_key, orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn)), group_key, orig_fullname, prim_range, prim_name, zip, sec_range, st,
											p_city_name, fname, mname, lname, clean_ssn, local);
												
			rejoin_bdid	:= join(needs_bdid_srt,d_bdid_srt,
							left.group_key			= right.group_key
					and	left.orig_fullname	= right.orig_fullname
					and left.prim_range		= right.prim_range
					and left.prim_name		= right.prim_name
					and left.zip					= right.zip
					and left.sec_range		= right.sec_range
					and left.st						= right.st
					and left.p_city_name	= right.p_city_name
					and left.fname				= right.fname
					and left.mname				= right.mname
					and left.lname				= right.lname
					and left.clean_ssn		= right.clean_ssn
			,TRANSFORM(track_ancillaries
					,SELF.bdid						:= right.bdid
					,SELF.bdid_score			:= right.bdid_score
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);		
			
		all_bdid	:= has_bdid + rejoin_bdid;
		sort_bdid	:= fn_rollup(all_bdid);
				
		needs_lnpid	:= dedup(sort(distribute(sort_bdid, hash(fname, mname, lname, name_suffix, prim_range, prim_name,
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num, group_key,
												npi_num, upin, did, bdid)), fname, mname, lname, name_suffix, prim_range, prim_name, 
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num, group_key,
												npi_num, upin, did, bdid, local), fname, mname, name_suffix, prim_range, prim_name,
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num, group_key,
												npi_num, upin, did, bdid, local);
		
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			needs_lnpid
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,clean_SSN
			,clean_DOB
			,phone1
			,LIC_STATE
			,LIC_Num_in
			,//TAX_ID
			,DEA_NUM
			,group_key
			,NPI_NUM
			,UPIN
			,DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);
			
			sort_bdid_srt	:= sort(distribute(sort_bdid,hash(group_key, fname, mname, lname, name_suffix, prim_range, prim_name,
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num,
												npi_num, upin, did, bdid)), fname, mname, lname, name_suffix, prim_range, prim_name, 
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num,
												npi_num, upin, did, bdid, local);
			result_srt	:= sort(distribute(result,hash(group_key, fname, mname, lname, name_suffix, prim_range, prim_name,
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num,
												npi_num, upin, did, bdid)), fname, mname, lname, name_suffix, prim_range, prim_name, 
												sec_range, v_city_name, st, zip, clean_ssn, clean_dob, phone1, lic_state, lic_num_in, dea_num,
												npi_num, upin, did, bdid, local);

			rejoin_lnpid	:= join(sort_bdid_srt, result_srt,
							left.group_key		= right.group_key
					and	left.fname				= right.fname
					and left.mname				= right.mname
					and left.lname				= right.lname
					and left.name_suffix	= right.name_suffix
					and left.prim_range		= right.prim_range
					and left.prim_name		= right.prim_name
					and left.sec_range		= right.sec_range
					and left.v_city_name	= right.v_city_name
					and left.st						= right.st
					and left.zip					= right.zip
					and left.clean_ssn		= right.clean_ssn
					and left.clean_dob		= right.clean_dob
					and left.phone1				= right.phone1
					and left.lic_state		= right.lic_state
					and left.lic_num_in		= right.lic_num_in
					and left.dea_num			= right.dea_num
					and left.npi_num			= right.npi_num
					and left.upin					= right.upin
					and left.did					= right.did
					and left.bdid 				= right.bdid
			,TRANSFORM(track_ancillaries
					,SELF.lnpid						:= right.lnpid
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);					
		
		// all_lnpid	:= has_lnpid + rejoin_lnpid;
		all_lnpid	:= rejoin_lnpid;
		sort_lnpid	:= fn_rollup(all_lnpid);
		
		pre_final_base	:= project(sort_lnpid, enclarity.Layouts.individual_base);		
		get_historical_mo_provs	:= pre_final_base(lic_state = 'MO' and record_type = 'H');
		non_historical_provs		:= pre_final_base(record_type = 'C');
		non_mo_historical				:= pre_final_base(lic_state <> 'MO' and record_type = 'H');
		
		get_mo_apn		:= get_historical_mo_provs(taxonomy[1..4] = '363L' or taxonomy[1..4] = '364S' or taxonomy[1..3] = '367');
		
		non_mo_apn		:= get_historical_mo_provs(taxonomy[1..4] <> '363L' and taxonomy[1..4] <> '364S' and taxonomy[1..3] <> '367');
		
		clear_exp_stat	:= project(get_mo_apn, 
																transform(enclarity.Layouts.individual_base,
																	self.lic_end_date	:= '00000000',
																	self.lic_status		:= '',
																	self							:= left));
																	
		recombined_provs	:= non_historical_provs + non_mo_historical + non_mo_apn + clear_exp_stat;

		RETURN recombined_provs;
	END;
			
	EXPORT Associate_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).associate_base.built, layouts.associate_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Associate;
		
		sort_std	:= sort(distribute(std_input, hash(group_key, addr_key, prac_addr_confidence_score, bill_addr_confidence_score, sloc_group_key, billing_group_key, cam_latest, cam_earliest, cbm1, cbm3, cbm6, cbm12, cbm18)), 
								group_key, addr_key, prac_addr_confidence_score, bill_addr_confidence_score, sloc_group_key, billing_group_key, cam_latest, cam_earliest, cbm1, cbm3, cbm6, cbm12, cbm18, skew(0.1,0.5), local);
		
		cleanNames := Clean_name(sort_std, Enclarity.Layouts.associate_base,true):persist('~thor_data400::persist::enclarity::associate_afternames');

		cleanAdd_a	:= Clean_addr(cleanNames, Enclarity.layouts.associate_base):PERSIST('~thor_data400::persist::enclarity::associate_addr');

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).associate_lBaseTemplate_built)) = 0
												 ,cleanAdd_a
												 ,cleanAdd_a + hist_base);
												 
fn_rollup(dataset(enclarity.layouts.associate_base) d) := function
											 
		new_base_s := SORT(distribute(d, hash(group_key, addr_key, normed_name_rec_type, prepped_name, addr_phone, sloc_phone,
												sloc_group_key, billing_group_key, bill_npi, bill_tin, clean_dob, clean_ssn, sloc_type, billing_type))
									,group_key
									,addr_key
									,normed_name_rec_type
									,prepped_name
									,addr_phone
									,sloc_phone
									,sloc_group_key
									,billing_group_key
									,bill_npi
									,bill_tin
									,clean_dob
									,clean_ssn
									,sloc_type
									,billing_type
									,LOCAL);
									
		Enclarity.Layouts.associate_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_n := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.addr_key=right.addr_key
										AND left.normed_name_rec_type=right.normed_name_rec_type
										AND left.prepped_name=right.prepped_name
										AND left.addr_phone=right.addr_phone
										AND left.sloc_phone=right.sloc_phone
										AND left.sloc_group_key=right.sloc_group_key
										AND left.billing_group_key=right.billing_group_key
										AND left.bill_npi=right.bill_npi
										AND left.bill_tin=right.bill_tin
										AND left.clean_dob=right.clean_dob
										AND left.clean_ssn=right.clean_ssn
										AND left.sloc_type=right.sloc_type
										AND left.billing_type=right.billing_type
										,t_rollup(LEFT,RIGHT),LOCAL);
			return base_n;
end;

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));
		
		c_base_d	:= new_base_d(record_type <> 'H' or (record_type = 'H' and clean_dob =''));
		h_base_d	:= new_base_d(record_type = 'H' and clean_dob <> '');

		dob_file	:= sort(distribute(Enclarity.Files().prov_birthdate_base.built(clean_date_of_birth<>'' and record_type <> 'H'), hash(group_key)), group_key, local);
		c_dob_d		:= JOIN(sort(distribute(c_base_d, hash(group_key)), group_key, local), dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
										
		h_dob_d	:= JOIN(sort(distribute(h_base_d, hash(group_key)), group_key, local), 
										sort(distribute(dob_file, hash(group_key)), group_key, local)
										,LEFT.group_key = RIGHT.group_key //and
										 // LEFT.clean_dob = RIGHT.clean_date_of_birth
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
							
		all_dob	:= c_dob_d + h_dob_d;
		sort_dob	:= fn_rollup(all_dob);
		c_all_dob	:= sort_dob(record_type <> 'H' or (record_type = 'H' and clean_ssn = ''));
		h_all_dob	:= sort_dob(record_type = 'H' and clean_ssn <> '');

		ssn_file	:= sort(distribute(Enclarity.Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key)), group_key, local);
		c_base_s	:= JOIN(sort(distribute(c_all_dob, hash(group_key)), group_key, local), ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({all_dob}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
										
		h_base_s	:= JOIN(sort(distribute(h_all_dob, hash(group_key)), group_key, local), ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({all_dob}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_ssn	:= RIGHT.clean_ssn
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
										
		all_ssn := c_base_s + h_base_s;
		sort_ssn	:= fn_rollup(all_ssn);
		c_all_ssn	:= sort_ssn(record_type <> 'H' or (record_type = 'H' and sloc_type = ''));
		h_all_ssn	:= sort_ssn(record_type = 'H' and sloc_type <> '');

		fac_file	:= sort(distribute(Enclarity.Files().facility_base.built, hash(group_key)), group_key, local);
		c_base_f	:= JOIN(sort(distribute(c_all_ssn, hash(sloc_group_key)), sloc_group_key, local), fac_file
										,LEFT.sloc_group_key = RIGHT.group_key
										,TRANSFORM({all_ssn}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.sloc_type	:= RIGHT.type1
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
										
		h_base_f	:= JOIN(sort(distribute(h_all_ssn, hash(sloc_group_key)), sloc_group_key, local), fac_file
										,LEFT.sloc_group_key = RIGHT.group_key
										,TRANSFORM({all_ssn}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.sloc_type	:= RIGHT.type1
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		all_sloc := c_base_f + h_base_f;
		sort_sloc	:= fn_rollup(all_sloc);
		c_all_sloc	:= sort_sloc(record_type <> 'H' or (record_type = 'H' and billing_type = ''));
		h_all_sloc	:= sort_sloc(record_type = 'H' and billing_type <> '');
	
		c_base_f1	:= JOIN(sort(distribute(c_all_sloc, hash(billing_group_key)), billing_group_key, local), fac_file
										,LEFT.billing_group_key = RIGHT.group_key
										,TRANSFORM({sort_sloc}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.billing_type	:= RIGHT.type1
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
		
		h_base_f1	:= JOIN(sort(distribute(h_all_sloc, hash(billing_group_key)), billing_group_key, local), fac_file
										,LEFT.billing_group_key = RIGHT.group_key
										,TRANSFORM({sort_sloc}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.billing_type	:= RIGHT.type1
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
								
		all_bill	:= c_base_f1 + h_base_f1;
		sort_bill	:= fn_rollup(all_bill);
		dist_bill	:= distribute(sort_bill, hash(group_key, prepped_name, addr_key, prepped_addr1, prepped_addr2, normed_name_rec_type, addr_phone, sloc_phone, sloc_group_key, billing_group_key));		
		
		Enclarity.Layouts.associate_base GetSourceRID(dist_bill L)	:= TRANSFORM
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
			
		d_rid	:= PROJECT(dist_bill, GetSourceRID(left));
		sort_rid	:= fn_rollup(d_rid);
		has_did		:= sort_rid(did > 0);
		needs_did	:= sort_rid(did = 0);
		dedup_needs_did	:= dedup(sort(distribute(needs_did, hash(clean_ssn, clean_dob, fname, mname, lname, name_suffix, prim_range,
									prim_name, sec_range, zip, st, clean_phone)), clean_ssn, clean_dob, fname, mname, lname, name_suffix, prim_range,
									prim_name, sec_range, zip, st, clean_phone, local), clean_ssn, clean_dob, fname, mname, lname, name_suffix, prim_range,
									prim_name, sec_range, zip, st, clean_phone, local);
		
		matchset := ['A','S','Z','P'];
		did_add.MAC_Match_Flex
			(dedup_needs_did, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st,clean_phone, 
			DID, Layouts.associate_base, TRUE, did_score,
			75, d_did);
			
			needs_did_srt	:= sort(distribute(needs_did,hash(group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st)), group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st, local);
												
			d_did_srt	:= sort(distribute(d_did,hash(group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st)), group_key, clean_ssn, clean_dob, fname, mname, lname, name_suffix,
												prim_range, prim_name, sec_range, zip, st, local);

			rejoin_did	:= join(needs_did_srt,d_did_srt,
							left.group_key		= right.group_key
					and	left.clean_ssn		= right.clean_ssn
					and left.clean_dob		= right.clean_dob
					and left.fname				= right.fname
					and left.mname				= right.mname
					and left.lname				= right.lname
					and left.name_suffix	= right.name_suffix
					and left.prim_range		= right.prim_range
					and left.prim_name		= right.prim_name
					and left.sec_range		= right.sec_range
					and left.zip					= right.zip
					and left.st						= right.st
			,TRANSFORM(Enclarity.Layouts.associate_base
					,SELF.did							:= right.did
					,SELF.did_score				:= right.did_score
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);		

		all_did	:= has_did + rejoin_did;
		sort_did	:= fn_rollup(all_did);
		has_best	:= sort_did(best_ssn <>'' and best_ssn <> '0');
		needs_best	:= sort_did(best_ssn = '' or best_ssn = '0');
		
		did_add.MAC_Add_SSN_By_DID(needs_best,did,best_ssn,d_ssn);
		all_best	:= has_best + d_ssn;
		has_bestbd	:= all_best(best_dob > 0);
		needs_bestbd	:= all_best(best_dob = 0);

		did_add.MAC_Add_DOB_By_DID(needs_bestbd,did,best_dob,d_dob0);
		all_bestbd	:= has_bestbd + d_dob0;

		d_dob:=project(all_bestbd
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>((STRING)left.best_dob)[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));
		all_bd	:= d_dob;
		sort_bd	:= fn_rollup(all_bd);
		has_bdid	:= sort_bd(bdid > 0);
		needs_bdid	:= sort_bd(bdid = 0);		
		dedup_needs_bdid	:= dedup(sort(distribute(needs_bdid, hash(prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn)), prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn, local), prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn, local);

		bdid_matchset := ['A','P'];
		Business_Header_SS.MAC_Add_BDID_Flex
			(
			dedup_needs_bdid
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
			,Enclarity.layouts.associate_base
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

			needs_bdid_srt	:= sort(distribute(needs_bdid, hash(group_key, prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn)), group_key, prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn, local);
			
			d_bdid_srt	:= sort(distribute(d_bdid, hash(group_key, prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn)), group_key, prepped_name, prim_range, prim_name, zip, sec_range, st,
											clean_phone, bill_tin, p_city_name, fname, mname, lname, clean_ssn, local);
												
			rejoin_bdid	:= join(needs_bdid_srt,d_bdid_srt,
							left.group_key			= right.group_key
					and	left.prepped_name	= right.prepped_name
					and left.prim_range		= right.prim_range
					and left.prim_name		= right.prim_name
					and left.zip					= right.zip
					and left.sec_range		= right.sec_range
					and left.st						= right.st
					and left.p_city_name	= right.p_city_name
					and left.fname				= right.fname
					and left.mname				= right.mname
					and left.lname				= right.lname
					and left.clean_ssn		= right.clean_ssn
			,TRANSFORM(Enclarity.layouts.associate_base
					,SELF.bdid						:= right.bdid
					,SELF.bdid_score			:= right.bdid_score
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);		
			
		all_bdid	:= has_bdid + rejoin_bdid;
		sort_bdid	:= fn_rollup(all_bdid);
			
		has_lnpid	:= sort_bdid(lnpid > 0);
		needs_lnpid	:= sort_bdid(lnpid = 0);

		dedup_needs_lnpid	:= dedup(sort(distribute(sort_bdid, hash(fname, mname, lname, name_suffix, prim_range, prim_name, sec_range, v_city_name, st, zip,
				clean_ssn, clean_dob, clean_phone, bill_tin, group_key, did, bdid)), fname, lname, name_suffix, prim_range, prim_name,
				sec_range, v_city_name, st, zip, clean_ssn, clean_dob, clean_phone, bill_tin, group_key, did, bdid, local), fname,
				mname, lname, name_suffix, prim_range, prim_name, sec_range, v_city_name, st, zip, clean_ssn, clean_dob, clean_phone,
				bill_tin, group_key, did, bdid, local);
				
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			dedup_needs_lnpid
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,clean_SSN
			,clean_DOB
			,clean_Phone
			,//LIC_STATE
			,//LIC_Num_in
			,bill_tin
			,//DEA_NUM
			,group_key
			,//NPI_NUM
			,//UPIN
			,DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);
			
		sort_bdid_srt	:= sort(distribute(sort_bdid,hash(group_key,fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,v_city_name,st,zip,
											clean_ssn,clean_dob,clean_phone,bill_tin,did,bdid)),group_key,fname,mname,lname,name_suffix,
											prim_range,prim_name,sec_range,v_city_name,st,zip,clean_ssn,clean_dob,clean_phone,bill_tin,
											did,bdid,local);
		result_srt	:= sort(distribute(result,hash(group_key,fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,v_city_name,st,zip,
											clean_ssn,clean_dob,clean_phone,bill_tin,did,bdid)),group_key,fname,mname,lname,name_suffix,
											prim_range,prim_name,sec_range,v_city_name,st,zip,clean_ssn,clean_dob,clean_phone,bill_tin,
											did,bdid,local);

		rejoin_lnpid	:= join(sort_bdid_srt, result_srt,
							left.group_key		= right.group_key
					and	left.fname				= right.fname
					and left.mname				= right.mname
					and left.lname				= right.lname
					and left.name_suffix	= right.name_suffix
					and left.prim_range		= right.prim_range
					and left.prim_name		= right.prim_name
					and left.sec_range		= right.sec_range
					and left.v_city_name	= right.v_city_name
					and left.st						= right.st
					and left.zip					= right.zip
					and left.clean_ssn		= right.clean_ssn
					and left.clean_dob		= right.clean_dob
					and left.clean_phone	= right.clean_phone
					and left.bill_tin			= right.bill_tin
					and left.did					= right.did
					and left.bdid 				= right.bdid
			,TRANSFORM(enclarity.layouts.associate_base
					,SELF.lnpid						:= right.lnpid
					,SELF									:= left)
					,LEFT OUTER
					,LOCAL);		

		endfile	:= rejoin_lnpid;
		rolled_end:=fn_rollup(endfile);
		RETURN rolled_end;
	END;
	
 	EXPORT Address_Base := FUNCTION
   		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).address_base.built, Enclarity.layouts.address_base);
   
   		stdInput := Enclarity.StandardizeInputFile(filedate, pUseProd).Address;

   		cleanAdd_a	:= Clean_addr(stdInput, Enclarity.layouts.address_base)
   			:PERSIST('~thor_data400::persist::enclarity::address_addr');	
				
   		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).address_lBaseTemplate_built)) = 0
   												 ,cleanAdd_a
   												 ,cleanAdd_a + hist_base);

   		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key, addr_key, prac_addr_ind, bill_addr_ind, phone1));

   		new_base_s := SORT(new_base_d
												,group_key
												,addr_key
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
												,addr_rectype
												,primary_location
												,LOCAL);
   										
   		Enclarity.Layouts.address_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
   			SELF.dt_vendor_first_reported 	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
   			SELF.dt_vendor_last_reported  	:= max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 									:= IF(L.record_type = 'C', L, R);
   		END;
   
   		base_t := ROLLUP(new_base_s
										,   left.group_key=right.group_key
										AND left.addr_key=right.addr_key
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
										AND left.addr_rectype=right.addr_rectype
										AND left.primary_location=right.primary_location
										,t_rollup(LEFT,RIGHT)
										,LOCAL);								
   		
   		Enclarity.Layouts.address_base GetSourceRID(base_t L)	:= TRANSFORM
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
			,Enclarity.layouts.address_base
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
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).dea_base.built, Enclarity.layouts.dea_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).DEA;
		
		cleanAdd_a	:= clean_addr(std_input, layouts.dea_base)
			:PERSIST('~thor_data400::persist::enclarity::dea_addr');
			
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).dea_lBaseTemplate_built)) = 0
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
										
		Enclarity.Layouts.dea_base t_rollup (new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
										,SELF.record_type:= if((unsigned)left.dea_num_exp > 0 and left.dea_num_exp < (string8)Std.Date.Today(),'H',left.record_type)
										,SELF:=LEFT
										));

		RETURN base_p;
	END;
	
	EXPORT License_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).license_base.built, Enclarity.layouts.license_base);
	
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).License;

		cleanNames := Clean_name(std_input, Enclarity.Layouts.license_base)
			:PERSIST('~thor_data400::persist::enclarity::license_names');

		cleanAdd_a	:= Clean_addr(cleanNames, Enclarity.layouts.license_base)
			:PERSIST('~thor_data400::persist::enclarity::license_addr');
			
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).license_lBaseTemplate_built)) = 0
											 ,cleanAdd_a
											 ,cleanAdd_a + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));  

		dob_file	:= distribute(Enclarity.Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key));
		base_d	:= JOIN(new_base_d, dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= left.record_type//if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);

		ssn_file	:= distribute(Enclarity.Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key));
		base_s	:= JOIN(base_d, ssn_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= left.record_type//if(right.record_type='H',right.record_type,left.record_type)
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
		
		Enclarity.Layouts.license_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
										
		Enclarity.Layouts.license_base GetSourceRID(base_i L)	:= TRANSFORM
			SELF.record_type 					:= l.record_type;//if((unsigned)l.lic_end_date>0 and l.lic_end_date < ut.GetDate,'H',l.record_type);
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

		matchset := ['A','S','Z'];
		did_add.MAC_Match_Flex
			(d_rid, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st,'', 
			DID, Enclarity.Layouts.license_base, true, did_score,
			75, d_did);
	
		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);

		d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>((STRING)left.best_dob)[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));
		
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
			,Enclarity.layouts.license_base
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

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,clean_SSN
			,clean_DOB
			,//clean_Phone
			,LIC_STATE
			,LIC_Num_in
			,//bill_tin
			,//DEA_NUM
			,group_key
			,//NPI_NUM
			,//UPIN
			,DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);

		RETURN result;
	END;
	
	EXPORT Modified_License_Base	:= FUNCTION
		orig_lic_base		:= Enclarity.Files(filedate,pUseProd).license_base.built;
		mo_only					:= orig_lic_base(lic_state = 'MO');
		no_mo_lic				:= orig_lic_base(lic_state <> 'MO');
		npi_base				:= Enclarity.Files(filedate,pUseProd).npi_base.built;
		
		lic_base_w_tax	:= record
			Enclarity.Layouts.license_base;
			Enclarity.Layouts.npi_base.npi_num;
			Enclarity.Layouts.npi_base.taxonomy;
		end;
		
		joined_npi	:= join(sort(distribute(mo_only, hash(group_key)), group_key, local),
												sort(distribute(npi_base, hash(group_key)), group_key, local),
													left.group_key = right.group_key,
													transform({lic_base_w_tax},
														self.npi_num	:= right.npi_num,
														self.taxonomy	:= trim(right.taxonomy,all),
														self					:= left),
													left outer, local);
	
		mo_apn			:= joined_npi(taxonomy[1..4] = '363L' or taxonomy[1..4] = '364S' or taxonomy[1..3] = '367')
										:persist('~thor_data400::base::enclarity::modified_license_w_taxonomy');
		
		non_mo_apn	:= joined_npi(taxonomy[1..4] <> '363L' and taxonomy[1..4] <> '364S' and taxonomy[1..3] <> '367')
										:persist('~thor_data400::base::enclarity::modified_license_w_taxonomy_non_apn');;
		
		clear_exp_stat	:= project(mo_apn, 
																transform(enclarity.Layouts.license_base,
																	old_rec									:= if(left.dt_vendor_last_reported < (unsigned4)filedate, true, false);
																	self.lic_end_date				:= if(old_rec,'00000000',left.lic_end_date),
																	self.lic_status					:= if(old_rec,'',left.lic_status),
																	self.clean_lic_end_date	:= if(old_rec,'00000000',left.clean_lic_end_date),
																	self										:= left));
																	
		sort_clear_exp_stat	:= sort(distribute(clear_exp_stat, hash(group_key, lic_state, lic_num, lic_begin_date)),
															group_key, lic_state, lic_num, lic_begin_date, local);

		Enclarity.Layouts.license_base t_rollup(sort_clear_exp_stat L, sort_clear_exp_stat R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.lic_end_date = '00000000', L, R);
		END;

		roll_mo_lic := ROLLUP(sort_clear_exp_stat,
										LEFT.group_key 			= RIGHT.group_key 			AND 
										LEFT.lic_state 			= RIGHT.lic_state				AND				
										LEFT.lic_num				= RIGHT.lic_num					AND						
										// LEFT.lic_end_date		= RIGHT.lic_end_date	 	AND	
										// LEFT.lic_status			= RIGHT.lic_status		  AND
										LEFT.lic_begin_date = RIGHT.lic_begin_date	AND
										LEFT.record_type		= RIGHT.record_type,
										t_rollup(LEFT,RIGHT),LOCAL);
									
		recombined_provs	:= no_mo_lic + project(non_mo_apn, enclarity.Layouts.license_base) + roll_mo_lic;
		
		dedup_recombined_provs	:= dedup(sort(distribute(recombined_provs, hash(group_key, lic_state, lic_num, lic_end_date, lic_status)),
																	group_key, lic_state, lic_num, lic_end_date, lic_status, local), record, local):
										persist('~thor_data400::base::enclarity::modified_license_persist_for_keys::' + filedate);
										
		// RETURN non_mo_apn;
		// RETURN roll_mo_lic;
		// RETURN mo_apn;
		// RETURN sort_clear_exp_stat;
		RETURN dedup_recombined_provs;
	END;
	
	EXPORT Taxonomy_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).taxonomy_base.built, Enclarity.layouts.taxonomy_base);
		
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Taxonomy;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).taxonomy_lBaseTemplate_built)) = 0
										   ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		npi_file	:= distribute(Enclarity.Files().npi_base.built, hash(group_key));
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
										
		Enclarity.Layouts.taxonomy_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).npi_base.built, Enclarity.layouts.npi_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).npi;

		cleanNames := Clean_name(std_input, Enclarity.Layouts.npi_base)
			:PERSIST('~thor_data400::persist::enclarity::npi_name');

		cleanAdd_a	:= Clean_addr(cleanNames, Enclarity.layouts.npi_base)
			:PERSIST('~thor_data400::persist::enclarity::npi_addr');
			
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).npi_lBaseTemplate_built)) = 0
											 ,cleanAdd_a
											 ,cleanAdd_a + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key, clean_dob, addr_key));

		dob_file	:= distribute(Enclarity.Files().prov_birthdate_base.built(clean_date_of_birth<>''), hash(group_key, clean_date_of_birth));
		base_d	:= JOIN(new_base_d, dob_file
										,LEFT.group_key = RIGHT.group_key
										,TRANSFORM({new_base_d}
											,SELF.record_type	:= if(right.record_type='H',right.record_type,left.record_type)
											,SELF.clean_dob	:= RIGHT.clean_date_of_birth;
											,SELF:=LEFT)
										,LEFT OUTER
										,LOCAL
										);
										
		ssn_file	:= distribute(Enclarity.Files().prov_ssn_base.built(clean_ssn<>''), hash(group_key));
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
										,LOCAL);
						
		Enclarity.Layouts.npi_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
										,t_rollup(LEFT,RIGHT)
										,LOCAL);	
		
		Enclarity.Layouts.npi_base GetSourceRID(base_i L)	:= TRANSFORM
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
																														
		matchset := ['A','S','Z'];
		did_add.MAC_Match_Flex
			(d_rid, matchset,					
			clean_ssn, clean_dob, fname, mname, lname, name_suffix, 
			prim_range, prim_name, sec_range, zip, st,'', 
			DID, Enclarity.Layouts.npi_base, TRUE, did_score,
			75, d_did);
			
		did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn);
		did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0);

		d_dob:=project(d_dob0
											,transform({d_dob0}
												,self.did:=if(    left.clean_dob<>''
																			and left.best_dob>0
																			and left.clean_dob[1..4]<>((STRING)left.best_dob)[1..4]
																			,0
																			,left.did)
												,self.did_score:=if(self.did=0,0,left.did_score)
												,self:=left));

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
			,Enclarity.layouts.npi_base
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

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			d_bdid
			,LNPID
			,FNAME
			,MNAME
			,LNAME
			,name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,clean_SSN
			,clean_DOB
			,clean_Phone
			,//LIC_STATE
			,//LIC_Num_in
			,//bill_tin
			,//DEA_NUM
			,group_key
			,NPI_NUM
			,//UPIN
			,DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);

		RETURN result;
	END;
	
	EXPORT Medschool_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).medschool_base.built, Enclarity.layouts.medschool_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).medschool;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).medschool_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										medschool,						
										medschool_year,							
										LOCAL);
										
		Enclarity.Layouts.medschool_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).tax_codes_base.built, Enclarity.layouts.tax_codes_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Tax_Codes;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).tax_codes_lBaseTemplate_built)) = 0
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
										
		Enclarity.Layouts.tax_codes_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).prov_ssn_base.built, Enclarity.layouts.prov_ssn_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Prov_SSN;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).prov_ssn_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										ssn,						
										LOCAL);
										
		Enclarity.Layouts.prov_ssn_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).specialty_base.built, Enclarity.layouts.specialty_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).specialty;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).specialty_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										spec_code,						
										spec_desc,
										LOCAL);
						
		Enclarity.Layouts.specialty_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).sanc_prov_type;						
		new_base_d	:= DEDUP(std_input, RECORD, ALL);
		RETURN new_base_d;
	END;
	
	EXPORT Sanc_Codes_Base := FUNCTION
		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).sanc_codes;
		new_base_d := DEDUP(std_input, sanc_code, ALL);
		RETURN new_base_d;
	END;
	
	EXPORT Prov_birthdate_Base := FUNCTION
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).prov_birthdate_base.built, Enclarity.layouts.prov_birthdate_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).Prov_birthdate;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).prov_birthdate_lBaseTemplate_built)) = 0
											 ,std_input
											 ,std_input + hist_base);			

		new_base_d := DISTRIBUTE(base_and_update, HASH(group_key));

		new_base_s := SORT(new_base_d,
										group_key,				
										date_of_birth,						
										LOCAL);
			
		Enclarity.Layouts.prov_birthdate_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
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
		hist_base	:= Mark_history(Enclarity.Files(filedate,pUseProd).sanction_base.built, Enclarity.layouts.sanction_base);

		std_input := Enclarity.StandardizeInputFile(filedate, pUseProd).sanction;

		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Enclarity.Filenames(filedate, pUseProd).sanction_lBaseTemplate_built)) = 0
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
		
		temp_explode:=record
			enclarity.Layouts.sanction_base;
			string1 lic_status := '';
		end;

		base_u	:= project(new_base_s, transform(temp_explode
								,self.ln_derived_rein_date:=if(left.record_type = 'C',''   ,left.ln_derived_rein_date)
								,self.ln_derived_rein_flag:=if(left.record_type = 'C',false,left.ln_derived_rein_flag)
								,self:=left
								));
		
		lic_t  :=enclarity.Files(,true).license_base.qa;
		base_u1	:= distribute(base_u,hash(group_key));
		lic_u1	:= distribute(lic_t,hash(group_key));
		
		base_u2	:= join(base_u1, lic_u1(record_type	=	'C')
						,   left.group_key    = right.group_key
						AND left.sanc1_state  = right.lic_state
						,transform({base_u1}
							,self.lic_status := right.lic_status
							,self						 := left)
						,left outer
						,local);

			base_u3 := SORT(base_u2
											,group_key
											,sanc1_date
											,sanc1_code
											,sanc1_state
											,sanc1_lic_num
											,sanc1_prof_type
											,sanc1_rein_date
											,sanc1_desc
											,if(lic_status='A',0,1)
										,LOCAL);

		base_u3 t_rollup(base_u3  L, base_u3 R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		base_t := ROLLUP(base_u3,
										LEFT.group_key 				= RIGHT.group_key 			AND 
										LEFT.sanc1_date 			= RIGHT.sanc1_date 			AND				
										LEFT.sanc1_code 			= RIGHT.sanc1_code 			AND
										LEFT.sanc1_state 			= RIGHT.sanc1_state 		AND
										LEFT.sanc1_lic_num 		= RIGHT.sanc1_lic_num 	AND
										LEFT.sanc1_prof_type 	= RIGHT.sanc1_prof_type AND
										LEFT.sanc1_rein_date 	= RIGHT.sanc1_rein_date AND
										LEFT.sanc1_desc			  = RIGHT.sanc1_desc,
										t_rollup(LEFT,RIGHT)
										,LOCAL);	

		base_w_level := JOIN(base_t, Enclarity.LookupTables.dsSancLookup,
										LEFT.sanc1_code=RIGHT.code,
										transform({base_t}, 
												SELF.level	:= RIGHT.level,
												SELF				:= LEFT),
												LEFT OUTER, LOOKUP);

		base_t_plus:=project(base_w_level,{
														 base_w_level
														,string8 temp_st_revoke_dt := ''
														,string8 temp_fed_revoke_dt	:= ''
														,string8 temp_st_rein_dt:=''
														,string8 temp_st_ds_dt:=''
														,string8 temp_st_as_dt	:= ''
														,string8 temp_fed_rein_dt:=''
														});
														
		st_rein_codes			:= ['113R'];
		st_ds_codes				:= ['112DS'];
		st_as_codes				:= ['112AS'];
		st_revoke_codes		:= ['111L','CANDD'];
		fed_rein_codes		:= ['SMR'];
		fed_revoke_codes	:= ['SME'];
		
		base_u2_dst :=distribute(base_t_plus,hash(group_key,sanc1_state));
		base_u2_srt :=sort(base_u2_dst,group_key,sanc1_state,local);
		Gbase_u2    :=group(base_u2_srt,group_key,sanc1_state);
		Gbase_u2_std:=sort(Gbase_u2
										,-sanc1_date
										,map(
 										 sanc1_code in st_rein_codes		=>2
										,sanc1_code in st_ds_codes			=>4
										,sanc1_code in st_as_codes			=>6
										,sanc1_code in st_revoke_codes	=>8
										,sanc1_code in fed_rein_codes		=>10
										,sanc1_code in fed_revoke_codes	=>12
										,99)
										);

		Gbase_u2 tr_iter(Gbase_u2_std l, Gbase_u2_std r) :=transform
			self.temp_st_rein_dt  	:= if(r.sanc1_code in st_rein_codes, 	r.clean_sanc1_date,l.temp_st_rein_dt);
			self.temp_st_ds_dt 	    := if(r.sanc1_code in st_ds_codes, 	  r.clean_sanc1_date,l.temp_st_ds_dt);
			self.temp_st_as_dt 	    := if(r.sanc1_code in st_as_codes, 	  r.clean_sanc1_date,l.temp_st_as_dt);
			self.temp_st_revoke_dt  := if(r.sanc1_code in st_revoke_codes,r.clean_sanc1_date,l.temp_st_revoke_dt);
			self.temp_fed_rein_dt   := if(r.sanc1_code in fed_rein_codes,	r.clean_sanc1_date,l.temp_fed_rein_dt);
			self.temp_fed_revoke_dt := if(r.sanc1_code in fed_revoke_codes,r.clean_sanc1_date,l.temp_fed_revoke_dt);
			self.LN_derived_rein_date:=map(
																 r.sanc1_code in st_rein_codes  => self.temp_st_rein_dt

																,r.sanc1_code in st_ds_codes
																			and (unsigned)self.temp_st_rein_dt>0
																			and (unsigned)self.temp_st_ds_dt<=(unsigned)self.temp_st_rein_dt
																			and (unsigned)self.temp_st_ds_dt>=(unsigned)self.temp_st_revoke_dt
																											=> self.temp_st_rein_dt

																,r.sanc1_code in st_revoke_codes  //here comes the "fun!"
																		=>	map(
																			// we have no 112dS but have 112aS with active license within the group
																			(
																				(
																				(unsigned)self.temp_st_ds_dt=0
																				and (unsigned)self.temp_st_rein_dt=0
																				)
																			or
																				(
																				(unsigned)self.temp_st_ds_dt=0
																				and (unsigned)self.temp_st_rein_dt>0
																				and (unsigned)self.temp_st_as_dt<=(unsigned)self.temp_st_rein_dt
																				)
																			or
																				(
																				(unsigned)self.temp_st_ds_dt=0
																				and (unsigned)self.temp_st_rein_dt=0
																				)
																			)
																			and (unsigned)self.temp_st_as_dt>0
																			and r.lic_status = 'A'
																											=> self.temp_st_as_dt

																			// we have a 112dS within the group
																			,(
																				(
																				(unsigned)self.temp_st_ds_dt>0
																				and (unsigned)self.temp_st_rein_dt=0
																				)
																			or
																				(
																				(unsigned)self.temp_st_ds_dt>0
																				and (unsigned)self.temp_st_rein_dt>0
																				and (unsigned)self.temp_st_ds_dt<=(unsigned)self.temp_st_rein_dt
																				)
																			)
																											=> self.temp_st_ds_dt

																			// we do not have a 112dS or 112aS but have a 113R within the group
																			,self.temp_st_rein_dt
																			)

																,r.sanc1_code in fed_rein_codes
																											=> self.temp_fed_rein_dt

																,r.sanc1_code in fed_revoke_codes
																											=> self.temp_fed_rein_dt

																,r.LN_derived_rein_date
																);
			self.LN_derived_rein_flag:=if(
																		 r.sanc1_code not in [st_rein_codes,fed_rein_codes]
																		 and (unsigned)self.LN_derived_rein_date>0
																				,true
																				,r.LN_derived_rein_flag
																		);
			self:=r;
		end;

		it1:=iterate(Gbase_u2_std(record_type = 'C'),tr_iter(left,right)) + Gbase_u2_std(record_type = 'H');
		flags_set	:= ungroup(project(it1, Enclarity.Layouts.sanction_base));
		
		flags_sort := SORT(flags_set
											,group_key
											,sanc1_date
											,sanc1_code
											,sanc1_state
											,sanc1_lic_num
											,sanc1_prof_type
											,sanc1_rein_date
											,sanc1_desc
										,LOCAL);

		flags_sort last_rollup(flags_sort  L, flags_sort R) := TRANSFORM
			SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := max	(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;
		
		final_set := ROLLUP(flags_sort,
										LEFT.group_key 				= RIGHT.group_key 			AND 
										LEFT.sanc1_date 			= RIGHT.sanc1_date 			AND				
										LEFT.sanc1_code 			= RIGHT.sanc1_code 			AND
										LEFT.sanc1_state 			= RIGHT.sanc1_state 		AND
										LEFT.sanc1_lic_num 		= RIGHT.sanc1_lic_num 	AND
										LEFT.sanc1_prof_type 	= RIGHT.sanc1_prof_type AND
										LEFT.sanc1_rein_date 	= RIGHT.sanc1_rein_date AND
										LEFT.sanc1_desc			  = RIGHT.sanc1_desc,
										last_rollup(LEFT,RIGHT)
										,LOCAL);	

		RETURN final_set;
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