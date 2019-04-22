IMPORT _Control,tools,STD,NAC,FraudGovPlatform,inql_v2, ut;

EXPORT SprayAndQualifyInquiryLogs(
	string pversion )
:= FUNCTION
	// DateSearch := ut.date_math(pVersion[1..8], -1);
	DateSearch := pVersion[1..8];


	RDP_GcIds := FraudGovPlatform.MBS_Mappings(contribution_source = 'RDP' and contribution_gc_id != '');

	gcid_list := SET(RDP_GcIds,contribution_gc_id);


	// inquiry_logs:=	inql_v2.Files().Inql_base.qa;
	inquiry_logs := dataset('~uspr::inql::nonfcra::base::daily::qa', INQL_v2.Layouts.Common_ThorAdditions, thor, opt);
	IDM_Logs := inquiry_logs(
			 mbs.global_company_id in gcid_list 
			, search_info.function_description<>'' 
			// , Search_info.datetime[1..8] = ut.date_math(ut.GetDate,-2)	
			, Search_info.datetime[1..8] = DateSearch
			, regexfind('gov',bus_intel.vertical,nocase)
			,~regexfind('test',search_info.transaction_type,nocase)
			,~regexfind('test',bus_intel.industry,nocase)
			,~regexfind('test',bus_intel.sub_market,nocase)
		);
			
	fname	:= 'inquirylogs_' + DateSearch;
	FileSprayed := FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
	InquiryLogs_Sprayed := FraudGovPlatform.Filenames().Sprayed.InquiryLogs;
	
	tools.mac_WriteFile(FileSprayed,
									IDM_Logs,
									Build_Input_File,
									pCompress	:= true,
									pHeading := false,
									pCsvout := true,
									pSeparator := '~|~',
									pOverwrite := true,
									pTerminator := '~<EOL>~',
									pQuote:= '');

	outputwork  := sequential(
								  Build_Input_File
								, fileservices.AddSuperfile(InquiryLogs_Sprayed,FileSprayed)
							);
	
	RETURN outputwork;							
END;	