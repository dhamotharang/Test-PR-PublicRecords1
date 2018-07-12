import RoxieKeybuild,doxie_files,ut,PromoteSupers,Orbit3,DopsGrowthCheck,dops;
export Proc_build_fcra_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_LiensV3_FCRA,'~thor_data400::key::liensv2::fcra::bocashell_did_v2','~thor_data400::key::liensv2::fcra::'+filedate+'::bocashell_did_v2',fcra_bshell_did_key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_did_fcra,'~thor_data400::key::liensv2::fcra::DID','~thor_data400::key::liensv2::fcra::'+filedate+'::did',fcra_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_main_ID_FCRA,'~thor_data400::key::liensv2::fcra::main::TMSID.RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::main::TMSID.RMSID',fcra_main_trid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_party_id_FCRA,'~thor_data400::key::liensv2::fcra::party::TMSID.RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::party::TMSID.RMSID',fcra_party_trid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_RMSID_FCRA,'~thor_data400::key::liensv2::fcra::main::RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::main::RMSID',fcra_rmsid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.Key_FCRA_Liens_BDID,'~thor_data400::key::liensv2::fcra::bdid' ,'~thor_data400::key::liensv2::fcra::'+filedate+'::bdid',bld_fcra_bdid); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.Key_FCRA_Liens_case_number,'~thor_data400::key::liensv2::fcra::case_number','~thor_data400::key::liensv2::fcra::'+filedate+'::case_number',bld_fcra_case_nbr); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.Key_FCRA_Liens_Certificate_Number,'~thor_data400::key::liensv2::fcra::main::certificate_number','~thor_data400::key::liensv2::fcra::'+filedate+'::main::certificate_number',bld_fcra_cert_nbr); 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.Key_FCRA_Liens_Filing,'~thor_data400::key::liensv2::fcra::filing_number','~thor_data400::key::liensv2::fcra::'+filedate+'::filing_number',bld_fcra_filing_nbr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.Key_FCRA_Liens_Irs_serial_number,'~thor_data400::key::liensv2::fcra::main::irs_serial_number','~thor_data400::key::liensv2::fcra::'+filedate+'::main::irs_serial_number',bld_fcra_serial_nbr); 

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::fcra::bocashell_did_v2','~thor_data400::key::liensv2::fcra::'+filedate+'::bocashell_did_v2',mv_fcra_bshell_did_key3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::fcra::DID','~thor_data400::key::liensv2::fcra::'+filedate+'::did',mv_fcra_did_key);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::fcra::main::TMSID.RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::main::TMSID.RMSID',mv_fcra_main_trid_key);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::fcra::party::TMSID.RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::party::TMSID.RMSID',mv_fcra_party_trid_key);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::fcra::main::RMSID','~thor_data400::key::liensv2::fcra::'+filedate+'::main::RMSID',mv_fcra_rmsid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2     ('~thor_data400::key::liensv2::fcra::@version@::bdid','~thor_data400::key::liensv2::fcra::'+filedate+'::bdid',mv_fcra_bdid);
Roxiekeybuild.Mac_SK_Move_to_Built_v2     ('~thor_data400::key::liensv2::fcra::@version@::case_number','~thor_data400::key::liensv2::fcra::'+filedate+'::case_number',mv_fcra_case_nbr); 
Roxiekeybuild.Mac_SK_Move_to_Built_v2     ('~thor_data400::key::liensv2::fcra::@version@::main::certificate_number','~thor_data400::key::liensv2::fcra::'+filedate+'::main::certificate_number',mv_fcra_cert_nbr); 
Roxiekeybuild.Mac_SK_Move_to_Built_v2     ('~thor_data400::key::liensv2::fcra::@version@::filing_number','~thor_data400::key::liensv2::fcra::'+filedate+'::filing_number',mv_fcra_filing_nbr); 
Roxiekeybuild.Mac_SK_Move_to_Built_v2     ('~thor_data400::key::liensv2::fcra::@version@::main::irs_serial_number','~thor_data400::key::liensv2::fcra::'+filedate+'::main::irs_serial_number',mv_fcra_serial_nbr);


PromoteSupers.mac_sk_move_v2('~thor_data400::key::liensv2::fcra::bocashell_did_v2','Q',qmv_fcra_bshell_did_key_v2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::liensv2::fcra::DID','Q',qmv_fcra_did_key);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::liensv2::fcra::main::TMSID.RMSID','Q',qmv_fcra_main_trid_key);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::liensv2::fcra::party::TMSID.RMSID','Q',qmv_fcra_party_trid_key);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::liensv2::fcra::main::RMSID','Q',qmv_fcra_rmsid_key);
Roxiekeybuild.MAC_SK_Move ('~thor_data400::key::liensv2::fcra::@version@::bdid','Q',mv_bdid_qa);
Roxiekeybuild.MAC_SK_Move ('~thor_data400::key::liensv2::fcra::@version@::case_number','Q',mv_case_nbr_qa);
Roxiekeybuild.MAC_SK_Move ('~thor_data400::key::liensv2::fcra::@version@::main::certificate_number','Q',mv_cert_nbr_qa);
Roxiekeybuild.MAC_SK_Move ('~thor_data400::key::liensv2::fcra::@version@::filing_number','Q',mv_filing_nbr_qa);
Roxiekeybuild.MAC_SK_Move ('~thor_data400::key::liensv2::fcra::@version@::main::irs_serial_number','Q',mv_serial_nbr_qa);

