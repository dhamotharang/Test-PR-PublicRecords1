import BIPV2_Files, BIPV2, ut, BIPV2_Company_Names, MDR, _Control, Advo, Data_Services, BIPV2_Tools, LocationID_XLink,STD; 
l_as_linking := BIPV2_Files.layout_ingest;
EXPORT tools_dotid(dataset(l_as_linking) ds_as_linking = dataset([],l_as_linking)) := module
	shared l_dot := BIPV2.CommonBase.Layout;	                           
	                           
	export l_dot flatten(l_as_linking L, unsigned C) := transform
		self.rcid									:= C; // NOTE: Assigning rcid is the responsibility of Ingest, but BIPV2_Company_Names needs a placeholder
		self.DOTid								:= 0;
		self.EmpID								:= 0;
		self.POWID								:= 0;
		self.ProxID								:= 0;
		self.LGID3								:= 0;
		self.OrgID								:= 0;
		self.UltID								:= 0;
		self.SELEID								:= 0;
		
		// sub-SELE fields (set post-Hrchy)
		self.cnt_rcid_per_dotid := 0;
		self.cnt_dot_per_proxid := 0;
		self.cnt_prox_per_lgid3 := 0;
		self.cnt_prox_per_powid := 0;
		self.cnt_dot_per_empid	:= 0;
		
		// Added for Hrchy
		self.has_lgid					:= false;
		self.is_sele_level		:= false;
		self.is_org_level			:= false;
		self.is_ult_level			:= false;
		self.parent_proxid		:= 0;
		self.sele_proxid			:= 0;
		self.org_proxid				:= 0;
		self.ultimate_proxid	:= 0;
		self.levels_from_top	:= 0;
		self.nodes_below			:= 0;
		self.nodes_total			:= 0;
		self.sele_gold				:= '';
		self.ult_seg					:= '';
		self.org_seg					:= '';
		self.sele_seg					:= '';
		self.prox_seg					:= '';
		self.pow_seg					:= '';
		self.ult_prob					:= '';
		self.org_prob					:= '';
		self.sele_prob				:= '';
		self.prox_prob				:= '';
		self.pow_prob					:= '';
		
		self.dt_first_seen	:= ut.NormDate(L.dt_first_seen);
		self.dt_last_seen		:= ut.NormDate(L.dt_last_seen);
		
		// flatten company_address
		self.prim_range		:= L.company_address.prim_range;
		self.predir				:= L.company_address.predir;
		self.prim_name		:= L.company_address.prim_name;
		self.prim_name_derived	:= ''; // SetPrimNameDerived
		self.addr_suffix	:= L.company_address.addr_suffix;
		self.postdir			:= L.company_address.postdir;
		self.unit_desig		:= L.company_address.unit_desig;
		self.sec_range		:= L.company_address.sec_range;
		self.p_city_name	:= L.company_address.p_city_name;
		self.v_city_name	:= L.company_address.v_city_name;
		self.st						:= L.company_address.st;
		self.zip					:= L.company_address.zip;
		self.zip4					:= L.company_address.zip4;
		self.cart					:= L.company_address.cart;
		self.cr_sort_sz		:= L.company_address.cr_sort_sz;
		self.lot					:= L.company_address.lot;
		self.lot_order		:= L.company_address.lot_order;
		self.dbpc					:= L.company_address.dbpc;
		self.chk_digit		:= L.company_address.chk_digit;
		self.rec_type			:= L.company_address.rec_type;
		self.fips_state		:= L.company_address.fips_state;
		self.fips_county	:= L.company_address.fips_county;
		self.geo_lat			:= L.company_address.geo_lat;
		self.geo_long			:= L.company_address.geo_long;
		self.msa					:= L.company_address.msa;
		self.geo_blk			:= L.company_address.geo_blk;
		self.geo_match		:= L.company_address.geo_match;
		self.err_stat			:= L.company_address.err_stat;
		self.locid        := 0;
		
		// flatten contact_name
		self.isContact		:= if(L.contact_name.fname<>'' or L.contact_name.mname<>'' or L.contact_name.lname<>'', 'T', 'F');
		self.title				:= L.contact_name.title;
		self.fname				:= L.contact_name.fname;
		self.mname				:= L.contact_name.mname;
		self.lname				:= L.contact_name.lname;
		self.name_suffix	:= L.contact_name.name_suffix;
		self.name_score		:= L.contact_name.name_score;
		
		// derived/modified fields
		self.ebr_file_number	:= if(MDR.sourceTools.SourceIsEBR(L.source), L.vl_id, '');
		self.vl_id						:= if(MDR.sourceTools.SourceIsBusiness_Registration(L.source), '', L.vl_id);
		
		// we'll catch these later
		self.cnp_number								    := ''; // SetCompanyFields
		self.cnp_store_number					    := ''; // SetCompanyFields
		self.cnp_btype								    := ''; // SetCompanyFields
		self.cnp_lowv									    := ''; // SetCompanyFields
		self.cnp_translated						    := false; // SetCompanyFields
		self.cnp_classid							    := 0; // SetCompanyFields
		self.isCorp										    := ''; // SetCompanyFields
		self.cnp_hasNumber						    := ''; // SetCompanyFields
		self.cnp_name									    := ''; // SetCompanyFields
		self.cnp_component_code				    := ''; // SetCompanyFields
		self.corp_legal_name					    := ''; // SetCompanyFields
		self.dba_name									    := ''; // SetCompanyFields
		self.active_duns_number				    := ''; // SetDuns
		self.hist_duns_number					    := ''; // SetDuns
		self.deleted_key		              := ''; // SetDuns
		self.deleted_fein		              := ''; // SetDuns
		self.active_enterprise_number	    := ''; // SetEnterprise
		self.hist_enterprise_number		    := ''; // SetEnterprise
		self.active_domestic_corp_key	    := ''; // SetSOS
		self.hist_domestic_corp_key		    := ''; // SetSOS
		self.foreign_corp_key					    := ''; // SetSOS
		self.unk_corp_key							    := ''; // SetSOS
		self.ingest_status						    := ''; // runIngest
		self.vanity_owner_did             := 0 ; // Set_Vanity_Owner_Did
    self.address_type_derived         := ''; // SetAddrType
    self.prim_range_derived           := ''; // SetPrimRangeDerived
    self.is_vanity_name_derived       := false; // Set_Vanity_Owner_Did	

		unsigned4 tempRevIndex            := STD.Str.Find(L.revenue_org_raw,'-',1) + 1;
		unsigned6 highValue               := (unsigned6) L.revenue_org_raw[tempRevIndex..];
		unsigned4 tempRevIndexLocal       := STD.Str.Find(L.revenue_local_raw,'-',1) + 1;
		unsigned6 highValueLocal          := (unsigned6) L.revenue_local_raw[tempRevIndexLocal..];

		unsigned4 tempEmpIndex            := STD.Str.Find(L.employee_count_org_raw,'-',1) + 1;
		unsigned6 highEmpValue            := (unsigned6) L.employee_count_org_raw[tempEmpIndex..];
		unsigned4 tempEmpIndexLocal       := STD.Str.Find(L.employee_count_local_raw,'-',1) + 1;
		unsigned6 highEmpValueLocal       := (unsigned6) L.employee_count_local_raw[tempEmpIndexLocal..];

		unsigned6 temp_emp_count          := map(
				                                   L.source=MDR.sourceTools.src_Equifax_Business_Data and STD.Str.Find(L.employee_count_org_raw,'-',1)=0                            => highEmpValue
																					,L.source=MDR.sourceTools.src_Business_Registration and length(trim(STD.Str.FilterOut(L.employee_count_org_raw,'0123456789')))>0  => 0
		                                      ,L.source in [MDR.sourceTools.src_Equifax_Business_Data
																					             ,MDR.sourceTools.src_Cortera
																					             ,MDR.sourcetools.src_Experian_CRDB
																					             ,MDR.sourcetools.src_DCA
																					             ,MDR.sourcetools.src_EBR
																					             ,MDR.sourceTools.src_Equifax_Business_Data
																											 ]                                                                                                                   => (unsigned6) L.employee_count_org_raw
                                           ,L.source=MDR.sourceTools.src_infutor_narb and L.revenue_org_raw[1..4]='Over'                                                   => 0				
																					 ,L.source=MDR.sourceTools.src_infutor_narb                                                                                      => (unsigned6) STD.Str.Filter(L.employee_count_org_raw[6..],'1234567890')
																					,0
		                                    );
		unsigned6 temp_emp_count_local    := map(
		                                       L.source=MDR.sourceTools.src_Equifax_Business_Data and STD.Str.Find(L.employee_count_local_raw,'-',1)=0                            => highEmpValueLocal
																					,L.source=MDR.sourceTools.src_Business_Registration and length(trim(STD.Str.FilterOut(L.employee_count_local_raw,'0123456789')))>0  => 0
		                                      ,L.source in [MDR.sourceTools.src_Equifax_Business_Data
																					             ,MDR.sourceTools.src_Cortera
																					             ,MDR.sourcetools.src_Experian_CRDB
																					             ,MDR.sourcetools.src_DCA
																					             ,MDR.sourcetools.src_EBR
																					             ,MDR.sourceTools.src_Equifax_Business_Data
																											 ]                                                                                                                      => (unsigned6) L.employee_count_local_raw
																					,L.source=MDR.sourceTools.src_infutor_narb and L.revenue_org_raw[1..4]='Over'                                                       => 0
																					,L.source=MDR.sourceTools.src_infutor_narb                                                                                          => (unsigned6) STD.Str.Filter(L.employee_count_local_raw[6..],'1234567890')
																					,0
		                                  );
    unsigned6 temp_revenue            := map(
                                             L.source=MDR.sourceTools.src_infutor_narb and L.revenue_org_raw[1..5]='Under'                                                => (unsigned6) STD.Str.FilterOut(L.revenue_org_raw[8..],',')
																			      ,L.source=MDR.sourceTools.src_infutor_narb and L.revenue_org_raw[1]='$'                                                       => (unsigned6) STD.Str.Filter(L.revenue_org_raw[13..],'1234567890')
																			      ,L.source=MDR.sourceTools.src_Equifax_Business_Data and STD.Str.Find(L.revenue_org_raw,'-',1)=0                               => (unsigned6) L.revenue_org_raw * 1000
																			      ,L.source=MDR.sourceTools.src_Equifax_Business_Data                                                                           => (unsigned6) highValue
																			      ,L.source in [MDR.sourceTools.src_DCA, MDR.sourceTools.src_Cortera,MDR.sourcetools.src_Experian_CRDB,MDR.sourceTools.src_EBR] => (unsigned6) L.revenue_org_raw
																			      ,0
																			 );
    unsigned6 temp_revenue_local      := map(
                                             L.source=MDR.sourceTools.src_infutor_narb and L.revenue_local_raw[1..5]='Under'                                              => (unsigned6) STD.Str.FilterOut(L.revenue_local_raw[8..],',')
																			      ,L.source=MDR.sourceTools.src_infutor_narb and L.revenue_local_raw[1]='$'                                                     => (unsigned6) STD.Str.Filter(L.revenue_local_raw[13..],'1234567890')
																			      ,L.source=MDR.sourceTools.src_Equifax_Business_Data and STD.Str.Find(L.revenue_local_raw,'-',1)=0                             => (unsigned6) L.revenue_local_raw * 1000
																			      ,L.source=MDR.sourceTools.src_Equifax_Business_Data                                                                           => highValueLocal
																						,L.source in [MDR.sourceTools.src_DCA, MDR.sourceTools.src_Cortera,MDR.sourcetools.src_Experian_CRDB,MDR.sourceTools.src_EBR] => (unsigned6) L.revenue_local_raw
																			      ,0
																			 );
    self.revenue_org_derived           := if(L.revenue_org_raw='' or L.source=MDR.sourceTools.src_Dunn_Bradstreet,0,temp_revenue);
    self.revenue_local_derived         := if(L.revenue_local_raw='' or L.source=MDR.sourceTools.src_Dunn_Bradstreet,0,temp_revenue_local);
    self.employee_count_local_derived  := if(L.employee_count_local_raw='' or L.source=MDR.sourceTools.src_Dunn_Bradstreet,0,temp_emp_count_local);
	  self.employee_count_org_derived    := if(L.employee_count_org_raw='' or L.source=MDR.sourceTools.src_Dunn_Bradstreet,0,temp_emp_count);
    self.seleid_status_private_score   := 1;
    self.seleid_status_public_score    := 1;
    
		self := L; 
	end;
	
	
	// Assign the prim_name_derived field
	export dataset(l_dot) SetPrimNameDerived(dataset(l_dot) ds_in) := function
		return BIPV2.fn_derive_pn(ds_in);
	end;
	
	// Set parsed company name fields and detect corporations
	export dataset(l_dot) SetCompanyFields(dataset(l_dot) ds_in) := function
		BIPV2_Company_Names.functions.mac_go(ds_in, ds_out, rcid, company_name, false, false);
		
		l_dot toCnp(ds_out L) := transform
			self.cnp_hasNumber := if(L.cnp_number <> '', 'T', 'F');
			boolean match_src := MDR.sourceTools.SourceIsCorpV2(L.source);
			boolean match_typ := regexfind('\\b(INC|LLC|PLLC|LLP)\\b',L.cnp_btype,NOCASE);
      boolean match_org := regexfind('(corporation|corporate|llc|llp|sos|limited liability company|limited liability partnership)',trim(L.company_org_structure_raw,left,right),nocase);
			boolean match_ssn := false; // STUB - ???
			self.isCorp := map(
				match_src or match_typ or match_org	=> 'T',
				match_ssn														=> 'F',
				''
			);
			
			// Derived fields
			self.corp_legal_name := if(
				BIPV2.BL_Tables.CompanyNameTypeDesc(L.company_name_type_raw) not in ['DBA','FBN','TRADEMARK']
					and not regexfind('FICTITIOUS NAME',L.company_org_structure_raw,nocase),
				L.cnp_name,
				'');
			self.dba_name := if(self.corp_legal_name='', L.cnp_name, '');
			
			self := L;
		end;
		
		return project(ds_out, toCnp(left));
	end;
	
	export l_err_rec := record
		l_dot.rcid;
		l_dot.source;
		l_dot.source_record_id;
		l_dot.vl_id;
		string6		remedy; // BLANK/CLEAN/REJECT
		string50	reason;
	end;
	// Check vl_id in certain sources to prevent overly-common terms
	export BlankCommonTerms(dataset(l_dot) ds_in) := module
		shared thresh(string1 isCorp) := if(isCorp='T', 10000, 1000);
		shared set_check	:= MDR.sourceTools.set_Dunn_Bradstreet + MDR.sourceTools.set_CorpV2; // no set_Dunn_Bradstreet_Fein for now
		shared ds_check		:= distribute(ds_in(source in set_check and vl_id<>''), hash32(vl_id));
		shared ds_pass		:= ds_in(source not in set_check or vl_id='');
		shared ds_xtab		:= table(ds_check, {isCorp, vl_id, unsigned cnt:=count(group)}, isCorp, vl_id, local);
		// shared set_bogus	:= set(ds_xtab(cnt>=thresh(isCorp='T')), vl_id);
		shared comm_vlid	:= ds_xtab(cnt>=thresh(isCorp));
		
		// export result			:= ds_pass + project(ds_check, transform(l_dot, self.vl_id:= if(left.vl_id in set_bogus, '', left.vl_id), self := left));
		// export err_rec		:= project(ds_check(vl_id in set_bogus), transform(l_err_rec,
			// self.remedy:='BLANK', self.reason:='vl_id frequency over threshold', self:=left));
		export err_rec		:= join(ds_check, comm_vlid, left.vl_id=right.vl_id, transform(l_err_rec,
			self.remedy:='BLANK', self.reason:='vl_id frequency over threshold', self:=left), local);
		export result			:= ds_pass + join(ds_check, comm_vlid, left.vl_id=right.vl_id, transform(l_dot, 
			self.vl_id:=if(right.vl_id='',left.vl_id,''), self:=left), left outer, local);
	end;
	// throw out records we cannot link due to blank (or excluded) required terms
	shared FiltUnlinkable(dataset(l_dot) ds_in) := module
		shared pnExcluded := ['MOVED NO FORWARDING ADDRESS']; // Excluded prim_name values
		export result		:= ds_in(
			trim(cnp_name) NOT IN ['','ACCOUNTS PAYABLE'],
			prim_name<>'' or active_duns_number<>'' or active_enterprise_number<>'' or MDR.sourcetools.SourceIsBusiness_Credit(source),
			prim_name not in pnExcluded,
			source_record_id<>0);
		export err_rec	:= project(ds_in, transform(l_err_rec, 
			self.remedy:='REJECT', self.reason:=map(
				trim(left.cnp_name) NOT IN ['','ACCOUNTS PAYABLE']																														=> 'cnp_name is blank',
				left.prim_name='' and left.active_duns_number='' and left.active_enterprise_number=''	and not MDR.sourcetools.SourceIsBusiness_Credit(left.source)=> 'prim_name is blank',
				left.prim_name in pnExcluded																								=> 'prim_name is excluded',
				left.source_record_id=0																											=> 'source_record_id is blank',
				skip),
			self:=left));
	end;
	
  import _Control;
	pPersistname		:= 'thor_data400::persist::BIPV2::file_current_LNCA';
	// #IF(_Control.ThisEnvironment.Name='Prod_Thor')
		import dcav2;
    set_updated_new := [dcav2.Utilities.RecordType.Updated,dcav2.Utilities.RecordType.New];
		pFile_LNCA_Base	:= dcav2.files().base.companies.qa(record_type in set_updated_new);
		du							:= pFile_LNCA_Base(rawfields.enterprise_num != '');
		export ds_active_entnum := table(du,{string9 enterprise_num := rawfields.enterprise_num},rawfields.enterprise_num) : persist('~'+pPersistname);
	// #ELSE
		// export ds_active_entnum := dataset(Data_Services.foreign_prod+pPersistname, {string9 enterprise_num}, thor);
	// #END
	
	pPersistname		:= 'thor_data400::persist::BIPV2::file_current_SOS';
	// #IF(_Control.ThisEnvironment.Name='Prod_Thor')
		import corp2, paw;
		pCorpInactives	:= PAW.fCorpInactives();
		du							:= table(pCorpInactives,{corp_key},corp_key,local);
		export ds_DEAD_SOS := table(du,{corp_key},corp_key) : persist('~'+pPersistname);
	// #ELSE
		// import corp2, paw;
		// export ds_DEAD_SOS := dataset(Data_Services.foreign_prod+pPersistname, {string30 corp_key}, thor);
	// #END
	
	
	import BIPV2_Tools,bipv2;
  export Set_Duns := BIPV2_Tools.SetDuns;
 
	export dataset(l_dot) SetEnterprise(dataset(l_dot) ds_in) := function
		l_dot toEnt(l_dot L, ds_active_entnum R) := transform
			self.active_enterprise_number	:= if(R.enterprise_num != '', R.enterprise_num, '');
			self.hist_enterprise_number		:= if(R.enterprise_num = '' and MDR.sourceTools.SourceIsDCA(L.source), L.vl_id, '');
			self := L;
		end;
		return ds_in(vl_id='') + join(
			distribute(ds_in(vl_id<>''),hash32(vl_id)), distribute(ds_active_entnum,hash32(enterprise_num)),
			trim(left.vl_id) = trim(right.enterprise_num) and MDR.sourceTools.SourceIsDCA(left.source),
			toEnt(left,right),
			left outer, local
		);
	end;
	
	// Propagate F/D company_foreign_domestic values within corp_keys
	EXPORT DATASET(l_dot) prop_corpkey_fd(DATASET(l_dot) ds_in) := FUNCTION
		// Create a patch file - roll cfd values by ck and exclude conflicts
		ds_corp := ds_in(MDR.sourceTools.SourceIsCorpV2(source));
		ds_thin := TABLE(ds_corp(vl_id<>''), {vl_id, company_foreign_domestic, BOOLEAN patchable:=FALSE}, vl_id, company_foreign_domestic, MERGE);
		ds_dist := DISTRIBUTE(ds_thin, HASH32(vl_id));
		ds_dist doRoll(ds_dist L, ds_dist R) := TRANSFORM
			SELF.company_foreign_domestic := CASE(
				L.company_foreign_domestic,
				'D' => IF(R.company_foreign_domestic IN ['D',''], L.company_foreign_domestic, 'X'),
				'F' => IF(R.company_foreign_domestic IN ['F',''], L.company_foreign_domestic, 'X'),
				'U' => IF(R.company_foreign_domestic IN ['U',''], L.company_foreign_domestic, 'X'),
				''	=> R.company_foreign_domestic,
				'X'
			);
			SELF.patchable := L.patchable OR L.company_foreign_domestic<>R.company_foreign_domestic;
			SELF := L;
		END;
		ds_roll := ROLLUP(SORT(ds_dist,vl_id,LOCAL), doRoll(LEFT,RIGHT), vl_id, LOCAL);
		ds_patch := ds_roll(company_foreign_domestic IN ['D','F'] AND patchable);
		
		// Now apply the patch to the input
		ds_result := JOIN(
			ds_in(vl_id<>''), ds_patch,
			LEFT.vl_id=RIGHT.vl_id AND MDR.sourceTools.SourceIsCorpV2(LEFT.source),
			TRANSFORM(l_dot, SELF.company_foreign_domestic:=BIPV2_Tools.firstNonBlank(RIGHT.company_foreign_domestic,LEFT.company_foreign_domestic), SELF:=LEFT),
			LEFT OUTER, KEEP(1), HASH
		) + ds_in(vl_id='');
		
		OUTPUT(CHOOSEN(ds_patch,100), NAMED('ds_patch'));	// DEBUG
		OUTPUT(COUNT(ds_patch), NAMED('cnt_patch'));			// DEBUG
		
		RETURN ds_result;
	END;
  export Solo_Assumed_Name_Corpkeys(dataset(Corp2.Layout_Corporate_Direct_Corp_Base) pCorp = corp2.files().base.corp.qa) := 
  function
    
    dcorpy_select_AN          := pCorp(corp_ln_name_type_cd = 'AN' or regexfind('ASSUMED',corp_ln_name_type_desc,nocase));
    dcorpy_select_AN_corpkeys := table(dcorpy_select_AN,{corp_key},corp_key,merge);
  
    djoinback_ans := join(table(pCorp,{corp_key,corp_ln_name_type_cd,corp_ln_name_type_desc},corp_key,corp_ln_name_type_cd,corp_ln_name_type_desc,merge),dcorpy_select_AN_corpkeys,left.corp_key = right.corp_key,transform(left),hash);
    djoinback_ans_countCorpkey_groups := table(djoinback_ans,{corp_key,unsigned8 cnt := count(group)},corp_key,merge);
    djoinback_ans_countCorpkey_gt1 := djoinback_ans_countCorpkey_groups(cnt > 1);
    djoinback_ans_countCorpkey_eq1 := djoinback_ans_countCorpkey_groups(cnt = 1);
    
    return djoinback_ans_countCorpkey_eq1;
    
  end;
	
  export Current_Corpkeys(dataset(Corp2.Layout_Corporate_Direct_Corp_Base) pCorp = corp2.files().base.corp.qa) := 
  function
    
    return table(pCorp,{corp_key},corp_key,merge);
      
  end;
	export dataset(l_dot) SetSOS(dataset(l_dot) ds_in,boolean pUse_Old_Way = false) := function
		l_dot toSOS(l_dot L, ds_DEAD_SOS R) := transform
			isCorp := MDR.sourceTools.SourceIsCorpV2(L.source);
			isHist := (R.corp_key != '' or L.ingest_status='Old'); // A rec in SOS means we know the corp_key is historic. If not, we must assume it's active.
			// self.active_domestic_corp_key	:= if(isCorp and L.company_foreign_domestic = 'D' and not isHist, L.vl_id, '');
			self.active_domestic_corp_key	:= if(isCorp and L.company_foreign_domestic in ['D',''] and not isHist, L.vl_id, ''); // HACK
			self.hist_domestic_corp_key		:= if(isCorp and L.company_foreign_domestic = 'D' and isHist, L.vl_id, '');
			self.foreign_corp_key					:= if(isCorp and L.company_foreign_domestic = 'F', L.vl_id, '');
			// self.unk_corp_key							:= if(isCorp and L.company_foreign_domestic = '', L.vl_id, '');
			// self.unk_corp_key							:= if(isCorp and L.company_foreign_domestic = '' and isHist, L.vl_id, '');
			self.unk_corp_key							:= if(isCorp and L.company_foreign_domestic in ['U',''], L.vl_id, '');
			self := L;
		end;
    
    blank_vl_id := ds_in(vl_id ='');
    pop_vl_id   := ds_in(vl_id!='');
    
    setsos1 := join(
			distribute(pop_vl_id, hash32(vl_id)), distribute(ds_DEAD_SOS, hash32(corp_key)),
			trim(left.vl_id) = trim(right.corp_key) and MDR.sourceTools.SourceIsCorpV2(left.source),
			toSOS(left,right),
			left outer, local
		);
    
    setsos2 := join(
       distribute(setsos1                     , hash32(vl_id    ))
      ,distribute(Solo_Assumed_Name_Corpkeys(), hash32(corp_key ))
			,trim(left.vl_id) = trim(right.corp_key) and MDR.sourceTools.SourceIsCorpV2(left.source)
			,transform(recordof(left)
        ,self.active_domestic_corp_key  := if(right.corp_key = '',left.active_domestic_corp_key ,'')
        ,self.hist_domestic_corp_key    := if(left.active_domestic_corp_key != self.active_domestic_corp_key  ,left.active_domestic_corp_key
                                                                                                              ,left.hist_domestic_corp_key   
                                           )
        ,self                           := left
      )
			,left outer, local
		);
    
		return blank_vl_id + if(pUse_Old_Way  ,setsos1  ,setsos2);
	end;
	
	export dataset(l_dot) SetAddrType(
    dataset(l_dot) ds_in
  ) := 
  function
  
    key_advo  := Advo.Key_Addr1;
  
    // -- dedup key and take latest res/biz indicator.  keyed join takes forever
    dtable  := table(key_advo(zip != '',prim_name != '')  ,{zip,prim_range,prim_name,sec_range,date_last_seen,Residential_or_Business_Ind,unsigned cnt := count(group)},zip,prim_range,prim_name,sec_range,date_last_seen,Residential_or_Business_Ind,merge);
    dtableDedup := dedup(sort(distribute(dtable,hash64(zip,prim_range,prim_name,sec_range)),zip,prim_range,prim_name,sec_range,-date_last_seen,local),zip,prim_range,prim_name,sec_range);
    l_dot whx(l_dot le, dtableDedup ri) :=
    transform
      self.address_type_derived :=
            map(ri.Residential_or_Business_Ind = 'A'		=> 'R',
                ri.Residential_or_Business_Ind = 'B'		=> 'B',			
                le.address_type_derived);
      self := le;
    end;
    //add addr type
    WithHeader_pull := 
      join(
        ds_in,
        dtableDedup,
			// keyed(left.zip = right.zip) and 
			// keyed(left.prim_range = right.prim_Range) and
			// keyed(left.prim_name = right.prim_name) and			
			left.zip        = right.zip and 
			left.prim_range = right.prim_Range and
			left.prim_name  = right.prim_name and			
			left.sec_range  = right.sec_range
        ,whx(left, right),
        keep(1),
        left outer
        ,hash
      );
      
    WithHeader := WithHeader_pull;
  
		return WithHeader;
	end;
 
  // -------
	export dataset(l_dot) SetPrimRangeDerived(
    dataset(l_dot) ds_in
    ,string pPersistname = ''
  ) := 
  function
    import BIPV2;
    h := ds_in;
    prim_range_error_code := 'E421';//see Address.Error_Codes
    hr := {h.cnp_name, h.zip, h.prim_name, h.prim_range, h.predir, h.addr_suffix, h.sec_range, h.err_stat, h.proxid, h.ingest_status} or {typeof(h.prim_range) prim_range_derived := ''};
    hd := dedup(project(h, hr),  all)
      (length(trim(cnp_name, all)) > 3, zip <> '', prim_name <> '', prim_range <> '');//>3 is to be on the safe side with our matches by company name
    // JOIN BEST TO ITSELF TO FIND THE DERIVED PRIM NAMES
    hd_unclean 		:= hd(err_stat = prim_range_error_code);
    hd_clean 		:= hd(err_stat[1] = 'S');
    hd_clean_ddp 	:= dedup(hd_clean, cnp_name, prim_name, zip, predir, addr_suffix, sec_range, prim_range, all);
    // MAYBE WE SHOULD CALL CLEAN ANY PR,PN,ZIP COMBO THAT WAS EVER CLEAN
    hd_unclean2 :=
    join(
      hd_unclean,
      hd_clean,
      left.prim_Range = right.prim_range and
      left.prim_name = right.prim_name and
      left.zip = right.zip,
      transform(left),
      left only,
      hash
    );
    jprd0 :=
    join(
      hd_unclean2,
      hd_clean_ddp,
      left.cnp_name = right.cnp_name and
      left.prim_name = right.prim_name and
      left.zip = right.zip and
      ut.withineditn(left.prim_range, right.prim_range, 1) and 
      ut.NNEQ(left.predir, right.predir) and
      ut.NNEQ(left.addr_suffix, right.addr_suffix) and
      ut.NNEQ(left.sec_range, right.sec_range) and
      left.prim_range <> right.prim_range  and
      left.proxid <> right.proxid
      ,
      transform(
        {hr, typeof(hr.ingest_status) ingest_status_for_pr_derived, typeof(hr.proxid)  proxid_for_pr_derived},
        self.prim_range_derived := right.prim_range,
        self.ingest_status_for_pr_derived := right.ingest_status,
        self.proxid_for_pr_derived := right.proxid,
        self:= left
      )
      ,limit(1000, skip)
    ) : persist('~persist::BIPV2_Files::tools_dotid.jprd0' + trim(pPersistname), expire(7));
    //if a prim_range matches to more than one derived prim_range, then dont let it derive
    jprd0d := dedup(jprd0, all);
    jprd :=
    join(
      jprd0d,
      jprd0d,
      left.prim_range = right.prim_range and 
      left.proxid = right.proxid and
      left.prim_range_derived <> right.prim_range_derived,
      hash,
      left only
    );
    //output(hd_unclean, named('hd_unclean'));
    //output(hd_unclean2, named('hd_unclean2'));
    //output(hd_clean, named('hd_clean'));
    //output(jprd0, named('jprd0'));
    //output(jprd, named('jprd'));
    rh2 := {recordof(h) or {string10 prim_range_derived := ''}};//should be flexible enough to span a layout change and then the prim_name_derived part of this can be removed
    //The infile is what we want: -----------------------------------
    infile :=
    join(
      h,
      dedup(jprd, proxid, prim_range, prim_name, predir, addr_suffix, sec_range, all), //this ensures we dont create dups as long as it matches the join blocking criteria.  could also use keep(1)
      left.proxid = right.proxid and
      left.prim_range = right.prim_range and
      left.prim_name = right.prim_name and
      left.predir = right.predir and
      left.addr_suffix = right.addr_suffix and
      left.sec_range = right.sec_range and	
      left.err_stat = prim_range_error_code and 
      left.zip = right.zip
      ,transform(
        rh2,
        self.prim_range_derived := if(right.prim_range_derived <> '', right.prim_range_derived, left.prim_range),
        self := left
      )
      ,smart
      ,left outer
      , keep(1)
    );
  
    return infile;
    
	end;
  // ----------
  
	export dataset(l_dot) Set_Vanity_Owner_Did(
     dataset(l_dot                  ) ds_in
    // ,dataset(header.Layout_Header_v2) pHeaders = Header.File_Headers
    ,boolean pDebugOutputs  = true
    ,string  pPersistUnique = ''
  
  ) := 
  function
  
    import header,CompanyNameAnalysis,did_Add,std,address;
    //take residential addresses
    //take only company name with a vanity name attached(first/last)
    //join those to the header file on address and name, then grab the did and put it in vanity_owner_did
    ds_residential := ds_in(address_type_derived  = 'R');
    ds_other       := ds_in(address_type_derived != 'R');
    // single_addr_orgids := table(table(ds_in,{orgid,prim_range,prim_name,v_city_name,st},orgid,prim_range,prim_name,v_city_name,st,merge),{orgid,unsigned cnt := count(group)},orgid)(cnt = 1); //do this later!!!
    
    ds_setaddr_res := table(ds_residential,{cnp_name,fname,mname,lname,contact_did,contact_job_title_raw,contact_job_title_derived},cnp_name,fname,mname,lname,contact_did,contact_job_title_raw,contact_job_title_derived,merge);
    ds_setaddr_res_name_only := table(ds_setaddr_res,{cnp_name},cnp_name,merge);
    ds_setaddr_res_clean := project(ds_setaddr_res_name_only  ,transform({recordof(left)},self := left));
    
    ds_joinback := join(ds_setaddr_res,ds_setaddr_res_clean,left.cnp_name = right.cnp_name,transform({recordof(left)},self := right,self := left),hash);
    ds_joinback_rid := project(ds_joinback,transform({unsigned6 rid,string coname,recordof(left)},self.rid := counter,self.coname := left.cnp_name,self := left)); 
    CompanyNameAnalysis.Mac_isVanityName(ds_joinback_rid,coname,outvanity,outvanity2,rid,,pDebugOutputs);
    outvanity_persist := outvanity(vanity = true)  : persist('~persist::BIPV2_Files::tools_dotid.Set_Vanity_Owner_Did.outvanity_persist' + pPersistUnique);
    outvanity_clean := project(dedup(outvanity_persist,full_name,all)  ,transform({recordof(left),Address.Layout_Clean_Name clean_cname},self.clean_cname := Address.CleanPersonFML73_fields(left.full_name).CleanNameRecord,self := left));
    ds_joinback4addr := join(ds_residential,outvanity_clean,left.cnp_name = right.full_name,transform({recordof(left),string20 owner_fname,string20 owner_mname,string20 owner_lname,string5 owner_name_suffix}
    ,self.owner_fname := right.clean_cname.fname
    ,self.owner_mname := right.clean_cname.mname
    ,self.owner_lname := right.clean_cname.lname
    ,self.owner_name_suffix := right.clean_cname.name_suffix
    ,self.is_vanity_name_derived := true
    ,self := left),hash);
    // ds_onlysingle_addr_orgids := join(ds_joinback4addr,single_addr_orgids,left.orgid = right.orgid,transform(left),hash);  //do this later!!!
    matchset := ['A'];
    did_Add.MAC_Match_Flex(ds_joinback4addr,matchset,
              '','',owner_fname,owner_mname,owner_lname,owner_name_suffix,
              prim_range,prim_name,sec_range,zip,st,'',
              vanity_owner_did,
              recordof(ds_joinback4addr),
              false, did_score,
              75,
              dsWithADL)
              
    withDid := dsWithADL;
    
    //get rest of recs
    ds_rest     := join(ds_in ,withDid ,left.rcid = right.rcid  ,transform(left),left only,hash);
    withDid_out := project(withDid  ,l_dot);
    
        
		return withDid_out + ds_rest;
	end;

 // -- SetFeins -- use old base file to set feins properly by taking into account deletions/corrections
  export SetFeins(

     pDs_Fein
    ,pDs_Base       = 'BIPV2.CommonBase.DS_base'
    ,pDebugOutputs  = 'true'
    
  ) :=
  functionmacro

    import BIPV2;
    
		isDunns(string src) := (MDR.sourcetools.sourceisDunn_Bradstreet(src) or 
                            MDR.sourcetools.SourceIsDunn_Bradstreet_Fein(src));
		
    Ds_Fein_fix := project(pDs_Fein ,transform(recordof(left),self.company_fein := if(trim(left.company_fein) not in ['999999999']  ,left.company_fein,''),self := left));
    
    ds_updates_with_fein    := Ds_Fein_fix(company_fein != '');
    ds_updates_without_fein := Ds_Fein_fix(company_fein  = '');
		
    ds_base_with_deleted_fein    := pDs_Base(deleted_fein != '' and isDunns(source));

    ds_refresh_fein := join(ds_updates_with_fein  ,ds_base_with_deleted_fein  
      ,     left.source           = right.source 
        and left.source_record_id = right.source_record_id
        and left.company_fein     = right.deleted_fein
        and left.company_name     = right.company_name      //keep this here in case source record ids become non-persistent
      ,transform({unsigned6 proxid_old,BIPV2.CommonBase.Layout}
        ,self.company_fein := if(right.deleted_fein != '' ,''                 ,left.company_fein)
        ,self.deleted_fein := if(right.deleted_fein != '' ,left.company_fein  ,''               )
        ,self.proxid_old   := right.proxid
        ,self              := left
        // ,self              := []
      )
      ,hash
      ,keep(1)
      ,left outer
    );
    
    fslim :=  
      // return project(pmydata,{unsigned6 lgid3,unsigned6 lgid3_old,unsigned6 proxid,unsigned6 proxid_old,unsigned6 dotid,string source,string cnp_name,string active_duns_number,string deleted_key,string duns_number,string company_fein,string prim_range,string prim_name,string st,string zip ,recordof(left) - company_name_type_derived - source - cnp_name - lgid3 - prim_range - prim_name - st - zip - company_fein - active_domestic_corp_key - active_duns_number - duns_number - hist_duns_number - deleted_key - proxid - dotid});
      // return table(pmydata,{lgid3_old,lgid3,proxid_old,proxid,cnp_name,deleted_key,duns_number,company_fein,deleted_fein,prim_range, prim_name,st,zip }
       table(ds_base_with_deleted_fein,{lgid3,proxid,cnp_name,deleted_key,duns_number,company_fein,deleted_fein,prim_range, prim_name,st,zip }
      ,lgid3,proxid,cnp_name,deleted_key,duns_number,company_fein,deleted_fein,prim_range, prim_name,st,zip ,merge);

    ds_sort := project(sort(distribute(fslim,proxid),proxid,local),transform(
      {unsigned6 proxid,dataset(recordof(left)) recs}
      ,self.proxid := left.proxid
      ,self.recs := dataset(left)
    ));
    
    ds_rollup_deleted := rollup(ds_sort
      ,left.proxid = right.proxid
      ,transform(recordof(left),self.proxid := left.proxid,self.recs := left.recs + right.recs)
      ,local);
    
    // {string file,recordof(fslim)} tr_Update2Base(recordof(ds_refresh_fein) l) := 
    // transform
      // self.file           := 'Update';
      // self.lgid3          := 0;
      // self.proxid         := 0;
      // self.cnp_name       := l.company_name;
      // self.deleted_key    := '';
      // self.duns_number    := l.duns_number;
      // self.company_fein   := l.company_fein;
      // self.deleted_fein   := l.deleted_fein;
      // self.prim_range     := l.company_address.prim_range;
      // self.prim_name      := l.company_address.prim_name;
      // self.st             := l.company_address.st;
      // self.zip            := l.company_address.zip;
    // end;
    
    ds_examples := join(ds_refresh_fein(proxid_old != 0) ,ds_rollup_deleted  ,left.proxid_old = right.proxid
    ,transform({unsigned6 proxid,dataset({string file,recordof(fslim)}) recs}
      ,self.proxid  := left.proxid_old
      ,self.recs    :=  project(dataset(left ),transform({string file,recordof(fslim)},self.file := 'Update',self := left))
                      + project(right.recs,transform({string file,recordof(fslim)},self.file := 'base'  ,self := left))
    )
    ,hash);

  ds_result :=  project(ds_refresh_fein,BIPV2.CommonBase.Layout) 
              + project(ds_updates_without_fein,transform(BIPV2.CommonBase.Layout,self := left,self := []));
                ;
  ds_stats := dataset(
    [{
       count(pDs_Fein)
      ,count(ds_result  )
      ,count(pDs_Fein   (company_fein != ''))
      ,count(ds_result  (company_fein != ''))
      // ,count(ds_as_linking(deleted_fein != ''))
      ,count(ds_result  (deleted_fein != ''))
    }
    ]
    ,{
     unsigned cnt_recs_in  
    ,unsigned cnt_recs_out
    ,unsigned cnt_company_feins_in  
    ,unsigned cnt_company_feins_out
    // ,unsigned cnt_deleted_feins_in  
    ,unsigned cnt_deleted_feins_out
    }
  );
   
    return  when(
           ds_result
          ,if(pDebugOutputs = true  ,parallel(
             output(ds_stats                        ,named('SetFeins_stats'   ))
            ,output(topn(ds_examples  ,300,proxid)  ,named('SetFeins_examples'))
          ))
          );
    
  endmacro;
 
	// wrap up all the conversion steps into a single function
	export dataset(l_dot) setDerived(dataset(l_dot) ds_in,boolean pDebugOutputs = true) := function
		ds_cnp	 := SetCompanyFields    (ds_in  );
		ds_duns	 := Set_Duns            (ds_cnp ,false,pDebug_Outputs := pDebugOutputs);
		ds_ent	 := SetEnterprise       (ds_duns);
		ds_sos	 := SetSOS              (ds_ent );
    ds_fein  := SetFeins            (ds_sos ,,pDebugOutputs);
		ds_pn		 := SetPrimNameDerived  (ds_fein);
		ds_pr		 := SetPrimRangeDerived (ds_pn  );
    ds_at    := SetAddrType         (ds_pr  );
    ds_owner := Set_Vanity_Owner_Did(ds_at  ,pDebugOutputs);
		return ds_owner;
	end;
	shared rawToDot(dataset(l_as_linking) ds_in,boolean pDebugOutputs  = true) := module
		export ds_tops	:= ds_in(BIPV2.mod_sources.srcInBIPV2Header(source));
		import tools;
    ds_seq          := tools.MAC_Sequence_Records(ds_tops,rcid);
		ds_flat	        := project(ds_seq, flatten(left,left.rcid)) : INDEPENDENT;
		shared mod_bct	:= BlankCommonTerms(ds_flat);
		
		ds_derived := setDerived(mod_bct.result,pDebugOutputs) : INDEPENDENT;
		shared mod_filt	:= FiltUnlinkable(ds_derived);
		export ds_good	:= mod_filt.result : INDEPENDENT;
		
		export outCounts := parallel(output(count(ds_in),named('cnt_total')), output(count(ds_tops),named('cnt_tops')), output(count(ds_good),named('cnt_good')));
		
		ds_CCPA := MDR.macGetGlobalSID(ds_good, 'BIPV2', 'source', 'global_sid');
    LocationID_xLink.Append(ds_CCPA, 
                            prim_range, 
                            predir, 
                            prim_name, 
                            addr_suffix, 
                            postdir, 
                            sec_range, 
                            v_city_name, 
                            st, 
                            zip, 
                            ds_with_locid); 			
		
		export result		:= project(ds_with_locid, transform(l_dot, self.rcid:=0, self:=left)); // strip temporary rcids
		export err_rec	:= mod_bct.err_rec + mod_filt.err_rec;
		export err_summary := sort(table(err_rec, {string60 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source),source,remedy,reason,unsigned cnt:=count(group)}, source,remedy,reason, merge), record);
		
		ds_cnt_tot	:= table(ds_tops, {source, unsigned cnt_total:=count(group), unsigned cnt_reject:=0, unsigned cnt_blank:=0, unsigned cnt_good:=0}, source, merge);
		ds_cnt_good	:= table(ds_good, {source, unsigned cnt_total:=0, unsigned cnt_reject:=0, unsigned cnt_blank:=0, unsigned cnt_good:=count(group)}, source, merge);
		ds_cnt_err	:= project(err_summary, transform(recordof(ds_cnt_tot), self.source:=left.source, self.cnt_reject:=if(left.remedy='REJECT',left.cnt,0), self.cnt_blank:=if(left.remedy='BLANK',left.cnt,0), self:=[]));
		ds_cnt_tot toRoll(ds_cnt_tot L, ds_cnt_tot R) := transform
			self.source			:= if(L.source<>'', L.source, R.source);
			self.cnt_total	:= L.cnt_total + R.cnt_total;
			self.cnt_reject	:= L.cnt_reject + R.cnt_reject;
			self.cnt_blank	:= L.cnt_blank + R.cnt_blank;
			self.cnt_good		:= L.cnt_good + R.cnt_good;
		end;
		export err_xtab := rollup(sort(ds_cnt_tot+ds_cnt_good+ds_cnt_err, source), toRoll(left,right), source);
		export err_xtab_agg := table(err_xtab, {string60 src_name:=BIPV2.mod_sources.TranslateSource_aggregate(source), cnt_total, cnt_reject, cnt_blank, cnt_good});
		
	end;
	
	// reinitialize all linking ids to singletons
	export dataset(l_dot) reInitIDs(dataset(l_dot) ds_in) := function
		l_dot toNull(l_dot L) := transform
			self.DOTid	:= L.rcid;
			self.EmpID	:= L.rcid;
			self.POWID	:= L.rcid;
			self.ProxID	:= L.rcid;
			self.OrgID	:= L.rcid;
			self.UltID	:= L.rcid;
			self.SELEID	:= L.rcid;
			self := L;
		end;
		return project(ds_in, toNull(left));
	end;
	export boolean isgoodsic(string psic,string2 psource) := 
      (
        (     mdr.sourceTools.SourceIsDunn_Bradstreet     (psource) 
          or  mdr.sourceTools.SourceIsInfutor_NARB        (psource) 
          or  mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(psource)
          or  mdr.sourceTools.SourceIsDataBridge          (psource) 
        ) 
        and length(trim(psic)) in [4,8]
      )
      or length(trim(psic)) = 4
      ;
	
	export dataset(l_dot) SetSICNAICS(dataset(l_dot) ds_in) := function
		l_dot tCleanSIC(l_dot L) := transform
			self.company_sic_code1							:= if (trim(l.company_sic_code1  ) != '' and ut.fn_valid_SICCode  (l.company_sic_code1  ) = 1 and isgoodsic   (l.company_sic_code1    ,l.source ) = true, trim(l.company_sic_code1   )   ,'');
			self.company_sic_code2							:= if (trim(l.company_sic_code2  ) != '' and ut.fn_valid_SICCode  (l.company_sic_code2  ) = 1 and isgoodsic   (l.company_sic_code2    ,l.source ) = true, trim(l.company_sic_code2   )   ,'');
			self.company_sic_code3							:= if (trim(l.company_sic_code3  ) != '' and ut.fn_valid_SICCode  (l.company_sic_code3  ) = 1 and isgoodsic   (l.company_sic_code3    ,l.source ) = true, trim(l.company_sic_code3   )   ,'');
			self.company_sic_code4							:= if (trim(l.company_sic_code4  ) != '' and ut.fn_valid_SICCode  (l.company_sic_code4  ) = 1 and isgoodsic   (l.company_sic_code4    ,l.source ) = true, trim(l.company_sic_code4   )   ,'');
			self.company_sic_code5							:= if (trim(l.company_sic_code5  ) != '' and ut.fn_valid_SICCode  (l.company_sic_code5  ) = 1 and isgoodsic   (l.company_sic_code5    ,l.source ) = true, trim(l.company_sic_code5   )   ,'');
			self.company_naics_code1						:= if (trim(l.company_naics_code1) != '' and ut.fn_valid_NAICSCode(l.company_naics_code1) = 1 and length(trim (l.company_naics_code1)           ) = 6   , trim(l.company_naics_code1 )   ,'');
			self.company_naics_code2						:= if (trim(l.company_naics_code2) != '' and ut.fn_valid_NAICSCode(l.company_naics_code2) = 1 and length(trim (l.company_naics_code2)           ) = 6   , trim(l.company_naics_code2 )   ,'');
			self.company_naics_code3						:= if (trim(l.company_naics_code3) != '' and ut.fn_valid_NAICSCode(l.company_naics_code3) = 1 and length(trim (l.company_naics_code3)           ) = 6   , trim(l.company_naics_code3 )   ,'');
			self.company_naics_code4						:= if (trim(l.company_naics_code4) != '' and ut.fn_valid_NAICSCode(l.company_naics_code4) = 1 and length(trim (l.company_naics_code4)           ) = 6   , trim(l.company_naics_code4 )   ,'');
			self.company_naics_code5						:= if (trim(l.company_naics_code5) != '' and ut.fn_valid_NAICSCode(l.company_naics_code5) = 1 and length(trim (l.company_naics_code5)           ) = 6   , trim(l.company_naics_code5 )   ,'');
			self := L;
		end;
		return project(ds_in, tCleanSIC(left));
	end;
  
  
	export dataset(l_dot) RemoveBogusNames(dataset(l_dot) ds_in) := 
  function
      filterexamples := ds_in(
                            BIPV2_Tools.BogusNames.BogusNames(company_name  )
                         // or BIPV2_Tools.BogusNames.BogusNames(dba_name     )
                         or BIPV2_Tools.BogusNames.BogusNames(lname         )
                         or BIPV2_Tools.BogusNames.BogusNames(mname         )
                         or BIPV2_Tools.BogusNames.BogusNames(fname         )
                      );
      
      filterout :=    ds_in(
                          ~(BIPV2_Tools.BogusNames.BogusNames(company_name  )
                         // or BIPV2_Tools.BogusNames.BogusNames(dba_name     )
                         or BIPV2_Tools.BogusNames.BogusNames(lname         )
                         or BIPV2_Tools.BogusNames.BogusNames(mname         )
                         or BIPV2_Tools.BogusNames.BogusNames(fname         )
                      ));

      return when(filterout
        ,parallel(
           output(count(ds_in    )                    ,named('BIPV2_Files_tools_dotid_RemoveBogusNames_Count_In'            ))
          ,output(count(filterout)                    ,named('BIPV2_Files_tools_dotid_RemoveBogusNames_Count_Out'           ))
          ,output(count(ds_in    ) - count(filterout) ,named('BIPV2_Files_tools_dotid_RemoveBogusNames_Count_Removed'       ))
          ,output(choosen(filterexamples,100)         ,named('BIPV2_Files_tools_dotid_RemoveBogusNames_FilteredOut_Examples'))
        )
      );
  
  end;

	// rerun selected routines on an existing DOT file
	export dataset(l_dot) reclean(dataset(l_dot) ds_in) := function
		ds_cnp	:= SetCompanyFields     (ds_in    );
		ds_duns	:= Set_Duns             (ds_cnp   ,false,,'reclean',pDebug_Outputs := false);
		ds_ent	:= SetEnterprise        (ds_duns  );
		ds_sos	:= SetSOS               (ds_ent   );
		ds_pn		:= SetPrimNameDerived   (ds_sos   );
    ds_pr		:= SetPrimRangeDerived  (ds_pn    ,'reclean');
    ds_at   := SetAddrType          (ds_pr    );
    ds_owner:= Set_Vanity_Owner_Did (ds_at    ,false,'reclean');
    ds_sic  := SetSICNAICS          (ds_owner );
    ds_filt := RemoveBogusNames     (ds_sic   );
		return ds_filt;
	end;
	
	export city_samp(ds_in, st_field, city_field) := functionmacro
		return ds_in(
			st_field in ['FL','OH'],
			city_field in [
				'BOCA RATON','BOCARATON','BOCA RTN','BCA RTN','DELRAY BEACH','DEL RAY BEACH','DELRAY BCH','DEL RAY BCH',
				'MIAMISBURG','DAYTON','GERMANTOWN','KETTERING','WILMINGTON']
		);
	endmacro;
	
	// base files, computed on-the-fly
	shared raw				:= distribute(ds_as_linking);
	shared raw_samp		:= nofold(city_samp(raw, company_address.st, company_address.v_city_name));
	export base				:= rawToDot(raw).result;
	export base_NoDebug				:= rawToDot(raw,false).result;
	export count_ds_In	  := count(raw);
	export count_ds_Tops	:= count(rawToDot(raw).ds_Tops);
	export count_ds_Good	:= count(rawToDot(raw).ds_Good);
	export outCounts	:= rawToDot(raw).outCounts;
	export err_rec		:= rawToDot(raw).err_rec;
	export err_summary	:= rawToDot(raw).err_summary;
	export base_samp		:= rawToDot(raw_samp).result;
	export err_rec_samp	:= rawToDot(raw_samp).err_rec;
	export Convert_Vanity_To_Regular(
     pds_in               = 'bipv2.commonbase.ds_base'
    ,pSet_Ingest_Statuses = '[\'New\',\'Unchanged\',\'Updated\']'
  ) := 
  functionmacro
  
    import header,CompanyNameAnalysis,did_Add,std,address;
    dfilter := pds_in(vanity_owner_did != 0,vanity_owner_did != contact_did,BIPV2.mod_sources.srcInBase(source),pSet_Ingest_Statuses = [] or ingest_status in pSet_Ingest_Statuses);
        
    ds_proj := project(dfilter,transform(recordof(left)
    ,cleaned_name := Address.CleanPersonFML73_fields(left.cnp_name);
    self.empid                        := 0                         ;//zero out dot and empid since the vanity owner doesn't have these(the records need to be ingested with the vanity name, etc to get these values)
    self.dotid                        := 0                         ;
    self.contact_did                  := left.vanity_owner_did     ; 
    self			                        := cleaned_name.CleanNameRecord		;
    self                              := left                      ;
    // self.company_address.prim_range	 := left.prim_range	          ; 
    // self.company_address.predir			 := left.predir			          ;
    // self.company_address.prim_name		 := left.prim_name		        ; 
    // self.company_address.addr_suffix	 := left.addr_suffix	        ;
    // self.company_address.postdir			 := left.postdir			        ; 
    // self.company_address.unit_desig	 := left.unit_desig	          ;
    // self.company_address.sec_range		 := left.sec_range		        ; 
    // self.company_address.p_city_name	 := left.p_city_name	        ;
    // self.company_address.v_city_name	 := left.v_city_name	        ; 
    // self.company_address.st					 := left.st					          ;
    // self.company_address.zip					 := left.zip					        ; 
    // self.company_address.zip4				 := left.zip4				          ;
    // self.company_address.cart				 := left.cart				          ; 
    // self.company_address.cr_sort_sz	 := left.cr_sort_sz	          ;
    // self.company_address.lot					 := left.lot					        ; 
    // self.company_address.lot_order		 := left.lot_order		        ;
    // self.company_address.dbpc				 := left.dbpc				          ; 
    // self.company_address.chk_digit		 := left.chk_digit		        ;
    // self.company_address.rec_type		 := left.rec_type		          ; 
    // self.company_address.fips_state	 := left.fips_state	          ;
    // self.company_address.fips_county	 := left.fips_county	        ; 
    // self.company_address.geo_lat			 := left.geo_lat			        ; 
    // self.company_address.geo_long		 := left.geo_long		          ;
    // self.company_address.msa					 := left.msa					        ; 
    // self.company_address.geo_blk			 := left.geo_blk			        ;
    // self.company_address.geo_match		 := left.geo_match		        ; 
    // self.company_address.err_stat		 := left.err_stat		          ;
    // self.contact_name			           := cleaned_name.CleanNameRecord		;
    // ,self.contact_name.fname			     := left.fname			
    // ,self.contact_name.mname			     := left.mname			
    // ,self.contact_name.lname			     := left.lname			
    // ,self.contact_name.name_suffix     := left.name_suffix
    // ,self.contact_name.name_score	     := left.name_score	
    // self                              := [];
  
  ));    
    
    ddedup_it1 := dedup(sort(ds_proj    ,proxid,contact_did),proxid,contact_did);
    ddedup_it2 := dedup(sort(distribute(ddedup_it1,hash64(proxid,contact_did)) ,proxid,contact_did,local),proxid,contact_did,local);
        
		return ddedup_it2;
	endmacro;
	
  export runit := Convert_Vanity_To_Regular(bipv2.commonbase.ds_base);
  
  // -- Re-DID the whole file
  export APPEND_DID(
  
    pDs_Append
    
  ) := 
  functionmacro
  
    ds_base := pDs_Append;
 
    ds_contacts     := ds_base(    fname != '' and lname != '') ;
    ds_Not_contacts := ds_base(not(fname != '' and lname != ''));
    new_layout := {unsigned6 orig_contact_did, string9 new_contact_ssn,recordof(ds_base)};
    ds_contacts_save_did := project(ds_contacts,transform(new_layout
      ,self.orig_contact_did  := left.contact_did
      ,self.new_contact_ssn   := ''
      ,self.contact_did       := 0
      ,self.contact_ssn       := left.contact_ssn //keep orig ssn the same for now
      ,self                   := left
    ));
    import tools,aid,address,MDR,Business_Header_SS,business_header,DID_Add,business_headerv2;
    import tools,
			address,
			idl_header,
			Header_Slimsort,
			AID,
 		  DID_Add,
			lib_StringLib,
			Census_Data,
			Watchdog;
   ds_Append_DID  		:= tools.mac_Append_DID(ds_contacts_save_did	,'fname','mname','lname','name_suffix',['prim_range'],['prim_name'],['zip'],['sec_range'],['st'],['contact_phone']
      ,'contact_did','','rcid','contact_ssn',,,'',,false);
    import did_add;    
    // Watchdog.mac_Append_Ssn(pDataset,did,subject_ssn,out_dataset,false);
    did_add.MAC_Add_SSN_By_DID(ds_Append_DID, contact_did, new_contact_ssn, ds_Append_SSN, false,true); //append ssn just to check to see how reliable this field is per source.
    // output(ds_Append_SSN,,'~thor_data400::bipv2::internal_linking::20150804_test',__compressed__);
    
		
		//KDW: Removed line that set contact_ssn to null
		//KDW: See Jira:  https://jira.rsi.lexisnexis.com/browse/BH-315
    ds_return := ds_Append_SSN 
    + project(ds_Not_contacts  ,transform(new_layout
      ,self.orig_contact_did  := left.contact_did
      ,self.contact_did       := 0
      ,self                   := left
      ,self                   := []
    ))
    : persist('~persist::BIPV2_Files::tools_dotid.APPEND_DID.ds_return');
    
    return ds_return;

  endmacro;
  
  export ds_redid := APPEND_DID(bipv2.CommonBase.ds_base);
  
  import bipv2_build,bipv2;
  
  export RE_DID_Stats (
  
     pDs_Append_Did
    // ,pversion         = 'bipv2.KeySuffix'                     // build date
    // ,pIsTesting       = 'false'                               // true = do not send to strata, false = send to strata
    // ,pEmail_List      = 'BIPV2_Build.mod_email.emailList'     // email list 
    // ,pOverwrite       = 'false'                               // no effect yet
  ) := 
  functionmacro
	  ds_slim  := table(pDs_Append_Did,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),contact_did,string9 contact_ssn := new_contact_ssn,orig_contact_did,string9 orig_contact_ssn := contact_ssn});
    ds_table := table(ds_slim ,{source, string ingest_status:='', string field := 'contact_did',unsigned countgroup := count(group)  
      ,unsigned total_new   := sum(group,if(contact_did != 0,1,0))  
      ,unsigned total_old   := sum(group,if(orig_contact_did != 0,1,0))  
      ,unsigned gained      := sum(group,if(contact_did != 0 and orig_contact_did = 0,1,0))  
      ,unsigned lost        := sum(group,if(contact_did  = 0 and orig_contact_did != 0,1,0))  
      ,unsigned changed     := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did != orig_contact_did,1,0))  
      ,unsigned same        := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did  = orig_contact_did,1,0))  
      },source,merge)
      +
    table(ds_slim ,{source, string ingest_status:='', string field := 'contact_ssn',unsigned countgroup := count(group)  
      ,unsigned total_new   := sum(group,if(contact_ssn != '',1,0))  
      ,unsigned total_old   := sum(group,if(orig_contact_ssn != '',1,0))  
      ,unsigned gained      := sum(group,if(contact_ssn != '' and orig_contact_ssn = '',1,0))  
      ,unsigned lost        := sum(group,if(contact_ssn  = '' and orig_contact_ssn != '',1,0))  
      ,unsigned changed     := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn != orig_contact_ssn,1,0))  
      ,unsigned same        := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn  = orig_contact_ssn,1,0))  
      },source,merge)
      +
    table(ds_slim ,{string source := '_Total', string ingest_status := '', string field := 'contact_did',unsigned countgroup := count(group)  
      ,unsigned total_new   := sum(group,if(contact_did != 0,1,0))  
      ,unsigned total_old   := sum(group,if(orig_contact_did != 0,1,0))  
      ,unsigned gained      := sum(group,if(contact_did != 0 and orig_contact_did = 0,1,0))  
      ,unsigned lost        := sum(group,if(contact_did  = 0 and orig_contact_did != 0,1,0))  
      ,unsigned changed     := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did != orig_contact_did,1,0))  
      ,unsigned same        := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did  = orig_contact_did,1,0))  
      },'_Total',merge)
      +
    table(ds_slim ,{string source := '_Total', string ingest_status := '', string field := 'contact_ssn',unsigned countgroup := count(group)  
      ,unsigned total_new   := sum(group,if(contact_ssn != '',1,0))  
      ,unsigned total_old   := sum(group,if(orig_contact_ssn != '',1,0))  
      ,unsigned gained      := sum(group,if(contact_ssn != '' and orig_contact_ssn = '',1,0))  
      ,unsigned lost        := sum(group,if(contact_ssn  = '' and orig_contact_ssn != '',1,0))  
      ,unsigned changed     := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn != orig_contact_ssn,1,0))  
      ,unsigned same        := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn  = orig_contact_ssn,1,0))  
      },'_Total',merge)
    ;
  
    return sort(ds_table,source,field);
