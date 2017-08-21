//export bwr_xpaw_kb := 'todo';

import paw;
import demo_data_scrambler;

#workunit('name','PAW keybuilds and superfile tx')

wuid := '20090820a';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::paw::built::data');
s2:= output(demo_data_scrambler.scramble_paw2,,'~thor::base::demo_data_file_paw'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::paw::built::data','~thor::base::demo_data_file_paw'+wuid+'_scrambled');

ak := paw.proc_Build_Autokey(filedate,paw.File_Base);
bk := paw.Proc_Build_Keys(filedate);
mk := paw.promote(filedate).built2qa;

sequential(s1,s2,s3,ak,bk,mk);

// 11/04/2008 note : DCA keys were made opt to get paw_services.PAWSearchService working