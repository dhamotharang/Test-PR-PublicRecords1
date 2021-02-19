IMPORT _control, Dops, Doxie, dx_PhonesInfo, PromoteSupers, RoxieKeyBuild, Scrubs_PhonesInfo, Std, Ut, Orbit3;

//DF-24397: Create Dx-Prefixed Keys

EXPORT Proc_Build_Transaction_Key(string version, string contacts):= function

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
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhonesInfo.Key_Phones_Transaction
																							,PhonesInfo.File_Phones_Transaction.Main	
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
//Run Scrub Reports//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////																				 
	scrubsRun		:= sequential(Scrubs_PhonesInfo.RawFileScrubs(version, contacts), 
														Scrubs_PhonesInfo.PostBuildScrubs(version, contacts)
														);
															
/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Run Build & Send Notification Emails///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	sendEmail		:= sequential(buildComBase,
														clearDelete, 
														moveComBase,
														bkPhonesTransaction, mvBltPhonesTransaction, mvQAPhonesTransaction,
														scrubsRun):
														Success(FileServices.SendEmail(contacts, 'PhonesInfo Transaction Key Build Succeeded', workunit + ': Build complete.')),
														Failure(FileServices.SendEmail(contacts, 'PhonesInfo Transaction Key Build Failed', workunit + '\n' + FAILMESSAGE));
	return sendEmail;														

END;