//      ds_slim  := table(pDs_Append_Did,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),ingest_status,contact_did,string9 contact_ssn := new_contact_ssn,orig_contact_did,string9 orig_contact_ssn := contact_ssn});
       // ds_table := table(ds_slim ,{source,ingest_status,string field := 'contact_did',unsigned countgroup := count(group)  
         // ,unsigned total_new   := sum(group,if(contact_did != 0,1,0))  
         // ,unsigned total_old   := sum(group,if(orig_contact_did != 0,1,0))  
         // ,unsigned gained      := sum(group,if(contact_did != 0 and orig_contact_did = 0,1,0))  
         // ,unsigned lost        := sum(group,if(contact_did  = 0 and orig_contact_did != 0,1,0))  
         // ,unsigned changed     := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did != orig_contact_did,1,0))  
         // ,unsigned same        := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did  = orig_contact_did,1,0))  
         // },source,ingest_status,merge)
         // +
       // table(ds_slim ,{source,ingest_status,string field := 'contact_ssn',unsigned countgroup := count(group)  
         // ,unsigned total_new   := sum(group,if(contact_ssn != '',1,0))  
         // ,unsigned total_old   := sum(group,if(orig_contact_ssn != '',1,0))  
         // ,unsigned gained      := sum(group,if(contact_ssn != '' and orig_contact_ssn = '',1,0))  
         // ,unsigned lost        := sum(group,if(contact_ssn  = '' and orig_contact_ssn != '',1,0))  
         // ,unsigned changed     := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn != orig_contact_ssn,1,0))  
         // ,unsigned same        := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn  = orig_contact_ssn,1,0))  
         // },source,ingest_status,merge)
         // +
       // table(ds_slim ,{string source := 'Total',string9 ingest_status := '',string field := 'contact_did',unsigned countgroup := count(group)  
         // ,unsigned total_new   := sum(group,if(contact_did != 0,1,0))  
         // ,unsigned total_old   := sum(group,if(orig_contact_did != 0,1,0))  
         // ,unsigned gained      := sum(group,if(contact_did != 0 and orig_contact_did = 0,1,0))  
         // ,unsigned lost        := sum(group,if(contact_did  = 0 and orig_contact_did != 0,1,0))  
         // ,unsigned changed     := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did != orig_contact_did,1,0))  
         // ,unsigned same        := sum(group,if(contact_did != 0 and orig_contact_did != 0 and contact_did  = orig_contact_did,1,0))  
         // },'Total',merge)
         // +
       // table(ds_slim ,{string source := 'Total',string9 ingest_status := '',string field := 'contact_ssn',unsigned countgroup := count(group)  
         // ,unsigned total_new   := sum(group,if(contact_ssn != '',1,0))  
         // ,unsigned total_old   := sum(group,if(orig_contact_ssn != '',1,0))  
         // ,unsigned gained      := sum(group,if(contact_ssn != '' and orig_contact_ssn = '',1,0))  
         // ,unsigned lost        := sum(group,if(contact_ssn  = '' and orig_contact_ssn != '',1,0))  
         // ,unsigned changed     := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn != orig_contact_ssn,1,0))  
         // ,unsigned same        := sum(group,if(contact_ssn != '' and orig_contact_ssn != '' and contact_ssn  = orig_contact_ssn,1,0))  
         // },'Total',merge)
       // ;
     
       // return sort(ds_table,source,ingest_status,field);
