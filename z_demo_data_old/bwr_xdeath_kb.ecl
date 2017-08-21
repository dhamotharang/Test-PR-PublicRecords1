//export bwr_xdeath_kb := 'todo';


import demo_data_scrambler;
import death_master,header;


#workunit('name','Death keybuilds and superfile tx')

wuid := '20081021a';
filedate:= wuid;

s1:=fileservices.clearsuperfile('~thor_data400::base::did_death_masterV2');
s2:=output(demo_data_scrambler.scramble_death_masterv2,,'~thor::base::demo_data_file_death_masterv2'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::did_death_masterV2','~thor::base::demo_data_file_death_masterv2'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::death_master_supplemental');
null_ds := dataset([], header.Layout_Death_Master_Supplemental);
s5:= output(null_ds,,'~thor::base::demo_data_file_death_master_supplemental'+wuid+'_scrambled',overwrite);
s6 := fileservices.addsuperfile('~thor_data400::base::death_master_supplemental','~thor::base::demo_data_file_death_master_supplemental'+wuid+'_scrambled');

s7:= fileservices.clearsuperfile('~thor_data400::base::did_death_master');
null_ds2 := dataset([], header.Layout_Did_Death_Master);
s8:= output(null_ds2,,'~thor::base::demo_data_file_did_death_master'+wuid+'_scrambled',overwrite);
s9 := fileservices.addsuperfile('~thor_data400::base::did_death_master','~thor::base::demo_data_file_did_death_master'+wuid+'_scrambled');

s10:= fileservices.clearsuperfile('~thor_data400::base::headerprodkey_building');
s11:= fileservices.addsuperfile('~thor_data400::Base::HeaderProdKey_Building','~thor_data400::Base::Header_prod',,true);

bk:=header.proc_deathmaster_buildkey(filedate);
ak:=death_master.proc_autokeybuild(filedate);
//bb:=death_master.Proc_Build_boolean_Key(filedate);

sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,bk,ak);

