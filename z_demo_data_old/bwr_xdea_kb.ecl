

import demo_data_scrambler;
import dea;

#workunit('name','DEA keybuilds and superfile tx')

wuid := '20081027';
filedate:= wuid;

s1:=fileservices.clearsuperfile('~thor_data400::base::dea');
s1a:=fileservices.clearsuperfile('~thor_data400::base::dea_building');
s1b:=fileservices.clearsuperfile('~thor_data400::base::dea_built');
s2:=output(demo_data_scrambler.scramble_dea_modified,,'~thor::base::demo_data_file_dea_modified'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::dea','~thor::base::demo_data_file_dea_modified'+wuid+'_scrambled');
//

bk := dea.proc_build_key(filedate);
mq := dea.proc_accept_sk_To_QA;
bb := dea.Proc_Build_Boolean_Keys(filedate);

sequential(s1,s1a,s1b,s2,s3,bk,mq,bb);
