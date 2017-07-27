Import Healthcare_Shared,iesp,Healthcare_NPI,Healthcare_Cleaners,STD;
EXPORT Transforms_NPI  := MODULE
	export healthcare_shared.layouts_commonized.std_record_struct set_std_record_struct(healthcare_shared.layouts.npi_base_with_input l) := TRANSFORM
		self.acctno := l.acctno;
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.vendor_id := l.npi;
		self.filesource:= Healthcare_Shared.Constants.SRC_NPPES;
		// self.filecode:= Healthcare_Shared.Constants.SRC_NPPES;
		getUpdateDate := l.dt_last_seen;
		self.last_update_date:= (string)getUpdateDate;
		name_in := l.provider_first_name + ' ' + l.provider_middle_name + ' ' + l.provider_last_name + ' ' + l.provider_name_suffix_text;
		self.name_key:= l.provider_first_name + '_' + STD.Metaphone.Primary(name_in);		
		self.pre_name:= l.provider_name_prefix_text;
		self.first_name:= l.provider_first_name;
		self.middle_name:= l.provider_middle_name;
		self.last_name:= l.provider_last_name;
		self.maturity_suffix:= l.provider_name_suffix_text;
		self.other_suffix:= Healthcare_Shared.Functions.cleanAlpha(l.provider_credential_text);
		self.gender:= l.provider_gender_code;
		self.prac_company1.company_name:= l.provider_organization_name;
		self.dba_name:= l.provider_other_organization_name;
		clnAddr := project(l,transform(Healthcare_Cleaners.Layouts.cleanAddressOutput,
													self.prim_range := left.clean_location_address.prim_range;
													self.predir :=left.clean_location_address.predir;
													self.prim_name :=left.clean_location_address.prim_name;
													self.addr_suffix :=left.clean_location_address.addr_suffix;
													self.postdir :=left.clean_location_address.postdir;
													self.unit_desig :=left.clean_location_address.unit_desig;
													self.sec_range :=left.clean_location_address.sec_range;
													self.p_city_name :=left.clean_location_address.p_city_name;
													self.st :=left.clean_location_address.st;
													self.zip :=left.clean_location_address.zip;
													self.rec_type := left.clean_location_address.rec_type;self:=[];));
		self.prac1.addr_key	:= healthcare_shared.Fn_StandardizeInput.fn_make_address_key(clnAddr);
		self.prac1.primary_address:= l.location_prep_address1;
		self.prac1.city:= l.clean_location_address.p_city_name;
		self.prac1.state:= l.clean_location_address.st;
		self.prac1.zip:= l.clean_location_address.zip;
		self.prac1.zip4:= l.clean_location_address.zip4;
		self.prac1.rectype:= l.clean_location_address.rec_type;
		self.prac1.primary_range:= l.clean_location_address.prim_range;
		self.prac1.pre_directional:= l.clean_location_address.predir;
		self.prac1.primary_name:= l.clean_location_address.prim_name;
		self.prac1.suffix:= l.clean_location_address.addr_suffix;
		self.prac1.post_directional:= l.clean_location_address.postdir;
		self.prac1.unit_designator:= l.clean_location_address.unit_desig;
		self.prac1.secondary_range:= l.clean_location_address.sec_range;
		self.prac1.error_code:= l.clean_location_address.err_stat;
		self.prac1.clean_geo_lat:= l.clean_location_address.geo_lat;
		self.prac1.clean_geo_long:= l.clean_location_address.geo_long;
		self.prac1.clean_fips_st:= l.clean_location_address.fips_state;
		self.prac1.clean_fips_county:= l.clean_location_address.fips_county;                 
		self.prac1.clean_msa:= l.clean_location_address.msa;                                   
		self.prac1.clean_geo_blk:= l.clean_location_address.geo_blk;                     
		self.prac1.clean_geo_match:= l.clean_location_address.geo_match;
		self.prac_phone1.phone:= l.provider_business_practice_location_address_telephone_number;
		self.prac_fax1.fax:= l.provider_business_practice_location_address_fax_number;
		clnBillAddr := project(l,transform(Healthcare_Cleaners.Layouts.cleanAddressOutput,
													self.prim_range := left.clean_mailing_address.prim_range;
													self.predir :=left.clean_mailing_address.predir;
													self.prim_name :=left.clean_mailing_address.prim_name;
													self.addr_suffix :=left.clean_mailing_address.addr_suffix;
													self.postdir :=left.clean_mailing_address.postdir;
													self.unit_desig :=left.clean_mailing_address.unit_desig;
													self.sec_range :=left.clean_mailing_address.sec_range;
													self.p_city_name :=left.clean_mailing_address.p_city_name;
													self.st :=left.clean_mailing_address.st;
													self.zip :=left.clean_mailing_address.zip;
													self.rec_type := left.clean_mailing_address.rec_type;self:=[];));
		self.bill1.addr_key	:= healthcare_shared.Fn_StandardizeInput.fn_make_address_key(clnBillAddr);
		self.bill1.primary_address:= l.mailing_prep_address1;
		self.bill1.city:= l.clean_mailing_address.p_city_name;
		self.bill1.state:= l.clean_mailing_address.st;
		self.bill1.zip:= l.clean_mailing_address.zip;
		self.bill1.zip4:= l.clean_mailing_address.zip4;
		self.bill1.rectype:= l.clean_mailing_address.rec_type;
		self.bill1.primary_range:= l.clean_mailing_address.prim_range;
		self.bill1.pre_directional:= l.clean_mailing_address.predir;
		self.bill1.primary_name:= l.clean_mailing_address.prim_name;
		self.bill1.suffix:= l.clean_mailing_address.addr_suffix;
		self.bill1.post_directional:= l.clean_mailing_address.postdir;
		self.bill1.unit_designator:= l.clean_mailing_address.unit_desig;
		self.bill1.secondary_range:= l.clean_mailing_address.sec_range;
		self.bill1.error_code:= l.clean_mailing_address.err_stat;
		self.bill1.clean_geo_lat:= l.clean_mailing_address.geo_lat;
		self.bill1.clean_geo_long:= l.clean_mailing_address.geo_long;
		self.bill1.clean_fips_st:= l.clean_mailing_address.fips_state;
		self.bill1.clean_fips_county:= l.clean_mailing_address.fips_county;                 
		self.bill1.clean_msa:= l.clean_mailing_address.msa;                                   
		self.bill1.clean_geo_blk:= l.clean_mailing_address.geo_blk;                     
		self.bill1.clean_geo_match:= l.clean_mailing_address.geo_match;
		self.bill_phone1.phone:= l.provider_business_mailing_address_telephone_number;
		self.bill_fax1.fax:= l.provider_business_mailing_address_fax_number;
		self.did := (integer)l.did;
		self.bdid := (integer)l.bdid;
		self.npi_num := l.npi;
		self.npi_type := l.entity_type_code;				
		self.taxonomy_mprd := map(l.healthcare_provider_primary_taxonomy_switch_1 = 'Y' => l.healthcare_provider_taxonomy_code_1,
															l.healthcare_provider_primary_taxonomy_switch_2 = 'Y' => l.healthcare_provider_taxonomy_code_2,
															l.healthcare_provider_primary_taxonomy_switch_3 = 'Y' => l.healthcare_provider_taxonomy_code_3,
															l.healthcare_provider_primary_taxonomy_switch_4 = 'Y' => l.healthcare_provider_taxonomy_code_4,
															l.healthcare_provider_primary_taxonomy_switch_5 = 'Y' => l.healthcare_provider_taxonomy_code_5,
															l.healthcare_provider_primary_taxonomy_switch_6 = 'Y' => l.healthcare_provider_taxonomy_code_6,
															l.healthcare_provider_primary_taxonomy_switch_7 = 'Y' => l.healthcare_provider_taxonomy_code_7,
															l.healthcare_provider_primary_taxonomy_switch_8 = 'Y' => l.healthcare_provider_taxonomy_code_8,
															l.healthcare_provider_primary_taxonomy_switch_9 = 'Y' => l.healthcare_provider_taxonomy_code_9,
															l.healthcare_provider_primary_taxonomy_switch_10 = 'Y' => l.healthcare_provider_taxonomy_code_10,
															l.healthcare_provider_primary_taxonomy_switch_11 = 'Y' => l.healthcare_provider_taxonomy_code_11,
															l.healthcare_provider_primary_taxonomy_switch_12 = 'Y' => l.healthcare_provider_taxonomy_code_12,
															l.healthcare_provider_primary_taxonomy_switch_13 = 'Y' => l.healthcare_provider_taxonomy_code_13,
															l.healthcare_provider_primary_taxonomy_switch_14 = 'Y' => l.healthcare_provider_taxonomy_code_14,
															l.healthcare_provider_primary_taxonomy_switch_15 = 'Y' => l.healthcare_provider_taxonomy_code_15,
															'');
		self.npi_deact_date := l.NPI_Deactivation_Date;
		self.npi_react_date := l.NPI_reactivation_date; // added 6.6?
		self.npi_enum_date := l.provider_enumeration_date;
		ds1 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=1;
																self.lic_state :=left.Provider_License_Number_State_Code_1;
																self.lic_num:=left.Provider_License_Number_1;));
		ds2 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=2;
																self.lic_state :=left.Provider_License_Number_State_Code_2;
																self.lic_num:=left.Provider_License_Number_2;));
		ds3 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=3;
																self.lic_state :=left.Provider_License_Number_State_Code_3;
																self.lic_num:=left.Provider_License_Number_3;));
		ds4 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=4;
																self.lic_state :=left.Provider_License_Number_State_Code_4;
																self.lic_num:=left.Provider_License_Number_4;));
		ds5 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=5;
																self.lic_state :=left.Provider_License_Number_State_Code_5;
																self.lic_num:=left.Provider_License_Number_5;));
		ds6 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=6;
																self.lic_state :=left.Provider_License_Number_State_Code_6;
																self.lic_num:=left.Provider_License_Number_6;));
		ds7 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=7;
																self.lic_state :=left.Provider_License_Number_State_Code_7;
																self.lic_num:=left.Provider_License_Number_7;));
		ds8 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=8;
																self.lic_state :=left.Provider_License_Number_State_Code_8;
																self.lic_num:=left.Provider_License_Number_8;));
		ds9 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=9;
																self.lic_state :=left.Provider_License_Number_State_Code_9;
																self.lic_num:=left.Provider_License_Number_9;));
		ds10 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=10;
																self.lic_state :=left.Provider_License_Number_State_Code_10;
																self.lic_num:=left.Provider_License_Number_10;));
		ds11 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=11;
																self.lic_state :=left.Provider_License_Number_State_Code_11;
																self.lic_num:=left.Provider_License_Number_11;));
		ds12 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=12;
																self.lic_state :=left.Provider_License_Number_State_Code_12;
																self.lic_num:=left.Provider_License_Number_12;));
		ds13 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=13;
																self.lic_state :=left.Provider_License_Number_State_Code_13;
																self.lic_num:=left.Provider_License_Number_13;));
		ds14 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=14;
																self.lic_state :=left.Provider_License_Number_State_Code_14;
																self.lic_num:=left.Provider_License_Number_14;));
		ds15 := project(l, transform(Healthcare_Shared.layouts_commonized.layout_std_license,
																self.lic_st:=15;
																self.lic_state :=left.Provider_License_Number_State_Code_15;
																self.lic_num:=left.Provider_License_Number_15;));
		combinedLic := sort((ds1+ds2+ds3+ds4+ds5+ds6+ds7+ds8+ds9+ds10+ds11+ds12+ds13+ds14+ds15)(lic_num<>''),lic_st);
		self.lic1.lic_state:= combinedLic[1].lic_state;
		self.lic1.lic_num:= combinedLic[1].lic_num;
		self.lic2.lic_state:= combinedLic[2].lic_state;
		self.lic2.lic_num:= combinedLic[2].lic_num;
		self.lic3.lic_state:= combinedLic[3].lic_state;
		self.lic3.lic_num:= combinedLic[3].lic_num;
		self.lic4.lic_state:= combinedLic[4].lic_state;
		self.lic4.lic_num:= combinedLic[4].lic_num;
		self.lic5.lic_state:= combinedLic[5].lic_state;
		self.lic5.lic_num:= combinedLic[5].lic_num;
	end;
	//NPPES Base Transform
	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_npi (Healthcare_Shared.Layouts.npi_base_with_input l,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		self.acctno := l.acctno;
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.sources := dataset([{l.npi,Healthcare_Shared.Constants.SRC_NPPES}],Healthcare_Shared.Layouts.layout_SrcID);
		self.src := Healthcare_Shared.Constants.SRC_NCPDP;
		self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.VendorID := l.npi;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		getUpdateDate := l.dt_last_seen;
		self.last_update_date:= (string)getUpdateDate;
		self.RecordsRaw := project(l,set_std_record_struct(left));
		self.NPIRaw := if(cfg[1].keepRawNPIRecs,
													dataset([Healthcare_NPI.Transforms.formatRecords(project(l,transform(Healthcare_Shared.Layouts.nppes_penalty_recs,self:=left)))]),
													dataset([],iesp.npireport.t_NPIReport));
		self:=l; 
		self:=[];
	END;
/*	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_npi_base (Healthcare_Shared.Layouts.npi_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.npi,Healthcare_Shared.Constants.SRC_NPPES}],Healthcare_Shared.Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.npi;
		self.srcID := (integer)l.npi;
		self.src := Healthcare_Shared.Constants.SRC_NPPES;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		name1 := project(l,transform(Healthcare_Shared.Layouts.layout_nameinfo,
																			self.acctno := left.acctno;
																			self.ProviderID:=left.lnpid;
																			self.nameSeq := 5;
																			self.bestsource := 5;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := left.clean_name_provider.fname;
																			self.MiddleName := left.clean_name_provider.mname;
																			self.LastName := left.clean_name_provider.lname;
																			self.Suffix := left.clean_name_provider.name_suffix;
																			self.Title := left.clean_name_provider.title;
																			self.Gender := '';
																			self.CompanyName := left.provider_organization_name;self:=[];));
		nm2Exists := l.provider_other_organization_name<>'';
		name2 := if(nm2Exists,project(l,transform(Healthcare_Shared.Layouts.layout_nameinfo,
																			self.acctno := left.acctno;
																			self.ProviderID:=left.lnpid;
																			self.nameSeq := 5;
																			self.bestsource := 5;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := left.clean_name_provider.fname;
																			self.MiddleName := left.clean_name_provider.mname;
																			self.LastName := left.clean_name_provider.lname;
																			self.Suffix := left.clean_name_provider.name_suffix;
																			self.Title := left.clean_name_provider.title;
																			self.Gender := '';
																			self.CompanyName := left.provider_other_organization_name;self:=[];)));
		self.names := dedup(sort(name1+name2,record),record);
		Address1 := project(l,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.addrSeq := Healthcare_Shared.Constants.ADDR_SEQ_NPPES;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.location_prep_address1;
																		self.address2 := '';
																		self.prim_range := left.clean_location_address.prim_range;
																		self.predir := left.clean_location_address.predir;
																		self.prim_name := left.clean_location_address.prim_name;
																		self.addr_suffix := left.clean_location_address.addr_suffix;
																		self.postdir := left.clean_location_address.postdir;
																		self.unit_desig := left.clean_location_address.unit_desig;
																		self.sec_range := left.clean_location_address.sec_range;
																		self.p_city_name := left.clean_location_address.p_city_name;
																		self.v_city_name := left.clean_location_address.v_city_name;
																		self.st := left.clean_location_address.st;
																		self.z5 := left.clean_location_address.zip;
																		self.zip4 := left.clean_location_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_location_address.geo_lat;
																		self.geo_long := left.clean_location_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.provider_business_practice_location_address_telephone_number;
																		self.FaxNumber := left.provider_business_practice_location_address_fax_number;
																		self.Phones := dataset([{left.provider_business_practice_location_address_telephone_number,left.provider_business_practice_location_address_fax_number}],Healthcare_Shared.Layouts.layout_addressphone);self:=[];));
		Address2 := project(l,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.addrSeq := Healthcare_Shared.Constants.ADDR_SEQ_NPPES+1;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'B';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := left.mailing_prep_address1;
																		self.address2 := '';
																		self.prim_range := left.clean_mailing_address.prim_range;
																		self.predir := left.clean_mailing_address.predir;
																		self.prim_name := left.clean_mailing_address.prim_name;
																		self.addr_suffix := left.clean_mailing_address.addr_suffix;
																		self.postdir := left.clean_mailing_address.postdir;
																		self.unit_desig := left.clean_mailing_address.unit_desig;
																		self.sec_range := left.clean_mailing_address.sec_range;
																		self.p_city_name := left.clean_mailing_address.p_city_name;
																		self.v_city_name := left.clean_mailing_address.v_city_name;
																		self.st := left.clean_mailing_address.st;
																		self.z5 := left.clean_mailing_address.zip;
																		self.zip4 := left.clean_mailing_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := (string)left.dt_last_seen;
																		self.first_seen := (string)left.dt_first_seen;
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_mailing_address.geo_lat;
																		self.geo_long := left.clean_mailing_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.provider_business_mailing_address_telephone_number;
																		self.FaxNumber := left.provider_business_mailing_address_fax_number;
																		self.Phones := dataset([{left.provider_business_mailing_address_telephone_number,left.provider_business_mailing_address_fax_number}],Healthcare_Shared.Layouts.layout_addressphone);self:=[];));
		self.Addresses := address1+address2;
		self.dids := dataset([{l.acctno,l.lnpid,(integer)l.did}],Healthcare_Shared.Layouts.layout_did)(did>0);
		self.bdids := dataset([{l.acctno,l.lnpid,(integer)l.bdid}],Healthcare_Shared.Layouts.layout_bdid)(bdid>0);
		self.npis := project(l,transform(Healthcare_Shared.Layouts.layout_npi,self.acctno:=left.acctno;self.ProviderID:=left.lnpid;self.npi:=(string)left.npi,self.npi_deact_date:=left.NPI_Deactivation_Date;self.usersupplied:=left.usernpi<>'',self.bestsource:=1;self:=[];));
		self.NPPESVerified := map(l.userNPI = l.vendorid =>'YES',
															l.userNPI <> '' => 'CORRECTED',
															'');
		self.NPIRaw := dataset([Healthcare_NPI.Transforms.formatRecords(project(l,transform(Healthcare_Shared.Layouts.nppes_penalty_recs,self:=left)))]);
		ds1 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_1;self.LicenseNumber:=left.Provider_License_Number_1;self:=[];));
		ds2 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_2;self.LicenseNumber:=left.Provider_License_Number_2;self:=[];));
		ds3 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_3;self.LicenseNumber:=left.Provider_License_Number_3;self:=[];));
		ds4 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_4;self.LicenseNumber:=left.Provider_License_Number_4;self:=[];));
		ds5 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_5;self.LicenseNumber:=left.Provider_License_Number_5;self:=[];));
		ds6 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_6;self.LicenseNumber:=left.Provider_License_Number_6;self:=[];));
		ds7 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_7;self.LicenseNumber:=left.Provider_License_Number_7;self:=[];));
		ds8 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_8;self.LicenseNumber:=left.Provider_License_Number_8;self:=[];));
		ds9 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_9;self.LicenseNumber:=left.Provider_License_Number_9;self:=[];));
		ds10 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_10;self.LicenseNumber:=left.Provider_License_Number_10;self:=[];));
		ds11 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_11;self.LicenseNumber:=left.Provider_License_Number_11;self:=[];));
		ds12 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_12;self.LicenseNumber:=left.Provider_License_Number_12;self:=[];));
		ds13 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_13;self.LicenseNumber:=left.Provider_License_Number_13;self:=[];));
		ds14 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_14;self.LicenseNumber:=left.Provider_License_Number_14;self:=[];));
		ds15 := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.Provider_License_Number_State_Code_15;self.LicenseNumber:=left.Provider_License_Number_15;self:=[];));
		combinedLic := ds1+ds2+ds3+ds4+ds5+ds6+ds7+ds8+ds9+ds10+ds11+ds12+ds13+ds14+ds15;
		self.StateLicenses := combinedLic(LicenseNumber<>'');
		self:=l; 
		self:=[];
	END;
	//NPPES Rollups
	export Healthcare_Shared.Layouts.layout_addressinfo doNPIBaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows,v_first_seen) <> '', min(allRows,v_first_seen),min(allRows,v_last_seen));
			self := l;
			self := [];
	end;
	export Healthcare_Shared.Layouts.CombinedHeaderResults doNPIBaseRecordSrcIdRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
																									DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := l.ProcessingMessage;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Healthcare_Shared.Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Healthcare_Shared.Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( Healthcare_Shared.Layouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doNPIBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.dids          := Healthcare_Shared.Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Healthcare_Shared.Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Healthcare_Shared.Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.npis	         := DEDUP( NORMALIZE( allRows, LEFT.npis(npi<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_npi, SELF := RIGHT	)	), npi, All);
		self.NPIRaw	       := DEDUP(sort( NORMALIZE( allRows, LEFT.NPIRaw, TRANSFORM(iesp.npireport.t_NPIReport, SELF := RIGHT	)	), NPIInformation.NPINumber,-npiinformation.LastUpdateDate), NPIInformation.NPINumber);
		self.NPPESVerified := map(exists(allRows(NPPESVerified='YES')) => 'YES',
															exists(allRows(NPPESVerified='CORRECTED')) => 'CORRECTED','');
		self.StateLicenses := sort(dedup( NORMALIZE( allRows, LEFT.StateLicenses(LicenseNumber<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_licenseinfo, SELF := RIGHT	)	), record, all ),LicenseState,-Termination_Date, LicenseNumber);
		self := l;
	end;*/
End;