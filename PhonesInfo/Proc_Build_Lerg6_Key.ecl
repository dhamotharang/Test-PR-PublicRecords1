import _control, PromoteSupers, Roxiekeybuild, Std, ut;

EXPORT Proc_Build_Lerg6_Key(string version) := FUNCTION

	//DF-24166: Split Lerg6 Build

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
									//Build Key
										bkPhonesLerg6,
										mvBltPhonesLerg6,
										mvQAPhonesLerg6,
									//Send Email Notice	
										emailNotice
										);
	
END;