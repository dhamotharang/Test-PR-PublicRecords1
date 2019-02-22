IMPORT _control, Std, ut;

EXPORT Proc_Build_Deact_Gong_History_File(string version) := FUNCTION

	//This build uses the Gong.Key_History_Phone for the input.	
	
	//Clear Delete/Persist Files
	clearDelete 							:= sequential(nothor(Fileservices.ClearSuperfile('~thor_data400::base::phones::deact_gh_main_delete', true)),
																					nothor(Fileservices.ClearSuperfile('~thor_data400::in::phones::deact_gh_history_delete', true)),
																					nothor(FileServices.DeleteLogicalFile('~thor_data400::persist::gong_history_deact_sameDay')));
	
	//Build History/Base Files																			
	buildBase									:= PhonesInfo.Remap_Deact_Gong_History(version);	

	//Move History Files	
	moveHistory								:= Std.File.PromoteSuperFileList(['~thor_data400::in::phones::deact_gh_history',
																															'~thor_data400::in::phones::deact_gh_history_father',
																															'~thor_data400::in::phones::deact_gh_history_grandfather',
																															'~thor_data400::in::phones::deact_gh_history_delete'], '~thor_data400::in::phones::deact_gh_history_'+version, true);						
	//Move Base Files															 
	moveBase									:= Std.File.PromoteSuperFileList(['~thor_data400::base::phones::deact_gh_main',
																															'~thor_data400::base::phones::deact_gh_main_father',
																															'~thor_data400::base::phones::deact_gh_main_grandfather',
																															'~thor_data400::base::phones::deact_gh_main_delete'], '~thor_data400::base::phones::deact_gh_main_'+version, true);																						

	//Email Build Status	
	emailDOps									:= ';darren.knowles@lexisnexisrisk.com; charlene.ros@lexisnexisrisk.com; gregory.rose@lexisnexisrisk.com';
	emailDev									:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget								:= _control.MyInfo.EmailAddressNotify + emailDev;
	emailBuildNotice 					:= if(count(PhonesInfo.File_Deact_GH.Main(phone<>'')) > 0
																				,fileservices.SendEmail(emailTarget, 'Phones Metadata: Deact Gong History File', 'Phones Metadata: Deact Gong History File Is Now Available.  Please see: ' + 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																				,fileservices.SendEmail(emailTarget, 'Phones Metadata: No Deact Gong History File', 'There Were No Deact Gong History Records In This Build')
																				);	
																				
	RETURN sequential(clearDelete,
										buildBase,
										moveHistory,
										moveBase,
										emailBuildNotice);
	
END;