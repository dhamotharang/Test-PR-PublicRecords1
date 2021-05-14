IMPORT std;

//Previous Port Build Before the iConectiv PortData Validate Change  
EXPORT Proc_Build_Historical_Port_File(string version, const varstring eclsourceip, string thor_name):= FUNCTION
	
	//Generate Common Port File (Current + Historical Sources)
	buildBase							:= output(PhonesInfo.Map_Combined_Port_Full,,'~thor_data400::base::phones::iconectiv_main_'+version,overwrite,__compressed__);
													 
	clearDelete 					:= sequential(nothor(fileservices.clearsuperfile('~thor_data400::base::phones::iconectiv_main_delete', true)),
																			nothor(fileservices.clearsuperfile('~thor_data400::in::phones::iconectiv_daily_history_delete', true))
																			);		
		
	moveBase							:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::iconectiv_main',
																														'~thor_data400::base::phones::iconectiv_main_father',
																														'~thor_data400::base::phones::iconectiv_main_grandfather',
																														'~thor_data400::base::phones::iconectiv_main_delete'], '~thor_data400::base::phones::iconectiv_main_'+version, true);
																																					
	return 	sequential(	buildBase,
											clearDelete,
											moveBase);

END;