import Address,doxie_files, ut, doxie, autokey,SANCTN, RoxieKeyBuild;

export proc_build_SANCTN_keys(string filedate) := FUNCTION

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN.Key_SANCTN_casenum
                                          ,'~thor_data400::key::sanctn::casenum'
										  ,'~thor_data400::key::sanctn::'+filedate+'::casenum'
										  ,bk_casenum);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN.Key_SANCTN_incident
										  ,'~thor_data400::key::sanctn::incident'
										  ,'~thor_data400::key::sanctn::'+filedate+'::incident'
										  ,bk_pyld_inc);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(SANCTN.Key_SANCTN_party
										  ,'~thor_data400::key::sanctn::party'
										  ,'~thor_data400::key::sanctn::'+filedate+'::party'
										  ,bk_pyld_pty);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sanctn::casenum'
								     ,'~thor_data400::key::sanctn::'+filedate+'::casenum'
									 ,mv2blt_casenum);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sanctn::incident'
								     ,'~thor_data400::key::sanctn::'+filedate+'::incident'
									 ,mv2blt_inc);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::sanctn::party'
								     ,'~thor_data400::key::sanctn::'+filedate+'::party'
									 ,mv2blt_pty);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::sanctn::casenum' ,'Q',mv2qa_casenum);
ut.mac_sk_move('~thor_data400::key::sanctn::incident','Q',mv2qa_inc);
ut.mac_sk_move('~thor_data400::key::sanctn::party'   ,'Q',mv2qa_pty);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := SANCTN.proc_build_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

emailN := fileservices.sendemail('RoxieBuilds@seisint.com ; ehamel@seisint.com ; tgibson@seisint.com ',
								 
								'sanctn: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::sanctn::qa::autokey::address(thor_data400::key::sanctn::' + filedate + '::autokey::address),\n' +
								'      2) thor_data400::key::sanctn::qa::autokey::citystname(thor_data400::key::sanctn::' + filedate + '::autokey::citystname),\n' +
								'      3) thor_data400::key::sanctn::qa::autokey::name(thor_data400::key::sanctn::' + filedate + '::autokey::name),\n' +
								'      4) thor_data400::key::sanctn::qa::autokey::payload(thor_data400::key::sanctn::'+ filedate + '::autokey::payload),\n' +
								'      5) thor_data400::key::sanctn::qa::autokey::zip(thor_data400::key::sanctn::' + filedate + '::autokey::zip),\n' +
								'      6) thor_data400::key::sanctn::qa::autokey::stname(thor_data400::key::sanctn::' + filedate + '::autokey::stname),\n' +
								'      7) thor_data400::key::sanctn::qa::autokey::addressb2(thor_data400::key::sanctn::' + filedate + '::autokey::addressb2),\n' +
								'      8) thor_data400::key::sanctn::qa::autokey::citystnameb2(thor_data400::key::sanctn::' + filedate + '::autokey::citystnameb2),\n' +
								'      9) thor_data400::key::sanctn::qa::autokey::nameb2(thor_data400::key::sanctn::' + filedate + '::autokey::nameb2),\n' +
								'     10) thor_data400::key::sanctn::qa::autokey::namewords2(thor_data400::key::sanctn::' + filedate + '::autokey::namewords2),\n' + 
								'     11) thor_data400::key::sanctn::qa::autokey::stnameb2(thor_data400::key::sanctn::' + filedate + '::autokey::stnameb2),\n' +
								'     12) thor_data400::key::sanctn::qa::autokey::zipb2(thor_data400::key::sanctn::' + filedate + '::autokey::zipb2),\n' +
								'     13) thor_data400::key::sanctn::casenum_qa(thor_data400::key::sanctn::' + filedate + '::casenum),\n' +
								'     14) thor_data400::key::sanctn::incident_qa(thor_data400::key::sanctn::' + filedate + '::incident),\n' +
								'	  15) thor_data400::key::sanctn::party_qa(thor_data400::key::sanctn::' + filedate + '::party),\n' +
						        '         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := 

sequential(
	parallel(
			  bk_casenum
			 ,bk_pyld_inc
			 ,bk_pyld_pty
			),
	parallel(
			 mv2blt_casenum
			,mv2blt_inc
			,mv2blt_pty
			),
	parallel(
			mv2qa_casenum
		   ,mv2qa_inc
		   ,mv2qa_pty
			 )
   ,
   build_autokeys
);


return parallel(build_keys
				,emailN
				);

end;


 
 
 
 