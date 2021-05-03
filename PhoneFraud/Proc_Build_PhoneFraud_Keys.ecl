IMPORT _control, Doxie, PromoteSupers, RoxieKeyBuild, std, ut,Scrubs_PhoneFraud, Orbit3, dx_PhoneFraud;

//oType: populate 'otp', if file is available 'Y', else 'N'
//sType: populate 'spoofing', if file is available 'Y', else 'N'

EXPORT Proc_Build_PhoneFraud_Keys(string version, string oType, string sType):= FUNCTION

	//#workunit('name', 'Yogurt:Phone Fraud Build - ' + version);
	//#workunit('priority','high');
	
    day_of_week := ut.Weekday((integer)version);
    updateType := if( day_of_week = 'MONDAY', 'F', 'D'); //F is for full ie monday, D is for delta which runs on all other days

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
		
        ////// old code
            /* pickOTPBase			:= if(ctOTPRaw>0,
                                                        PhoneFraud.Mapping_Common_OTP(version),
                                                        PhoneFraud.File_OTP.Base); */
        //////
        pickOTPBase			:= PhoneFraud.Mapping_Common_OTP(version); //creating empty delta base file is equivalent to doing the above in a non-delta build
		
		bldOTPBase 			:= output(
                                    if(updateType = 'D',
                                        pickOTPBase,
                                        pickOTPBase+PhoneFraud.File_OTP.Base
                                        ),
                                    ,'~thor_data400::base::phonefraud_OTP_'+version, __compressed__); 

		clrOTPDelete		:= nothor(fileservices.clearsuperfile('~thor_data400::base::phonefraud_otp_delete', true));		

        deltaUpdateOTPBase := fileservices.addsuperfile('~thor_data400::base::phonefraud_otp', '~thor_data400::base::phonefraud_OTP_'+version);

		mvOTPBase				:= STD.File.PromoteSuperFileList(['~thor_data400::base::phonefraud_otp',
																											'~thor_data400::base::phonefraud_otp_father',
																											'~thor_data400::base::phonefraud_otp_grandfather',
																											'~thor_data400::base::phonefraud_otp_delete'], '~thor_data400::base::phonefraud_otp_'+version, true);																				
		
		//Spoofing - If daily file available, continue processing else use previous day's base file.	
		ctSpoofRaw			:= count(PhoneFraud.File_Spoofing.Raw);
		
        ////// old code
            /* pickSpoofBase		:= if(ctSpoofRaw>0,
                                                        PhoneFraud.Mapping_Common_Spoofing(version),
                                                        PhoneFraud.File_Spoofing.Base); */
        //////

		pickSpoofBase		:= PhoneFraud.Mapping_Common_Spoofing(version); //creating empty delta base file is equivalent to doing the above in a non-delta build

		bldSpoofBase 		:= output(
                                    if(updateType = 'D',
                                        pickSpoofBase,
                                        pickSpoofBase+PhoneFraud.File_Spoofing.Base
                                        )
                                    ,,'~thor_data400::base::phonefraud_spoofing_'+version, __compressed__); 

		clrSpoofDelete	:= nothor(fileservices.clearsuperfile('~thor_data400::base::phonefraud_spoofing_delete', true));		

        deltaUpdateSpoofBase := fileservices.addsuperfile('~thor_data400::base::phonefraud_spoofing', '~thor_data400::base::phonefraud_spoofing_'+version);

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
        Base_otp := project(dataset('~thor_data400::base::phonefraud_OTP_'+version, PhoneFraud.Layout_OTP.Base,flat), PhoneFraud.Layout_OTP.Base-date_file_loaded);
        RoxieKeybuild.MAC_build_logical(dx_PhoneFraud.key_otp,Base_otp,dx_PhoneFraud.names.otp,'~thor_data400::key::'+version+'::phonefraud_otp',bkPhoneFraudOTP);

        Base_spoofing := project(dataset('~thor_data400::base::phonefraud_SPOOFING_'+version, PhoneFraud.Layout_Spoofing.Base,flat), PhoneFraud.Layout_Spoofing.Base - date_file_loaded);
        RoxieKeybuild.MAC_build_logical(dx_PhoneFraud.key_spoofing,Base_spoofing,dx_PhoneFraud.names.spoofing,'~thor_data400::key::'+version+'::phonefraud_spoofing',bkPhoneFraudSpoofing);

																								
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Move Common PhoneFraud Keys to Superfiles//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        dmvBltPhoneFraudOTP := fileservices.addsuperfile('~thor_data400::key::phonefraud_otp_qa', '~thor_data400::key::'+version+'::phonefraud_otp');
        dmvBltPhoneFraudSpoofing := fileservices.addsuperfile('~thor_data400::key::phonefraud_spoofing_qa', '~thor_data400::key::'+version+'::phonefraud_spoofing');


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

		dopsUpdate 			:= Roxiekeybuild.updateversion('PhoneFraudKeys', version, 'Christopher.Brodeur@lexisnexisrisk.com, CHERRY.AUSTERO@lexisnexisrisk.com, Judy.Tao@lexisnexisrisk.com', , 'N' ,,,,,, updatetype);

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
																	bldOTPBase,
                                                                    if(updateType = 'D',
                                                                        deltaUpdateOTPBase,
                                                                        sequential(clrOTPDelete, mvOTPBase)
                                                                        ),
																	bldSpoofBase, 
                                                                    if(updateType = 'D',
                                                                        deltaUpdateSpoofBase,
                                                                        sequential(clrSpoofDelete, mvSpoofBase)
                                                                        ),
																	catOTPHistory, mvOTPHistory,
																	catSpoofHistory, mvSpoofHistory,
																	bkPhoneFraudOTP,
																	bkPhoneFraudSpoofing,  
                                                                    if(updateType = 'D',
                                                                        parallel(
                                                                            dmvBltPhoneFraudOTP,
                                                                            dmvBltPhoneFraudSpoofing
                                                                            ),
																	    parallel(
                                                                            sequential(
                                                                                mvBltPhoneFraudOTP,
                                                                                mvQAPhoneFraudOTP
                                                                                ),
                                                                            sequential(
                                                                                mvBltPhoneFraudSpoofing,
                                                                                mvQAPhoneFraudSpoofing
                                                                                )    
                                                                            )
                                                                        ), 																
														 			dopsUpdate,
																	create_phonefraud_build,
																	buildStrata,
																	Scrubs_PhoneFraud.fn_RunScrubs(version,'Judy.Tao@lexisnexis.com')):
																	Success(FileServices.SendEmail('Judy.Tao@lexisnexisrisk.com;Christopher.Brodeur@lexisnexisrisk.com;CHERRY.AUSTERO@lexisnexisrisk.com', 'PhoneFraud Key Build Succeeded', workunit + ': Build completed.')),
																	Failure(FileServices.SendEmail('Judy.Tao@lexisnexisrisk.com;Christopher.Brodeur@lexisnexisrisk.com;CHERRY.AUSTERO@lexisnexisrisk.com', 'PhoneFraud Key Build Failed', workunit + '\n' + FAILMESSAGE)
																	);

	RETURN sendEmail;

END;