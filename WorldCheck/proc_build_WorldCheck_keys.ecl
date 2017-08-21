import Address,doxie_files, ut, doxie, autokey,WorldCheck, RoxieKeyBuild;

export proc_build_WorldCheck_keys (string filedate) := FUNCTION

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////

/* Build the Input file payload key based off of UID*/
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(WorldCheck.Key_WorldCheck_In
										  ,'~thor_data400::key::WorldCheck::in'
										  ,'~thor_data400::key::WorldCheck::'+filedate+'::in'
										  ,bk_pyld_in);
/* Build the Main payload key based off of UID*/
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(WorldCheck.Key_WorldCheck_main
										  ,'~thor_data400::key::WorldCheck::main'
										  ,'~thor_data400::key::WorldCheck::'+filedate+'::main'
										  ,bk_pyld_main);
/* Build the Main payload key based off of key*/
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(WorldCheck.Key_WorldCheck_key
										  ,'~thor_data400::key::WorldCheck::key'
										  ,'~thor_data400::key::WorldCheck::'+filedate+'::key'
										  ,bk_pyld_key);
/* Build the External Sources payload key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(WorldCheck.Key_WorldCheck_ext_sources
										  ,'~thor_data400::key::WorldCheck::external_sources'
										  ,'~thor_data400::key::WorldCheck::'+filedate+'::external_sources'
										  ,bk_pyld_ext_srcs);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(WorldCheck.Key_WorldCheck_Version
										  ,'~thor_data400::key::WorldCheck::version'
										  ,'~thor_data400::key::WorldCheck::'+filedate+'::version'
										  ,bk_pyld_version);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::WorldCheck::in'
									 ,'~thor_data400::key::WorldCheck::'+filedate+'::in'
									 ,mv2blt_in);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::WorldCheck::main'
									 ,'~thor_data400::key::WorldCheck::'+filedate+'::main'
									 ,mv2blt_main);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::WorldCheck::key'
									 ,'~thor_data400::key::WorldCheck::'+filedate+'::key'
									 ,mv2blt_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::WorldCheck::external_sources'
                                     ,'~thor_data400::key::WorldCheck::'+filedate+'::external_sources'
									 ,mv2blt_ext_srcs);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::WorldCheck::version'
                                     ,'~thor_data400::key::WorldCheck::'+filedate+'::version'
									 ,mv2blt_version);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

roxiekeybuild.mac_sk_move('~thor_data400::key::WorldCheck::in','Q',mv2qa_in);
roxiekeybuild.mac_sk_move('~thor_data400::key::WorldCheck::main','Q',mv2qa_main);
roxiekeybuild.mac_sk_move('~thor_data400::key::WorldCheck::key','Q',mv2qa_key);
roxiekeybuild.mac_sk_move('~thor_data400::key::WorldCheck::external_sources','Q',mv2qa_ext_srcs);
roxiekeybuild.mac_sk_move('~thor_data400::key::WorldCheck::version','Q',mv2qa_version);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := WorldCheck.proc_build_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

// emailN := fileservices.sendemail('ehamel@seisint.com ',
emailN := fileservices.sendemail('RoxieBuilds@seisint.com ; ehamel@seisint.com; mluber@seisint.com;roxiebuilds@seisint.com;qualityassurance@seisint.com',
								'WorldCheck: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::worldcheck::qa::autokey::address     (thor_data400::key::WorldCheck::'+ filedate +'::autokey::address),\n' +
								'      2) thor_data400::key::worldcheck::qa::autokey::addressb2   (thor_data400::key::WorldCheck::'+ filedate +'::autokey::addressb2),\n' +
								'      3) thor_data400::key::worldcheck::qa::autokey::citystname  (thor_data400::key::WorldCheck::'+ filedate +'::autokey::citystname),\n' +
								'      4) thor_data400::key::worldcheck::qa::autokey::citystnameb2(thor_data400::key::WorldCheck::'+ filedate +'::autokey::citystnameb2),\n' +
								'      5) thor_data400::key::worldcheck::qa::autokey::name        (thor_data400::key::WorldCheck::'+ filedate +'::autokey::name),\n' +
								'      6) thor_data400::key::worldcheck::qa::autokey::nameb2      (thor_data400::key::WorldCheck::'+ filedate +'::autokey::nameb2),\n' +
								'      7) thor_data400::key::worldcheck::qa::autokey::namewords2  (thor_data400::key::WorldCheck::'+ filedate +'::autokey::namewords2),\n' +
								'      8) thor_data400::key::worldcheck::qa::autokey::namewordsb2 (thor_data400::key::WorldCheck::'+ filedate +'::autokey::namewordsb2),\n' +
								'     10) thor_data400::key::worldcheck::qa::autokey::payload     (thor_data400::key::WorldCheck::'+ filedate +'::autokey::payload),\n' +
								'     11) thor_data400::key::worldcheck::qa::autokey::ssn2        (thor_data400::key::WorldCheck::'+ filedate +'::autokey::ssn2),\n' +
								'     12) thor_data400::key::worldcheck::qa::autokey::stname      (thor_data400::key::WorldCheck::'+ filedate +'::autokey::stname),\n' +
								'     13) thor_data400::key::worldcheck::qa::autokey::stnameb2    (thor_data400::key::WorldCheck::'+ filedate +'::autokey::stnameb2),\n' +
								'     14) thor_data400::key::worldcheck::qa::autokey::zip         (thor_data400::key::WorldCheck::'+ filedate +'::autokey::zip),\n' +
								'     15) thor_data400::key::worldcheck::qa::autokey::zipb2       (thor_data400::key::WorldCheck::'+ filedate +'::autokey::zipb2),\n' +
								'     16) thor_data400::key::WorldCheck::in_qa                    (thor_data400::key::WorldCheck::'+ filedate +'::in),\n' +
								'     17) thor_data400::key::WorldCheck::main_qa                  (thor_data400::key::WorldCheck::'+ filedate +'::main),\n' +
								'     18) thor_data400::key::WorldCheck::key_qa                   (thor_data400::key::WorldCheck::'+ filedate +'::key),\n' +
								'     19) thor_data400::key::WorldCheck::external_sources_qa      (thor_data400::key::WorldCheck::'+ filedate +'::external_sources),\n' +
								'     20) thor_data400::key::WorldCheck::version_qa               (thor_data400::key::WorldCheck::'+ filedate +'::version),\n' +
								'         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := sequential(// Build the keys
						  parallel(bk_pyld_in
						           ,bk_pyld_main
						           ,bk_pyld_key
								   ,bk_pyld_ext_srcs
								   ,bk_pyld_version)
					     ,// Move the keys to built
					 	  parallel(mv2blt_in
								   ,mv2blt_main
								   ,mv2blt_key
								   ,mv2blt_ext_srcs
								   ,mv2blt_version)
					     ,// Move the keys to qa
					  	  parallel(mv2qa_in
								   ,mv2qa_main
								   ,mv2qa_key
								   ,mv2qa_ext_srcs
								   ,mv2qa_version)
					     ,// Build the autokeys
					      build_autokeys
		                 );


return parallel(build_keys
				,emailN
				);

end;
