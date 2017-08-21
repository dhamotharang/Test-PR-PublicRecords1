import liensv2;
import demo_data_scrambler;

#workunit('name','Liens V2 keybuilds and superfile tx')

wuid := '20090708';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::liens::main');
s2:= output(demo_data_scrambler.scramble_liens_main,,'~thor::base::demo_data_file_liens_main'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::liens::main','~thor::base::demo_data_file_liens_main'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::liens::party');
s5:= output(demo_data_scrambler.scramble_liens_party,,'~thor::base::demo_data_file_liens_party'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::liens::party','~thor::base::demo_data_file_liens_party'+wuid+'_scrambled');


Proc_Build_Keys				:= LiensV2.proc_build_liens_keys(filedate);
Proc_Accept_to_QA			:= LiensV2.proc_AcceptSK_ToQA;



sequential(s1,s2,s3,s4,s5,s6,proc_build_keys,proc_accept_to_qa);





