//export bwr_xpatriot_kb := 'todo';


//demo_data_scrambler.scramble_patriot;


import patriot;
import globalwatchlists;
import demo_data_scrambler;

#workunit('name','Patriot/GWL keybuilds and superfile tx')

wuid := '20081106b';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::in::patriot_file');
s2:= output(demo_data_scrambler.scramble_patriot,,'~thor::base::demo_data_file_patriot'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::in::patriot_file','~thor::base::demo_data_file_patriot'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::globalwatchlists');
s5:= output(demo_data_scrambler.scramble_globalwatchlists,,'~thor::base::demo_data_file_globalwatchlists'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::globalwatchlists','~thor::base::demo_data_file_globalwatchlists'+wuid+'_scrambled');


do1 := output(count(Patriot.ScoreNames));
do2 := patriot.Proc_BuildDidKeys(filedate);
do4 := patriot.Proc_Build_Patriot_Keys(filedate);
do6 := patriot.Proc_Patriot_Keys_to_Built(filedate);
do8 := patriot.proc_accept_sk_to_qa;
do9 := globalwatchlists.proc_buildkey(filedate);

sequential(s1,s2,s3,s4,s5,s6,do1,do2,do4,do6,do8,do9);
