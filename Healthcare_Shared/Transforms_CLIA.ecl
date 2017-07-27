Import Healthcare_Shared,iesp,ut,Healthcare_Cleaners,STD;
EXPORT Transforms_CLIA  := MODULE
	//CLIA Legacy transforms
	export iesp.cliasearch.t_CLIARecord CLIARawRecords(Healthcare_Shared.Layouts.clia_base_with_input recs):= TRANSFORM
		self.BusinessId := (string)recs.bdid;
		self.CLIANumber := recs.clia_number;
		self.LaboratoryType := recs.lab_type;
		self.CompanyName := recs.facility_name;
		self.CompanyName2 := recs.facility_name2;
		addr := recs.clean_company_address;
		self.CLIAProviderAddress := iesp.ECL2ESP.SetAddress(
																addr.prim_name, addr.prim_range, addr.predir, addr.postdir, addr.addr_suffix,
																addr.unit_desig, addr.sec_range, recs.city, recs.State, recs.zip, recs.zip4,
																'','', recs.address1, recs.address2, '');
		self.Phone10 := recs.facility_phone;
		self.RecordType := recs.record_type;
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_first_reported);
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8((string)recs.dt_vendor_last_reported);
		self.ExpirationDate := iesp.ECL2ESP.toDatestring8((string)recs.expiration_date);
		self.CertificateType := recs.certificate_type;
		self.TerminationCode := recs.lab_term_code;
		self.TerminationCodeDesc := recs.TermCodeDesc;
		self := recs;
		self := [];
	end;
	Export Healthcare_Shared.layouts_commonized.std_record_struct set_std_record_struct (Healthcare_Shared.Layouts.clia_base_with_input l) := transform
		self.acctno := l.acctno;
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.lnpid := l.lnpid;
		self.lnfid := l.lnfid;
		self.did := (integer)l.did;
		self.bdid := (integer)l.bdid;
		self.filesource := Healthcare_Shared.Constants.SRC_CLIA;
		// self.filecode:= Healthcare_Shared.Constants.SRC_CLIA;
		self.prac_company1.company_key:= STD.Metaphone.Primary(l.facility_name);
		self.prac_company1.company_name:= l.facility_name;
		self.prac_company2.company_key:= STD.Metaphone.Primary(l.facility_name2);
		self.prac_company2.company_name:= l.facility_name2;
		self.prac_phone1.phone:= l.facility_phone;
		clnAddr := project(l,transform(Healthcare_Cleaners.Layouts.cleanAddressOutput,
													self.prim_range := left.clean_company_address.prim_range;
													self.predir :=left.clean_company_address.predir;
													self.prim_name :=left.clean_company_address.prim_name;
													self.addr_suffix :=left.clean_company_address.addr_suffix;
													self.postdir :=left.clean_company_address.postdir;
													self.unit_desig :=left.clean_company_address.unit_desig;
													self.sec_range :=left.clean_company_address.sec_range;
													self.p_city_name :=left.clean_company_address.p_city_name;
													self.st :=left.clean_company_address.st;
													self.zip :=left.clean_company_address.zip;
													self.rec_type := left.clean_company_address.rec_type;self:=[];));
		self.prac1.addr_key	:= healthcare_shared.Fn_StandardizeInput.fn_make_address_key(clnAddr);
		self.prac1.primary_address:= if(l.address1<>'',l.address1,Healthcare_Shared.Functions.buildAddress(l.clean_company_address.prim_range,l.clean_company_address.predir,l.clean_company_address.prim_name,l.clean_company_address.addr_suffix,l.clean_company_address.postdir,l.clean_company_address.unit_desig,l.clean_company_address.sec_range));
		self.prac1.city:= l.clean_company_address.p_city_name;
		self.prac1.state:= l.clean_company_address.st;
		self.prac1.zip:= l.clean_company_address.zip;
		self.prac1.zip4:= l.clean_company_address.zip4;
		self.prac1.rectype:= l.clean_company_address.rec_type;
		self.prac1.primary_range:= l.clean_company_address.prim_range;
		self.prac1.pre_directional:= l.clean_company_address.predir;
		self.prac1.primary_name:= l.clean_company_address.prim_name;
		self.prac1.suffix:= l.clean_company_address.addr_suffix;
		self.prac1.post_directional:= l.clean_company_address.postdir;
		self.prac1.unit_designator:= l.clean_company_address.unit_desig;
		self.prac1.secondary_range:= l.clean_company_address.sec_range;
		self.prac1.ace_stat_code:= l.clean_company_address.err_stat;
		self.prac1.error_code:= l.clean_company_address.err_stat[2..];
		self.prac1.fipscode:= trim(l.clean_company_address.fips_state,right)+l.clean_company_address.fips_county;
		self.prac1.clean_geo_lat:= l.clean_company_address.geo_lat;
		self.prac1.clean_geo_long:= l.clean_company_address.geo_long;
		self.prac1.clean_fips_st:= l.clean_company_address.fips_state;
		self.prac1.clean_fips_county:= l.clean_company_address.fips_county;                 
		self.prac1.clean_msa:= l.clean_company_address.msa;                                   
		self.prac1.clean_geo_blk:= l.clean_company_address.geo_blk;                     
		self.prac1.clean_geo_match:= l.clean_company_address.geo_match;
		self.clia_num:= l.clia_number;
		self.clia_status_code:= l.lab_term_code;
		self.clia_cert_type_code:= l.certificate_type;
		self.clia_cert_eff_date:= l.expiration_date;
		self.clia_lab_type_description:=l.lab_type;
		self.clia_lab_term_code:=l.lab_term_code;
		self.clia_TermCodeDesc :=l.TermCodeDesc;
	self := [];
	end;
	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_CLIA (Healthcare_Shared.Layouts.clia_base_with_input l,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		self.acctno := l.acctno;
		self.InternalID := l.lnfid;
		// self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.sources := dataset([{l.clia_number,Healthcare_Shared.Constants.SRC_CLIA,''}],Healthcare_Shared.Layouts.layout_SrcID);
		self.vendorid := l.clia_number;
		self.src := Healthcare_Shared.Constants.SRC_CLIA;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		getUpdateDate := (string)l.dt_vendor_last_reported;
		self.last_update_date := Healthcare_Shared.Functions.cleanOnlyNumbers(getUpdateDate);
		self.bdids := if(l.bdid>0,dataset([{l.acctno,if(l.srcIndividualHeader,l.lnpid,l.lnfid),l.bdid}],Healthcare_Shared.Layouts.layout_bdid));
		self.bipkeys := project(l,transform(Healthcare_Shared.Layouts.layout_bipkeys, 
																self.acctno := left.acctno;self.InternalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);self := left));
		self.CLIARaw := if(cfg[1].keepRawCLIARecs,project(l,CLIARawRecords(left)),dataset([],iesp.cliasearch.t_CLIARecord)[1]);
		self.RecordsRaw := PROJECT(l,set_std_record_struct(LEFT));
		self.taxonomy := dataset([],Healthcare_Shared.Layouts.layout_taxonomy);
		self := l;
		self:=[]; 
	end;
