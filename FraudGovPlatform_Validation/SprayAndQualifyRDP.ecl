IMPORT _Control,tools,STD,FraudGovPlatform, ut,inquiry_acclogs, Data_Services;

EXPORT SprayAndQualifyRDP( STRING pVersion )
 := FUNCTION

	DateSearch := pVersion[1..8];

	sf := FraudGovPlatform.Filenames().Sprayed.RDP;

	Customer_Settings := FraudGovPlatform.MBS_Mappings(contribution_source = 'RDP' and contribution_gc_id != '');
	billingID_list := SET(Customer_Settings,contribution_billing_id);

	fname :=  (string)(Customer_Settings[1].contribution_gc_id + '_' + 
		Customer_Settings[1].Customer_State + '_' + 
		Customer_Settings[1].Customer_Agency_Vertical_Type + '_' + 
		Customer_Settings[1].Customer_Program + '_' + 
		trim(Customer_Settings[1].Contribution_Source) + '_' + 
		DateSearch + '_' + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S') +
		'.dat') ;
	
	FileSprayed := FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ fname: independent;

	sba_logs := dataset(
			Data_Services.foreign_logs +'thor100_21::in::'+DateSearch+'::sba_acclogs' , 
			inquiry_acclogs.Layout_SBA_logs.input_raw, 
			csv(quote(''), separator(['~~']), terminator(['\n'])), 
			opt);

	rdp_logs := sba_logs(company_id in billingID_list and function_name='AUTHENTICATION');

	Build_Input_File := output(rdp_logs, , FileSprayed, compressed, overwrite );

	outputwork := 	
		sequential(		
					Build_Input_File,
					fileservices.AddSuperfile(sf,FileSprayed ));


	RETURN outputwork;

END;	