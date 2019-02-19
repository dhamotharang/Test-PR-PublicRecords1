import _control, PromoteSupers, Roxiekeybuild, Std, ut;

EXPORT Proc_Build_Lerg6_Key(string version, const varstring eclsourceip, string thor_name) := FUNCTION

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Spray Input File///////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		sprayDaily 				:= PhonesInfo.Spray_Lerg_In(version, eclsourceip, 'lerg6', thor_name);
		
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Lerg6 History File//////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//Project File to Maintain Filenames
		dsCCdaily 				:= project(distribute(PhonesInfo.File_Lerg.Lerg6), PhonesInfo.Layout_Lerg.lerg6Hist);
		
		//Concat Daily File with History File
		concatRawHistory	:= output(dedup(sort(distribute(dsCCdaily + PhonesInfo.File_Lerg.Lerg6Hist, hash(ocn)), record, local), record, local),,'~thor_data400::in::phones::lerg6_history_'+version,__compressed__);
		
		//Clear Delete Files
		clearDelete 			:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::lerg6_main_delete', true)),
																		nothor(fileservices.clearsuperfile('~thor_data400::in::phones::lerg6_history_delete', true))
																		);	
																				
		//Move to Latest Superfile	
		moveRawHistory		:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::lerg6_history',
																												'~thor_data400::in::phones::lerg6_history_father',
																												'~thor_data400::in::phones::lerg6_history_grandfather',
																												'~thor_data400::in::phones::lerg6_history_delete'], '~thor_data400::in::phones::lerg6_history_'+version, true);						

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Build Lerg6 Base///////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////

		//Build Base File
		buildMain					:= output(PhonesInfo.Map_Lerg6,,'~thor_data400::base::phones::lerg6_main_'+version, __compressed__);
																 
		//Move Base Into Superfile	
		moveMain					:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::lerg6_main',
																												'~thor_data400::base::phones::lerg6_main_father',
																												'~thor_data400::base::phones::lerg6_main_grandfather',
																												'~thor_data400::base::phones::lerg6_main_delete'], '~thor_data400::base::phones::lerg6_main_'+version, true);																						
					
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Build Lerg6 Key////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		//Create Lerg6 Key
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhonesInfo.Key_Phones_Lerg6
																							 ,'~thor_data400::key::phones_lerg6'
																							 ,'~thor_data400::key::'+version+'::phones_lerg6'
																							 ,bkPhonesLerg6
																							 );	

		//Move Lerg6 Key to Built Superfile	
		Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phones_lerg6'
																					,'~thor_data400::key::'+version+'::phones_lerg6'
																					,mvBltPhonesLerg6
																					);
		
		//Move Lerg6 Key to QA Superfile
		PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phones_lerg6','Q',mvQAPhonesLerg6,'4');	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Email Build Notices////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		emailNotice 			:= if(count(PhonesInfo.File_Lerg.Lerg6Main(ocn<>''))>0
																	,fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'Phones Info: Lerg6 Key', 'An updated Lerg6 key is now available.')
																	,fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'Phones Info: No Updated Lerg6 Key', 'There was no Lerg6 key update in this build.')
																	);	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Run Build//////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
																	
	RETURN sequential(
									//Spray File
										sprayDaily,
									//Create History File
										concatRawHistory,
										clearDelete,
										moveRawHistory,
									//Build Base
										buildMain,
										moveMain,
									//Build Key
										bkPhonesLerg6,
										mvBltPhonesLerg6,
										mvQAPhonesLerg6,
									//Send Email Notice	
										emailNotice
										);
	
END;