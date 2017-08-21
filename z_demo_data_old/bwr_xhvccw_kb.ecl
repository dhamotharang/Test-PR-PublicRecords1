import demo_data_scrambler;
import emerges;

#workunit('name','emerges hvccw V2 keybuilds and superfile tx')

wuid := '20090316';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_vote_ccw');
s1a:= fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_vote_ccw_building');
s1b:= fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_vote_ccw_built');
//
s4:= fileservices.clearsuperfile('~thor_data400::base::emerges_hunt');
s4a:= fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_building');
s4b:= fileservices.clearsuperfile('~thor_data400::base::emerges_hunt_built');
s5:= fileservices.clearsuperfile('~thor_data400::base::emerges_ccw');
s5a:= fileservices.clearsuperfile('~thor_data400::base::emerges_ccw_building');
s5b:= fileservices.clearsuperfile('~thor_data400::base::emerges_ccw_built');
s6:= fileservices.clearsuperfile('~thor_data400::base::emerges');
s6a:= fileservices.clearsuperfile('~thor_data400::base::emerges_building');
s6b:= fileservices.clearsuperfile('~thor_data400::base::emerges_built');
//
s7:= output(demo_data_scrambler.scramble_hvccw_base,,'~thor::base::demo_data_file_hvccw_base'+wuid+'_scrambled',overwrite);
s8:= fileservices.addsuperfile('~thor_data400::base::emerges_hunt_vote_ccw','~thor::base::demo_data_file_hvccw_base'+wuid+'_scrambled');
//
s9 := emerges.proc_build_key(filedate);
//
sequential(s1,s1a,s1b,s4,s4a,s4a,s4b,s5,s5a,s5b,s6,s6a,s6b,s7,s8,s9);

