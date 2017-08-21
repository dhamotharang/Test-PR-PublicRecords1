
import demo_data_scrambler;
import flaccidents;

#workunit('name','FL accidents keybuilds and superfile tx')

wuid := '20081027c';
filedate:= wuid;
// also set flaccidents.Version;
// and flaccidents.Version_development

s0a:= fileservices.clearsuperfile('~thor_data400::base::flcrash0');
s0b := fileservices.clearsuperfile('~thor_data400::base::flcrash0_building');
s0c := fileservices.clearsuperfile('~thor_data400::base::flcrash0_built');
s0d := output(demo_data_scrambler.scramble_fl_crash0,,'~thor::base::demo_data_file_flcrash0'+wuid+'_scrambled',overwrite);
s0e := fileservices.addsuperfile('~thor_data400::base::flcrash0','~thor::base::demo_data_file_flcrash0'+wuid+'_scrambled');


s1a:= fileservices.clearsuperfile('~thor_data400::base::flcrash1');
s1b := fileservices.clearsuperfile('~thor_data400::base::flcrash1_building');
s1c := fileservices.clearsuperfile('~thor_data400::base::flcrash1_built');
s1d := output(demo_data_scrambler.scramble_fl_crash1,,'~thor::base::demo_data_file_flcrash1'+wuid+'_scrambled',overwrite);
s1e := fileservices.addsuperfile('~thor_data400::base::flcrash1','~thor::base::demo_data_file_flcrash1'+wuid+'_scrambled');


s2va:= fileservices.clearsuperfile('~thor_data400::base::flcrash2v');
s2vb := fileservices.clearsuperfile('~thor_data400::base::flcrash2v_building');
s2vc := fileservices.clearsuperfile('~thor_data400::base::flcrash2v_built');
s2vd := output(demo_data_scrambler.scramble_fl_crash2v,,'~thor::base::demo_data_file_fl_crash2v'+wuid+'_scrambled',overwrite);
s2ve := fileservices.addsuperfile('~thor_data400::base::flcrash2v','~thor::base::demo_data_file_fl_crash2v'+wuid+'_scrambled');

s3va:= fileservices.clearsuperfile('~thor_data400::base::flcrash3v');
s3vb := fileservices.clearsuperfile('~thor_data400::base::flcrash3v_building');
s3vc := fileservices.clearsuperfile('~thor_data400::base::flcrash3v_built');
s3vd := output(demo_data_scrambler.scramble_fl_crash3v,,'~thor::base::demo_data_file_fl_crash3v'+wuid+'_scrambled',overwrite);
s3ve := fileservices.addsuperfile('~thor_data400::base::flcrash3v','~thor::base::demo_data_file_fl_crash3v'+wuid+'_scrambled');

s4a:= fileservices.clearsuperfile('~thor_data400::base::flcrash4');
s4b := fileservices.clearsuperfile('~thor_data400::base::flcrash4_building');
s4c := fileservices.clearsuperfile('~thor_data400::base::flcrash4_built');
s4d := output(demo_data_scrambler.scramble_fl_crash4,,'~thor::base::demo_data_file_fl_crash4'+wuid+'_scrambled',overwrite);
s4e := fileservices.addsuperfile('~thor_data400::base::flcrash4','~thor::base::demo_data_file_fl_crash4'+wuid+'_scrambled');

s5a:= fileservices.clearsuperfile('~thor_data400::base::flcrash5');
s5b := fileservices.clearsuperfile('~thor_data400::base::flcrash5_building');
s5c := fileservices.clearsuperfile('~thor_data400::base::flcrash5_built');
s5d := output(demo_data_scrambler.scramble_fl_crash5,,'~thor::base::demo_data_file_fl_crash5'+wuid+'_scrambled',overwrite);
s5e := fileservices.addsuperfile('~thor_data400::base::flcrash5','~thor::base::demo_data_file_fl_crash5'+wuid+'_scrambled');


s6a:= fileservices.clearsuperfile('~thor_data400::base::flcrash6');
s6b := fileservices.clearsuperfile('~thor_data400::base::flcrash6_building');
s6c := fileservices.clearsuperfile('~thor_data400::base::flcrash6_built');
s6d := output(demo_data_scrambler.scramble_fl_crash6,,'~thor::base::demo_data_file_fl_crash6'+wuid+'_scrambled',overwrite);
s6e := fileservices.addsuperfile('~thor_data400::base::flcrash6','~thor::base::demo_data_file_fl_crash6'+wuid+'_scrambled');


s7a:= fileservices.clearsuperfile('~thor_data400::base::flcrash7');
s7b := fileservices.clearsuperfile('~thor_data400::base::flcrash7_building');
s7c := fileservices.clearsuperfile('~thor_data400::base::flcrash7_built');
s7d := output(demo_data_scrambler.scramble_fl_crash7,,'~thor::base::demo_data_file_fl_crash7'+wuid+'_scrambled',overwrite);
s7e := fileservices.addsuperfile('~thor_data400::base::flcrash7','~thor::base::demo_data_file_fl_crash7'+wuid+'_scrambled');


s8a:= fileservices.clearsuperfile('~thor_data400::base::flcrash8');
s8b := fileservices.clearsuperfile('~thor_data400::base::flcrash8_building');
s8c := fileservices.clearsuperfile('~thor_data400::base::flcrash8_built');
s8d := output(demo_data_scrambler.scramble_fl_crash8,,'~thor::base::demo_data_file_fl_crash8'+wuid+'_scrambled',overwrite);
s8e := fileservices.addsuperfile('~thor_data400::base::flcrash8','~thor::base::demo_data_file_fl_crash8'+wuid+'_scrambled');


sda:= fileservices.clearsuperfile('~thor_data400::base::flcrash_did');
sdb := fileservices.clearsuperfile('~thor_data400::base::flcrash_did_building');
sdc := fileservices.clearsuperfile('~thor_data400::base::flcrash_did_built');
sdd := output(demo_data_scrambler.scramble_fl_crash_did,,'~thor::base::demo_data_file_fl_crash_did'+wuid+'_scrambled',overwrite);
sde := fileservices.addsuperfile('~thor_data400::base::flcrash_did','~thor::base::demo_data_file_fl_crash_did'+wuid+'_scrambled');

bd := FLAccidents.FLCrash_BuildDidFile;
ss :=FLAccidents.FLCrash_BuildSSFile;
bk := FLAccidents.FLCrash_BuildKeys;
ak := FLAccidents.Proc_build_autokey(filedate);

sequential(
parallel(
	s0a,s0b,s0c,
	s1a,s1b,s1c,
	s4a,s4b,s4c,
	s5a,s5b,s5c,
	s6a,s6b,s6c,
	s7a,s7b,s7c,
	s8a,s8b,s8c,
	s2va,s2vb,s2vc,
	s3va,s3vb,s3vc,
	sda,sdb,sdc),
s0d,s0e,
s1d,s1e,
s4d,s4e,
s5d,s5e,
s6d,s6e,
s7d,s7e,
s8d,s8e,
s2vd,s2ve,
s3vd,s3ve,
sdd,sde,
bd,ss,bk,ak);