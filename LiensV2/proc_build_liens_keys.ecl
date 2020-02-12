import liensV2,roxiekeybuild,ingenix_natlprof,ut,autokey,doxie,doxie_files;

export proc_build_liens_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_main_ID,'~thor_data400::key::liensv2::main::tmsid.rmsid','~thor_data400::key::liensv2::'+filedate+'::main::TMSID.RMSID',liens_MID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_party_ID,'~thor_data400::key::liensv2::party::tmsid.rmsid','~thor_data400::key::liensv2::'+filedate+'::party::TMSID.RMSID',liens_PID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_DID,'~thor_data400::key::liensv2::did','~thor_data400::key::liensv2::'+filedate+'::DID',liens_DID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_BDID,'~thor_data400::key::liensv2::bdid','~thor_data400::key::liensv2::'+filedate+'::BDID',liens_BDID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_ssn,'~thor_data400::key::liensv2::ssn','~thor_data400::key::liensv2::'+filedate+'::ssn',liens_ssn_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_taxID,'~thor_data400::key::liensv2::taxid','~thor_data400::key::liensv2::'+filedate+'::taxID',liens_taxid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_filing,'~thor_data400::key::liensv2::filing_number','~thor_data400::key::liensv2::'+filedate+'::filing_number',liens_filing_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_case_number,'~thor_data400::key::liensv2::case_number','~thor_data400::key::liensv2::'+filedate+'::case_number',liens_case_number_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_RMSID,'~thor_data400::key::liensv2::main::rmsid','~thor_data400::key::liensv2::'+filedate+'::main::RMSID',liens_RMSID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.key_liens_irs_serial_number,'~thor_data400::key::liensv2::main::IRS_serial_number','~thor_data400::key::liensv2::'+filedate+'::main::IRS_serial_number',liens_IRS_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(LiensV2.key_liens_certificate_number,'~thor_data400::key::liensv2::main::certificate_number','~thor_data400::key::liensv2::'+filedate+'::main::certificate_number',liens_cert_nbr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_Bocashell_Liens_and_Evictions_V2,'~thor_data400::key::liensv2::bocashell_liens_and_evictions_did_v2','~thor_data400::key::liensv2::'+filedate+'::bocashell_liens_and_evictions_did_v2',liens_evic_v2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(LiensV2.Key_LinkIds.key,'~thor_data400::key::liensv2::party::linkids','~thor_data400::key::liensv2::'+filedate+'::party::linkids',Liens_LinkID_key);
//Deprecated Key - Jira DF-26975
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensV2.key_liens_party_ID_linkids,'~thor_data400::key::liensv2::party::tmsid.rmsid_linkids','~thor_data400::key::liensv2::'+filedate+'::party::tmsid.rmsid_linkids',liens_PID_linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(liensv2.key_liens_SourceRecID,'~thor_data400::key::liensv2::party::SourceRecId','~thor_data400::key::liensv2::'+filedate+'::party::SourceRecId',liens_SourceRecId_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::main::tmsid.rmsid', '~thor_data400::key::liensv2::'+filedate+'::main::TMSID.RMSID',mv_mid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::party::tmsid.rmsid', '~thor_data400::key::liensv2::'+filedate+'::party::TMSID.RMSID',mv_pid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::did', '~thor_data400::key::liensv2::'+filedate+'::DID',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::bdid', '~thor_data400::key::liensv2::'+filedate+'::BDID', mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::ssn', '~thor_data400::key::liensv2::'+filedate+'::ssn', mv_ssn_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::taxid', '~thor_data400::key::liensv2::'+filedate+'::taxID', mv_taxid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::filing_number', '~thor_data400::key::liensv2::'+filedate+'::filing_number', mv_filing_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::case_number', '~thor_data400::key::liensv2::'+filedate+'::case_number', mv_case_number_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::main::rmsid', '~thor_data400::key::liensv2::'+filedate+'::main::RMSID', mv_RMSID_key);	
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::main::IRS_serial_number','~thor_data400::key::liensv2::'+filedate+'::main::IRS_serial_number',mv_IRS_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::main::certificate_number','~thor_data400::key::liensv2::'+filedate+'::main::certificate_number',mv_cert_nbr);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::bocashell_liens_and_evictions_did_v2','~thor_data400::key::liensv2::'+filedate+'::bocashell_liens_and_evictions_did_v2',mv_liens_evic_v2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::party::linkids','~thor_data400::key::liensv2::'+filedate+'::party::linkids',mv_LinkID_key);
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::party::tmsid.rmsid_linkids','~thor_data400::key::liensv2::'+filedate+'::party::tmsid.rmsid_linkids',mv_liens_PID_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::liensv2::party::SourceRecId', '~thor_data400::key::liensv2::'+filedate+'::party::SourceRecId', mv_SourceRecId_key);
                                        

build_keys := sequential(
														parallel
														(	liens_MID_key,liens_PID_key, liens_DID_key,liens_BDID_key,liens_ssn_key,liens_taxID_key,liens_filing_key,
															liens_case_number_key,liens_RMSID_key ,liens_IRS_key,liens_cert_nbr,liens_evic_v2,Liens_LinkID_key,/*liens_PID_linkids_key,*/liens_SourceRecId_key
														 ),
														 liensv2.Proc_build_autokeys(filedate),
														parallel
														(	
														mv_mid_key,mv_pid_key, mv_DID_key,mv_BDID_key,mv_ssn_key,mv_taxID_key,mv_filing_key,
															mv_case_number_key, mv_RMSID_key,mv_IRS_key,mv_cert_nbr,mv_liens_evic_v2,
															mv_LinkID_key,/*mv_liens_PID_linkids_key,*/mv_SourceRecId_key
														 ),
														 LiensV2.proc_AcceptSK_ToQA,
														 notify('LIENS KEY BUILD COMPLETE','*'),
														 if(~fileservices.fileexists('~thor::dops::liensv2'),
								fileservices.createsuperfile('~thor::dops::liensv2')),
								fileservices.RemoveSuperFile('~thor::dops::liensv2','~thor::dops::liensv2::nonfcrakeys'),
								output(dataset([{filedate}],{string processdate}),,'~thor::dops::liensv2::nonfcrakeys',overwrite),
								fileservices.addsuperfile('~thor::dops::liensv2','~thor::dops::liensv2::nonfcrakeys')
								
														 
												 );


return build_keys;

end;