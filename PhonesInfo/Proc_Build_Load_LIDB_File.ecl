import _control, Doxie, RoxieKeyBuild, Std, Ut;

EXPORT Proc_Build_Load_LIDB_File(string version, const varstring eclsourceip, string thor_name) := function

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Use LIDB Response File to Create Reference Table/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Spray Response File to Thor
	sprayRespFile		:= PhonesInfo.Spray_LIDB_Response(version, eclsourceip, thor_name);
	
	//Join Response File to Reference Table
	joinRefRespMain	:= output(PhonesInfo.Map_LIDB_Reference_Main(version),, '~thor_data400::base::phones::lidb_reference_'+version, __compressed__);
	
	//Move Reference Table
	clearDelete 		:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::lidb_reference_delete', true));		
	
	moveRefMain			:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::lidb_reference',
																										'~thor_data400::base::phones::lidb_reference_father',
																										'~thor_data400::base::phones::lidb_reference_grandfather',
																										'~thor_data400::base::phones::lidb_reference_delete'], '~thor_data400::base::phones::lidb_reference_'+version, true);																						
	
	//Run Build & Provide Email on Build Status
	sendEmail				:= sequential(sprayRespFile, clearDelete, joinRefRespMain, moveRefMain):
																Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Response Load Build Succeeded', workunit + ': Build complete.  Response file sprayed.')),
																Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Response Load Build Failed', workunit + '\n' + FAILMESSAGE)
																);
	
	return sendEmail;

end;