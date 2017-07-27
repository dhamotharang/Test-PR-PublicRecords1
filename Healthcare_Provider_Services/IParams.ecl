import AutoKeyI, AutoStandardI, AutoHeaderI, iesp, suppress;

EXPORT IParams := MODULE

	export nameinfo := record
		unsigned2   nameSeq := 0;
		unsigned 		namePenalty := 0;
		STRING120 	CompanyName := '';
		string20		FirstName := '';
		string20		MiddleName := '';
		string20		LastName := '';
		string5			Suffix := '';
		string4			Title := '';
		string6			Gender := '';
	end;
	export addressinfo := record
		unsigned2   addrSeq := 0;
		unsigned 		addrPenalty := 0;
		string120  	address1 := '';
		string120  	address2 := '';
		string10  	prim_range := '';
		string2   	predir := '';
		string28  	prim_name := '';
		string4   	addr_suffix := '';
		string2   	postdir := '';
		string10  	unit_desig := '';
		string8   	sec_range := '';
		string25  	p_city_name := '';
		string25  	v_city_name := '';
		string2   	st := '';
		string5   	z5 := '';
		string4   	zip4 := '';
		string8   	last_seen := '';
		string8   	first_seen := '';
		string8   	v_last_seen := '';
		string8   	v_first_seen := '';
		STRING10  	geo_lat;
		STRING11  	geo_long;
		STRING10		PhoneNumber;
		STRING10		FaxNumber;
	end;
	export licenseinfo := record
	  string20	 	licenseAcctno := '';
		unsigned2   licenseSeq := 0;
		String2 		LicenseState := '';
		String			LicenseNumber := '';
		STRING8	  	Effective_Date :='';
		STRING8	  	Termination_Date:='';
	end;

	EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := true;
		EXPORT BOOLEAN noFail := true;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	SHARED commonParams := INTERFACE (AutoStandardI.PermissionI_Tools.params,
																		AutoStandardI.LIBIN.PenaltyI.base, 
																		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
																		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
																		AutoKeyIdsParams)			
		EXPORT BOOLEAN 		noFail := true;
		EXPORT string25 	requestorCompanyID := '';
		EXPORT UNSIGNED2 	penalty_threshold := 10;
		EXPORT UNSIGNED2 	max_results := 10;
		EXPORT STRING6 		ssnMask := 'ALL'; 
		EXPORT unsigned1 	dob_mask_value := suppress.Constants.dateMask.NONE; 
		EXPORT string11 	Fein := '';
		EXPORT string11 	TaxID := '';
		EXPORT string 		UPIN := '';
		EXPORT string 		NPI := '';	
		EXPORT string 		DEA := '';	
		EXPORT string 		DEA2 := '';	
		Export String15 	NCPDPNumber := '';
		EXPORT unsigned6 	ProviderId := 0;
		EXPORT String1	 	ProviderSrc := '';
		Export String2 		LicenseState := '';
		Export String			LicenseNumber := '';
		Export String15		CLIANumber := '';
		Export boolean		isReport := false;
		Export boolean		includeCustomerData := false;
		EXPORT boolean 		IncludeSanctions := false;
		EXPORT boolean 		derivedLexID := false;
		EXPORT boolean 		IsShowAllDoDs := false;
		EXPORT boolean 		IncludeAlsoFound := false;
		EXPORT boolean 		IncludeBoardCertifiedSpecialty := false;
		EXPORT boolean 		IncludeCareer := false;
		EXPORT boolean 		IncludeEducation := false;
		EXPORT boolean 		IncludeProfessionalAssociations := false;
		EXPORT String50 	OneStepRule := '';
		EXPORT String50 	BoardCertifiedSpecialty := '';
		EXPORT boolean 		IncludeAllSources := false;
		EXPORT boolean		IncludeSourceIngenix := false;
		EXPORT boolean 		IncludeSourceAMS := false;
		EXPORT boolean 		IncludeSourceNPPES := false;
		EXPORT boolean 		IncludeSourceDEA := false;
		EXPORT boolean 		IncludeSourceProfLic := false;
		EXPORT boolean 		IncludeSourceSelectFile := false;
		EXPORT boolean 		IncludeSourceCLIA := false;
		EXPORT boolean 		IncludeSourceABMS := false;
		EXPORT boolean 		IncludeSourceNCPDP := false;
		EXPORT string 		DataRestrictionMask := '';
	END;
	
	EXPORT reportParams := INTERFACE (commonParams)			
					export set of unsigned6  sanc_id_set := [] ;
					EXPORT boolean IncludeGroupAffiliations := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeHospitalAffiliations := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeSpecialties  := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeLicenses  := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeResidencies  := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeDegrees := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeMedicalSchools := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeDEAInformation := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeBusinessAddresses := false;//Set to true for backward compatibility done by ESP
					EXPORT boolean IncludeProfessionalLicenses := false;
					EXPORT boolean IncludeCurrentProfessionalLicensesOnly := false;
					EXPORT boolean IncludeAssoc := false;
					EXPORT boolean IncludeGSASanctions := false;
					EXPORT boolean StrictMatchGSASanctions := false;
					EXPORT boolean IncludeCLIA := false;
					EXPORT boolean IncludeCorporateAffiliations := false;
					EXPORT boolean IncludeCriminalRecords := false;
					EXPORT boolean IncludeSexOffenders := false;
					EXPORT boolean IncludeLiensJudgments := false;
					EXPORT boolean IncludeBankruptcies := false;
					EXPORT boolean IncludeBlankDOD := false;
					EXPORT boolean IncludeIndividualInstantID := false;
					EXPORT boolean IncludeBusinessInstantID := false;
					EXPORT boolean IncludeVerifications := false;
					EXPORT boolean IncludeRels := false;
					EXPORT unsigned3 MaxRelatives := 0;
					EXPORT unsigned1 RelativeDepth := 0;
					EXPORT boolean IncludeRelativeAddresses := false;
					EXPORT unsigned1 MaxRelativeAddresses := 0;
					EXPORT boolean IncludeNeighs := false;
					EXPORT boolean IncludeHistoricalNeighbors := false;
					EXPORT unsigned1 NeighborhoodCount := 0;
					EXPORT unsigned1 NeighborCount := 0;
					EXPORT unsigned1 HistoricalNeighborhoodCount := 0;
					EXPORT unsigned1 HistoricalNeighborCount := 0;
					EXPORT boolean IncludeCorporateAffiliationsOnlyWhenSanctions := false;
					EXPORT boolean IncludeRelativesOnlyWhenDeadOrWithSanctions := false;
	END;
	
	EXPORT searchParams := interface(commonParams)	
		EXPORT boolean IncludeProvidersOnly := false;
		EXPORT boolean IncludeSanctionsOnly := false;
		EXPORT boolean IncludeSanctions := true;
		EXPORT boolean IncludeGroupAffiliations := false;
		EXPORT boolean IncludeHospitalAffiliations := false;
		EXPORT boolean IncludeSpecialties  := false;
		EXPORT boolean IncludeLicenses  := false;
		EXPORT boolean IncludeResidencies  := false;
		EXPORT String50 BoardCertifiedSpecialty2 := '';
		EXPORT String50 BoardCertifiedSpecialty3 := '';
		EXPORT String50 BoardCertifiedSpecialty4 := '';
		EXPORT String50 BoardCertifiedSpecialty5 := '';
		EXPORT String50 BoardCertifiedSubSpecialty := '';
		EXPORT String50 BoardCertifiedSubSpecialty2 := '';
		EXPORT String50 BoardCertifiedSubSpecialty3 := '';
		EXPORT String50 BoardCertifiedSubSpecialty4 := '';
		EXPORT String50 BoardCertifiedSubSpecialty5 := '';
		EXPORT string  MedicalSchoolName := '';
		EXPORT integer GraduationYear :=0;
		Export String15	Taxonomy := '';
		Export String15	Taxonomy2 := '';
		Export String15	Taxonomy3 := '';
		Export String15	Taxonomy4 := '';
		Export String15	Taxonomy5 := '';
		Export string20	acctno := '1';
		Export dataset(licenseinfo) StateLicenses := dataset([],licenseinfo);
		Export dataset(nameinfo) OtherNames := dataset([],nameinfo);
		Export dataset(addressinfo) OtherAddresses := dataset([],addressinfo);
	END;

	export SetInputSearchCriteria (iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportBy tag) := FUNCTION
		string10 in_addr_stnbr_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.StreetNumber,all)):stored('StreetNumber');
		string2 in_addr_predir_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.StreetPreDirection,all)):stored('StreetPreDirection');
		string50 in_addr_name_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.StreetName,all)):stored('StreetName');
		string4 in_addr_suffix_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.StreetSuffix,all)):stored('StreetSuffix');
		string2 in_addr_postdir_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.StreetPostDirection,all)):stored('StreetPostDirection');
		string8 in_addr_unit_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.UnitNumber,all)):stored('UnitNumber');
		string200 in_addr_st1_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.StreetAddress1,all)):stored('StreetAddress1');
		string25 in_addr_city_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.City,all)):stored('City');
		string2 in_addr_state_val :=	stringlib.StringToUpperCase(trim(global(tag).Address.State,all)):stored('State');
		buildAddr := if(in_addr_st1_val <> '',in_addr_st1_val,trim(trim(trim(trim(trim(in_addr_stnbr_val+' '+in_addr_predir_val,all)+' '+in_addr_name_val,all)+' '+in_addr_suffix_val,all)+' '+in_addr_postdir_val,all)+' '+in_addr_unit_val,all));
		in_addr_zip_val :=	trim(global(tag).Address.Zip5,all):stored('Zip5');
		in_dob_val :=	iesp.ECL2ESP.t_DateToString8(global(tag).DOB);
		string10 in_phone_val :=	trim(global(tag).Phone10,all):stored('Phone10');
		string11 in_fein_val :=	stringlib.StringToUpperCase(trim(global(tag).fein,all));
		string120 in_comp_val :=	stringlib.StringToUpperCase(trim(global(tag).CompanyName,all)):stored('CompanyName');
		string30 in_first_val :=	stringlib.StringToUpperCase(trim(global(tag).Name.First,all)):stored('First');
		string30 in_middle_val :=	stringlib.StringToUpperCase(trim(global(tag).Name.Middle,all)):stored('Middle');
		string30 in_last_val :=	stringlib.StringToUpperCase(trim(global(tag).Name.Last,all)):stored('Last');
	  string11 SSN       := trim (global(tag).SSN);
    string15 Phone10 := global(tag).Phone10; // funny...
		iesp.ECL2ESP.SetInputName (global(tag).Name, true);
		iesp.ECL2ESP.SetInputAddress (global(tag).Address, true);
		iesp.ECL2ESP.SetInputDate (global(tag).DOB, 'DOB');
		#STORED('CompanyName',stringlib.StringToUpperCase(trim(global(tag).CompanyName)));
		#STORED('LastName',in_last_val);      			
		#STORED('FirstName',in_first_val);      			
		#STORED('MiddleName',in_middle_val);
		//InstantID (Ind and Bus) need inputs in these stored fields no the original IESP stored values.
		#STORED('primrange',in_addr_stnbr_val);
		#STORED('prim_range',in_addr_stnbr_val);
		#STORED('predir',in_addr_predir_val);
		#STORED('primname',in_addr_name_val);
		#STORED('prim_name',in_addr_name_val);
		#STORED('AddrSuffix',in_addr_suffix_val);
		#STORED('suffix',in_addr_suffix_val);
		#STORED('postdir',in_addr_postdir_val);
		#STORED('SecRange',in_addr_unit_val);
		#STORED('sec_range',in_addr_unit_val);
		#STORED('City',in_addr_city_val);
		#STORED('State',in_addr_state_val);
		#STORED('StreetAddress',in_addr_st1_val);
		#STORED('Addr',in_addr_st1_val);
		#STORED('RepresentativeFirstName',global(tag).NAME.First);
		#STORED('RepresentativeLastName',global(tag).NAME.Last);
		#STORED('RepresentativeAddr',buildAddr);
		#STORED('RepresentativeCity',stringlib.StringToUpperCase(trim(global(tag).Address.CITY,all)));
		#STORED('RepresentativeState',stringlib.StringToUpperCase(trim(global(tag).Address.STATE,all)));
		#STORED('RepresentativeZip',in_addr_zip_val);
		#STORED('RepresentativeSSN',global(tag).SSN);
		#STORED('RepresentativeDOB',in_dob_val);
		#STORED('Zip',in_addr_zip_val);
		#STORED('DateOfBirth',in_dob_val);
		#STORED('HomePhone',in_phone_val);
		#STORED('BusinessPhone',in_phone_val);
		#STORED('TaxIdNumber',in_fein_val);
		//GSA Needs this
		#STORED('Z5',in_addr_zip_val);
    #stored('ssn', SSN);
    #stored('phone', Phone10);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;


	export SetInputSearchOptions (iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportOption tag) := FUNCTION
		in_maxRel := global(tag).Relatives.MaxRelatives;
		maxRel := if(in_maxRel=0,iesp.Constants.HPR.MAX_Relatives,min(in_maxRel,iesp.Constants.BR.MaxRelatives));
		in_RelDepth := global(tag).Relatives.RelativeDepth;
		maxRelDepth := if(in_RelDepth>0,in_RelDepth,iesp.Constants.HPR.MAX_RelativeDepth);
		in_MaxRelAddr := global(tag).Relatives.MaxRelativeAddresses;
		maxRelAddr := if(in_MaxRelAddr>0,in_MaxRelAddr,iesp.Constants.HPR.MAX_RelativeAddresses);
		in_NbrhoodCnt := global(tag).Neighbors.NeighborhoodCount;
		maxNbrhoodCnt := if(in_NbrhoodCnt>0,in_NbrhoodCnt,iesp.Constants.HPR.MAX_NeighborhoodCount);
		in_NbrCnt := global(tag).Neighbors.NeighborCount;
		maxNbrCnt := if(in_NbrCnt>0,in_NbrCnt,iesp.Constants.HPR.MAX_NeighborCount);
		in_HNbrhoodCnt := global(tag).Neighbors.HistoricalNeighborhoodCount;
		maxHNbrhoodCnt := if(in_HNbrhoodCnt>0,in_HNbrhoodCnt,iesp.Constants.HPR.MAX_HistoricalNeighborhoodCount);
		in_HNbrCnt := global(tag).Neighbors.HistoricalNeighborCount;
		maxHNbrCnt := if(in_HNbrCnt>0,in_HNbrCnt,iesp.Constants.HPR.MAX_HistoricalNeighborCount);
		#STORED('IncludeAlsoFound',global(tag).IncludeAlsoFound);
		#STORED('IncludeSanctions',global(tag).IncludeSanctions);
		#STORED('IncludeDegrees',global(tag).IncludeDegrees);
		#STORED('IncludeGroupAffiliations',global(tag).IncludeGroupAffiliations);
		#STORED('IncludeHospitalAffiliations',global(tag).IncludeHospitalAffiliations);
		#STORED('IncludeResidencies',global(tag).IncludeResidencies);
		#STORED('IncludeMedicalSchools',global(tag).IncludeMedicalSchools);
		#STORED('IncludeSpecialties',global(tag).IncludeSpecialties);
		#STORED('IncludeLicenses',global(tag).IncludeLicenses);
		#STORED('IncludeDEAInformation',global(tag).IncludeDEAInformation);
		#STORED('IncludeBusinessAddresses',global(tag).IncludeBusinessAddresses);
		#STORED('IncludeProfessionalLicenses',global(tag).IncludeProfessionalLicenses);
		#STORED('IncludeAssociates',global(tag).IncludeAssociates);
		#STORED('IncludeGSASanctions',global(tag).IncludeGSASanctions);
		#STORED('IncludeCorporateAffiliations',global(tag).IncludeCorporateAffiliations);
		#STORED('IncludeCriminalRecords',global(tag).IncludeCriminalRecords);
		#STORED('IncludeLiensJudgments',global(tag).IncludeLiensJudgments);
		#STORED('IncludeBankruptcies',global(tag).IncludeBankruptcies);
		#STORED('IncludeBlankDOD',global(tag).IncludeBlankDOD);
		#STORED('IncludeIndividualInstantID',global(tag).IncludeIndividualInstantID);
		#STORED('IncludeBusinessInstantID',global(tag).IncludeBusinessInstantID);
		#STORED('IncludeVerifications',global(tag).IncludeVerifications);
		#STORED('IncludeRelatives',global(tag).Relatives.IncludeRelatives);
		#STORED('MaxRelatives',if(global(tag).Relatives.IncludeRelatives,maxRel,0));
		#STORED('RelativeDepth',maxRelDepth);
		#STORED('IncludeRelativeAddresses',global(tag).Relatives.IncludeRelativeAddresses);
		#STORED('MaxRelativeAddresses',if(global(tag).Relatives.IncludeRelativeAddresses,maxRelAddr,0));
		#STORED('IncludeNeighbors',global(tag).Neighbors.IncludeNeighbors);
		#STORED('IncludeHistoricalNeighbors',global(tag).Neighbors.IncludeHistoricalNeighbors);
		#STORED('NeighborhoodCount',if(global(tag).Neighbors.IncludeNeighbors,maxNbrhoodCnt,0));
		#STORED('NeighborCount',if(global(tag).Neighbors.IncludeNeighbors,maxNbrCnt,0));
		#STORED('HistoricalNeighborhoodCount',if(global(tag).Neighbors.IncludeHistoricalNeighbors,maxHNbrhoodCnt,0));
		#STORED('HistoricalNeighborCount',if(global(tag).Neighbors.IncludeHistoricalNeighbors,maxHNbrCnt,0));
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

	export SetInputSearch (iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRequest tag) := FUNCTION
		SetInputSearchCriteria(tag.ReportBy2);
		SetInputSearchOptions(tag.Options);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

END;