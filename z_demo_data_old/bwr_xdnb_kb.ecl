
import dnb;
import demo_data_scrambler;

#workunit('name','DNB keybuilds and superfile tx')

wuid := '20090113';
filedate:= wuid;


s1:= fileservices.clearsuperfile('~thor_data400::BASE::DNB_Companies');
s2:= output(demo_data_scrambler.scramble_dnb_base,,'~thor::base::demo_data_file_dnb_base'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::BASE::DNB_Companies','~thor::base::demo_data_file_dnb_base'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::BASE::DNB_Contacts');
s5:= output(demo_data_scrambler.scramble_dnb_contacts_base,,'~thor::base::demo_data_file_dnb_contacts_base'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::BASE::DNB_Contacts','~thor::base::demo_data_file_dnb_contacts_base'+wuid+'_scrambled');

bk := dnb.Proc_build_keys_dnb(filedate);

// do we also need proc_build_keys to get remaining two "old" keys, referenced in mq below???

mq := dnb.proc_accept_keys_to_QA;

sequential(s1,s2,s3,s4,s5,s6,bk,mq);
