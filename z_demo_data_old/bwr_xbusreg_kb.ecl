import busreg;
import demo_data_scrambler;

#workunit('name','BusReg keybuilds and superfile tx')

wuid := '20090819b';
filedate:= wuid;
//set busreg.version also

s1:= fileservices.clearsuperfile('~thor_data400::base::Busreg::built::companies');
s2:= output(demo_data_scrambler.scramble_busreg_company,,'~thor::base::demo_data_file_busreg_company'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::Busreg::built::companies','~thor::base::demo_data_file_busreg_company'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::Busreg::built::contacts');
s5:= output(demo_data_scrambler.scramble_busreg_contact,,'~thor::base::demo_data_file_busreg_contact'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::Busreg::built::contacts','~thor::base::demo_data_file_busreg_contact'+wuid+'_scrambled');

bk:= busreg.proc_build_keys(filedate).all;
       

sequential(s1,s2,s3,s4,s5,s6,bk);
