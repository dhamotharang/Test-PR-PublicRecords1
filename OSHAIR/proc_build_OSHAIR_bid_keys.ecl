import Address,doxie_files, ut, doxie, autokey,OSHAIR, RoxieKeyBuild;

export proc_build_OSHAIR_bid_keys(string filedate) := FUNCTION

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////
/* Build the BID key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_BID
                                          ,'~thor_data400::key::oshair::bid'
										  ,'~thor_data400::key::oshair::'+filedate+'::bid'
										  ,bk_bid);
/* Build the Inspection key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_inspection_BID
										  ,'~thor_data400::key::oshair::inspection_bid'
										  ,'~thor_data400::key::oshair::'+filedate+'::inspection_bid'
										  ,bk_pyld_insp);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::bid'
                                     ,'~thor_data400::key::oshair::'+filedate+'::bid'
									 ,mv2blt_bid);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::inspection_bid'
                                     ,'~thor_data400::key::oshair::'+filedate+'::inspection_bid'
									 ,mv2blt_insp);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::oshair::bid','Q',mv2qa_bid);
ut.mac_sk_move('~thor_data400::key::oshair::inspection_bid','Q',mv2qa_insp);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := OSHAIR.proc_build_bid_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

// emailN := fileservices.sendemail('ehamel@seisint.com ',
emailN := fileservices.sendemail('RoxieBuilds@seisint.com ; ehamel@seisint.com ',
								 
								'OSHAIR: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::oshair::QA::autokey::bid::addressb2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::addressb2),\n' +
								'      2) thor_data400::key::oshair::QA::autokey::bid::citystnameb2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::citystnameb2),\n' +
								'      3) thor_data400::key::oshair::QA::autokey::bid::fein2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::fein2),\n' +
								'      4) thor_data400::key::oshair::QA::autokey::bid::nameb2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::nameb2),\n' +
								'      5) thor_data400::key::oshair::QA::autokey::bid::namewords2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::namewords2),\n' +
								'      6) thor_data400::key::oshair::QA::autokey::bid::payload(thor_data400::key::oshair::'+ filedate +'::autokey::bid::payload),\n' +
								'      7) thor_data400::key::oshair::QA::autokey::bid::stnameb2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::stnameb2),\n' +
								'      8) thor_data400::key::oshair::QA::autokey::bid::zipb2(thor_data400::key::oshair::'+ filedate +'::autokey::bid::zipb2),\n' +
								'      9) thor_data400::key::oshair::bid_qa(thor_data400::key::oshair::'+ filedate +'::bid),\n' +
				        '     10) thor_data400::key::oshair::inspection_bid_qa(thor_data400::key::oshair::'+ filedate +'::inspection_bid),\n' +
								'         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := sequential(// Build the keys
						  parallel(bk_bid
						           ,bk_pyld_insp)
					     ,// Move the keys to built
					 	  parallel(mv2blt_bid
								   ,mv2blt_insp)
					     ,// Move the keys to qa
					  	  parallel(mv2qa_bid
								   ,mv2qa_insp)
					     ,// Build the autokeys
					      build_autokeys
		                 );


return parallel(build_keys
				,emailN
				);

end;


 
 
 
 