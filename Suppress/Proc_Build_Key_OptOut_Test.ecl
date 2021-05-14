// This is used to build OptOut test key until PRTE is ready
IMPORT RoxieKeyBuild, dops, _Control;
export Proc_Build_Key_OptOut_Test(String pVersion, string pContact ='\' \'') := FUNCTION

    filedate := TRIM(pVersion);
	spray_opt_out_input_file	:= Suppress.fSprayFiles.OptOutSrc(filedate
                                                                 ,pServerIP:=_Control.IPAddress.bctlpedata12
                                                                 ,pDirectory:='/data/hds_2/test/'
                                                                 ,pFilename:=TRIM('latest.csv',ALL)
                                                                 );
																	
 
	global_sid_pr_pd		:= Suppress.Files.Global_Sid.Basefile(history_flag='' and domain_id=$.Constants.Exemptions().Domain_Id_PR and prof_data_only='Y')[1].global_sids;
	global_sid_pr_npd		:= Suppress.Files.Global_Sid.Basefile(history_flag='' and domain_id=$.Constants.Exemptions().Domain_Id_PR and prof_data_only='N')[1].global_sids;

	Suppress.Layout_OptOut tInputC(Suppress.Layout_OptOut_In L) := TRANSFORM
			SELF.date_added					:= L.DATE_OF_REQUEST;	
            SELF.exemptions                 := 64;
            SELF.act_id                     := 'CACCPA';
            // SELF.global_sids                := Suppress.Constants.OptOut().CACCPA_Global_Sid;																
			SELF.global_sids			    := IF(L.prof_data='Y', global_sid_pr_pd, global_sid_pr_npd);
			SELF							:= L;
	END;
	input_raw 	:= Suppress.Files.OptOut.Input_Raw(ENTRY_TYPE NOT IN ['','ROWCOUNT']);
	input_0		:= PROJECT(input_raw, tInputC(LEFT));
    ds_key_input:= dedup(sort(distribute(input_0,lexid),lexid,-date_added,local),lexid,local);
	key         := INDEX(ds_key_input, {lexid}, {ds_key_input}, '~thor::key::new_suppression::qa::opt_out');

    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key,'','~thor::key::new_suppression::'+filedate+'::opt_out',bld_optout_key,true);

    //Update DOPS
    update_dops := dops.updateversion('SuppressOptOutKeys',filedate,'christopher.brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'N',l_updateflag:='DR');

    RETURN sequential(spray_opt_out_input_file
                      ,bld_optout_key
                      ,update_dops
            );
END;          
