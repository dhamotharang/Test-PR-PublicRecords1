
import ut,demo_data_scrambler, gong;

filedate:= '20090821';	
wuid:=filedate;


s1 := fileservices.clearsuperfile('~thor_data400::base::gong'); 	
s2 := output(demo_data_scrambler.scramble_gong,,'~thor::base::demo_data_file_gongbase_'+wuid+'_scrambled',overwrite);
s3 :=fileservices.addsuperfile('~thor_data400::base::gong','~thor::base::demo_data_file_gongbase_'+wuid+'_scrambled');
//
s4 := fileservices.clearsuperfile('~thor_data400::base::gong_history'); 	
s5 := output(demo_data_scrambler.scramble_gonghist,,'~thor::base::demo_data_file_gonghist_'+wuid+'_scrambled',overwrite);
s6 :=fileservices.addsuperfile('~thor_data400::base::gong_history','~thor::base::demo_data_file_gonghist_'+wuid+'_scrambled');

base_keys := gong.proc_build_full_keys_jtrost(filedate);
history_keys := gong.proc_build_history_keys_jtrost(filedate);

sequential(s1,s2,s3,s4,s5,s6,base_keys,history_keys);




