//export bwr_xwhois_kb := 'todo';

import demo_data_scrambler;
import domains;


#workunit('name','Whois keybuilds and superfile tx')

wuid := '20090602';
filedate:= wuid;

s1:=fileservices.clearsuperfile('~thor_data400::BASE::Whois');
s1a:=fileservices.clearsuperfile('~thor_data400::BASE::Whois_building');
s1b:=fileservices.clearsuperfile('~thor_data400::BASE::Whois_built');
s2:=output(demo_data_scrambler.scramble_whois_base,,'~thor::base::demo_data_file_whois_base_'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::BASE::Whois','~thor::base::demo_data_file_whois_base_'+wuid+'_scrambled');

s4:= domains.Make_Keys(filedate);
s5:= Domains.proc_domains_autokeybuild(filedate);	

sequential(s1,s1a,s1b,s2,s3,s4,s5);
