IMPORT _Control,tools,STD,NAC,FraudGovPlatform,inql_v2, ut;

EXPORT SprayAndQualifyRDP(
	string pversion )
:= FUNCTION
	DateSearch := pVersion[1..8];

	Customer_Settings := FraudGovPlatform.MBS_Mappings(contribution_source = 'RDP' and contribution_gc_id != '');

	billingID_list := SET(Customer_Settings,contribution_billing_id);

	rdp_file := dataset('~foreign::10.173.50.45::thor100_21::in::'+DateSearch+'::sba_acclogs',INQL_v2.layouts.rSBA_In, csv( separator('~~'), terminator(['\n', '\r\n'])));

	RDP_Logs := rdp_file(
			 company_id in billingID_list,
			 function_name = 'VERIFICATION'
		);

	FileSprayed := (string)(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ Customer_Settings[1].Customer_Account_Number + '_' + Customer_Settings[1].Customer_State + '_' + Customer_Settings[1].Customer_Agency_Vertical_Type + '_' + Customer_Settings[1].Customer_Program + '_' + trim(Customer_Settings[1].Contribution_Source) + '_' + DateSearch + '_' + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S')):independent ;
	
	RDP_Sprayed := FraudGovPlatform.Filenames().Sprayed.RDP;
	
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
								, nothor(fileservices.AddSuperfile(RDP_Sprayed,FileSprayed))
							);
	
	RETURN outputwork;							
END;	