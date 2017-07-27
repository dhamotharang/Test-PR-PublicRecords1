import AutoKeyI, AutoStandardI, AutoHeaderI, iesp, suppress,ut;
EXPORT IParams := MODULE
	export nameinfo := record
		unsigned2   nameSeq := 0;
		unsigned 		namePenalty := 0;
		STRING120 	CompanyName := '';
		string20		FirstName := '';
		string20		MiddleName := '';
		string20		LastName := '';
		string5			Suffix := '';
		string5			ProfSuffix := '';
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
	
	EXPORT CommonCoreParams := interface
		EXPORT STRING6 		ssnMask := 'ALL'; 
		EXPORT unsigned1 	dob_mask_value := suppress.Constants.dateMask.NONE; 
		EXPORT string11 	Fein := '';
		EXPORT string11 	TaxID := '';
		EXPORT string 		UPIN := '';
		EXPORT string 		NPI := '';	
		EXPORT string 		DEA := '';	
		EXPORT string 		DEA2 := '';	
		Export String15 	NCPDPNumber := '';
		EXPORT unsigned6 	LNPID := 0;
		EXPORT unsigned6 	LNFID := 0;
		EXPORT String5	 	ProviderSrc := '';
		EXPORT String50 	ClientProviderId := '';
		EXPORT String10 	ServiceFromDate := '';
		EXPORT String10 	ServiceToDate := '';
		Export String2 		LicenseState := '';
		Export String			LicenseNumber := '';
		Export String15		CLIANumber := '';
		EXPORT String50 	BoardCertifiedSpecialty := '';
	END;
	
	SHARED commonParams := INTERFACE (AutoStandardI.PermissionI_Tools.params,
																		AutoStandardI.LIBIN.PenaltyI.base, 
																		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
																		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,
																		AutoKeyIdsParams,
																		CommonCoreParams)			
		EXPORT BOOLEAN 		noFail := true;
		EXPORT boolean 		derivedLexID := false;
		EXPORT boolean 		IsIndividualSearch := false;
		EXPORT boolean 		IsBusinessSearch := false;
		EXPORT boolean 		IsUnknownSearchBoth := false;
		EXPORT string4		NameSuffix := '';
		EXPORT string5		ProfSuffix := '';
		EXPORT string4		Title := '';
		Export string40		VendorSrcID := '';
	END;
	
	EXPORT searchParams := interface(commonParams)	
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
		Export ServiceFromDate := ut.GetDate;
		Export ServiceToDate := ut.GetDate;
		Export string50	ClientProviderId := '';
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
		string120 unparsedfullname :=	stringlib.StringToUpperCase(trim(global(tag).Name.Full,all)):stored('unparsedfullname');
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
		#STORED('Zip',in_addr_zip_val);
		#STORED('DateOfBirth',in_dob_val);
		#STORED('HomePhone',in_phone_val);
		#STORED('BusinessPhone',in_phone_val);
		#STORED('TaxIdNumber',in_fein_val);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;


	export SetInputSearchOptions (iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportOption tag) := FUNCTION
		#STORED('IncludeAlsoFound',global(tag).IncludeAlsoFound);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

	export SetInputSearch (iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRequest tag) := FUNCTION
		SetInputSearchCriteria(tag.ReportBy2);
		SetInputSearchOptions(tag.Options);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

END;