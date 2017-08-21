import doxie_build,ut,doxie,autokey,RoxieKeyBuild,CRIM,doxie_files;
export proc_build_doc_offenders_key(string filedate) := 
function

prekey := if (fileservices.getsuperfilesubcount('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING') > 0,
		output('Nothing added to Offenders BUILDING file.'),
		fileservices.addsuperfile('~thor_data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILDING','~thor_data400::base::corrections_offenders_' + doxie_build.buildstate,0,true));
		
RoxieKeybuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_offenders,'~thor_Data400::key::corrections_offenders::'+filedate+'::' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_' + doxie_build.buildstate,key,2);
RoxieKeybuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_offenders_docnum,'~thor_Data400::key::corrections_offenders::'+filedate+'::docnum_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,key2,2);
RoxieKeybuild.Mac_SK_BuildProcess_Local(doxie_build.key_prep_offenders_OffenderKey,'~thor_Data400::key::corrections_offenders::'+filedate+'::OffenderKey_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_OffenderKey_' + doxie_build.buildstate,key3,2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_Crim ,'~thor_data400::key::corrections_offenders::bocashell_did','~thor_data400::key::corrections_offenders::'+filedate+'::bocashell_did', key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_Crim2 ,'~thor_data400::key::corrections_offenders_risk::bocashell_did','~thor_data400::key::corrections_offenders_risk::'+filedate+'::bocashell_did', key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_Offenders_Risk, '~thor_data400::key::corrections_offenders_risk::did_' + doxie_build.buildstate, '~thor_data400::key::corrections_offenders_risk::'+filedate+'::did', key6);

//RoxieKeybuild.Mac_SK_BuildProcess_Local (doxie_files.Key_Offenders_FCRA, '~thor_Data400::key::corrections::fcra::'+filedate+'::did', '~thor_data400::key::corrections::fcra::did', key7, 2);


RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_' + doxie_build.buildstate,bkey,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::docnum_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate,bkey2,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_Data400::key::corrections_offenders::'+filedate+'::OffenderKey_' + doxie_build.buildstate,'~thor_Data400::key::corrections_offenders_OffenderKey_' + doxie_build.buildstate,bkey3,2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections_offenders::bocashell_did','~thor_data400::key::corrections_offenders::'+filedate+'::bocashell_did', bkey4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections_offenders_risk::bocashell_did','~thor_data400::key::corrections_offenders_risk::'+filedate+'::bocashell_did', bkey5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections_offenders_risk::did_' + doxie_build.buildstate,'~thor_data400::key::corrections_offenders_risk::'+filedate+'::did', bkey6);

//RoxieKeybuild.Mac_SK_Move_To_Built ('~thor_Data400::key::corrections::fcra::'+filedate+'::did', '~thor_data400::key::corrections::fcra::did', bkey7, 2);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::corrections_offenders_risk::bocashell_did' ,'Q',mv2qa_bocashell_did);
ut.mac_sk_move('~thor_data400::key::corrections_offenders_risk::did_' + doxie_build.buildstate,'Q',mv2qa_risk_did);
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

retval := if(fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate + '_BUILT',1) = fileservices.getsuperfilesubname('~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate,1),
							output('BASE = BUILT, nothing done for offenders'),
							sequential(prekey,key,key2,key3,key4,key5,key6,
							parallel(bkey,bkey2,bkey3,bkey4,bkey5,bkey6),
							parallel(mv2qa_bocashell_did,mv2qa_risk_did),outaction,d,md));

return retval;

end;