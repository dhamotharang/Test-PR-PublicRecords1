IMPORT dx_Phone_TCPA, Phone_TCPA, RoxieKeyBuild;

EXPORT Proc_TCPA_Phone_Key(boolean isFCRA = false, string pVersion = ''):= FUNCTION

	unsigned fcraFlag 		:= if(isFCRA, 1, 0);
		
	//Phone History Key//////////////////////////////////////////////////////
	historyKeyFile				:= project(Phone_TCPA.File_TCPA_Phone.Main,
																		transform({dx_Phone_TCPA.Layout.i_tcpa_phone_history},
																							self.phone 				:= left.expand_phone;
																							self 							:= left));	
		
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(	dx_Phone_TCPA.Key_TCPA_Phone_History(fcraFlag)										//Key
																							,historyKeyFile																										//Dataset File
																							,dx_Phone_TCPA.names(fcraFlag).i_tcpa_phone_history								//Superfile Key
																							,Phone_TCPA.Keynames(isfcra, pVersion).tcpa_phone_history.New	//Logical Key File
																							,keybldHistory);	
																							
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Phone_TCPA.Keynames(isfcra, pVersion).tcpa_phone_history_template, 
																				Phone_TCPA.Keynames(isfcra, pVersion).tcpa_phone_history.New,  
																				mvPhoneHistBuilt);
	
	RoxieKeyBuild.Mac_SK_Move_v2(Phone_TCPA.Keynames(isfcra, pVersion).tcpa_phone_history_template, 'Q', mvPhoneHistKey);
	
	/////////////////////////////////////////////////////////////////////////
	//Build Keys/////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////

	RETURN SEQUENTIAL( keybldHistory, mvPhoneHistBuilt, mvPhoneHistKey
										);

END;