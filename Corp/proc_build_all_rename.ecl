import roxiekeybuild, corp2;
//Please check the following attributes to make sure they are correct:
// Corp.MOXIE_CORP_MOUNT
// Corp.MOXIE_DESPRAY_SERVER
// Corp.MOXIE_KEY_THOR
// Corp.Corp_Build_Date

build_bases			:= Proc_Build_Base							: success(output('All Corp base files created successfully'));
build_keys			:= Proc_Build_Keys_rename					: success(output('All Corp keys created successfully'));
build_corp_out		:= corp.proc_corp_out						: success(output('Corp Output files created successfully'));
build_corp_cont_out	:= corp.proc_corp_cont_out					: success(output('Corp Cont Output files created successfully'));
build_corp_affils	:= Corp.proc_corporate_affiliations_rename	: success(output('Corporate Affiliations created successfully'));
//run_stats			:= Query_BDID_Stats		: success(output('BDID Stats completed successfully'));
superfiles_clear 	:= Clear_Input_Superfiles					: success(output('Cleared all input superfiles'));
accept_sk_to_qa		:= proc_accept_corp_keys_to_QA_rename 		: success(output('Moved Corp superkeys to QA'));
accept_aff_sk_to_qa	:= corp.proc_accept_corp_affiliation_keys_to_QA_rename	: success(output('Moved Corporate Affiliations Superkeys to QA'));
despray_files 		:= corp.Despray_Corp_Out_Files				: success(output('Desprayed all output files'));
dkc_keys 			:= corp.Out_Corp_All_Keys 					: success(output('Dkc of all keys completed'));
Population_Stats	:= Out_Population_Stats.All					: success(output('Population Stats Completed'));
send_email 			:= Send_Build_Completion_Email()			: success(output('Build Completion Email Sent.'));

e_mail_success := fileservices.sendemail(
													corp2.Email_Notification_Lists.roxie,
													'Corp Build Succeeded - ' + corp.version_development,
													'keys: 1) thor_data400::key::corp_base_bdid_qa(thor_data400::key::corp::'+corp.version_development+'::base.bdid),\n' + 
													'	   2) thor_data400::key::corp_base_bdid_pl_qa(thor_data400::key::corp::'+corp.version_development+'::base.bdid.pl),\n' + 
													'      3) thor_data400::key::corp_base_corpkey_qa(thor_data400::key::corp::'+corp.version_development+'::base.corpkey),\n' +
													'      4) thor_data400::key::corporate_affiliations.did_qa(thor_data400::key::corporate_affiliations::'+corp.version_development+'::did),\n' +
													'      5) thor_data400::key::corporate_affiliations.filepos_qa(thor_data400::key::corporate_affiliations::'+corp.version_development+'::filepos),\n' +
													'      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
													corp2.Email_Notification_Lists.BuildFailure,
													'Corp Build Failed ' + corp.version_development,
													workunit + '\n' + failmessage);
													
export proc_build_all_rename := sequential(
	 build_bases
	,build_keys
	,build_corp_out
	,build_corp_cont_out
	,build_corp_affils
	,superfiles_clear
	,accept_sk_to_qa
	,accept_aff_sk_to_qa
	,despray_files
	,dkc_keys
	,Population_Stats
	,Strata_Population_Stats
	,send_email
) : success(e_mail_success),failure(e_mail_fail);
