IMPORT _control, Doxie, PromoteSupers, RoxieKeyBuild, std, ut,Scrubs_PhoneFraud, Orbit3;

//oType: populate 'otp', if file is available 'Y', else 'N'
//sType: populate 'spoofing', if file is available 'Y', else 'N'

EXPORT Proc_Build_PhoneFraud_Keys(string version, string oType, string sType):= FUNCTION

	#workunit('name', 'Yogurt:Phone Fraud Build - ' + version);
	#workunit('priority','high');
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Spray OTP/Spoofing Files to Thor///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		sprayOTP				:= if(stringlib.stringtouppercase(trim(oType, left, right)[1]) = 'Y',
														PhoneFraud.Spray_PhoneFraud(version, 'otp'),
													if(stringlib.stringtouppercase(trim(oType, left, right)[1]) = 'N',
														PhoneFraud.Empty_PhoneFraud(version, 'otp'),
														output('error_otp')));
														
		spraySpoof			:= if(stringlib.stringtouppercase(trim(sType, left, right)[1]) = 'Y',
														PhoneFraud.Spray_PhoneFraud(version, 'spoofing'),
													if(stringlib.stringtouppercase(trim(sType, left, right)[1]) = 'N',
														PhoneFraud.Empty_PhoneFraud(version, 'spoofing'),
														output('error_spoofing')));
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Common PhoneFraud Base//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//OTP	- If daily file available, continue processing else use previous day's base file.
		ctOTPRaw				:= count(PhoneFraud.File_OTP.Raw);
		
		pickOTPBase			:= if(ctOTPRaw>0,
													PhoneFraud.Mapping_Common_OTP(version),
													PhoneFraud.File_OTP.Base);
		
		bldOTPBase 			:= output(pickOTPBase,,'~thor_data400::base::phonefraud_OTP_'+version, __compressed__); 

		clrOTPDelete		:= nothor(fileservices.clearsuperfile('~thor_data400::base::phonefraud_otp_delete', true));		

		mvOTPBase				:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefraud_otp',
																											'~thor_data400::base::phonefraud_otp_father',
																											'~thor_data400::base::phonefraud_otp_grandfather',
																											'~thor_data400::base::phonefraud_otp_delete'], '~thor_data400::base::phonefraud_otp_'+version, true);																				
		
		//Spoofing - If daily file available, continue processing else use previous day's base file.	
		ctSpoofRaw			:= count(PhoneFraud.File_Spoofing.Raw);
		
		pickSpoofBase		:= if(ctSpoofRaw>0,
													PhoneFraud.Mapping_Common_Spoofing(version),
													PhoneFraud.File_Spoofing.Base);
		
		bldSpoofBase 		:= output(pickSpoofBase,,'~thor_data400::base::phonefraud_spoofing_'+version, __compressed__); 

		clrSpoofDelete	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phonefraud_spoofing_delete', true));		

		mvSpoofBase			:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefraud_spoofing',
																											'~thor_data400::base::phonefraud_spoofing_father',
																											'~thor_data400::base::phonefraud_spoofing_grandfather',
																											'~thor_data400::base::phonefraud_spoofing_delete'], '~thor_data400::base::phonefraud_spoofing_'+version, true);																						
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build/Move Raw PhoneFraud History Files////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//OTP - If daily file available, continue processing else use previous day's base file.
		pickOTPHistory	:= if(ctOTPRaw>0,
													PhoneFraud.File_OTP.Raw + PhoneFraud.File_OTP.History,
													PhoneFraud.File_OTP.History);
													
		catOTPHistory		:= output(dedup(sort(distribute(pickOTPHistory, hash(otp_phone)), record, local), record, local),,'~thor_data400::in::phonefraud_otp_history_'+version,__compressed__);
		
		mvOTPHistory		:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefraud_otp_history',
																											'~thor_data400::in::phonefraud_otp_history_father',
																											'~thor_data400::in::phonefraud_otp_history_grandfather',
																											'~thor_data400::in::phonefraud_otp_history_delete'], '~thor_data400::in::phonefraud_otp_history_'+version, true);	
		
		//Spoofing - If daily file available, continue processing else use previous day's base file.
		pickSpoofHistory:= if(ctSpoofRaw>0,
													PhoneFraud.File_Spoofing.Raw + PhoneFraud.File_Spoofing.History,
													PhoneFraud.File_Spoofing.History);
													
		catSpoofHistory	:= output(dedup(sort(distribute(pickSpoofHistory, hash(spoofed_phone_number)), record, local), record, local),,'~thor_data400::in::phonefraud_spoofing_history_'+version,__compressed__);
		
		mvSpoofHistory	:= STD.File.PromoteSuperFileList(['~thor_data400::in::phonefraud_spoofing_history',
																											'~thor_data400::in::phonefraud_spoofing_history_father',
																											'~thor_data400::in::phonefraud_spoofing_history_grandfather',
																											'~thor_data400::in::phonefraud_spoofing_history_delete'], '~thor_data400::in::phonefraud_spoofing_history_'+version, true);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Common PhoneFraud Keys///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhoneFraud.Key_OTP
																								,'~thor_data400::key::phonefraud_otp'
																								,'~thor_data400::key::'+version+'::phonefraud_otp'
																								,bkPhoneFraudOTP
																								);
		
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhoneFraud.Key_Spoofing
																								,'~thor_data400::key::phonefraud_spoofing'
																								,'~thor_data400::key::'+version+'::phonefraud_spoofing'
																								,bkPhoneFraudSpoofing
																								);	
																								
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Move Common PhoneFraud Keys to Superfiles//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonefraud_otp'
																								,'~thor_data400::key::'+version+'::phonefraud_otp'
																								,mvBltPhoneFraudOTP
																								);
		
		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonefraud_spoofing'
																								,'~thor_data400::key::'+version+'::phonefraud_spoofing'
																								,mvBltPhoneFraudSpoofing
																								);

		PromoteSupers.mac_sk_move_v2('~thor_data400::key::phonefraud_otp',		 'Q',	mvQAPhoneFraudOTP);
		PromoteSupers.mac_sk_move_v2('~thor_data400::key::phonefraud_spoofing','Q',	mvQAPhoneFraudSpoofing);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Update DOPs Page///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		dopsUpdate 			:= Roxiekeybuild.updateversion('PhoneFraudKeys', version, _control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com', , 'N');
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Build Strata Reports for Build/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		PhoneFraud.Out_Strata_Population_Stats(PhoneFraud.File_OTP.Base
																						,PhoneFraud.File_Spoofing.Base
																						,version
																						,buildStrata);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Create Orbit Entry for Build/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	create_phonefraud_build:=	IF(	ut.Weekday((INTEGER)version[1..8]) NOT IN ['SATURDAY','SUNDAY'],
																Orbit3.proc_Orbit3_CreateBuild ('PhoneFraud',version,'N'),
																OUTPUT('No Orbit Entry Needed for Saturday and Sunday'));
																
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Run Build & Provide Email on Build Status//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		sendEmail				:= sequential(sprayOTP, spraySpoof,
																	bldOTPBase, clrOTPDelete, mvOTPBase,
																	bldSpoofBase, clrSpoofDelete, mvSpoofBase,
																	catOTPHistory, mvOTPHistory,
																	catSpoofHistory, mvSpoofHistory,
																	bkPhoneFraudOTP, 
																	bkPhoneFraudSpoofing,  
																	mvBltPhoneFraudOTP, 
																	mvBltPhoneFraudSpoofing,
																	mvQAPhoneFraudOTP, 
																	mvQAPhoneFraudSpoofing,
																	dopsUpdate,
																	create_phonefraud_build,
																	buildStrata,
																	Scrubs_PhoneFraud.fn_RunScrubs(version,'Judy.Tao@lexisnexis.com')):
																	Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com;christopher.brodeur@lexisnexisrisk.com;charles.pettola@lexisnexisrisk.com;intel357@bellsouth.net', 'PhoneFraud Key Build Succeeded', workunit + ': Build completed.')),
																	Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexis.com;christopher.brodeur@lexisnexisrisk.com;charles.pettola@lexisnexisrisk.com;intel357@bellsouth.net', 'PhoneFraud Key Build Failed', workunit + '\n' + FAILMESSAGE)
																	);

	RETURN sendEmail;

END;