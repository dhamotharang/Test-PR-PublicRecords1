import Address,doxie_files, ut, doxie, autokey,SANCTN_Mari, RoxieKeyBuild;

export proc_build_SANCTN_Mari_keys(string filedate) := FUNCTION

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN_Mari.key_Midex_NP_incident
										  ,SANCTN_Mari.cluster_name +'key::sanctn::np::incident'
										  ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::incident'
										  ,bk_pyld_inc);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN_Mari.key_Midex_NP_party
										  ,SANCTN_Mari.cluster_name +'key::sanctn::np::party'
										  ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::party'
										  ,bk_pyld_pty);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN_Mari.key_Midex_NP_text
										  ,SANCTN_Mari.cluster_name +'key::sanctn::np::incidenttext'
										  ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::incidenttext'
										  ,bk_pyld_txt);
											
/* Keys not necessary on this code file at this time as it is not being used */
// RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN_Mari.key_Midex_NP_codes
										  // ,SANCTN_Mari.cluster_name +'key::sanctn::np::incidentcode'
										  // ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::incidentcode'
										  // ,bk_pyld_cds);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SANCTN_Mari.cluster_name +'key::sanctn::np::incident'
								     ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::incident'
									 ,mv2blt_inc);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SANCTN_Mari.cluster_name +'key::sanctn::np::party'
								     ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::party'
									 ,mv2blt_pty);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SANCTN_Mari.cluster_name +'key::sanctn::np::incidenttext'
								     ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::incidenttext'
									 ,mv2blt_txt);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2(SANCTN_Mari.cluster_name +'key::sanctn::np::incidentcode'
								     // ,SANCTN_Mari.cluster_name +'key::sanctn::np::'+filedate+'::incidentcode'
									 // ,mv2blt_cds);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move(SANCTN_Mari.cluster_name +'key::sanctn::np::incident'			,'Q',mv2qa_inc);
ut.mac_sk_move(SANCTN_Mari.cluster_name +'key::sanctn::np::party'   			,'Q',mv2qa_pty);
ut.mac_sk_move(SANCTN_Mari.cluster_name +'key::sanctn::np::incidenttext' ,'Q',mv2qa_txt);
//ut.mac_sk_move(SANCTN_Mari.cluster_name +'key::sanctn::np::incidentcode' ,'Q',mv2qa_cds);
/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := SANCTN_Mari.proc_build_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

//emailN := fileservices.sendemail('shannon.lucero@lexisnexis.com',
//emailN := fileservices.sendemail('roxiebuilds@seisint.com;shannon.lucero@lexisnexis.com;jstewart@lexisnexis.com',
								 
								// 'sanctn: BUILD SUCCESS '+ filedate ,
								// 'keys: 1) thor_data400::key::sanctn::np::qa::autokey::address(thor_data400::key::sanctn::np::' + filedate + '::autokey::address),\n' +
								// '      2) thor_data400::key::sanctn::np::qa::autokey::citystname(thor_data400::key::sanctn::np::' + filedate + '::autokey::citystname),\n' +
								// '      3) thor_data400::key::sanctn::np::qa::autokey::name(thor_data400::key::sanctn::np::' + filedate + '::autokey::name),\n' +
								// '      4) thor_data400::key::sanctn::np::qa::autokey::payload(thor_data400::key::sanctn::np::'+ filedate + '::autokey::payload),\n' +
								// '      5) thor_data400::key::sanctn::np::qa::autokey::zip(thor_data400::key::sanctn::np::' + filedate + '::autokey::zip),\n' +
								// '      6) thor_data400::key::sanctn::np::qa::autokey::stname(thor_data400::key::sanctn::np::' + filedate + '::autokey::stname),\n' +
								// '      7) thor_data400::key::sanctn::np::qa::autokey::addressb2(thor_data400::key::sanctn::np::' + filedate + '::autokey::addressb2),\n' +
								// '      8) thor_data400::key::sanctn::np::qa::autokey::citystnameb2(thor_data400::key::sanctn::np::' + filedate + '::autokey::citystnameb2),\n' +
								// '      9) thor_data400::key::sanctn::np::qa::autokey::nameb2(thor_data400::key::sanctn::np::' + filedate + '::autokey::nameb2),\n' +
								// '     10) thor_data400::key::sanctn::np::qa::autokey::namewords2(thor_data400::key::sanctn::np::' + filedate + '::autokey::namewords2),\n' + 
								// '     11) thor_data400::key::sanctn::np::qa::autokey::stnameb2(thor_data400::key::sanctn::np::' + filedate + '::autokey::stnameb2),\n' +
								// '     12) thor_data400::key::sanctn::np::qa::autokey::zipb2(thor_data400::key::sanctn::np::' + filedate + '::autokey::zipb2),\n' +
								// '     13) thor_data400::key::sanctn::np::incident_qa(thor_data400::key::sanctn::np::' + filedate + '::incident),\n' +
								// '	   14) thor_data400::key::sanctn::np::party_qa(thor_data400::key::sanctn::np::' + filedate + '::party),\n' +
								// '	   15) thor_data400::key::sanctn::np::incidenttext_qa(thor_data400::key::sanctn::np::' + filedate + '::incidenttext),\n' +
								// '	   16) thor_data400::key::sanctn::np::incidentcode_qa(thor_data400::key::sanctn::np::' + filedate + '::incidentcode),\n' +
								// '     17) thor_data400::key::sanctn::np::qa::docref.docref(thor_data400::key::sanctn::np::' + filedate + '::docref.docref),\n' +
								// '     18) thor_data400::key::sanctn::np::qa::nidx(thor_data400::key::sanctn::np::' + filedate + '::nidx),\n' +
								// '     19) thor_data400::key::sanctn::np::qa::xdstat(thor_data400::key::sanctn::np::' + filedate + '::xdstat),\n' +
								// '     20) thor_data400::key::sanctn::np::qa::xseglist(thor_data400::key::sanctn::np::' + filedate + '::xseglist),\n' +
						    //    '         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := 

sequential(parallel(bk_pyld_inc
					 ,bk_pyld_pty
					 ,bk_pyld_txt)
					 //,bk_pyld_cds)
		   ,parallel(mv2blt_inc
					 ,mv2blt_pty
					 ,mv2blt_txt)
					 //,mv2blt_cds)
		   ,parallel(mv2qa_inc
				     ,mv2qa_pty
						 ,mv2qa_txt)
						 //,mv2qa_cds)
			 ,build_autokeys
		   );


return parallel(build_keys
			//	,emailN
				);

end;