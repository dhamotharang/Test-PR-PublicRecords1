IMPORT _Control,tools,STD,NAC,FraudGovPlatform,inql_v2, ut;

EXPORT SprayAndQualifyRDP(
	string pversion )
:= FUNCTION
	DateSearch := ut.date_math(pVersion[1..8], -1);

	RDP_GcIds := FraudGovPlatform.MBS_Mappings(contribution_source = 'RDP' and contribution_gc_id != '');

	billingID_list := SET(RDP_GcIds,contribution_billing_id);

	// rdp_file := dataset('~foreign::10.173.50.45::thor100_21::in::sba_acclogs_processed',INQL_v2.layouts.rSBA_In, csv( separator('~~'), terminator(['\n', '\r\n'])));
	rdp_file := dataset('~foreign::10.173.50.45::thor100_21::in::'+DateSearch+'::sba_acclogs',INQL_v2.layouts.rSBA_In, csv( separator('~~'), terminator(['\n', '\r\n'])));


	RDP_Logs := rdp_file(
			 company_id in billingID_list,
			 function_name = 'VERIFICATION'
			 //(unsigned)STD.Str.FindReplace( STD.Str.FindReplace( date_added,':',''),'-','')[1..8] = (unsigned)DateSearch
		);
			
	fname	:= 'rdp_' + pVersion[1..8];
	FileSprayed := FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname;
	InquiryLogs_Sprayed := FraudGovPlatform.Filenames().Sprayed.RDP;
	
	tools.mac_WriteFile(FileSprayed,
									RDP_Logs,
									Build_Input_File,
									pCompress	:= true,
									pHeading := false,
									pCsvout := true,
									pSeparator := '~~',
									pOverwrite := true,
									pTerminator := '\n',
									pQuote:= '');

	outputwork  := sequential(
								  Build_Input_File
								, fileservices.AddSuperfile(InquiryLogs_Sprayed,FileSprayed)
							);
	
	RETURN outputwork;							
END;	