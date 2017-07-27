Import Healthcare_Shared,iesp,std;
EXPORT Transforms_ProfLic  := MODULE
	//Proflic Legacy transforms
	Export iesp.proflicense.t_PL2Action build_Action (Healthcare_Shared.Layouts.proflic_base_with_input src) := transform
		Self._Type := src.rawdata.action_record_type;
		Self.ViolationDescription := src.rawdata.action_complaint_violation_desc;
		Self.ViolationDate := iesp.ecl2esp.toDatestring8(src.rawdata.action_complaint_violation_dt);
		Self.EffectiveDate := iesp.ecl2esp.toDatestring8(src.rawdata.action_effective_dt);
		Self.Description :=  src.rawdata.action_complaint_violation_desc;
		Self.Status := src.rawdata.action_status;
		Self.PostingDate := iesp.ecl2esp.toDatestring8(src.rawdata.action_posting_status_dt);
		Self.CaseNumber := src.rawdata.action_case_number;
	end;

	Export iesp.proflicense.t_PL2Education build_Education (Healthcare_Shared.Layouts.proflic_base_with_input srcEdu, integer seq) := transform
		self.School := map(seq=1 => srcEdu.rawdata.education_1_school_attended,
											 seq=2 => srcEdu.rawdata.education_2_school_attended,
											 seq=3 => srcEdu.rawdata.education_3_school_attended,'');
		self.Degree := map(seq=1 => srcEdu.rawdata.education_1_degree,
											 seq=2 => srcEdu.rawdata.education_2_degree,
											 seq=3 => srcEdu.rawdata.education_3_degree,'');
		self.Curriculum := map(seq=1 => srcEdu.rawdata.education_1_curriculum,
													 seq=2 => srcEdu.rawdata.education_2_curriculum,
													 seq=3 => srcEdu.rawdata.education_3_curriculum,'');
		self.DatesAttended := map(seq=1 => srcEdu.rawdata.education_1_dates_attended,
															seq=2 => srcEdu.rawdata.education_2_dates_attended,
															seq=3 => srcEdu.rawdata.education_3_dates_attended,'');
	end;

	Export iesp.proflicense.t_ProfessionalLicenseRecord build_ProflicRaw (Healthcare_Shared.Layouts.proflic_base_with_input l) := transform
		self.prolicSeqId :=(String) l.rawdata.prolic_seq_id;
		self.IdValue := (STRING) l.rawdata.prolic_seq_id; 
		self.LicenseType := l.rawdata.license_type;
		self.LicenseNumber := l.rawdata.Orig_License_Number;
		self.ProviderNumber := l.LNPID;
		self.SanctionNumber := 0;
		self.SSN := l.rawdata.best_ssn;
		self.DateLastSeen := iesp.ecl2esp.toDatestring8(l.rawdata.date_last_seen);
		self.ProfessionOrBoard := l.rawdata.profession_or_board;
		self.Status := l.rawdata.Status;
		self.StatusEffectiveDate := iesp.ecl2esp.toDatestring8(l.rawdata.status_effective_dt);
		self.Name := iesp.ECL2ESP.SetName(l.rawdata.fname, l.rawdata.mname, l.rawdata.lname, l.rawdata.name_suffix, l.rawdata.title, '');
		self.OriginalName := iesp.ECL2ESP.SetName('', '', '', '', '', l.rawdata.Orig_name);
		self.AdditionalOrigName := iesp.ECL2ESP.SetName('', '', '', '', '', l.rawdata.Orig_Former_Name);
		self.CompanyName := l.rawdata.Company_name;
		self.Address := iesp.ecl2esp.SetAddress (l.rawdata.prim_name, l.rawdata.prim_range, l.rawdata.predir, l.rawdata.postdir,
					 l.rawdata.suffix, l.rawdata.unit_desig, l.rawdata.sec_range, l.rawdata.p_city_name,
					 l.rawdata.st, l.rawdata.zip, l.rawdata.zip4, '','', '', '', '');
		self.OriginalAddress := iesp.ecl2esp.SetAddress ('', '', '', '','', '', '', l.rawdata.Orig_City, l.rawdata.Orig_St, l.rawdata.Orig_Zip, '', '','', l.rawdata.Orig_Addr_1, l.rawdata.Orig_Addr_2, '');
		self.AdditionalOrigAddress := iesp.ecl2esp.SetAddress ('', '', '', '','', '', '', l.rawdata.additional_orig_city, l.rawdata.additional_orig_st, l.rawdata.additional_orig_zip, '', '','', l.rawdata.additional_orig_additional_1, l.rawdata.additional_orig_additional_2, '');
		self.Phone := l.rawdata.phone;
		self.TimeZone := '';
		self.AdditionalPhone := l.rawdata.additional_phone;
		self.Gender := l.rawdata.sex;
		self.DOB := iesp.ecl2esp.toDatestring8(l.rawdata.dob);
		self.IssuedDate := iesp.ecl2esp.toDatestring8(l.rawdata.issue_date);
		self.ExpirationDate := iesp.ecl2esp.toDatestring8(l.rawdata.expiration_date);
		self.LastRenewalDate := iesp.ecl2esp.toDatestring8(l.rawdata.last_renewal_date);
		self.LicenseObtainedBy := l.rawdata.license_obtained_by;
		self.BoardActionIndicator := if(length(trim(l.rawdata.Action_Status,all))>0,'Y','N'); 
		self.SourceState := l.rawdata.source_st;
		self.Occupation := l.rawdata.misc_occupation;
		self.PracticeHours := 0;
		self.PracticeType := l.rawdata.misc_practice_type;
		self.Email := l.rawdata.misc_email;
		self.Fax := l.rawdata.misc_fax;
		self.Action := row(build_Action(l));
		self.ContinueEducation := l.rawdata.education_continuing_education;
		self.Education1 := row(build_Education(l,1)); 
		self.Education2 := row(build_Education(l,2)); 
		self.Education3 := row(build_Education(l,3)); 
		self.AdditionalLicensingSpecs := l.rawdata.additional_licensing_specifics;
		self.PlaceOfBirth := l.rawdata.personal_pob_desc;
		self.Race := l.rawdata.personal_race_desc;
    SELF := [];
	end;
	export healthcare_shared.layouts_commonized.std_record_struct set_std_record_struct(healthcare_shared.layouts.proflic_base_with_input l) := TRANSFORM
		self.acctno := l.acctno;
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.vendor_id := l.rawdata.did;
		self.filesource:= Healthcare_Shared.Constants.SRC_PROFLIC;
		// self.filecode:= Healthcare_Shared.Constants.SRC_PROFLIC;
		getUpdateDate := l.rawdata.date_last_seen;
		self.last_update_date:= getUpdateDate;
		name_in := l.rawdata.fname + ' ' + l.rawdata.mname + ' ' + l.rawdata.lname + ' ' + l.rawdata.name_suffix;
		nameKeyPrefix := l.rawdata.fname;
		self.name_key:= nameKeyPrefix + '_' + STD.Metaphone.Primary(name_in);		
		self.pre_name:= l.rawdata.title;
		self.first_name:= l.rawdata.fname;
		self.middle_name:= l.rawdata.mname;
		self.last_name:= l.rawdata.lname;
		self.maturity_suffix:= l.rawdata.name_suffix;
		self.prac_company1.company_name:= l.rawdata.company_name;
		self.prac1.primary_address:= if(l.rawdata.orig_addr_1 <> '', l.rawdata.orig_addr_1,Healthcare_Shared.Functions.buildAddress(l.rawdata.prim_range,l.rawdata.predir,l.rawdata.prim_name,l.rawdata.suffix,l.rawdata.postdir,l.rawdata.unit_desig,l.rawdata.sec_range));
		self.prac1.city:= l.rawdata.p_city_name;
		self.prac1.state:= l.rawdata.st;
		self.prac1.zip:= l.rawdata.zip;
		self.prac1.zip4:= l.rawdata.zip4;
		self.prac1.rectype:= l.rawdata.record_type;
		self.prac1.primary_range:= l.rawdata.prim_range;
		self.prac1.pre_directional:= l.rawdata.predir;
		self.prac1.primary_name:= l.rawdata.prim_name;
		self.prac1.suffix:= l.rawdata.suffix;
		self.prac1.post_directional:= l.rawdata.postdir;
		self.prac1.unit_designator:= l.rawdata.unit_desig;
		self.prac1.secondary_range:= l.rawdata.sec_range;
		self.prac1.error_code:= l.rawdata.err_stat;
		self.prac1.clean_geo_lat:= l.rawdata.geo_lat;
		self.prac1.clean_geo_long:= l.rawdata.geo_long;
		self.prac1.clean_msa:= l.rawdata.msa;                                   
		self.prac1.clean_geo_match:= l.rawdata.geo_match;
		self.prac_phone1.phone:= l.rawdata.phone;
		self.birthdate:= l.rawdata.dob;
		self.ssn:= l.rawdata.best_ssn;
		self.lic1.lic_state:= l.rawdata.orig_st;
		self.lic1.lic_num:= l.rawdata.license_number;
		self.lic1.lic_type:= Healthcare_Shared.Functions.cleanAlpha(l.rawdata.license_type);;
		self.lic1.lic_begin_date:= l.rawdata.issue_date;
		self.lic1.lic_end_date:= l.rawdata.expiration_date;
		self.did := (integer)l.rawdata.did;
		self.bdid := (integer)l.rawdata.bdid;
		self:=l;
		Self:=[];
	end;

	//ProfLic Base transforms
	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_ProfLic (Healthcare_Shared.Layouts.proflic_base_with_input l,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		//Profession License is a bit odd that it might have the company name for the person record.  If the input was truely a company search filter out the individuals
		hasIndividual := l.rawdata.lname <> '' ;
		self.acctno := if(l.srcIndividualHeader and hasIndividual,l.acctno,skip);
		self.internalID := if(l.srcIndividualHeader,l.lnpid,l.lnfid);
		self.sources := dataset([{l.rawdata.prolic_key,Healthcare_Shared.Constants.SRC_PROFLIC}],Healthcare_Shared.Layouts.layout_SrcID);
		self.src := Healthcare_Shared.Constants.SRC_PROFLIC;
		self.LNPID := l.lnpid;
		self.LNFID := l.lnfid;
		self.VendorID := (string)l.rawdata.did;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := if(l.srcBusinessHeader and l.returnThresholdExceeded,203,0);
		getUpdateDate := l.rawdata.date_last_seen;
		self.last_update_date:= (string)getUpdateDate;
		self.RecordsRaw := project(l,set_std_record_struct(left));
		self.ProfLicRaw := if(cfg[1].keepRawProfLicRecs,
																	project(l,build_ProflicRaw(left)),
																	dataset([],iesp.proflicense.t_ProfessionalLicenseRecord)[1]);
		self:=l; 
		self:=[];
	END;

/*	//Proflic Rollups
	export Healthcare_Shared.Layouts.layout_addressinfo doProfLicBaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	Export Healthcare_Shared.Layouts.CombinedHeaderResults build_ProfLic_base (Healthcare_Shared.Layouts.proflic_base_with_input l) := transform
		//Profession License is a bit odd that it might have the company name for the person record.  If the input was truely a company search filter out the individuals
		isCompany := l.comp_name <> '';
		hasIndividual := l.rawdata.lname <> '' ;
		self.acctno := if(isCompany and hasIndividual,skip,l.acctno);
		self.sources := dataset([{l.rawdata.prolic_key,Healthcare_Shared.Constants.SRC_PROFLIC}],Healthcare_Shared.Layouts.layout_SrcID);
		self.LNPID := l.lnpid;
		self.srcID := l.lnpid;
		self.VendorID := (string)l.rawdata.did;
		self.src := Healthcare_Shared.Constants.SRC_PROFLIC;
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
																			self.CompanyName := left.rawdata.company_name;self:=[];));
		self.Addresses := project(l,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																		self.acctno := left.acctno;
																		self.ProviderID:=left.lnpid;
																		self.addrSeq := Healthcare_Shared.Constants.ADDR_SEQ_PROFLIC;
																		self.addrSeqGrp := 0;
																		self.addrGoldFlag := '';
																		self.addrConfidenceValue := '';
																		self.addrType := '';
																		self.addrTypeCode := 'P';
																		self.addrVerificationStatusFlag := '';
																		self.addrVerificationDate := '';
																		self.addrPenalty := 0;
																		self.address1 := if(left.rawdata.orig_addr_1<>'',left.rawdata.orig_addr_1,Healthcare_Shared.Functions.buildAddress(left.rawdata.prim_range,left.rawdata.predir,left.rawdata.prim_name,left.rawdata.suffix,left.rawdata.postdir,left.rawdata.unit_desig,left.rawdata.sec_range));
																		self.address2 := '';
																		self.prim_range := left.rawdata.prim_range;
																		self.predir := left.rawdata.predir;
																		self.prim_name := left.rawdata.prim_name;
																		self.addr_suffix := left.rawdata.suffix;
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
																		self.last_seen := (string)left.rawdata.date_last_seen;
																		self.first_seen := (string)left.rawdata.date_first_seen;
																		self.v_last_seen := '';
																		self.v_first_seen := '';
																		self.geo_lat := left.rawdata.geo_lat;
																		self.geo_long := left.rawdata.geo_long;
																		self.fips_state := '';
																		self.fips_county := '';
																		self.PhoneNumber := '';
																		self.FaxNumber := '';
																		self.Phones := dataset([],Healthcare_Shared.Layouts.layout_addressphone);self:=[];));
		self.dids := dataset([{l.acctno,l.lnpid,(integer)l.rawdata.did}],Healthcare_Shared.Layouts.layout_did)(did>0);
		self.bdids := dataset([{l.acctno,l.lnpid,(integer)l.rawdata.bdid}],Healthcare_Shared.Layouts.layout_bdid)(bdid>0);
		self.dobs := project(l, transform(Healthcare_Shared.Layouts.layout_dob,self.acctno := left.acctno;self.ProviderID:=left.lnpid; self.DOB :=left.rawdata.dob;self:=[]));
		self.StateLicenses := project(l, transform(Healthcare_Shared.Layouts.layout_licenseinfo, self.licenseAcctno :=left.acctno;self.ProviderID:=left.lnpid;self.group_key:='';self.licenseSeq:=0;
																								self.LicenseState:=left.rawdata.source_st;self.LicenseNumber:=left.rawdata.license_number;
																								self.LicenseStatus:='';self.Effective_Date:=left.rawdata.issue_date;
																								self.Termination_Date:=left.rawdata.expiration_date;self:=[];));
		self.ProfLicRaw := project(l,build_ProflicRaw(left));
		self:=l; 
		self:=[];
	END;

	//Proflic Rollups
	export Healthcare_Shared.Layouts.layout_addressinfo doProfLicBaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export Healthcare_Shared.Layouts.CombinedHeaderResults doProfLicBaseRecordSrcIdRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
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
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doProfLicBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.dids          := Healthcare_Shared.Functions.processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Healthcare_Shared.Layouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := Healthcare_Shared.Functions.processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	) );
		self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs(dob<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
		self.StateLicenses := sort(dedup( NORMALIZE( allRows, LEFT.StateLicenses(LicenseNumber<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_licenseinfo, SELF := RIGHT	)	), record, all ),LicenseState,-Termination_Date, LicenseNumber);
		self.ProfLicRaw    := sort(DEDUP(NORMALIZE(allRows, LEFT.ProfLicRaw, TRANSFORM( iesp.proflicense.t_ProfessionalLicenseRecord, SELF := RIGHT)), RECORD, ALL ),-ExpirationDate,prolicSeqId);
		self := l;
	end;*/
End;