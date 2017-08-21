//export bwr_xatf_firearms_explosives_kb := 'todo';

import demo_data_scrambler;
import atf;


#workunit('name','ATF keybuilds and superfile tx')

wuid := '20081204';
filedate:= wuid;

s1:=fileservices.clearsuperfile('~thor_Data400::base::atf_firearms_explosives');
s1a:=fileservices.clearsuperfile('~thor_Data400::base::atf_firearms_explosives_building');
s1b:=fileservices.clearsuperfile('~thor_Data400::base::atf_firearms_explosives_built');
s2:=output(demo_data_scrambler.scramble_atf_firearms_explosives_base,,'~thor::base::demo_data_file_atf_firearms_explosives_'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_Data400::base::atf_firearms_explosives','~thor::base::demo_data_file_atf_firearms_explosives_'+wuid+'_scrambled');


s4:= atf.proc_build_keys(filedate);


sequential(s1,s1a,s1b,s2,s3,s4);
