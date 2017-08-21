/*2016-02-12T21:59:24Z (Judy Tao)
Add a patch
*/
import ut;

//build MA main & party base file
ut.MAC_SF_BuildProcess(liensV2.Mapping_MA_Main,
                       '~thor_data400::base::Liens::Main::MA',bld_MA_main, 2);
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 	:= LiensV2.MA_DID;
	ds_main 	:= LiensV2.Mapping_MA_Main;
	ds_fix		:= LiensV2._Functions.fn_PopDtFirstSeen(ds_party, ds_main);
				   
ut.MAC_SF_BuildProcess(ds_fix,
                       '~thor_data400::base::Liens::party::MA', bld_MA_party,2);
					   				 
export proc_build_MA_base := sequential(bld_MA_main, bld_MA_party);

