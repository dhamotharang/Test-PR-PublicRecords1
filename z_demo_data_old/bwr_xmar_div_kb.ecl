//export bwr_xmar_div_kb := 'todo';

import demo_data_scrambler;
import marriage_divorce_v2;


#workunit('name','Marriage/Divorce  keybuilds and superfile tx')

wuid := '20081020';
filedate:= wuid;

s1:=fileservices.clearsuperfile('~thor_data400::base::mar_div::base');
s2:=output(demo_data_scrambler.scramble_mar_div_base,,'~thor::base::demo_data_file_mar_div_base'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::mar_div::base','~thor::base::demo_data_file_mar_div_base'+wuid+'_scrambled');

s4:=fileservices.clearsuperfile('~thor_data400::base::mar_div::search');
s5:=output(demo_data_scrambler.scramble_mar_div_search,,'~thor::base::demo_data_file_mar_div_search'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::mar_div::search','~thor::base::demo_data_file_mar_div_search'+wuid+'_scrambled');


bk:=marriage_divorce_v2.proc_build_keys(filedate);
bb:=marriage_divorce_v2.Proc_Build_Boolean_Keys(filedate);


sequential(s1,s2,s3,s4,s5,s6,bk,bb);
