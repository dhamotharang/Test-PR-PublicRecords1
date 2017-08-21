//export bwr_xpcnsr_kb := 'todo';

import daybatchpcnsr;
import demo_data_scrambler;

#workunit('name','PCNSR keybuilds and superfile tx')

wuid := '20081107';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::daybatch_pcnsr');
s2:= output(demo_data_scrambler.scramble_pcnsr,,'~thor::base::demo_data_file_pcnsr'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::daybatch_pcnsr','~thor::base::demo_data_file_pcnsr'+wuid+'_scrambled');

bk := daybatchpcnsr.proc_build_keys(filedate);
mq := daybatchpcnsr.Proc_AcceptSK_ToQA;

sequential(s1,s2,s3,bk,mq);

