
import crim_common,doxie_build,sexoffender;
import demo_data_scrambler;

#workunit('name','Sex offender keybuilds and superfile tx')

wuid := '20090401b';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::sex_offender_mainPUBLIC_built');
s1a:= fileservices.clearsuperfile('~thor_data400::base::sex_offender_mainPUBLIC_building');
s1b:= fileservices.clearsuperfile('~thor_data400::base::sex_offender_mainPUBLIC');
s2:= output(demo_data_scrambler.scramble_so_main,,'~thor::base::demo_data_file_so_main'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::sex_offender_mainPUBLIC','~thor::base::demo_data_file_so_main'+wuid+'_scrambled');
//
s4:= fileservices.clearsuperfile('~thor_data400::base::sex_offender_offensesPUBLIC_built');
s4a:= fileservices.clearsuperfile('~thor_data400::base::sex_offender_offensesPUBLIC_building');
s4b:= fileservices.clearsuperfile('~thor_data400::base::sex_offender_offensesPUBLIC');
s5:= output(demo_data_scrambler.scramble_so_offenses,,'~thor::base::demo_data_file_so_offenses'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::sex_offender_offensesPUBLIC','~thor::base::demo_data_file_so_offenses'+wuid+'_scrambled');
//
sk1 := doxie_build.proc_build_So_Search_Keys(filedate);
mk1 := doxie_build.proc_acceptSK_SO_ToQA;
//
sequential(s1,s1a,s1b,s2,s3,s4,s4a,s4b,s5,s6,sk1,mk1);

