IMPORT _control, Doxie, PromoteSupers, RoxieKeyBuild, std, ut;

EXPORT Proc_Build_Deltabase_Gateway(string version, const varstring eclsourceip, string thor_name):= FUNCTION

	#workunit('name', 'Deltabase Gateway Build - ' + version);
	#workunit('priority','high');
	#OPTION('multiplePersistInstances',FALSE);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Spray Delta Gateway Files to Thor//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		sprayDltGwy				:= DeltabaseGateway.Spray_Deltabase_Gateway(version, eclsourceip, thor_name);
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Common PhonesInfo Base//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		bldDltGwyBase 		:= output(DeltabaseGateway.Map_Deltabase_Gateway(version),,'~thor_data400::base::deltabase_gateway::historic_results_'+version, __compressed__); 

		clrDltGwyDelete		:= nothor(fileservices.clearsuperfile('~thor_data400::base::deltabase_gateway::historic_results_delete', true));		

		mvDltGwyBase			:= STD.File.PromoteSuperFileList(['~thor_data400::base::deltabase_gateway::historic_results',
																												'~thor_data400::base::deltabase_gateway::historic_results_father',
																												'~thor_data400::base::deltabase_gateway::historic_results_grandfather',
																												'~thor_data400::base::deltabase_gateway::historic_results_great_grandfather',
																												'~thor_data400::base::deltabase_gateway::historic_results_delete'], '~thor_data400::base::deltabase_gateway::historic_results_'+version, true);																				
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Raw PhonesInfo History Files////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		ctDltGwyRaw				:= count(DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Raw);
	
		//DltGwy - If daily file available, continue processing else use previous day's base file.
		pickDltGwyHistory	:= if(ctDltGwyRaw>0,
														DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Raw + DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_History,
														DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_History);
													
		catDltGwyHistory	:= output(dedup(sort(distribute(pickDltGwyHistory, hash(submitted_PhoneNumber)), record, local), record, local),,'~thor_data400::in::deltabase_gateway::historic_results_history_'+version,__compressed__);
		
		mvDltGwyHistory		:= STD.File.PromoteSuperFileList(['~thor_data400::in::deltabase_gateway::historic_results_history',
																												'~thor_data400::in::deltabase_gateway::historic_results_history_father',
																												'~thor_data400::in::deltabase_gateway::historic_results_history_grandfather',
																												'~thor_data400::in::deltabase_gateway::historic_results_history_great_grandfather',
																												'~thor_data400::in::deltabase_gateway::historic_results_history_delete'], '~thor_data400::in::deltabase_gateway::historic_results_history_'+version, true);	
		
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Common PhonesInfo Keys///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DeltabaseGateway.Key_Deltabase_Gateway.Historic_Results
																								,'~thor_data400::key::deltabase_gateway::historic_results'
																								,'~thor_data400::key::'+version+'::deltabase_gateway::historic_results'
																								,bkDltGwy
																								);

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Move Delta Gateway Keys to Superfiles//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::deltabase_gateway::historic_results'
																					 ,'~thor_data400::key::'+version+'::deltabase_gateway::historic_results'
																					 ,mvBltDltGwy
																					 );

		PromoteSupers.mac_sk_move_v2('~thor_data400::key::deltabase_gateway::historic_results', 'Q',	mvQADltGwy, '4');

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Update DOPs Page///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		dopsUpdate 			:= Roxiekeybuild.updateversion('Deltabase Gateway', version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', , 'N');
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Strata Reports for Build/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		DeltabaseGateway.Out_Strata_Population_Stats(DeltabaseGateway.File_Deltabase_Gateway.Historic_Results_Base
																									,version
																									,buildStrata);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Run Build & Provide Email on Build Status//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		sendEmail				:= sequential(sprayDltGwy, 
																	bldDltGwyBase, clrDltGwyDelete, mvDltGwyBase,
																	catDltGwyHistory, mvDltGwyHistory
																	//Only AT&T LIDB Deltabase is going to Prod for now; These records will be populated in the Phones Metadata Key
																	//Keybuild, Strata, and Scrubs will be updated, once the other sources go live.
																	/*bkDltGwy 
																	mvBltDltGwy, 
																	mvQADltGwy, 
																	dopsUpdate,
																	buildStrata*/):
																	Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', 'Deltabase Gateway Key Build Succeeded', workunit + ': Build completed.')),
																	Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', 'Deltabase Gateway Build Failed', workunit + '\n' + FAILMESSAGE)
																	);

	RETURN sendEmail;

END;