
import demo_data_scrambler;
import yellowpages;

#workunit('name','Yellowpages keybuilds and superfile tx')

wuid := '20081107';
filedate:= wuid;
// need to change this attribute/date also  EXPORT STRING YellowPages_Build_Date := '20081107';

s1:=fileservices.clearsuperfile('~thor_data400::base::YellowPages::built::Data');
s2:= output(demo_data_scrambler.scramble_yellowpages,,'~thor::base::demo_data_file_yellowpages'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::YellowPages::built::Data','~thor::base::demo_data_file_yellowpages'+wuid+'_scrambled');
		  

build_keys		:= yellowpages.proc_build_keys;;
accept_QA		:= yellowpages.Proc_Accept_To_QA;

sequential(s1,s2,s3,build_keys,accept_qa);
