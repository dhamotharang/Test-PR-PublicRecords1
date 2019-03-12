import _control, Dops, Doxie, PromoteSupers, RoxieKeyBuild, Std, Ut, Orbit3;

EXPORT Proc_Build_Transaction_Key(string version):= function

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Create Transaction Base File///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	buildComBase	:= output(PhonesInfo.Map_Phones_Transaction_Main,,'~thor_data400::base::phones::transaction_main_'+version, overwrite, __compressed__);

	//Clear Transaction Base Delete Superfile
	clearDelete 	:= nothor(Fileservices.ClearSuperfile('~thor_data400::base::phones::transaction_main_delete', true));		

	//Move Transaction Base Logical File to Appropriate Superfile
	moveComBase		:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::transaction_main',
																									'~thor_data400::base::phones::transaction_main_father',
																									'~thor_data400::base::phones::transaction_main_grandfather',
																									'~thor_data400::base::phones::transaction_main_great_grandfather',
																									'~thor_data400::base::phones::transaction_main_delete'], '~thor_data400::base::phones::transaction_main_'+version, true);																						

/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Build Transaction Key//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PhonesInfo.Key_Phones_Transaction
																							,'~thor_data400::key::phones_transaction'
																							,'~thor_data400::key::'+version+'::phones_transaction'
																							,bkPhonesTransaction
																							);	

	//Move Transaction Key to Built Superfile	
	Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phones_transaction'
																							,'~thor_data400::key::'+version+'::phones_transaction'
																							,mvBltPhonesTransaction
																							);
	
	//Move Transaction Key to QA Superfile
	PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::phones_transaction','Q',mvQAPhonesTransaction,'4');																 
															
/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Build & Send Notification Emails///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	sendEmail		:= sequential(buildComBase,
														clearDelete, 
														moveComBase,
														bkPhonesTransaction, mvBltPhonesTransaction, mvQAPhonesTransaction):
														Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'PhonesInfo Transaction Key Build Succeeded', workunit + ': Build complete.')),
														Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' /*+ ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com'*/, 'PhonesInfo Transaction Key Build Failed', workunit + '\n' + FAILMESSAGE));
	return sendEmail;														

END;