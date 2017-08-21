export proc_build_liens_keys(filedate) := 
macro

#uniquename(bk1)
#uniquename(bk2)
#uniquename(bk3)
#uniquename(bk4)
#uniquename(bk5)
#uniquename(bk6)
#uniquename(bk7)
#uniquename(bk8)
#uniquename(bk9)
#uniquename(bk10)

#uniquename(move1)
#uniquename(move2)
#uniquename(move3)
#uniquename(move4)
#uniquename(move5)
#uniquename(move6)
#uniquename(move7)
#uniquename(move8)
#uniquename(move9)
#uniquename(move10)

#workunit('priority','high');

RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie.key_liens_did,'~thor_data400::key::liens::'+filedate+'::did', 
								  '~thor_data400::key::liens_did',%bk1%);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie.key_liens_bdid,'~thor_data400::key::liens::'+filedate+'::bdid',
								   '~thor_data400::key::liens_bdid',%bk2%);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie.key_liens_rmsid,'~thor_data400::key::liens::'+filedate+'::rmsid',
								    '~thor_data400::key::liens_rmsid',%bk3%);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie.key_liens_st_case,'~thor_data400::key::liens::'+filedate+'::st_case',
								      '~thor_data400::key::liens_st_case',%bk4%);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::'+filedate+'::did','~thor_data400::key::liens_did',%move1%);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::'+filedate+'::bdid','~thor_data400::key::liens_bdid',%move2%);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::'+filedate+'::rmsid','~thor_data400::key::liens_rmsid',%move3%);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::'+filedate+'::st_case','~thor_data400::key::liens_st_case',%move4%);


RoxieKeyBuild.Mac_sk_buildprocess_v2_Local(bankrupt.key_liens_plaintiffname,'~thor_data400::key::liens_plaintiffname','~thor_data400::key::liens::'+filedate+'::plaintiffname',%bk5%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie.key_liens_bdid_pl,'~thor_data400::key::liens_bdid_pl','~thor_data400::key::liens::'+filedate+'::bdid_pl',%bk6%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_Liens, '~thor_data400::key::liens::bocashell_did', '~thor_data400::key::liens::'+filedate+'::bocashell_did', %bk9%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::liens_plaintiffname','~thor_data400::key::liens::'+filedate+'::plaintiffname',%move5%);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::liens_bdid_pl','~thor_data400::key::liens::'+filedate+'::bdid_pl',%move6%);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::'+filedate+'::bocashell_did','~thor_data400::key::liens::bocashell_did', %move9%);


//FCRA
RoxieKeyBuild.Mac_SK_BuildProcess_Local (doxie.key_liens_did_FCRA,'~thor_data400::key::liens::fcra::'+filedate+'::did', 
								  '~thor_data400::key::liens::fcra::did',%bk7%);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(doxie.key_liens_rmsid_FCRA,'~thor_data400::key::liens::fcra::'+filedate+'::rmsid',
								    '~thor_data400::key::liens::fcra::rmsid',%bk8%);
									RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_Liens_FCRA, '~thor_data400::key::liens::fcra::bocashell_did', '~thor_data400::key::liens::fcra::'+filedate+'::bocashell_did', %bk10%);
									
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::fcra::'+filedate+'::did','~thor_data400::key::liens::fcra::did',%move7%);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::fcra::'+filedate+'::rmsid','~thor_data400::key::liens::fcra::rmsid',%move8%);
roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::liens::fcra::'+filedate+'::bocashell_did', '~thor_data400::key::liens::fcra::bocashell_did', %move10%);

#uniquename(mv1)
#uniquename(mv2)
#uniquename(mv3)
#uniquename(mv4)
#uniquename(mv5)
#uniquename(mv6)
#uniquename(mv7)
#uniquename(mv8)
#uniquename(mv9)
#uniquename(mv10)
ut.MAC_SK_Move('~thor_data400::key::liens_did','Q',%mv1%)
ut.MAC_SK_Move('~thor_data400::key::liens_bdid','Q',%mv2%)
ut.MAC_SK_Move('~thor_data400::key::liens_rmsid','Q',%mv3%)
ut.MAC_SK_Move('~thor_data400::key::liens_st_case','Q',%mv4%)
ut.mac_sk_move_v2('~thor_data400::key::liens_plaintiffname','Q',%mv5%,2);
ut.mac_sk_move_v2('~thor_data400::key::liens_bdid_pl','Q',%mv6%,2);
ut.MAC_SK_Move('~thor_data400::key::liens::fcra::did','Q',%mv7%)
ut.MAC_SK_Move('~thor_data400::key::liens::fcra::rmsid','Q',%mv8%)
ut.MAC_SK_Move_v2('~thor_data400::key::liens::bocashell_did',  'Q',%mv9%,2);
ut.MAC_SK_Move_v2('~thor_data400::key::liens::fcra::bocashell_did','Q',%mv10%,2);

RoxieKeyBuild.Mac_Daily_Email_Local('LIENS','SUCC', filedate, send_succ_msg,bankrupt.Spray_Notification_Email_Address);
RoxieKeyBuild.Mac_Daily_Email_Local('LIENS','FAIL', filedate, send_fail_msg,'cpettola@seisint.com;christopher.brodeur@lexisnexis.com');

sequential(parallel(%bk1%,%bk2%,%bk3%,%bk4%,%bk5%,%bk6%,%bk7%,%bk8%,%bk9%,%bk10%),
			parallel(%move1%,%move2%,%move3%,%move4%,%move5%,%move6%,%move7%,%move8%,%move9%,%move10%),
            parallel(%mv1%,%mv2%,%mv3%,%mv4%,%mv5%,%mv6%,%mv7%,%mv8%,%mv9%,%mv10%)) :
			success(send_succ_msg),
			failure(send_fail_msg);
endmacro;
