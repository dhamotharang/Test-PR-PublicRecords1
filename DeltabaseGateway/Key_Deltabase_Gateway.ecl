IMPORT Data_Services, Doxie;

EXPORT Key_Deltabase_Gateway := MODULE

	//Pull records that are not from AT&T or are otherwise "bad"
	inFile := project(DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Base, DeltabaseGateway.Layout_Deltabase_Gateway.Historic_Results_Base-date_file_loaded)(source not in ['ATT_DQ_IRS'] or stringlib.stringfind(device_mgmt_status, 'BAD', 1)<>0);

	export Historic_Results			:= index(inFile
																			,{submitted_phonenumber, transaction_id, batch_job_id, sequence_number}
																			,{inFile}
																			,'~thor_data400::key::deltabase_gateway::historic_results_'+doxie.Version_SuperKey);

END;
