//Please check the following attributes to make sure they are correct:
// Corp.MOXIE_CORP_MOUNT
// Corp.MOXIE_DESPRAY_SERVER
// Corp.MOXIE_KEY_THOR
// Corp.Corp_Build_Date

build_bases		:= Proc_Build_Base							: success(output('All Corp base files created successfully'));
build_keys		:= Proc_Build_Keys							: success(output('All Corp keys created successfully'));
build_corp_out		:= corp.proc_corp_out						: success(output('Corp Output files created successfully'));
build_corp_cont_out	:= corp.proc_corp_cont_out					: success(output('Corp Cont Output files created successfully'));
build_corp_affils	:= Corp.proc_corporate_affiliations			: success(output('Corporate Affiliations created successfully'));
//run_stats			:= Query_BDID_Stats		: success(output('BDID Stats completed successfully'));
superfiles_clear 	:= Clear_Input_Superfiles					: success(output('Cleared all input superfiles'));
accept_sk_to_qa	:= proc_accept_corp_keys_to_QA 				: success(output('Moved Corp superkeys to QA'));
accept_aff_sk_to_qa	:= corp.proc_accept_corp_affiliation_keys_to_QA	: success(output('Moved Corporate Affiliations Superkeys to QA'));
despray_files 		:= corp.Despray_Corp_Out_Files				: success(output('Desprayed all output files'));
dkc_keys 			:= corp.Out_Corp_All_Keys 					: success(output('Dkc of all keys completed'));
send_email 		:= Send_Build_Completion_Email()				: success(output('Build Completion Email Sent.'));

export proc_build_all := sequential(
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
	,send_email
);