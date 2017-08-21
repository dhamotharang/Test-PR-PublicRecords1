
import crim_common,criminal_records,doxie_build;
import demo_data_scrambler;

#workunit('name','Crim V2 keybuilds and superfile tx')

wuid := '20090401f';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_PUBLIC_built');
s1a:= fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_PUBLIC_building');
s1b:= fileservices.clearsuperfile('~thor_Data400::base::corrections_offenders_PUBLIC');
s1c:=output(dataset([],corrections.Layout_Offender),,'~thor::base::demo_data_file_offenders_keybuilt_null',overwrite);
s1d:= fileservices.addsuperfile('~thor_Data400::base::corrections_offenders_PUBLIC_built','~thor::base::demo_data_file_offenders_keybuilt_null');
s2:= output(demo_data_scrambler.scramble_offenders_keybuilding,,'~thor::base::demo_data_file_offenders_keybuilt'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_Data400::base::corrections_offenders_PUBLIC','~thor::base::demo_data_file_offenders_keybuilt'+wuid+'_scrambled');
s3a:= fileservices.addsuperfile('~thor_Data400::base::corrections_offenders_PUBLIC_building','~thor::base::demo_data_file_offenders_keybuilt'+wuid+'_scrambled');
//
s4:= fileservices.clearsuperfile('~thor_Data400::base::corrections_court_offenses_PUBLIC_built');
s4a:= fileservices.clearsuperfile('~thor_Data400::base::corrections_court_offenses_PUBLIC_building');
s4b:= fileservices.clearsuperfile('~thor_Data400::base::corrections_court_offenses_PUBLIC');
s4c:=output(dataset([],corrections.layout_CourtOffenses),,'~thor::base::demo_data_file_court_offenses_keybuilt_null',overwrite);
s4d:= fileservices.addsuperfile('~thor_Data400::base::corrections_court_offenses_PUBLIC_built','~thor::base::demo_data_file_court_offenses_keybuilt_null');
s5:= output(demo_data_scrambler.scramble_courtoffenses_keybuilding,,'~thor::base::demo_data_file_courtoffenses_keybuilt'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_Data400::base::corrections_court_offenses_PUBLIC','~thor::base::demo_data_file_courtoffenses_keybuilt'+wuid+'_scrambled');
//
s7:= fileservices.clearsuperfile('~thor_Data400::base::corrections_offenses_PUBLIC_built');
s7a:= fileservices.clearsuperfile('~thor_Data400::base::corrections_offenses_PUBLIC_building');
s7b:= fileservices.clearsuperfile('~thor_Data400::base::corrections_offenses_PUBLIC');
s7c:=output(dataset([],corrections.Layout_Offense),,'~thor::base::demo_data_file_offenses_keybuilt_null',overwrite);
s7d:= fileservices.addsuperfile('~thor_Data400::base::corrections_offenses_PUBLIC_built','~thor::base::demo_data_file_offenses_keybuilt_null');
s8:= output(demo_data_scrambler.scramble_offenses_keybuilding,,'~thor::base::demo_data_file_offenses_keybuilt'+wuid+'_scrambled',overwrite);
s9:= fileservices.addsuperfile('~thor_Data400::base::corrections_offenses_PUBLIC','~thor::base::demo_data_file_offenses_keybuilt'+wuid+'_scrambled');
//
s10:= fileservices.clearsuperfile('~thor_Data400::base::corrections_activity_PUBLIC_built');
s10a:= fileservices.clearsuperfile('~thor_Data400::base::corrections_activity_PUBLIC_building');
s10b:= fileservices.clearsuperfile('~thor_Data400::base::corrections_activity_PUBLIC');
s10c:=output(dataset([],corrections.Layout_Activity),,'~thor::base::demo_data_file_activity_keybuilt_null',overwrite);
s10d:= fileservices.addsuperfile('~thor_Data400::base::corrections_activity_PUBLIC_built','~thor::base::demo_data_file_activity_keybuilt_null');
s11:= output(demo_data_scrambler.scramble_activity_keybuilding,,'~thor::base::demo_data_file_activity_keybuilt'+wuid+'_scrambled',overwrite);
s12:= fileservices.addsuperfile('~thor_Data400::base::corrections_activity_PUBLIC','~thor::base::demo_data_file_activity_keybuilt'+wuid+'_scrambled');
//
s13:= fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_PUBLIC_built');
s13a:= fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_PUBLIC_building');
s13b:= fileservices.clearsuperfile('~thor_Data400::base::corrections_punishment_PUBLIC');
s13c:=output(dataset([],corrections.Layout_crimpunishment),,'~thor::base::demo_data_file_punishment_keybuilt_null',overwrite);
s13d:= fileservices.addsuperfile('~thor_Data400::base::corrections_punishment_PUBLIC_built','~thor::base::demo_data_file_punishment_keybuilt_null');
s14:= output(demo_data_scrambler.scramble_punishment_keybuilding,,'~thor::base::demo_data_file_punishment_keybuilt'+wuid+'_scrambled',overwrite);
s15:= fileservices.addsuperfile('~thor_Data400::base::corrections_punishment_PUBLIC','~thor::base::demo_data_file_punishment_keybuilt'+wuid+'_scrambled');


sequential(
s1,s1a,s1b,s1c,s1d,s2,s3,s3a,
s4,s4a,s4b,s4c,s4d,s5,s6,
s7,s7a,s7b,s7c,s7d,s8,s9,
s10,s10a,s10b,s10c,s10d,s11,s12,
s13,s13a,s13b,s13c,s13d,s14,s15,
doxie_build.proc_build_DOC_keys(filedate),doxie_build.proc_AcceptSK_DOC_To_QA);

