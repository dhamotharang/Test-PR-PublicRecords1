//export bwr_xphonesplus_kb := 'todo';

import demo_data_scrambler;
import phonesplus;

#workunit('name','Phonesplus_qsent keybuilds and superfile tx')

// also set phonesplus.version ARGH? it appears to be used???

wuid := '20081027c';
filedate:= wuid;

ahkb := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0,
							output('Nothing added to thor_data400::Base::HeaderKey_Building'),
							fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true));

p1:= fileservices.clearsuperfile('~thor_data400::base::phonesplus');
p1a:= fileservices.clearsuperfile('~thor_data400::base::phonesplus_father');
p1b:= fileservices.clearsuperfile('~thor_data400::base::phonesplus_grandfather');
p2 := output(demo_data_scrambler.scramble_phonesplus_base,,'~thor::base::demo_data_file_phonesplus_base'+wuid+'_scrambled',overwrite);
p3:= fileservices.addsuperfile('~thor_data400::base::phonesplus','~thor::base::demo_data_file_phonesplus_base'+wuid+'_scrambled');


q1:= fileservices.clearsuperfile('~thor_data400::base::qsent');
q1a:= fileservices.clearsuperfile('~thor_data400::base::qsent_father');
q1b:= fileservices.clearsuperfile('~thor_data400::base::qsent_grandfather');
q2:= output(demo_data_scrambler.scramble_qsent_base,,'~thor::base::demo_data_file_qsent_base'+wuid+'_scrambled',overwrite);
q3:= fileservices.addsuperfile('~thor_data400::base::qsent','~thor::base::demo_data_file_qsent_base'+wuid+'_scrambled');


n1:=fileservices.clearsuperfile('~thor_data400::base::neustarupdate');
n2:= output(demo_data_scrambler.scramble_neustar,,'~thor::base::demo_data_file_neustar'+wuid+'_scrambled',overwrite);
n3:= fileservices.addsuperfile('~thor_data400::base::neustarupdate','~thor::base::demo_data_file_neustar'+wuid+'_scrambled');
		  

pk := Phonesplus.proc_build_phonesplus_keys(filedate);

qk := Phonesplus.proc_build_qsent_keys(filedate);

chkb := FileServices.ClearSuperFile('~thor_data400::Base::HeaderKey_Building');

sequential(ahkb,p1,p1a,p1b,p2,p3,q1,q1a,q1b,q2,q3,n1,n2,n3,pk,qk,chkb);
