import ut,doxie_build, doxie, autokey, RoxieKeyBuild, CRIM, doxie_files, hygenics_search;

export proc_build_doc_offenders_key(string filedate) := function

prekey := if (nothor(fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING') > 0),
		output('Nothing added to Offenders BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_offenders_' + doxie_build.buildstate,0,true));


//Build non-fcra versions of the keys		
RoxieKeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_offenders(),
				'~thor_Data400::key::corrections_offenders::'+filedate+'::' + doxie_build.buildstate,
				'~thor_Data400::key::corrections_offenders_' + doxie_build.buildstate,
				offkey,2);
RoxieKeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_offenders_docnum(),
				'~thor_Data400::key::corrections_offenders::'+filedate+'::docnum_' + doxie_build.buildstate,
				'~thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,
				docnumkey,2);
RoxieKeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.key_prep_offenders_OffenderKey(),
				'~thor_Data400::key::corrections_offenders::'+filedate+'::offenderkey_' + doxie_build.buildstate,
				'~thor_Data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate,
				offenderkey,2);
				
RoxieKeybuild.Mac_SK_BuildProcess_Local(hygenics_crim.Key_prep_casenumber(), //added a new key for casenumber search VC
				'~thor_Data400::key::corrections_offenders::'+filedate+'::casenumber_' + doxie_build.buildstate,
				'~thor_Data400::key::corrections_offenders_casenumber_' + doxie_build.buildstate,
				casenumberkey,2);
				
RoxieKeyBuild.Mac_SK_BuildProcess_local(hygenics_crim.Key_BocaShell_Crim,
				'~thor_data400::key::corrections_offenders::'+filedate+'::bocashell_did', 
				'~thor_data400::key::corrections_offenders::bocashell_did_qa',
				bocashellkey,2);
RoxieKeyBuild.Mac_SK_BuildProcess_local(hygenics_crim.Key_BocaShell_Crim2,
				'~thor_data400::key::corrections_offenders_risk::'+filedate+'::bocashell_did', 
				'~thor_data400::key::corrections_offenders_risk::bocashell_did_qa',
				riskbocashellkey,2);
RoxieKeyBuild.Mac_SK_BuildProcess_local(hygenics_crim.Key_Offenders_Risk,
				'~thor_data400::key::corrections_offenders_risk::'+filedate+'::did', 
				'~thor_data400::key::corrections_offenders_risk::did_public_qa',
				riskkey,2);
								
//Move non-fcra versions of the keys	
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::' + doxie_build.buildstate,
																		'~thor_Data400::key::corrections_offenders_' + doxie_build.buildstate,
																		mv_offkey,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::docnum_' + doxie_build.buildstate,
																		'~thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,
																		mv_docnumkey,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::offenderkey_' + doxie_build.buildstate,
																		'~thor_Data400::key::corrections_offenders_offenderkey_' + doxie_build.buildstate,
																		mv_offenderkey,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::casenumber_' + doxie_build.buildstate, //added VC
																		'~thor_Data400::key::corrections_offenders_casenumber_' + doxie_build.buildstate,
																		mv_casenumberkey,2);																		
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::corrections_offenders::'+filedate+'::bocashell_did',																	
																		'~thor_data400::key::corrections_offenders::bocashell_did',
																		mv_bocashellkey, 2);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::corrections_offenders_risk::'+filedate+'::bocashell_did',																	
																		'~thor_data400::key::corrections_offenders_risk::bocashell_did',
																		mv_riskbocashellkey, 2);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::corrections_offenders_risk::'+filedate+'::did',																	
																		'~thor_data400::key::corrections_offenders_risk::did_' + doxie_build.buildstate,
																		mv_riskkey, 2);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

RoxieKeyBuild.mac_sk_move('~thor_data400::key::corrections_offenders_risk::bocashell_did' ,'Q',mv2qa_bocashell_did);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::corrections_offenders_risk::did_' + doxie_build.buildstate,'Q',mv2qa_risk_did);

/////////////////////////////////////////////////////////////////////////////////

f := file_offenders_keybuilding;

xl :=
RECORD
	f;
	unsigned6 i_did;
	zero := 0;
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('CRIM'))| ut.bit_set(0,0);
END;

xl xpand(f le,integer cntr) := 
TRANSFORM 
	SELF.i_did := cntr + autokey.did_adder('CRIM'); 
	SELF := le; 
END;

DS := PROJECT(f,xpand(LEFT,COUNTER));

logicalname := '~thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::';

AutoKey.MAC_Build_Version(DS,fname,mname,lname,
						ssn,
						dob,
						zero,
						prim_name,prim_range,st,v_city_name,zip5,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						i_did,
						'~thor_data400::key::corrections_'+doxie_build.buildstate,logicalname,outaction); 

i := index(ds,{sdid := i_did},{(STRING60)offender_key},'~thor_data400::key::corrections_fdid_'+ doxie_build.buildstate);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(i,'~thor_data400::key::corrections::'+filedate+'::fdid_'+ doxie_build.buildstate,
																					'~thor_data400::key::corrections_fdid_'+ doxie_build.buildstate,d);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::corrections::'+filedate+'::fdid_'+ doxie_build.buildstate,
																		'~thor_data400::key::corrections_fdid_'+ doxie_build.buildstate,md);

retval := if(nothor(fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate,1)),
								output('BASE = BUILT, nothing done for offenders'),		
								sequential(prekey, offkey, docnumkey, offenderkey,casenumberkey, bocashellkey, riskbocashellkey, riskkey,
								parallel(mv_offkey, mv_docnumkey, mv_offenderkey,mv_casenumberkey, mv_bocashellkey, mv_riskbocashellkey, mv_riskkey),
								parallel(mv2qa_bocashell_did, mv2qa_risk_did),
													outaction, d, md));
							//sequential(key3, bkey3);
			
return retval;

end;