bld_autokeys := LiensV2.Proc_build_autokeys_fcra(filedate); 

create_build := Orbit3.proc_Orbit3_CreateBuild ( 'FCRA Liens & Judgements',filedate,'F');

GetDops:=dops.GetDeployedDatasets('P','B','F');
OnlyLiens:=GetDops(datasetname='FCRA_LiensV2Keys');
set of string	DistSet:=['tmsid','rmsid'];
set of string InputSet:=['tmsid','rmsid','filing_jurisdiction','orig_filing_date','filing_number','filing_type_desc','amount','eviction','agency','agency_state','agency_county'];
DeltaCommands:=sequential(DOPSGrowthCheck.CalculateStats('FCRA_LiensV2Keys','liensv2.key_liens_main_ID_FCRA','key_liens_main_ID_FCRA','~thor_data400::key::liensv2::fcra::'+filedate+'::main::tmsid.rmsid','tmsid,rmsid','persistent_record_id','','','','',filedate,OnlyLiens[1].buildversion),DOPSGrowthCheck.CalculateStats('FCRA_LiensV2Keys','liensv2.key_liens_party_id_FCRA','key_liens_party_id_FCRA','~thor_data400::key::liensv2::fcra::'+filedate+'::party::tmsid.rmsid','tmsid,rmsid','persistent_record_id','','','','',filedate,OnlyLiens[1].buildversion),
DOPSGrowthCheck.DeltaCommand('~thor_data400::key::liensv2::fcra::'+filedate+'::main::tmsid.rmsid','~thor_data400::key::liensv2::fcra::'+OnlyLiens[1].buildversion+'::main::tmsid.rmsid','FCRA_LiensV2Keys','key_liens_main_ID_FCRA','liensv2.key_liens_main_ID_FCRA','persistent_record_id',filedate,OnlyLiens[1].buildversion,['rmsid','tmsid','persistent_record_id']),DOPSGrowthCheck.DeltaCommand('~thor_data400::key::liensv2::fcra::'+filedate+'::party::tmsid.rmsid','~thor_data400::key::liensv2::fcra::'+OnlyLiens[1].buildversion+'::party::tmsid.rmsid','FCRA_LiensV2Keys','key_liens_party_id_FCRA','liensv2.key_liens_party_id_FCRA','persistent_record_id',filedate,OnlyLiens[1].buildversion,['did','rmsid','tmsid','persistent_record_id']),
DOPSGrowthCheck.ChangesByField('~thor_data400::key::liensv2::fcra::'+filedate+'::main::tmsid.rmsid','~thor_data400::key::liensv2::fcra::'+OnlyLiens[1].buildversion+'::main::tmsid.rmsid','FCRA_LiensV2Keys','key_liens_main_ID_FCRA','liensv2.key_liens_main_ID_FCRA','persistent_record_id','process_date,filing_status',filedate,OnlyLiens[1].buildversion),DOPSGrowthCheck.ChangesByField('~thor_data400::key::liensv2::fcra::'+filedate+'::party::tmsid.rmsid','~thor_data400::key::liensv2::fcra::'+OnlyLiens[1].buildversion+'::party::tmsid.rmsid','FCRA_LiensV2Keys','key_liens_party_id_FCRA','liensv2.key_liens_party_id_FCRA','persistent_record_id','date_last_seen,date_vendor_last_reported',filedate,OnlyLiens[1].buildversion),
DopsGrowthCheck.PersistenceCheck('~thor_data400::key::liensv2::fcra::'+filedate+'::main::tmsid.rmsid','~thor_data400::key::liensv2::fcra::'+OnlyLiens[1].buildversion+'::main::tmsid.rmsid','FCRA_LiensV2Keys','key_liens_main_ID_FCRA','liensv2.key_liens_main_ID_FCRA','persistent_record_id',InputSet,DistSet,filedate,OnlyLiens[1].buildversion)
);

build_fcra_keys := sequential(
															parallel(
															fcra_bshell_did_key3,fcra_did_key,
															fcra_main_trid_key,fcra_party_trid_key,fcra_rmsid_key,
															bld_fcra_bdid,bld_fcra_case_nbr,bld_fcra_cert_nbr,bld_fcra_filing_nbr,bld_fcra_serial_nbr),
															sequential(
															mv_fcra_bshell_did_key3,
															mv_fcra_did_key,mv_fcra_main_trid_key,
															mv_fcra_party_trid_key,mv_fcra_rmsid_key,
															mv_fcra_bdid,mv_fcra_case_nbr,mv_fcra_cert_nbr,mv_fcra_filing_nbr,mv_fcra_serial_nbr,
															
					  qmv_fcra_bshell_did_key_v2,
					  qmv_fcra_did_key,qmv_fcra_main_trid_key,
						qmv_fcra_party_trid_key,qmv_fcra_rmsid_key,mv_bdid_qa,mv_case_nbr_qa,mv_cert_nbr_qa,mv_filing_nbr_qa,mv_serial_nbr_qa),bld_autokeys,
						DeltaCommands,
						RoxieKeybuild.updateversion('FCRA_LiensV2Keys',filedate,'skasavajjala@seisint.coml,michael.gould@lexisnexisrisk.com',,'F'),
						create_build);

return build_fcra_keys;

end;