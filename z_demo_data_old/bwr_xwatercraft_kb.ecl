//export bwr_xwatercraft_kb := 'todo';


import demo_data_scrambler;
import watercraft,watercraftv2_services;

#workunit('name','Watercraft keybuilds and superfile tx');

wuid := '20081028';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::watercraft_search');
s2:= output(demo_data_scrambler.scramble_watercraft_base_search,,'~thor::base::demo_data_file_watercraft_base_search'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::watercraft_search','~thor::base::demo_data_file_watercraft_base_search'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::watercraft_coastguard');
s5:= output(demo_data_scrambler.scramble_watercraft_base_coastguard,,'~thor::base::demo_data_file_watercraft_base_coastguard'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::watercraft_coastguard','~thor::base::demo_data_file_watercraft_base_coastguard'+wuid+'_scrambled');

s7:= fileservices.clearsuperfile('~thor_data400::base::watercraft_main');
s8:= output(demo_data_scrambler.scramble_watercraft_base_main,,'~thor::base::demo_data_file_watercraft_base_main'+wuid+'_scrambled',overwrite);
s9:= fileservices.addsuperfile('~thor_data400::base::watercraft_main','~thor::base::demo_data_file_watercraft_base_main'+wuid+'_scrambled');

bk:= watercraft.proc_build_keys(filedate);
ak:= watercraftv2_services.proc_autokeybuild(filedate);
bb:= watercraft.Proc_Build_Boolean_key(filedate);
mq:= watercraft.Proc_AcceptSK_toQA;


sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9,bk,ak,bb,mq);
