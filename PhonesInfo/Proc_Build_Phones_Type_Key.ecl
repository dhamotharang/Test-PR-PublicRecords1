IMPORT _control, Dops, Doxie, dx_PhonesInfo, PromoteSupers, RoxieKeyBuild, Std, Ut, Orbit3;

	//DF-24397: Create Dx-Prefixed Keys
	
EXPORT Proc_Build_Phones_Type_Key(string version):= function

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Create Phones Type Base File///////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildComBase	:= output(PhonesInfo.Map_Phones_Type_main,,'~thor_data400::base::phones::phones_type_main_'+version, overwrite, __compressed__);

	//Clear Phones Type Base Delete Superfile
	clearDelete 	:= nothor(Fileservices.ClearSuperfile('~thor_data400::base::phones::phones_type_main_delete', true));		

	//Move Phones Type Base Logical File to Appropriate Superfile
	moveComBase		:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::phones_type_main',
																									'~thor_data400::base::phones::phones_type_main_father',
																									'~thor_data400::base::phones::phones_type_main_grandfather',
																									'~thor_data400::base::phones::phones_type_main_great_grandfather',
																									'~thor_data400::base::phones::phones_type_main_delete'], '~thor_data400::base::phones::phones_type_main_'+version, true);																						

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Build Phones Type Key//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhonesInfo.Key_Phones_Type
																							,PhonesInfo.File_Phones_Type.Main
																							,'~thor_data400::key::phones_type'
																							,'~thor_data400::key::'+version+'::phones_type'
																							,bkPhonesTransaction
																							);	

	//Move Phones Type to Built Superfile	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phones_type'
																					,'~thor_data400::key::'+version+'::phones_type'
																					,mvBltPhonesTransaction
																					);
	
	//Move Phones Type to QA Superfile
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phones_type','Q',mvQAPhonesTransaction,'4');																 
															
/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Build & Send Notification Emails///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	sendEmail		:= sequential(buildComBase,
														clearDelete, 
														moveComBase,
														bkPhonesTransaction, mvBltPhonesTransaction, mvQAPhonesTransaction):
														Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'PhonesInfo Phone Type Key Build Succeeded', workunit + ': Build complete.')),
														Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'PhonesInfo Phone Type Key Build Failed', workunit + '\n' + FAILMESSAGE)
														);
	return sendEmail;														

END;