// 
    
    // return Strata.macf_CreateXMLStats (return_dataset ,'BIPV2','PrepIngest'  ,pversion	,pEmail_List	,'Stats' ,'ReDid'	,pIsTesting,pOverwrite);
    // BIPV2_Strata.mac_BIP_ID_Check(pDataset,'POWID','Preprocess',pversion,pIsTesting)
  endmacro;
  
  export Fix_Dotid_Overlinks (
  
     pBIP_File
    ,pBIP_ID      = 'dotid' //or empid
    ,pBIP_Rid     = 'rcid'  //or dotid
    
  ) := 
  functionmacro
  
    #UNIQUENAME(BIP_ID_ORIG)
    #SET(BIP_ID_ORIG  ,#TEXT(pBIP_ID) + '_orig')
    
    // -- get clusters that have lname and/or fname blank and populated.
    ds_prep := table(pBIP_File  ,{pBIP_ID
      ,unsigned cnt_fname_blanks    := sum(group,if(trim(fname)  = '',1,0))  
      ,unsigned cnt_fname_populated := sum(group,if(trim(fname) != '',1,0))  
      ,unsigned cnt_lname_blanks    := sum(group,if(trim(lname)  = '',1,0))  
      ,unsigned cnt_lname_populated := sum(group,if(trim(lname) != '',1,0))  
    },pBIP_ID,merge);
    
    ds_bad_clusters  := ds_prep(    (cnt_fname_blanks > 0 and cnt_fname_populated > 0) or (cnt_lname_blanks > 0 and cnt_lname_populated > 0) );
    ds_good_clusters := ds_prep(not((cnt_fname_blanks > 0 and cnt_fname_populated > 0) or (cnt_lname_blanks > 0 and cnt_lname_populated > 0)));
  
    ds_bad_full_recs  := join(pBIP_File  ,ds_bad_clusters  ,left.pBIP_ID = right.pBIP_ID ,transform(left),hash);
    ds_good_full_recs := join(pBIP_File  ,ds_bad_clusters  ,left.pBIP_ID = right.pBIP_ID ,transform(left),hash,left only);
  
    ds_bad_slim := table(ds_bad_full_recs ,{pBIP_ID,lname,fname,unsigned6 lowest_rcid := min(group,pBIP_Rid)},pBIP_ID,lname,fname,merge);
    
    temp_layout := {unsigned6 %BIP_ID_ORIG%,unsigned6 pBIP_ID,unsigned6 contact_did,string9 contact_ssn,string fname,string lname,string cnp_name,recordof(ds_bad_full_recs) - pBIP_ID - lname - fname - cnp_name - contact_did - contact_ssn};
    
    ds_bad_reset := sort(join(ds_bad_full_recs ,ds_bad_slim  ,left.pBIP_ID = right.pBIP_ID and left.lname = right.lname and left.fname = right.fname ,transform(
      temp_layout
      ,self.pBIP_ID       := right.lowest_rcid
      ,self.%BIP_ID_ORIG%  := left.pBIP_ID
      ,self             := left
    ),hash),%BIP_ID_ORIG%,pBIP_ID);
    
    ds_bad_reset_clusters := table(ds_bad_reset ,{pBIP_ID},pBIP_ID,merge);
    
    ds_return1 := ds_bad_reset + project(ds_good_full_recs ,transform(temp_layout
    ,self := left,self := []));
    
    ds_return := project(ds_return1 ,bipv2.CommonBase.layout);
    
    output_debug := parallel(
      output(count(pBIP_File              )  ,named('count_pBIP_File'             ))
     ,output(count(ds_prep                )  ,named('count_ds_prep'               ))
     ,output(count(ds_bad_clusters        )  ,named('count_ds_bad_clusters'       ))
     ,output(count(ds_good_clusters       )  ,named('count_ds_good_clusters'      ))
     ,output(count(ds_bad_full_recs       )  ,named('count_ds_bad_full_recs'      ))
     ,output(count(ds_good_full_recs      )  ,named('count_ds_good_full_recs'     ))
     ,output(count(ds_bad_slim            )  ,named('count_ds_bad_slim'           ))
     ,output(count(ds_bad_reset           )  ,named('count_ds_bad_reset'          ))
     ,output(count(ds_bad_reset_clusters  )  ,named('count_ds_bad_reset_clusters' ))
     ,output(count(ds_return1             )  ,named('count_ds_return'             ))
    
     ,output(choosen(pBIP_File              ,300)  ,named('choosen_pBIP_File'             ),all)
     ,output(choosen(ds_prep                ,300)  ,named('choosen_ds_prep'               ),all)
     ,output(choosen(ds_bad_clusters        ,300)  ,named('choosen_ds_bad_clusters'       ),all)
     ,output(choosen(ds_good_clusters       ,300)  ,named('choosen_ds_good_clusters'      ),all)
     ,output(choosen(ds_bad_full_recs       ,300)  ,named('choosen_ds_bad_full_recs'      ),all)
     ,output(choosen(ds_good_full_recs      ,300)  ,named('choosen_ds_good_full_recs'     ),all)
     ,output(choosen(ds_bad_slim            ,300)  ,named('choosen_ds_bad_slim'           ),all)
     ,output(choosen(ds_bad_reset           ,300)  ,named('choosen_ds_bad_reset'          ),all)
     ,output(choosen(ds_bad_reset_clusters  ,300)  ,named('choosen_ds_bad_reset_clusters' ),all)
     ,output(choosen(ds_return1             ,300)  ,named('choosen_ds_return'             ),all)
    
    );
    
    
    return when(ds_return,output_debug);
  
  endmacro;
  
end;
