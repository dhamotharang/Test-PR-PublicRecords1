import prof_licensev2;
import demo_data_scrambler;

#workunit('name','Prof Lic  V2 keybuilds and superfile tx')

wuid := '20080930a';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::prolicv2::proflic_base::built');
s2:= output(demo_data_scrambler.scramble_proflic_base,,'~thor::base::demo_data_file_proflic_base'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::prolicv2::proflic_base::built','~thor::base::demo_data_file_proflic_base'+wuid+'_scrambled');

s4 := prof_licensev2.Proc_Build_Proflic_Keys(filedate);
s5 := prof_licensev2.Proc_Build_Boolean_Keys(filedate);
s6 := prof_licensev2.Proc_Build_roxie_Keys(filedate);


sequential(s1,s2,s3,s4,s5,s6);



