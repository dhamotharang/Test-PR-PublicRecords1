// fileservices.createsuperfile('~thor_data400::key::watchdog_best.did_nonblank_qa');
// fileservices.createsuperfile('~thor_data400::key::watchdog_nonglb.did_nonblank_qa');   

import demo_data_scrambler;
import watchdog,ut,lib_keylib,lib_fileservices,RoxieKeybuild,Suppress,_control;

#workunit('name','Watchdog bestkeybuilds and superfile tx')

wuid := '20090706';
filedate:= wuid;

s1:=fileservices.clearsuperfile('~thor_data400::BASE::Watchdog_Best');
s2:=fileservices.clearsuperfile('~thor_data400::BASE::Watchdog_Best_nonglb');
s3:=fileservices.clearsuperfile('~thor_data400::BASE::Watchdog_Best_nonutility');
s4:=fileservices.clearsuperfile('~thor_data400::BASE::Watchdog_Best_nonglb_nonutility');
s4a:=fileservices.clearsuperfile('~thor400_84::out::watchdog_filtered_header_nonglb');
s4b:=fileservices.clearsuperfile('~thor400_84::out::watchdog_filtered_header');

s5:= output(demo_data_scrambler.scramble_watchdog_best,,'~thor::base::demo_data_file_watchdog_best'+wuid+'_scrambled',overwrite);
s5a:= output(demo_data_scrambler.scramble_headers,,'~thor::base::demo_data_file_headers'+wuid+'_scrambled',overwrite);

s6:= fileservices.addsuperfile('~thor_data400::BASE::Watchdog_Best','~thor::base::demo_data_file_watchdog_best'+wuid+'_scrambled');
s7:= fileservices.addsuperfile('~thor_data400::BASE::Watchdog_Best_nonglb',			'~thor::base::demo_data_file_watchdog_best'+wuid+'_scrambled');
s8:= fileservices.addsuperfile('~thor_data400::BASE::Watchdog_Best_nonutility','~thor::base::demo_data_file_watchdog_best'+wuid+'_scrambled');
s9:= fileservices.addsuperfile('~thor_data400::BASE::Watchdog_Best_nonglb_nonutility','~thor::base::demo_data_file_watchdog_best'+wuid+'_scrambled');
s9a:= fileservices.addsuperfile('~thor400_84::out::watchdog_filtered_header_nonglb','~thor::base::demo_data_file_headers'+wuid+'_scrambled');
s9b:= fileservices.addsuperfile('~thor400_84::out::watchdog_filtered_header','~thor::base::demo_data_file_headers'+wuid+'_scrambled');

// from bwr_watchdog_roxie

Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_GLB,'~thor_data400::key::watchdog::'+filedate+'::best.did','~thor_data400::key::watchdog_best.did',first_key,2);
RoxieKeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_nonglb,'~thor_data400::key::watchdog::'+filedate+'::nonglb.did','~thor_data400::key::watchdog_nonglb.did',second_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Best_SSN,'~thor_data400::key::watchdog::'+filedate+'::best.ssn','~thor_data400::key::watchdog_best.ssn',third_key,2);
// Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Watchdog_Delta,'~thor_data400::key::watchdog::'+filedate+'::delta.did','~thor_data400::key::watchdog_delta.did',fourth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(Suppress.Key_SSN_Bad,'~thor_data400::key::ssn_bads','~thor_data400::key::watchdog::'+filedate+'::ssn_bads',ssn_bad_key,true);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_watchdog_glb_nonblank,'~thor_data400::key::watchdog::'+filedate+'::best.did_nonblank','~thor_data400::key::watchdog_best.did_nonblank',sixth_key,2);
Roxiekeybuild.MAC_SK_BuildProcess_Local(Watchdog.key_watchdog_nonglb_nonblank,'~thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank','~thor_data400::key::watchdog_nonglb.did_nonblank',seventh_key,2);
//Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(watchdog.key_watchdog_nonglb_nonutility,
  //                        '~thor_data400::key::watchdog_nonglb_nonutility.did','~thor_data400::key::watchdog::'+filedate+'::nonglb_nonutility.did',notused_key);

build_keys := parallel(first_key,second_key,third_key,/*fourth_key,*/ssn_bad_key,sixth_key,seventh_key);

Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.did','~thor_data400::key::watchdog_best.did',mv1,2);
RoxieKeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.did','~thor_data400::key::watchdog_nonglb.did',mv2,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.ssn','~thor_data400::key::watchdog_best.ssn',mv3,2);
// Roxiekeybuild.MAC_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::delta.did','~thor_data400::key::watchdog_delta.did',mv4,2);
Roxiekeybuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::ssn_bads','~thor_data400::key::watchdog::'+filedate+'::ssn_bads',mv5);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::best.did_nonblank','~thor_data400::key::watchdog_best.did_nonblank',mv6,2);
Roxiekeybuild.Mac_SK_Move_To_Built('~thor_data400::key::watchdog::'+filedate+'::nonglb.did_nonblank','~thor_data400::key::watchdog_nonglb.did_nonblank',mv7,2);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watchdog_nonglb_nonutility.did','~thor_data400::key::watchdog::'+filedate+'::nonglb_nonutility.did',notused1);

move_to_built := parallel(mv1,mv2,mv3,/*mv4,*/mv5,mv6,mv7);



ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did','Q',move1);
ut.mac_sk_move('~thor_data400::key::watchdog_nonglb.did','Q',move2);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.ssn','Q',move3);
// ut.MAC_SK_Move('~thor_data400::key::watchdog_delta.did','Q',move4);
ut.MAC_SK_Move_v2('~thor_data400::key::ssn_bads','Q',move5);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did_nonblank','Q',move6);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.did_nonblank','Q',move7);
//ut.MAC_SK_Move_v2('~thor_data400::key::watchdog_nonglb_nonutility.did','Q',notused);

move_keys := parallel(move1,move2,move3,/*move4,*/move5,move6,move7);


sequential(s1,s2,s3,s4,s4a,s4b,s5,s5a,s6,s7,s8,s9,s9a,s9b,build_keys,move_to_built,move_keys)












