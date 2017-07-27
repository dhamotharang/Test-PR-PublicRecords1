#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',5);
// #Stored('DataPermissionMask','0000000001');
#Stored('DataRestrictionMask','00000000000000000');
#WORKUNIT('name','HC ProviderPoint SearchService Test');    //name it "MyJob"
import iesp,autostandardi,Healthcare_Shared,ut;
	stateLicenseDS := dataset([],Healthcare_ProviderPoint.IParams.licenseinfo);
	// stateLicenseDS := dataset([{1,1,'IN','1017944','',''}],Healthcare_ProviderPoint.IParams.licenseinfo);//Gap Test Case
	// stateLicenseDS := dataset([{1,1,'CA','3319','',''}],Healthcare_ProviderPoint.IParams.licenseinfo);
														 // {1,2,'MI','2901014302','',''}],Healthcare_ProviderPoint.IParams.licenseinfo);
														 // {1,3,'MA','47483','',''},
														 // {1,4,'NY','151731','',''},
														 // {1,5,'NY','60151731','',''}],Healthcare_ProviderPoint.IParams.licenseinfo);
														 // {1,6,'ND','386','',''},
														 // {1,7,'NY','099784','',''},
														 // {1,8,'ID','M-9471','',''},
														 // {1,9,'IL','041','',''},
														 // {1,10,'MI','4301045409','',''}
															// ],Healthcare_ProviderPoint.IParams.licenseinfo);
  	
		rec_in := iesp.providerpoint.t_ProviderPointSearchRequest;

		rec_in setinput():=transform
			// self.User.GLBPurpose:='1';
			// self.User.DLPurpose:='1';
			// self.User.DataPermissionMask:='1111111111';
			// self.User.DataRestrictionMask:='00000000000000000';
			self.Options.IncludeAlsoFound:=true;
			self.Options.IncludeGroupAffiliations:=true;
			self.Options.IncludeHospitalAffiliations:=true;
			self.Options.IncludeResidencies:=true;
			self.Options.IncludeSpecialties:=true;
			self.Options.IncludeLicenses:=true;
			self.Options.IncludeBoardCertifiedSpecialty:=false;
			self.Options.IncludeSanctionsOnly:=false;
			self.Options.ExcludeSourceAMS:=true;
			self.Options.ExcludeSourceNPPES:=false;
			self.Options.ExcludeSourceDEA:=false;
			self.Options.ExcludeSourceProfLic:=true;
			self.Options.ExcludeSourceSelectFile:=false;
			self.Options.ExcludeSourceCLIA:=false;
			self.Options.ExcludeSourceNCPDP:=false;
			// self.SearchBy.UniqueId:='1899916518';
			// self.SearchBy.ProviderId:='11093116';
			// self.SearchBy.ProviderSrc:='64';
			// self.SearchBy.ProviderId:='3502558';
			// self.SearchBy.ProviderSrc:='64';
			// self.SearchBy.ProviderSrc:='H';
			// self.SearchBy.UniqueId:='136560409';
			// self.SearchBy.Name.Full:='';
			self.SearchBy.Name.First:='ELIAS';
			self.SearchBy.Name.Middle:='JOSEPH';
			self.SearchBy.Name.last:='MICHAEL';
			// self.name_first:='JOHN';
      // self.name_middle:='WILLIAM';
      // self.name_last:='BASORE';
			// self.SearchBy.Name.Suffix:='';
			// self.searchby.MedicalSchoolName:='Philadelphia';
			// self.searchby.graduationyear:=1972;
			//self.searchby.GraduationYearVerification:='1972';
			// self.SearchBy.Name.Prefix:='';
			// self.SearchBy.CompanyName:='MEDIFEM HEALTH PSC';//Gap Bus Testcase
			// self.SearchBy.Address.StreetAddress1:='250 E LIBERTY ST STE 310';
			// self.SearchBy.Address.StreetNumber:='5250';
			// self.SearchBy.Address.StreetPreDirection:='E';
			// self.SearchBy.Address.StreetName:='US36';
			// self.SearchBy.Address.StreetSuffix:='';
			// self.SearchBy.Address.StreetPostDirection:='';
			// self.SearchBy.Address.UnitDesignation:='STE';
			// self.SearchBy.Address.UnitNumber:='610';
			// self.SearchBy.Address.City:='LAS VEGAS';//Gap Bus Testcase
			// self.SearchBy.Address.State:='NV';//Gap Bus Testcase
			// self.SearchBy.Address.Zip5:='40202';
			// self.SearchBy.CompanyName:='PHYSICIAN COVERAGE SERVICES PC';
			// self.SearchBy.CompanyName:='MICHIGAN HEALTH SPECIALIST';
			// self.SearchBy.NPINumber:='1528184785';
			// self.SearchBy.DEANumber:='AH6076132';
			// self.SearchBy.UPIN:='C95667';
			// self.SearchBy.CLIANumber:='01D0641618';
			self.SearchBy.SSN:='573714321';
			// self.SearchBy.FEIN:='573714321';
			// self.SearchBy.TaxId:='573714321';
			self:=[]
		end;
		ds_in:=dataset([setinput()]);

	request := ds_in[1] : INDEPENDENT;

	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputSearchOptions(first_row.options);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])), true);
	string11 Taxid       := trim(first_row.searchBy.Taxid);
	#stored('Taxid', Taxid);
	string11 Fein       := trim(first_row.searchBy.FEIN);
	#stored('Fein', Fein);
  STRING CompanyName := trim(first_row.searchBy.CompanyName);
	#STORED('CompanyName', CompanyName);
	unsigned1 PenaltThreshold := first_row.Options.penaltythreshold;
	unsigned1 UserThreshold := if (first_row.Options.ThresholdLimit > 0,first_row.Options.ThresholdLimit,10);
	#stored ('PenaltThreshold', PenaltThreshold);	
	// stateLicenseDS := dataset([{1,1,first_row.searchby.LicenseState,first_row.searchby.LicenseNumber,'',''},
														 // {1,2,first_row.searchby.LicenseState2,first_row.searchby.LicenseNumber2,'',''},
														 // {1,3,first_row.searchby.LicenseState3,first_row.searchby.LicenseNumber3,'',''},
														 // {1,4,first_row.searchby.LicenseState4,first_row.searchby.LicenseNumber4,'',''},
														 // {1,5,first_row.searchby.LicenseState5,first_row.searchby.LicenseNumber5,'',''},
														 // {1,6,first_row.searchby.LicenseState6,first_row.searchby.LicenseNumber6,'',''},
														 // {1,7,first_row.searchby.LicenseState7,first_row.searchby.LicenseNumber7,'',''},
														 // {1,8,first_row.searchby.LicenseState8,first_row.searchby.LicenseNumber8,'',''},
														 // {1,9,first_row.searchby.LicenseState9,first_row.searchby.LicenseNumber9,'',''},
														 // {1,10,first_row.searchby.LicenseState10,first_row.searchby.LicenseNumber10,'',''}
															// ],Healthcare_ProviderPoint.IParams.licenseinfo);
  	
	input_params := AutoStandardI.GlobalModule();
	tmpMod:= MODULE(PROJECT(input_params, Healthcare_ProviderPoint.IParams.searchParams,opt))		
		EXPORT STRING 		NPI := first_row.searchby.NPINumber;
		EXPORT STRING 		UPIN := first_row.searchby.UPIN;
		EXPORT string11 	Fein := AutoStandardI.InterfaceTranslator.fein_val.val(project(input_params, AutoStandardI.InterfaceTranslator.fein_val.params));  
		EXPORT STRING 		MedicalSchoolName := first_row.searchby.MedicalSchoolName;
		EXPORT integer 		GraduationYear := first_row.searchby.GraduationYear;
		EXPORT STRING100 	rawFullName := first_row.searchby.Name.Full;      			
		EXPORT STRING30 	LastName := first_row.searchby.Name.Last;      			
		EXPORT STRING30 	FirstName := first_row.searchby.Name.FIRST;      			
		EXPORT STRING30 	MiddleName := first_row.searchby.Name.Middle;
		EXPORT string120 	CompanyName := first_row.searchby.CompanyName;
		EXPORT string10 	prim_range :=  first_row.searchby.Address.StreetNumber;
		EXPORT string2		predir :=  first_row.searchby.Address.StreetPreDirection;
		EXPORT string28		prim_name :=  first_row.searchby.Address.StreetName;
		EXPORT string4		suffix :=  first_row.searchby.Address.StreetSuffix;
		EXPORT string2		postdir :=  first_row.searchby.Address.StreetPostDirection;
		EXPORT string8		sec_range :=  first_row.searchby.Address.UnitNumber;
		export string25 	city := AutoStandardI.InterfaceTranslator.city_val.val(project(input_params, AutoStandardI.InterfaceTranslator.city_val.params));
		export string2 		state := AutoStandardI.InterfaceTranslator.state_val.val(project(input_params, AutoStandardI.InterfaceTranslator.state_val.params));
		export string6 		zip := AutoStandardI.InterfaceTranslator.zip_val0.val(project(input_params, AutoStandardI.InterfaceTranslator.zip_val0.params));
		Export dataset(Healthcare_ProviderPoint.IParams.licenseinfo) StateLicenses := stateLicenseDS;
		EXPORT STRING 		DEA := first_row.searchby.DEANumber;
		EXPORT STRING 		DEA2 := first_row.searchby.DEANumber2;
		EXPORT string15		CLIANumber := first_row.searchby.CLIANumber;
		Export String15 	NCPDPNumber := first_row.searchby.PharmacyProviderId;
		EXPORT string15		Taxonomy := first_row.searchby.Taxonomy;
		export unsigned6  ProviderId := (integer)first_row.searchby.ProviderId;;
		export string5  	ProviderSrc := stringlib.StringToUpperCase(first_row.searchby.ProviderSrc);
		// export string5 		ProfessionalSuffix := first_row.searchby.name.ProfessionalSuffix;
		export string15		Fax10 := first_row.searchby.Fax10;
		export string1 		Gender := first_row.searchby.Gender;
		// export string20 	LicenseType := first_row.searchby.LicenseType;
		export string50 	EmailAddress := first_row.searchby.EmailAddress;
		export string120 	BillingCompanyName	:= first_row.searchby.BillingCompanyName;
		export string10 	BillingPrimRange		:= first_row.searchby.BillingAddress.StreetNumber;
		export string2		BillingPredir				:= first_row.searchby.BillingAddress.StreetPreDirection;
		export string28		BillingPrimName			:= first_row.searchby.BillingAddress.StreetName;
		export string4		BillingAddrSuffix		:= first_row.searchby.BillingAddress.StreetSuffix;
		export string2		BillingPostdir			:= first_row.searchby.BillingAddress.StreetPostDirection;
		export string10		BillingUnitDesig		:= first_row.searchby.BillingAddress.UnitDesignation;
		export string8		BillingSecRange			:= first_row.searchby.BillingAddress.UnitNumber;
		export string25		BillingCity					:= first_row.searchby.BillingAddress.City;
		export string2		BillingState				:= first_row.searchby.BillingAddress.State;
		export string5		BillingZip					:= first_row.searchby.BillingAddress.Zip5;
		export string10		BillingPhone				:= first_row.searchby.BillingPhone10;
		export string10		BillingFax					:= first_row.searchby.BillingFax10;
	END;

	Healthcare_ProviderPoint.Layouts.runtime_config buildConfig():=transform
		// self.CustomerID := '1535116';
		// self.OneStepRule := first_row.searchby.VerificationConfiguration;
		self.penalty_threshold := UserThreshold;
		self.MaxResults := first_row.options.MaxResults;
		self.DRM := first_row.user.DataRestrictionMask;
		self.glb_ok := ut.glb_ok ((integer)first_row.user.GLBPurpose);
		self.dppa_ok := ut.dppa_ok((integer)first_row.user.DLPurpose);
		// self.isExactAddressMatch := Constants.CFG_False;
		// self.IsShowAllDoDs := Constants.CFG_False;
		self.doDeepDive := first_row.options.IncludeAlsoFound;
		// self.BestOnly := Constants.CFG_False;
		// self.ShowComplete := Constants.CFG_False;
		self.MixedCaseOutput := True;
		self.excludeSourceAMS := True;// Force dataset off first_row.options.ExcludeSourceAMS;
		self.excludeSourceNPPES := True;// Force dataset off first_row.options.ExcludeSourceNPPES;
		self.excludeSourceDEA := True;// Force dataset off first_row.options.ExcludeSourceDEA;
		self.excludeSourceProfLic := True;// Force dataset off first_row.options.ExcludeSourceProfLic;
		self.excludeSourceSelectFile := first_row.options.ExcludeSourceSelectFile;
		self.excludeSourceCLIA := True;// Force dataset off first_row.options.ExcludeSourceCLIA;
		self.excludeSourceNCPDP := True;// Force dataset off first_row.options.ExcludeSourceNCPDP;
		self.excludeLegacySanctions := True;// Force dataset off first_row.options.ExcludeLegacySanctions;
		self.IncludeSanctionsOnly := first_row.options.IncludeSanctionsOnly;
		self.allowMergeAuthoritySrc := true;
		// self.IncludeSanctions := Constants.CFG_True;
		self.IncludeDea := first_row.options.IncludeDea;
		self.IncludeGroupAffiliations := first_row.options.IncludeHospitalAffiliations;
		self.IncludeHospitalAffiliations := first_row.options.IncludeGroupAffiliations;
		self.IncludeSpecialties  := first_row.options.IncludeSpecialties;
		self.IncludeLicenses  := first_row.options.IncludeLicenses;
		self.IncludeResidencies  := first_row.options.IncludeResidencies;
		self.IncludeABMSBoardCertifiedSpecialty := first_row.options.IncludeBoardCertifiedSpecialty;
		// self.IncludeABMSCareer := Constants.CFG_False;
		// self.IncludeABMSEducation := Constants.CFG_False;
		// self.IncludeABMSProfessionalAssociations := Constants.CFG_False;
		self.use_assoc := first_row.options.use_assoc;
		self.assoc_bill_min_score := IF(first_row.options.assoc_bill_min_score > 0,first_row.options.assoc_bill_min_score,Healthcare_ProviderPoint.Constants.CFG_ASSOC_BILL_MIN_SCORE);
		self.assoc_bill_min_rank1_score := IF(first_row.options.assoc_bill_min_rank1_score > 0,first_row.options.assoc_bill_min_rank1_score,Healthcare_ProviderPoint.Constants.CFG_ASSOC_BILL_MIN_RANK1_SCORE);
		self.assoc_caf_min_score := IF(first_row.options.assoc_caf_min_score > 0,first_row.options.assoc_caf_min_score,Healthcare_ProviderPoint.Constants.CFG_ASSOC_CAF_MIN_SCORE);
		self.assoc_caf_min_rank1_score := IF(first_row.options.assoc_caf_min_rank1_score > 0,first_row.options.assoc_caf_min_rank1_score,Healthcare_ProviderPoint.Constants.CFG_ASSOC_CAF_MIN_RANK1_SCORE);
		self.assoc_aug_prac := first_row.options.assoc_aug_prac;
		self.assoc_aug_bill := first_row.options.assoc_aug_bill;
		self.assoc_aug_remit := first_row.options.assoc_aug_remit;
		self.assoc_require_fgk := first_row.options.assoc_require_fgk;
		self.assoc_aug_inact := first_row.options.assoc_aug_inact;
		//self.use_cam := first_row.options.use_cam;
		self.cast_cam_person := first_row.options.cast_cam_person;
		self.cast_cam_entity := first_row.options.cast_cam_entity;
		self.clia_grace_days := if(first_row.options.clia_grace_days > 0,first_row.options.clia_grace_days,Healthcare_ProviderPoint.Constants.CFG_CLIA_GRACE_DAYS);
		self.dea_grace_days := if(first_row.options.dea_grace_days > 0,first_row.options.dea_grace_days,Healthcare_ProviderPoint.Constants.CFG_DEA_GRACE_DAYS);
		self.license_grace_days := IF(first_row.options.license_grace_days > 0,first_row.options.license_grace_days,Healthcare_ProviderPoint.Constants.CFG_LICENSE_GRACE_DAYS);
		self.npi_grace_days := IF(first_row.options.npi_grace_days > 0,first_row.options.npi_grace_days,Healthcare_ProviderPoint.Constants.CFG_NPI_GRACE_DAYS);
		self.use_client := first_row.options.use_client;
		self.use_client_data := first_row.options.use_client_data;
		self.use_csnm := first_row.options.use_csnm;
		self.use_emdeon_data := first_row.options.use_emdeon_data;
		self.use_erx_fax := first_row.options.use_erx_fax;
		self.use_high_risk := first_row.options.use_high_risk;
		self.aug_extra_npi_if_input_verified := first_row.options.aug_extra_npi_if_input_verified;
		self.do_client_pid_matching := first_row.options.do_client_pid_matching;
		self.do_csnm_pid_matching  := first_row.options.do_csnm_pid_matching;
		self.call_based_updates := first_row.options.call_based_updates;
		self.alternate_facility_matching := first_row.options.alternate_facility_matching;
		self.process_as_claim := first_row.options.process_as_claim;
		self.client_pid_confidence_score := if(first_row.options.client_pid_confidence_score > 0,first_row.options.client_pid_confidence_score,Healthcare_ProviderPoint.Constants.CFG_CLIENT_PID_CONFIDENCE_SCORE);
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfgData:=dataset([buildConfig()]);

  //	recs := Healthcare_ProviderPoint.Raw.getRecords(tmpMod,cfgData);	
	//or
	//Convert to common iparams
	// tmpMod1:= MODULE(PROJECT(tmpMod, Healthcare_ProviderPoint.IParams.searchParams,opt)) END;
	//Convert to Core Format
	convertedInput := Healthcare_ProviderPoint.Raw.convertInputtoDataset(tmpMod);
	//Name and Address Clean records using Healthcare cleaners into a single structure with the acctno key to join on later
	inputCleaned := Healthcare_ProviderPoint.Functions.CleanNameAddr(convertedInput);
	//Call Core
	rawRecs:=sort(dedup(sort(Healthcare_ProviderPoint.Raw.getRecordsRaw(inputCleaned,cfgData),acctno, LNPID),acctno, LNPID),acctno,record_penalty);
	//Filter if needed
	filterRecs := if(cfgData[1].IncludeSanctionsOnly = True,rawRecs(exists(LegacySanctions)),rawRecs);
	//Project into Internal ProviderPoint layout for further processing
	recsInternal := project(filterRecs,Healthcare_ProviderPoint.Transforms.formatServiceProviderOutput(left,cfgData));
	fmtRecs := project(filterRecs,Healthcare_ProviderPoint.Transforms_BatchService.processMasterBatch(left));										
								
output(convertedInput,named('RawInput'));
output(inputCleaned,named('CleanedInput'));
output(rawRecs,Named('CoreRecords'));
output(recsInternal,named('ProviderPointWebResults'));
output(fmtRecs,named('ProviderPointBatchMasterResults'));
	// recs := Healthcare_ProviderPoint.Raw.Records(tmpMod);	

	// iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs, results, iesp.providerpoint.t_ProviderPointSearchResponse,HealthCareProviders,false);
	// final_results := project(results, transform(iesp.providerpoint.t_ProviderPointSearchResponse, 
																									// self.recordcount := if(first_row.options.ReturnCount <> 0,min(first_row.options.ReturnCount, left.recordCount), left.recordCount ), 
																									// self.SearchBy := first_row.searchBy, 
																									// self.SearchOptions := first_row.options, 
																									// self:=left));
	// output(final_results, named('Results'));
	
