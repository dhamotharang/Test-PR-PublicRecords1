Import Healthcare_Shared,iesp,STD;
EXPORT Transforms_DEA  := MODULE
	//DEA Legacy transforms
	Export iesp.healthcare.t_DEAControlledSubstanceRecordEx build_DeaRaw (Healthcare_Shared.Layouts.dea_base_with_input l) := transform

		self.Number := l.rawData.dea_registration_number;
		self.RegistrationNumber := l.rawData.dea_registration_number;
		self.CompanyName := l.rawData.cname;

		SELF.Name := iesp.ECL2ESP.SetName (L.rawData.fname, L.rawData.mname, L.rawData.lname, L.rawData.name_suffix, L.rawData.title,'');
		SELF.Address := iesp.ECL2ESP.SetAddress(
			l.rawData.prim_name,l.rawData.prim_range,L.rawData.predir,L.rawData.postdir, L.rawData.addr_suffix,L.rawData.unit_desig,L.rawData.sec_range, 
			l.rawData.p_city_name,l.rawData.st,l.rawData.zip,l.rawData.zip4,'');
		SELF.BusinessType := map ( 
					L.rawData.Business_activity_code = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
					L.rawData.Business_activity_code = 'B' =>     	'Hospital/Clinic',
					L.rawData.Business_activity_code = 'C' =>     	'Practitioner',
					L.rawData.Business_activity_code = 'D' =>     	'Teaching Institution',
					L.rawData.Business_activity_code = 'E' =>     	'Manufacturer',
					L.rawData.Business_activity_code = 'F' =>     	'Distributor',
					L.rawData.Business_activity_code = 'G' =>     	'Researcher',
					L.rawData.Business_activity_code = 'H' =>     	'Analytical Lab',
					L.rawData.Business_activity_code = 'J' =>     	'Importer',
					L.rawData.Business_activity_code = 'K' =>     	'Exporter',
					L.rawData.Business_activity_code = 'M' =>     	'Mid Level Practitioner',
					L.rawData.Business_activity_code = 'N' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'P' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'R' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'S' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'T' =>     	'Narcotic Treatment Program',
					L.rawData.Business_activity_code = 'U' =>     	'Narcotic Treatment Program',
					'');		
		SELF.DrugSchedules := L.rawData.Drug_Schedules;
		SELF.ExpirationDate := iesp.ECL2ESP.toDate((INTEGER)L.rawData.Expiration_Date);
    SELF := [];
	end;
	export healthcare_shared.layouts_commonized.std_record_struct set_std_record_struct(healthcare_shared.layouts.dea_base_with_input l) := TRANSFORM
		self.acctno := l.acctno;
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.vendor_id := l.rawdata.dea_registration_number;
		self.filesource:= Healthcare_Shared.Constants.SRC_DEA;
		// self.filecode:= Healthcare_Shared.Constants.SRC_DEA;
		getUpdateDate := l.rawdata.date_last_reported;
		self.last_update_date:= getUpdateDate;
		name_in := l.rawdata.fname + ' ' + l.rawdata.mname + ' ' + l.rawdata.lname + ' ' + l.rawdata.name_suffix;
		nameKeyPrefix := l.rawdata.fname;
		self.name_key:= nameKeyPrefix + '_' + STD.Metaphone.Primary(name_in);		
		self.pre_name:= l.rawdata.title;
		self.first_name:= l.rawdata.fname;
		self.middle_name:= l.rawdata.mname;
		self.last_name:= l.rawdata.lname;
		self.maturity_suffix:= l.rawdata.name_suffix;
		self.prac_company1.company_name:= l.rawdata.cname;
		self.dea1.dea_num:= l.rawData.dea_registration_number;
		self.dea1.dea_num_exp:= L.rawData.Expiration_Date;
		self.dea1.dea_num_sch:= L.rawData.Drug_Schedules;
		self.dea1.dea_num_bus_act_ind:= l.rawData.Business_activity_code;
		self.dea1.dea_num_status := l.rawData.activity;
		self.dea1.dea_num_bus_act_sub_ind := l.rawData.Bus_Activity_Sub_Code;
		self.prac1.primary_address:= Healthcare_Shared.Functions.buildAddress(l.rawdata.prim_range,l.rawdata.predir,l.rawdata.prim_name,l.rawdata.addr_suffix,l.rawdata.postdir,l.rawdata.unit_desig,l.rawdata.sec_range);
		self.prac1.city:= l.rawdata.p_city_name;
		self.prac1.state:= l.rawdata.st;
		self.prac1.zip:= l.rawdata.zip;
		self.prac1.zip4:= l.rawdata.zip4;
		self.prac1.rectype:= l.rawdata.rec_type;
		self.prac1.primary_range:= l.rawdata.prim_range;
		self.prac1.pre_directional:= l.rawdata.predir;
		self.prac1.primary_name:= l.rawdata.prim_name;
		self.prac1.suffix:= l.rawdata.addr_suffix;
		self.prac1.post_directional:= l.rawdata.postdir;
		self.prac1.unit_designator:= l.rawdata.unit_desig;
		self.prac1.secondary_range:= l.rawdata.sec_range;
		self.prac1.error_code:= l.rawdata.err_stat;
		self.prac1.clean_geo_lat:= l.rawdata.geo_lat;
		self.prac1.clean_geo_long:= l.rawdata.geo_long;
		self.prac1.clean_msa:= l.rawdata.msa;                                   
		self.prac1.clean_geo_match:= l.rawdata.geo_match;
		self:=l;
		Self:=[];
	end;
	//DEA Base transforms
	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_Dea (Healthcare_Shared.Layouts.dea_base_with_input l,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		self.acctno := l.acctno;
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.sources := dataset([{l.rawdata.dea_registration_number,Healthcare_Shared.Constants.SRC_DEA}],Healthcare_Shared.Layouts.layout_SrcID);
		self.src := Healthcare_Shared.Constants.SRC_DEA;
		self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.VendorID := l.rawdata.dea_registration_number;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		getUpdateDate := l.rawdata.date_last_reported;
		self.last_update_date:= getUpdateDate;
		self.RecordsRaw := project(l,set_std_record_struct(left));
		self.DEARaw := if(cfg[1].keepRawDEARecs,
															project(l,build_DeaRaw(left)),
															dataset([],iesp.healthcare.t_DEAControlledSubstanceRecordEx)[1]);
		self:=l; 
		self:=[];
	end;
/*	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_Dea_base (Healthcare_Shared.Layouts.dea_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.rawdata.dea_registration_number,Healthcare_Shared.Constants.SRC_DEA}],Healthcare_Shared.Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.rawdata.dea_registration_number;
		self.srcID := l.lnpid;
		self.src := Healthcare_Shared.Constants.SRC_DEA;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.names := project(l,transform(Healthcare_Shared.Layouts.layout_nameinfo,
																			self.acctno := left.acctno;
																			self.ProviderID:=left.lnpid;
																			self.nameSeq := 5;
																			self.bestsource := 5;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := left.rawdata.fname;
																			self.MiddleName := left.rawdata.mname;
																			self.LastName := left.rawdata.lname;
																			self.Suffix := left.rawdata.name_suffix;
																			self.Title := left.rawdata.title;
																			self.Gender := '';
																			self.CompanyName := left.rawdata.cname;self:=[];));
		self.Addresses := project(l,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.addrSeq := Healthcare_Shared.Constants.ADDR_SEQ_DEA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := '';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := Healthcare_Shared.Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.addr_suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.addr_suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.p_city_name;
																		self.v_city_name := left.rawdata.v_city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.rawdata.date_last_reported;
																		self.v_first_seen := (string)left.rawdata.date_first_reported;
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Healthcare_Shared.Layouts.layout_addressphone);self:=[];));
		self.dids := dataset([{l.acctno,l.lnpid,(integer)l.rawdata.did}],Healthcare_Shared.Layouts.layout_did)(did>0);
		self.bdids := dataset([{l.acctno,l.lnpid,(integer)l.rawdata.bdid}],Healthcare_Shared.Layouts.layout_bdid)(bdid>0);
		self.ssns := project(l,transform(Healthcare_Shared.Layouts.layout_ssn, self.acctno := left.acctno;self.ProviderID:=left.lnpid;self.ssn:=left.rawdata.best_ssn;self:=[];));
		self.deas := project(l,transform(Healthcare_Shared.Layouts.layout_dea,self.acctno:=left.acctno;self.Providerid:=left.lnpid;self.dea:=(string)left.rawdata.dea_registration_number;self.expiration_date:=left.rawdata.expiration_date;self.dea_bus_act_ind:=left.rawdata.Business_activity_code;self.dea_sch:=left.rawdata.Drug_Schedules;self.bestsource:=1;self:=[];));
		self.DEARaw := project(l,build_DeaRaw(left));
		self:=l; 
		self:=[];
	END;

	//DEA Rollups
	export Healthcare_Shared.Layouts.layout_addressinfo doDEABaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
*/
/*	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_Dea_base (Healthcare_Shared.Layouts.dea_base_with_input l) := transform
		self.acctno := l.acctno;
		self.sources := dataset([{l.rawdata.dea_registration_number,Healthcare_Shared.Constants.SRC_DEA}],Healthcare_Shared.Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.VendorID := l.rawdata.dea_registration_number;
		self.srcID := l.lnpid;
		self.src := Healthcare_Shared.Constants.SRC_DEA;
		self.glb_ok	:= l.glb_ok;
		self.dppa_ok:= l.dppa_ok;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.names := project(l,transform(Healthcare_Shared.Layouts.layout_nameinfo,
																			self.acctno := left.acctno;
																			self.ProviderID:=left.lnpid;
																			self.nameSeq := 5;
																			self.bestsource := 5;
																			self.namePenalty := 0;
																			self.FullName := '';
																			self.FirstName := left.rawdata.fname;
																			self.MiddleName := left.rawdata.mname;
																			self.LastName := left.rawdata.lname;
																			self.Suffix := left.rawdata.name_suffix;
																			self.Title := left.rawdata.title;
																			self.Gender := '';
																			self.CompanyName := left.rawdata.cname;self:=[];));
		self.Addresses := project(l,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.addrSeq := Healthcare_Shared.Constants.ADDR_SEQ_DEA;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := '';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := Healthcare_Shared.Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.addr_suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range);
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.addr_suffix;
																		self.postdir := left.rawdata.postdir;
																		self.unit_desig := left.rawdata.unit_desig;
																		self.sec_range := left.rawdata.sec_range;
																		self.p_city_name := left.rawdata.p_city_name;
																		self.v_city_name := left.rawdata.v_city_name;
																		self.st := left.rawdata.st;
																		self.z5 := left.rawdata.zip;
																		self.zip4 := left.rawdata.zip4;
																		self.primaryLocation := '';
																		self.practiceAddress := '';
																		self.BillingAddress := '';
																		self.last_seen := '';
																		self.first_seen := '';
																		self.v_last_seen := (string)left.rawdata.date_last_reported;
																		self.v_first_seen := (string)left.rawdata.date_first_reported;
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Healthcare_Shared.Layouts.layout_addressphone);self:=[];));
		self.dids := dataset([{l.acctno,l.lnpid,(integer)l.rawdata.did}],Healthcare_Shared.Layouts.layout_did)(did>0);
		self.bdids := dataset([{l.acctno,l.lnpid,(integer)l.rawdata.bdid}],Healthcare_Shared.Layouts.layout_bdid)(bdid>0);
		self.ssns := project(l,transform(Healthcare_Shared.Layouts.layout_ssn, self.acctno := left.acctno;self.ProviderID:=left.lnpid;self.ssn:=left.rawdata.best_ssn;self:=[];));
		self.deas := project(l,transform(Healthcare_Shared.Layouts.layout_dea,self.acctno:=left.acctno;self.Providerid:=left.lnpid;self.dea:=(string)left.rawdata.dea_registration_number;self.expiration_date:=left.rawdata.expiration_date;self.dea_bus_act_ind:=left.rawdata.Business_activity_code;self.dea_sch:=left.rawdata.Drug_Schedules;self.bestsource:=1;self:=[];));
		self.DEARaw := project(l,build_DeaRaw(left));
		self:=l; 
		self:=[];
	END;

	//DEA Rollups
	export Healthcare_Shared.Layouts.layout_addressinfo doDEABaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Healthcare_Shared.Layouts.CombinedHeaderResults doDEABaseRecordSrcIdRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
																									DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.LNPID := l.LNPID;
		self.Vendorid := l.vendorid;
		self.SrcId := l.lnpid;
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
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns(ssn<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dids          := Healthcare_Shared.Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Healthcare_Shared.Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Healthcare_Shared.Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.deas	         := DEDUP(sort(NORMALIZE(allRows, LEFT.deas(dea<>''), TRANSFORM(Healthcare_Shared.Layouts.layout_dea, SELF := RIGHT)), dea,-expiration_date),dea,expiration_date);
		self.DEARaw        := sort(NORMALIZE(allRows, LEFT.DEARaw, TRANSFORM(iesp.healthcare.t_DEAControlledSubstanceRecordEx, SELF := RIGHT)),RegistrationNumber,-ExpirationDate);
		self := l;
	end;*/
End;