/*	//CLIA Base transforms
	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_CLIA_base (Healthcare_Shared.Layouts.clia_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.clia_number,Healthcare_Shared.Constants.SRC_CLIA}],Healthcare_Shared.Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.clia_number;
		self.srcID := l.lnpid;
		self.src := Healthcare_Shared.Constants.SRC_CLIA;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		name1 := project(l,transform(Healthcare_Shared.Layouts.layout_nameinfo,
																			self.acctno := left.acctno;
																			self.ProviderID:=left.lnpid;
																			self.nameSeq := 3;//Cert is required to be renewed so name should be pretty accurate
																			self.bestsource := 3;//Cert is required to be renewed so name should be pretty accurate
																			self.namePenalty := ut.CompanySimilar100(left.facility_name,left.comp_name);//Add penalty
																			self.CompanyName := left.facility_name;
																			self:=[];));
		name2 := project(l,transform(Healthcare_Shared.Layouts.layout_nameinfo,
																			self.acctno := left.acctno;
																			self.ProviderID:=left.lnpid;
																			self.nameSeq := 3;//Cert is required to be renewed so name should be pretty accurate
																			self.bestsource := 3;//Cert is required to be renewed so name should be pretty accurate
																			self.namePenalty := ut.CompanySimilar100(left.facility_name2,left.comp_name);
																			self.CompanyName := left.facility_name2;
																			self:=[];));
		self.names := (name1+name2)(CompanyName <> '');
		self.Addresses := project(l,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.addrSeq := Healthcare_Shared.Constants.ADDR_SEQ_CLIA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := if(left.address1<>'',left.address1,Healthcare_Shared.Functions.buildAddress(left.clean_company_address.prim_range,left.clean_company_address.predir,left.clean_company_address.prim_name,left.clean_company_address.addr_suffix,left.clean_company_address.postdir,left.clean_company_address.unit_desig,left.clean_company_address.sec_range));
																		self.address2 := '';
																		self.prim_range := left.clean_company_address.prim_range;
																		self.predir := left.clean_company_address.predir;
																		self.prim_name := left.clean_company_address.prim_name;
																		self.addr_suffix := left.clean_company_address.addr_suffix;
																		self.postdir := left.clean_company_address.postdir;
																		self.unit_desig := left.clean_company_address.unit_desig;
																		self.sec_range := left.clean_company_address.sec_range;
																		self.p_city_name := left.clean_company_address.p_city_name;
																		self.v_city_name := left.clean_company_address.v_city_name;
																		self.st := left.clean_company_address.st;
																		self.z5 := left.clean_company_address.zip;
																		self.zip4 := left.clean_company_address.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.dt_vendor_last_reported;
																		self.v_first_seen := (string)left.dt_vendor_first_reported;
																		self.geo_lat := left.clean_company_address.geo_lat;
																		self.geo_long := left.clean_company_address.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := left.facility_phone;
																		self.FaxNumber := '';
																		self.Phones := dataset([{left.facility_phone,''}],Healthcare_Shared.Layouts.layout_addressphone);self:=[];));
		self.bdids := dataset([{l.acctno,l.lnpid,(integer)l.bdid}],Healthcare_Shared.Layouts.layout_bdid)(bdid>0);
		self.clianumbers := project(l,transform(Healthcare_Shared.Layouts.layout_clianumber, 
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.clianumber:=left.clia_number;
																		self.bestsource := 1;
																		self.clia_cert_type_code:=left.certificate_type;
																		self.clia_end_date:=left.expiration_date;self:=[]));
		self.CLIARaw := project(l,CLIARawRecords(left));
		self:=l; 
		self:=[];
	END;
	//CLIA Rollups
	export Healthcare_Shared.Layouts.layout_addressinfo doCLIABaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Healthcare_Shared.Layouts.CombinedHeaderResults doCLIABaseRecordSrcIdRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
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
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doCLIABaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.bdids         := Healthcare_Shared.Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.CLIARaw    := sort(DEDUP(NORMALIZE(allRows, LEFT.CLIARaw, TRANSFORM( iesp.cliasearch.t_CLIARecord, SELF := RIGHT)), RECORD, ALL ),CLIANumber,-ExpirationDate);
		self := l;
	end;*/
End;