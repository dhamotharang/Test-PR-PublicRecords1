import doxie_build, ut, doxie, autokey, RoxieKeyBuild, CRIM, doxie_files, hygenics_search;

EXPORT proc_build_DOC_fcra_offenders_key (string filedate) := function

prekey := if (nothor(fileservices.getsuperfilesubcount('~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILDING') > 0),
		output('Nothing added to Offenders BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::fcra_corrections_offenders_' + doxie_build.buildstate,0,true));
			
//Build fcra-versions of the keys
RoxieKeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_offenders(true),
				'~thor_200::key::criminal_offenders::fcra::'+filedate+'::did',
				'~thor_200::key::criminal_offenders::fcra::' + doxie.Version_SuperKey + '::did',
				 offkey_fcra);
RoxieKeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_offenders_docnum(true),
				'~thor_200::key::criminal_offenders::fcra::'+ filedate +'::docnum',
				'~thor_200::key::criminal_offenders::fcra::'+ doxie.Version_SuperKey + '::docnum',	 
				docnumkey_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_crim.key_prep_offenders_OffenderKey(true)
				,'~thor_data400::key::criminal_offenders::fcra::offenders_offenderkey_'+ doxie_build.buildstate + '_' + doxie.Version_SuperKey
				,'~thor_data400::key::life_eir::fcra::'+filedate+'::offenders_offenderkey'
				,offenderkey_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_BocaShell_Crim_FCRA,
				'~thor_data400::key::corrections_offenders::fcra::bocashell_did_'+ doxie.Version_SuperKey,
				'~thor_data400::key::corrections_offenders::fcra::'+filedate+'::bocashell_did',	
				bocashellkey_fcra);						

//Move fcra versions of the keys	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_offenders::fcra::@version@::did',
																			'~thor_200::key::criminal_offenders::fcra::'+filedate+'::did',
																			mv_offkey_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_offenders::fcra::@version@::docnum',
																			'~thor_200::key::criminal_offenders::fcra::'+filedate+'::docnum',
																			mv_docnumkey_fcra);																		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections::fcra::offenders_offenderkey_'+ doxie_build.buildstate
																		 ,'~thor_data400::key::life_eir::fcra::'+filedate+'::offenders_offenderkey'
																		 ,mv_offenderkey_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections_offenders::fcra::bocashell_did',
																			'~thor_data400::key::corrections_offenders::fcra::'+filedate+'::bocashell_did',
																			mv_bocashellkey_fcra);	

postkey := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILT'),
		fileservices.addsuperfile('~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILT','~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILDING')
		);

retval := if(nothor(fileservices.getsuperfilesubname('~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::fcra_corrections_offenders_' + doxie_build.buildstate,1)),
								output('BASE = BUILT, nothing done for offenders'),		
								sequential(prekey,
														offkey_fcra, docnumkey_fcra, offenderkey_fcra, bocashellkey_fcra, /*riskkey_fcra,*/
								parallel(mv_offkey_fcra, mv_docnumkey_fcra, mv_offenderkey_fcra, mv_bocashellkey_fcra,postkey/*, mv_riskkey_fcra*/),
								));
			
return retval;

end;