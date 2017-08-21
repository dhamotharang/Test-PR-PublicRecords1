//export bwr_xbankruptcy_kb := 'todo';


import demo_data_scrambler;
import bankruptcyv2;

#workunit('name','Bankruptcy keybuilds and superfile tx');

wuid := '20081028';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::bankruptcy::search');
s2:= output(demo_data_scrambler.scramble_bankruptcy_search,,'~thor::base::demo_data_file_bankruptcy_search'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::bankruptcy::search','~thor::base::demo_data_file_bankruptcy_search'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::bankruptcy::main');
s5:= output(demo_data_scrambler.scramble_bankruptcy_main,,'~thor::base::demo_data_file_bankruptcy_main'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::bankruptcy::main','~thor::base::demo_data_file_bankruptcy_main'+wuid+'_scrambled');

bk := BankruptcyV2.proc_build_keys(filedate);
bb := bankruptcyv2.Proc_Build_Boolean_Key(filedate);
mq := BankruptcyV2.Proc_Accept_SK_To_QA;

sequential(s1,s2,s3,s4,s5,s6,bk,bb,mq);
