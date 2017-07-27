IMPORT AutoKeyI, AutoHeaderI, AutoStandardI, iesp, suppress;

EXPORT IParam := MODULE

	EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := FALSE;
		EXPORT BOOLEAN noFail := FALSE;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	export exclusionArray := record
		string stringValue;
	end;
	
	EXPORT SearchInterface := INTERFACE (AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
							AutoStandardI.PermissionI_Tools.params, 
							AutoStandardI.LIBIN.PenaltyI_Indv.base, 
							AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,AutoKeyIdsParams)
		EXPORT STRING userId :='';  
		EXPORT STRING startDate :='';
		EXPORT STRING endDate :='';	
		EXPORT STRING charterNumber :='';
		EXPORT STRING uccFilling :='';
		EXPORT STRING domain :='';	
		EXPORT STRING dlValue :='';
		EXPORT UNSIGNED2 	penalty_threshold := 20;
		EXPORT STRING6 		ssn_Mask := ''; 
		EXPORT BOOLEAN    dl_Mask := 0;
		EXPORT unsigned1  dob_mask_value := suppress.Constants.dateMask.NONE; 
		EXPORT STRING companyId_1 :='';
		EXPORT STRING companyId_2 :='';
		EXPORT STRING companyId_3 :='';
		EXPORT STRING companyId_4 :='';
		EXPORT STRING companyId_5 :='';
		EXPORT STRING companyId_6 :='';
		EXPORT STRING companyId_7 :='';
		EXPORT STRING companyId_8 :='';
		EXPORT STRING companyId_9 :='';
		EXPORT STRING companyId_10 :='';
		EXPORT BOOLEAN hasCompanyId := FALSE;
		EXPORT DATASET(exclusionArray) exclusion ;
	END;  // end SearchInterface
	
	// creates module for search according to #stored values
	EXPORT getSearchModule(iesp.deconfliction_audit.t_AuditSearchRequest request) := FUNCTION
		input_params := AutoStandardI.GlobalModule();
		searchBy := request.searchBy;
		options := request.options;
		in_mod:= MODULE(PROJECT(input_params, SearchInterface,opt))							
			EXPORT STRING userId := stringlib.stringtouppercase(trim(global(searchBy).UserId));  
			EXPORT STRING startDate := iesp.ECL2ESP.t_DateToString8(global(options).DateStart);
			EXPORT STRING endDate := iesp.ECL2ESP.t_DateToString8(global(options).DateEnd);	
			EXPORT STRING charterNumber := trim(global(searchby).BusinessId);
			EXPORT STRING uccFilling := trim(global(searchby).BusinessId);
			EXPORT STRING domain := stringlib.stringfilter(stringlib.stringtouppercase(trim(global(searchBy).DomainName)), 		'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
			//EXPORT STRING linkID := (String)trim(global(searchBy).UniqueId);
			EXPORT STRING6 		ssn_Mask := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(input_params,AutoStandardI.InterfaceTranslator.ssn_mask_value.params));; 
			EXPORT BOOLEAN    dl_Mask := AutoStandardI.InterfaceTranslator.dl_mask_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dl_mask_value.params));;
			EXPORT unsigned1 dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dob_mask_value.params));
			EXPORT STRING dlValue := AutoStandardI.InterfaceTranslator.dl_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dl_value.params));
			EXPORT string120 company := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(input_params, AutoStandardI.InterfaceTranslator.comp_name_value.params));
			EXPORT STRING companyId_1 := trim(global(searchBy).CompanyIds[1].value);
			EXPORT STRING companyId_2 := trim(global(searchBy).CompanyIds[2].value);
			EXPORT STRING companyId_3 := trim(global(searchBy).CompanyIds[3].value);
			EXPORT STRING companyId_4 := trim(global(searchBy).CompanyIds[4].value);
			EXPORT STRING companyId_5 := trim(global(searchBy).CompanyIds[5].value);
			EXPORT STRING companyId_6 := trim(global(searchBy).CompanyIds[6].value);
			EXPORT STRING companyId_7 := trim(global(searchBy).CompanyIds[7].value);
			EXPORT STRING companyId_8 := trim(global(searchBy).CompanyIds[8].value);
			EXPORT STRING companyId_9 := trim(global(searchBy).CompanyIds[9].value);
			EXPORT STRING companyId_10 := trim(global(searchBy).CompanyIds[10].value);		
			EXPORT BOOLEAN hasCompanyId := companyId_1 <> '' OR 
							companyId_2 <> '' OR companyId_3 <> '' OR 
							companyId_4 <> '' OR companyId_5 <> '' OR
							companyId_6 <> '' OR companyId_7 <> '' OR
							companyId_8 <> '' OR companyId_9 <> '' OR
							companyId_10 <> '' ;
			EXPORT DATASET(exclusionArray) exclusion := project(global(searchBy).ExclusionList, TRANSFORM(exclusionArray, 
							self.stringValue := left.value));
		END;
		RETURN in_mod;
	END;
	
	// #store all values in the ESDL
	EXPORT SetInputRequest (iesp.deconfliction_audit.t_AuditSearchBy request) := FUNCTION
    iesp.ECL2ESP.SetInputReportBy (ROW (request, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
		STRING DriversLicense := trim(global(request).DriversLicense);
		#stored('DriversLicense', DriversLicense);
		STRING CompanyName := trim(global(request).CompanyName);
		#stored('CompanyName', CompanyName);
		STRING FEIN := trim(global(request).BusinessId);
		#stored('FEIN', FEIN);				
		STRING cp1 := trim(global(request).CompanyIds[1].value);
		#stored('companyId_1', cp1);
		STRING cp2 := trim(global(request).CompanyIds[2].value);
		#stored('companyId_2', cp2);
		STRING cp3 := trim(global(request).CompanyIds[3].value);
		#stored('companyId_3', cp3);
		STRING cp4 := trim(global(request).CompanyIds[4].value);
		#stored('companyId_4', cp4);
		STRING cp5 := trim(global(request).CompanyIds[5].value);
		#stored('companyId_5', cp5);
		STRING cp6 := trim(global(request).CompanyIds[6].value);
		#stored('companyId_6', cp6);
		STRING cp7 := trim(global(request).CompanyIds[7].value);
		#stored('companyId_7', cp7);
		STRING cp8 := trim(global(request).CompanyIds[8].value);
		#stored('companyId_8', cp8);
		STRING cp9 := trim(global(request).CompanyIds[9].value);
		#stored('companyId_9', cp9);
		STRING cp10 := trim(global(request).CompanyIds[10].value);
		#stored('companyId_10', cp10);
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
	END;
	
	EXPORT SetInputOptions(iesp.deconfliction_audit.t_AuditSearchOptions options) := FUNCTION
		BOOLEAN UseNicknames := global(options).UseNicknames; 
    #STORED ('allownicknames', UseNicknames);
		BOOLEAN UsePhonetics := global(options).UsePhonetics;  
    #STORED ('phoneticmatch', UsePhonetics);
    iesp.ECL2ESP.Marshall.Mac_Set(options);  // sets options: StartingRecord, ReturnCount		
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);		
	END;
	
END;