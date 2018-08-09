IMPORT _Control,tools,STD,NAC,FraudGovPlatform,inquiry_acclogs, ut;

EXPORT SprayAndQualifyInquiryLogs(
	string pversion )
:= FUNCTION

	gcid_list := [ '80541', '125561', '284901', '285221', '290481', '308761', '320001', '327931', '328661', '346851', '369481'
								,'372021', '423111', '472921', '552381', '553271', '783831', '784031', '784071', '784501', '901151','950261'
								, '980871', '1072341', '1077221', '1079201', '1082841', '1084121', '1092341', '1097091', '1119871', '6517246'
								, '7182104', '8224952', '8269431', '8272321', '8328222','8375682', '8532882', '8552852', '8553792', '9233831'
								, '18411162', '19559842','19904052', '20384742', '20719102'];
		
	inquiry_logs:=	inquiry_acclogs.File_Accurint_Logs_Common +
							inquiry_acclogs.File_Custom_Logs_Common +
							inquiry_acclogs.File_Banko_Logs_Common +
							inquiry_acclogs.File_Riskwise_Logs_Common +
							Inquiry_AccLogs.File_Batch_Logs_Common +
							Inquiry_AccLogs.File_Bridger_Logs_Common +
							Inquiry_AccLogs.File_IDM_Logs_Common +
							Inquiry_AccLogs.File_BatchR3_Logs_Common;


	IDM_Logs := inquiry_logs(
			 mbs.global_company_id in gcid_list 
			, search_info.function_description<>'' 
			, Search_info.datetime[1..8] >= ut.date_math(ut.GetDate,-2)	
			, regexfind('gov',bus_intel.vertical,nocase)
			,~regexfind('test',search_info.transaction_type,nocase)
			,~regexfind('test',bus_intel.industry,nocase)
			,~regexfind('test',bus_intel.sub_market,nocase)
		);
			
	fname	:= 'inquirylogs_' + pversion;
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