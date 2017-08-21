
import uccv2;

import demo_data_scrambler;

#workunit('name','UCC header keybuilds and superfile tx')

wuid := '20081020';
filedate:= wuid;

//thor_data400::base::ucc::base::main // new superfile reference, on prod it is a project of vendor layouts

s1:= fileservices.clearsuperfile('~thor_data400::base::ucc::party');
s2:= output(demo_data_scrambler.scramble_uccv2_party_base,,'~thor::base::demo_data_file_uccv2_party'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::ucc::party','~thor::base::demo_data_file_uccv2_party'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::ucc::party_name');
s5:= output(demo_data_scrambler.scramble_uccv2_party_name,,'~thor::base::demo_data_file_uccv2_party_name'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::ucc::party_name','~thor::base::demo_data_file_uccv2_party_name'+wuid+'_scrambled');

s7:= fileservices.clearsuperfile('~thor_data400::base::ucc::main');
s8:= output(demo_data_scrambler.scramble_uccv2_main_base,,'~thor::base::demo_data_file_uccv2_main_base'+wuid+'_scrambled',overwrite);
s9:= fileservices.addsuperfile('~thor_data400::base::ucc::main','~thor::base::demo_data_file_uccv2_main_base'+wuid+'_scrambled');

auto_keys 	:= UCCV2.proc_autokeybuild(filedate);
main_keys :=UCCV2.Proc_Build_UCC_Keys(filedate);
boolean_keys := UCCV2.Proc_Build_Boolean_Keys(fileDate);

sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9,auto_keys,main_keys,boolean_keys);
