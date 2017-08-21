


import bbb2;
import demo_data_scrambler;

#workunit('name','BBB2 keybuilds and superfile tx')

wuid := '20081107';
filedate:= wuid;


s1:= fileservices.clearsuperfile('~thor_data400::base::bbb::built::member');
s2:= output(demo_data_scrambler.scramble_bbb2_member,,'~thor::base::demo_data_file_bbb2_member'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::bbb::built::member','~thor::base::demo_data_file_bbb2_member'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::bbb::built::nonmember');
s5:= output(demo_data_scrambler.scramble_bbb2_nonmember,,'~thor::base::demo_data_file_bbb2_nonmember'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::bbb::built::nonmember','~thor::base::demo_data_file_bbb2_nonmember'+wuid+'_scrambled');

bk := bbb2.Proc_Build_Keys(filedate).all;
mq := bbb2.Promote().built2qa;


sequential(s1,s2,s3,s4,s5,s6,bk,mq);
